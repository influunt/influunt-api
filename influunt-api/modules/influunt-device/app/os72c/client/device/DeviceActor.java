package os72c.client.device;

import akka.actor.UntypedActor;
import akka.actor.UntypedActorContext;
import com.fasterxml.jackson.databind.JsonNode;
import engine.*;
import logger.InfluuntLogger;
import models.Anel;
import models.Controlador;
import models.Evento;
import models.TipoDetector;
import org.apache.commons.math3.util.Pair;
import org.joda.time.DateTime;
import os72c.client.storage.Storage;
import os72c.client.utils.AtoresDevice;
import play.Logger;
import protocol.AlarmeFalha;
import protocol.Envelope;
import protocol.RemocaoFalha;
import protocol.TrocaPlanoEfetiva;

import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import static engine.TipoEventoParamsTipoDeDado.*;


/**
 * Created by rodrigosol on 11/4/16.
 */
public class DeviceActor extends UntypedActor implements MotorCallback, DeviceBridgeCallback {

    private final Storage storage;

    private Controlador controlador;

    private Motor motor;

    private DeviceBridge device;

    private boolean iniciado = false;

    private UntypedActorContext context;

    private ScheduledFuture<?> executor;


    public DeviceActor(Storage mapStorage, DeviceBridge device) {
        this.storage = mapStorage;
        this.device = device;
        start();
    }

    @Override
    public void preStart() throws Exception {
        this.context = getContext();
    }

