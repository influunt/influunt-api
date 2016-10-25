package json.deserializers.simulacao;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.ObjectCodec;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.fasterxml.jackson.databind.JsonNode;
import models.simulador.parametros.ParametroSimulacao;
import models.simulador.parametros.ParametroSimulacaoDetector;
import models.simulador.parametros.ParametroSimulacaoImposicaoPlano;
import org.joda.time.DateTime;
import org.joda.time.format.ISODateTimeFormat;
import play.libs.Json;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * Created by pedropires on 6/19/16.
 */
public class ParametroSimulacaoDeserializer extends JsonDeserializer<ParametroSimulacao> {

    @Override
    public ParametroSimulacao deserialize(JsonParser jp, DeserializationContext ctxt) throws IOException {
        ObjectCodec oc = jp.getCodec();
        JsonNode node = oc.readTree(jp);

        ParametroSimulacao params = new ParametroSimulacao();

        if (node.has("idControlador")) {
            params.setIdControlador(UUID.fromString(node.get("idControlador").asText()));
        }

        if (node.has("velocidade")) {
            params.setVelocidade(node.get("velocidade").asDouble());
        }

        if (node.has("inicioControlador")) {
            params.setInicioControlador(DateTime.parse(node.get("inicioControlador").asText(), ISODateTimeFormat.dateTimeParser()));
        }

        if (node.has("inicioSimulacao")) {
            params.setInicioSimulacao(DateTime.parse(node.get("inicioSimulacao").asText(), ISODateTimeFormat.dateTimeParser()));
        }

        if (node.has("fimSimulacao")) {
            params.setFimSimulacao(DateTime.parse(node.get("fimSimulacao").asText(), ISODateTimeFormat.dateTimeParser()));
        }

        if (node.has("disparoDetectores")) {
            List<ParametroSimulacaoDetector> detectores = new ArrayList<>();
            for (JsonNode detector : node.get("disparoDetectores")) {
                detectores.add(Json.fromJson(detector, ParametroSimulacaoDetector.class));
            }
            params.setDetectores(detectores);
        }

        if (node.has("imposicaoPlanos")) {
            List<ParametroSimulacaoImposicaoPlano> imposicoes = new ArrayList<>();
            for (JsonNode imposicao : node.get("imposicaoPlanos")) {
                imposicoes.add(Json.fromJson(imposicao, ParametroSimulacaoImposicaoPlano.class));
            }
            params.setImposicoes(imposicoes);
        }

        return params;
    }
}


