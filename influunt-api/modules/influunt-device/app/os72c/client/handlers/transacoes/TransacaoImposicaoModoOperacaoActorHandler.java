package os72c.client.handlers.transacoes;

import com.fasterxml.jackson.databind.JsonNode;
import models.ModoOperacaoPlano;
import models.StatusAnel;
import org.joda.time.DateTime;
import os72c.client.handlers.TransacaoActorHandler;
import os72c.client.storage.Storage;
import os72c.client.utils.AtoresDevice;
import play.libs.Json;
import protocol.Envelope;
import protocol.EtapaTransacao;
import protocol.MensagemImposicaoModoOperacao;
import status.Transacao;

import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by rodrigosol on 9/6/16.
 */
public class TransacaoImposicaoModoOperacaoActorHandler extends TransacaoActorHandler {

    public TransacaoImposicaoModoOperacaoActorHandler(String idControlador, Storage storage) {
        super(idControlador, storage);
    }

    @Override
    protected void executePrepareToCommit(Transacao transacao) {
        JsonNode payloadJson = Json.parse(transacao.payload);
        List<Integer> numerosAneis = Json.fromJson(payloadJson.get("numerosAneis"), List.class);
        List<StatusAnel> statusAneis = storage.getStatusAneis().entrySet().stream()
            .filter(entry -> numerosAneis.contains(entry.getKey()))
            .map(entry -> entry.getValue())
            .collect(Collectors.toList());
        if (isImposicaoModoOperacaoOk(payloadJson, statusAneis)) {
            storage.setTempData(transacao.transacaoId, "modoOperacao", payloadJson.get("modoOperacao").asText());
            storage.setTempData(transacao.transacaoId, "numerosAneis", payloadJson.get("numerosAneis").toString());
            storage.setTempData(transacao.transacaoId, "horarioEntrada", payloadJson.get("horarioEntrada").asText());
            storage.setTempData(transacao.transacaoId, "duracao", payloadJson.get("duracao").asText());
            transacao.etapaTransacao = EtapaTransacao.PREPARE_OK;
        } else {
            transacao.etapaTransacao = EtapaTransacao.PREPARE_FAIL;
        }


    }

    @Override
    @SuppressWarnings({"unchecked"})
    protected void executeCommit(Transacao transacao) {
        Envelope envelopeImposicaoModo = MensagemImposicaoModoOperacao.getMensagem(
            idControlador,
            storage.getTempData(transacao.transacaoId, "modoOperacao"),
            Json.fromJson(Json.parse(storage.getTempData(transacao.transacaoId, "numerosAneis")), List.class),
            Long.parseLong(storage.getTempData(transacao.transacaoId, "horarioEntrada")),
            Integer.parseInt(storage.getTempData(transacao.transacaoId, "duracao")));

        getContext().actorSelection(AtoresDevice.motor(idControlador)).tell(envelopeImposicaoModo, getSelf());

        transacao.etapaTransacao = EtapaTransacao.COMMITED;
        storage.clearTempData(transacao.transacaoId);
    }

    @Override
    protected void executeAbort(Transacao transacao) {
        transacao.etapaTransacao = EtapaTransacao.ABORTED;
        storage.clearTempData(transacao.transacaoId);
    }

    private boolean isImposicaoModoOperacaoOk(JsonNode payload, List<StatusAnel> statusAneis) {
        try {
            ModoOperacaoPlano.valueOf(payload.get("modoOperacao").asText());
            Long horarioEntrada = payload.get("horarioEntrada").asLong();
            int duracao = payload.get("duracao").asInt();
            List<Integer> numerosAneis = Json.fromJson(payload.get("numerosAneis"), List.class);
            boolean numerosAneisOk = numerosAneis.stream().allMatch(numeroAnel -> numeroAnel >= 1);
            return numerosAneisOk &&
                duracao >= 15 && duracao <= 600 &&
                horarioEntrada > DateTime.now().getMillis() &&
                statusAneis.stream().allMatch(entry -> !entry.equals(StatusAnel.IMPOSICAO));
        } catch (Exception e) {
            return false;
        }
    }
}