    private synchronized void start() {

        if (!iniciado) {
            Logger.info("Tentando iniciar o motor...");
            this.controlador = storage.getControlador();
            if (controlador != null) {
                Logger.info("Configuração de controlador encontrada.");
                iniciado = true;
                this.device.start(this);
                this.motor = new Motor(this.controlador, new DateTime(), new DateTime(), this);

                executor = Executors.newScheduledThreadPool(1)
                    .scheduleAtFixedRate(() -> {
                        try {
                            motor.tick();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }, 0, 100, TimeUnit.MILLISECONDS);
                Logger.info("O motor foi iniciado");
            } else {
                Logger.info("Não existe configuração para iniciar o motor.");
                Logger.warn("Aguardando configuração.");
            }
        }
    }

    private void sendAlarmeOuFalha(EventoMotor eventoMotor) {
        Envelope envelope = AlarmeFalha.getMensagem(controlador.getId().toString(), eventoMotor);
        sendMessage(envelope);
    }

    private void sendRemocaoFalha(EventoMotor eventoMotor) {
        Envelope envelope = RemocaoFalha.getMensagem(controlador.getId().toString(), eventoMotor);
        sendMessage(envelope);
    }

    @Override
    public void onTrocaDePlano(DateTime timestamp, Evento eventoAnterior, Evento eventoAtual, List<String> modos) {

    }

    @Override
    public void onAlarme(DateTime timestamp, EventoMotor eventoMotor) {
        sendAlarmeOuFalha(eventoMotor);
    }

    @Override
    public void onFalha(DateTime timestamp, EventoMotor eventoMotor) {
        sendAlarmeOuFalha(eventoMotor);
    }

    @Override
    public void onRemocaoFalha(DateTime timestamp, EventoMotor eventoMotor) {
        sendRemocaoFalha(eventoMotor);
    }

    @Override
    public void modoManualAtivo(DateTime timestamp) {
        device.modoManualAtivo();
    }

    @Override
    public void modoManualDesativado(DateTime timestamp) {
        device.modoManualDesativado();
    }

    @Override
    public void onEstagioChange(int anel, Long numeroCiclos, Long tempoDecorrido, DateTime timestamp, IntervaloGrupoSemaforico intervalos) {
        device.sendEstagio(intervalos);
    }

    @Override
    public void onEstagioEnds(int anel, Long numeroCiclos, Long tempoDecorrido, DateTime timestamp, IntervaloGrupoSemaforico intervalos) {
    }

    @Override
    public void onCicloEnds(int anel, Long numeroCiclos) {
    }

    @Override
    public void onTrocaDePlanoEfetiva(AgendamentoTrocaPlano agendamentoTrocaPlano) {
        Envelope envelope = TrocaPlanoEfetiva.getMensagem(controlador.getId().toString(), agendamentoTrocaPlano);
        sendMessage(envelope);
    }

    private void sendMessage(Envelope envelope) {
        context.actorFor(AtoresDevice.mqttActorPath(controlador.getId().toString())).tell(envelope, getSelf());
    }

    @Override
    public void onReceive(Object message) throws Exception {
        if (message instanceof Envelope) {
            Envelope envelope = (Envelope) message;
            System.out.println("Mensagem recebida no device actor: " + envelope.getTipoMensagem());
            switch (envelope.getTipoMensagem()) {
                case OK:
                    start();
                    break;

                case IMPOSICAO_DE_MODO_OPERACAO:
                    imporModoOperacao(envelope.getConteudoParsed());
                    break;

                case IMPOSICAO_DE_PLANO:
                    imporPlano(envelope.getConteudoParsed());
                    Thread.sleep(1000);
                    break;

                case LIBERAR_IMPOSICAO:
                    liberarImposicao(envelope.getConteudoParsed());
                    break;

                case TROCAR_TABELA_HORARIA:
                    InfluuntLogger.log("[DEVICE] onMudancaTabelaHoraria");
                    trocarTabelaHoraria(false);
                    break;

                case TROCAR_TABELA_HORARIA_IMEDIATAMENTE:
                    InfluuntLogger.log("[DEVICE] onMudancaTabelaHoraria IMEDIATO!");
                    trocarTabelaHoraria(true);
                    break;

                case ATUALIZAR_CONFIGURACAO:
                case TROCAR_PLANOS:
                    alterarControladorNoMotor();
                    break;
            }
        }
    }

    @Override
    public void onReady() {

    }

    @Override
    public void onEvento(EventoMotor eventoMotor) {
        Anel anel = null;
        if (eventoMotor.getTipoEvento().getParamsDescriptor() != null) {
            if (eventoMotor.getTipoEvento().getParamsDescriptor().getTipo().equals(DETECTOR_PEDESTRE) ||
                eventoMotor.getTipoEvento().getParamsDescriptor().getTipo().equals(DETECTOR_VEICULAR)) {
                anel = buscarAnelPorDetector((Pair<Integer, TipoDetector>) eventoMotor.getParams()[0]);
            } else if (eventoMotor.getTipoEvento().getParamsDescriptor().getTipo().equals(GRUPO_SEMAFORICO)) {
                anel = buscarAnelPorGrupo((Integer) eventoMotor.getParams()[0]);
            }
        }

        if (anel != null) {
            eventoMotor.setParams(new Object[]{eventoMotor.getParams()[0],
                anel.getPosicao()});
        }
        motor.onEvento(eventoMotor);
    }

    private Anel buscarAnelPorDetector(Pair<Integer, TipoDetector> pair) {
        return controlador.findAnelByDetector(pair.getSecond(), pair.getFirst());
    }

    private Anel buscarAnelPorGrupo(Integer posicao) {
        return controlador.findAnelByGrupoSemaforico(posicao);
    }

    private void imporModoOperacao(JsonNode conteudo) {
        String modoOperacao = conteudo.get("modoOperacao").asText();
        int numeroAnel = conteudo.get("numeroAnel").asInt();
        int duracao = conteudo.get("duracao").asInt();
        Long horarioEntrada = conteudo.get("horarioEntrada").asLong();

        motor.onEvento(new EventoMotor(new DateTime(), TipoEvento.IMPOSICAO_MODO, modoOperacao, numeroAnel, duracao, horarioEntrada));
    }

    private void imporPlano(JsonNode conteudo) {
        int posicaoPlano = conteudo.get("posicaoPlano").asInt();
        int numeroAnel = conteudo.get("numeroAnel").asInt();
        int duracao = conteudo.get("duracao").asInt();
        Long horarioEntrada = conteudo.get("horarioEntrada").asLong();

        motor.onEvento(new EventoMotor(new DateTime(), TipoEvento.IMPOSICAO_PLANO, posicaoPlano, numeroAnel, duracao, horarioEntrada));
    }

    private void liberarImposicao(JsonNode conteudo) {
        int numeroAnel = conteudo.get("numeroAnel").asInt();
        motor.onEvento(new EventoMotor(new DateTime(), TipoEvento.LIBERAR_IMPOSICAO, numeroAnel));
    }

    private void trocarTabelaHoraria(boolean imediatamente) {
        alterarControladorNoMotor();
        if (imediatamente) {
            motor.onMudancaTabelaHoraria();
        }
    }

    private void alterarControladorNoMotor() {
        motor.setControladorTemporario(storage.getControladorStaging());
        storage.setControlador(storage.getControladorStaging());
        storage.setControladorStaging(null);
    }


    @Override
    public void aroundPostStop() {

        if (motor != null) {
            motor.stop();
            executor.cancel(true);
        }
        super.aroundPostStop();
    }
}
