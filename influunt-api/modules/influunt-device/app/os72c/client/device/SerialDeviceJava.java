package os72c.client.device;

import com.fazecast.jSerialComm.SerialPort;
import com.fazecast.jSerialComm.SerialPortDataListener;
import com.fazecast.jSerialComm.SerialPortEvent;
import com.google.common.primitives.Bytes;
import com.typesafe.config.Config;
import engine.EventoMotor;
import engine.IntervaloGrupoSemaforico;
import engine.TipoEvento;
import engine.TipoEventoControlador;
import logger.InfluuntLogger;
import logger.NivelLog;
import logger.TipoLog;
import models.TipoDetector;
import org.apache.commons.codec.binary.Hex;
import org.apache.commons.math3.util.Pair;
import org.joda.time.DateTime;
import os72c.client.Client;
import os72c.client.exceptions.HardwareFailureException;
import protocol.*;

import java.nio.charset.StandardCharsets;
import java.util.*;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import static javafx.scene.input.KeyCode.F;
import static org.apache.commons.lang3.ArrayUtils.toArray;

/**
 * Created by rodrigosol on 11/4/16.
 */
public class SerialDeviceJava implements DeviceBridge, SerialPortDataListener {


    private final Config settings;

    private final int startDelay;

    private final String porta;

    private final Integer baudrate;

    private final Integer databits;

    private final Integer stopbits;

    private final Integer parity;

    private DeviceBridgeCallback callback;

    private com.fazecast.jSerialComm.SerialPort serialPort;

    StringBuffer buffer = new StringBuffer();

    private Mensagem lastReturn = null;

    private long ultima = 0l;

    private int sequencia = 0;

    private ArrayDeque<String> fila = new ArrayDeque<String>();



    public SerialDeviceJava() {
        settings = Client.getConfig().getConfig("serial");
        porta = settings.getString("porta");
        baudrate = settings.getInt("baudrate");
        databits = settings.getInt("databits");
        stopbits = settings.getInt("stopbits");
        parity = settings.getInt("parity");
        startDelay = settings.getInt("startdelay");

        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, String.format("Iniciando a municacao serial"));
        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, String.format("PORTA    :%s", porta));
        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, String.format("BAUDRATE :%d", baudrate));
        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, String.format("DATABITS :%d", databits));
        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, String.format("STOPBITS :%d", stopbits));
        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, String.format("PARITY   :%d", parity));
        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, String.format("START DELAY :%s", startDelay));
    }

    public void start(DeviceBridgeCallback deviceBridgeCallback) {
        this.callback = deviceBridgeCallback;


        serialPort = com.fazecast.jSerialComm.SerialPort.getCommPort(porta);
        serialPort.setBaudRate(baudrate);
        serialPort.setNumDataBits(databits);
        serialPort.setNumStopBits(stopbits);
        serialPort.setParity(parity);
        try {
            InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, "Abrindo a porta de comunicação");
            if(serialPort.openPort()) {//Open serial port

                InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, "Cumprindo delay");
                Thread.sleep(startDelay);
                InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, "Limpando buffer");
                int bytesAvailable = serialPort.bytesAvailable();
                if (bytesAvailable > 0) {
                    byte[] lixo = new byte[bytesAvailable];
                    serialPort.readBytes(lixo, bytesAvailable);
                }
                serialPort.addDataListener(this);
                InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, "Comunicação serial pronta para iniciar");

                Executors.newScheduledThreadPool(1)
                    .scheduleAtFixedRate(() -> {
                        try {
                            Mensagem mensagem;
                            while(!fila.isEmpty()){
                                mensagem = Mensagem.toMensagem(Hex.decodeHex(fila.pop().toCharArray()));
                                mensagemRecebida(mensagem);
                                InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, mensagem.getTipoMensagem().toString());
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }, 0, 100, TimeUnit.MILLISECONDS);



            }else{
                InfluuntLogger.log(NivelLog.NORMAL, TipoLog.ERRO, "Não foi possível abrir comunicação pela porta:" + porta);
            }
        } catch (Exception e) {
            e.printStackTrace();
            InfluuntLogger.log(NivelLog.NORMAL, TipoLog.ERRO, "Não foi possível iniciar a comunicação serial");
            throw new HardwareFailureException(e.getMessage());

        }
    }

    @Override
    public void modoManualDesativado() {
        send(new MensagemModoManualAtivado(TipoDeMensagemBaixoNivel.MODO_MANUAL_DESATIVADO, sequencia));
    }

    @Override
    public void modoManualAtivo() {
        send(new MensagemModoManualAtivado(TipoDeMensagemBaixoNivel.MODO_MANUAL_ATIVADO, sequencia));
    }

    private void send(Mensagem mensagem) {
        try {
            byte[] bytes = mensagem.toByteArray();

            InfluuntLogger.log(NivelLog.SUPERDETALHADO, TipoLog.EXECUCAO, String.format("Enviando %d bytes pela serial", bytes.length));
            String encoded = "<I>".concat(Hex.encodeHexString(bytes)).concat("<F>");
            InfluuntLogger.log(NivelLog.SUPERDETALHADO, TipoLog.EXECUCAO, encoded);
            int r = serialPort.writeBytes(encoded.getBytes(), encoded.getBytes().length);
            if(r == -1){
                InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.ERRO, "Falha na comunicação serial. Não foi possivel enviar mensagem");
            }
            System.out.println("Bytes enviados:" + r);

        } catch (Exception e) {
            InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.ERRO, e.getMessage());
            e.printStackTrace();
        }

    }


    @Override
    public void sendEstagio(IntervaloGrupoSemaforico intervaloGrupoSemaforico) {
        MensagemEstagio mensagem = new MensagemEstagio(TipoDeMensagemBaixoNivel.ESTAGIO, getSequencia(),
            intervaloGrupoSemaforico.quantidadeGruposSemaforicos());
        mensagem.addIntervalos(intervaloGrupoSemaforico);
        InfluuntLogger.log(NivelLog.DETALHADO, TipoLog.EXECUCAO, mensagem.print());
        send(mensagem);
    }


    private Integer getSequencia() {
        if (sequencia + 1 > 65535) {
            sequencia = 0;
        }
        return ++sequencia;
    }

    private void mensagemRecebida(Mensagem mensagem) {
        TipoEvento te = null;
        TipoDetector tipoDetector = null;
        Pair<Integer, TipoDetector> pair = null;

        switch (mensagem.getTipoMensagem()) {
            case RETORNO:
                lastReturn = mensagem;
                break;
            case DETECTOR:
                final MensagemDetector mensagemDetector = (MensagemDetector) mensagem;
                te = mensagemDetector.isPedestre() ? TipoEvento.ACIONAMENTO_DETECTOR_PEDESTRE :
                    TipoEvento.ACIONAMENTO_DETECTOR_VEICULAR;
                final int codigo = ((MensagemDetector) mensagem).getPosicao();
                tipoDetector = ((MensagemDetector) mensagem).isPedestre() ? TipoDetector.PEDESTRE :
                    TipoDetector.VEICULAR;
                pair = new Pair<Integer, TipoDetector>(codigo, tipoDetector);
                callback.onEvento(new EventoMotor(DateTime.now(), te, pair));
                break;
            case FALHA_ANEL:
                final MensagemFalhaAnel mensagemFalhaAnel = (MensagemFalhaAnel) mensagem;
                callback.onEvento(new EventoMotor(DateTime.now(),
                    TipoEvento.getByTipoECodigo(TipoEventoControlador.FALHA, mensagemFalhaAnel.getFalha()),
                    mensagemFalhaAnel.getAnel()));
                break;
            case FALHA_DETECTOR:
                te = TipoEvento.getByTipoECodigo(TipoEventoControlador.FALHA, ((MensagemFalhaDetector) mensagem).getFalha());
                final int posicao = ((MensagemFalhaDetector) mensagem).getPosicao();
                tipoDetector = ((MensagemFalhaDetector) mensagem).isPedestre() ? TipoDetector.PEDESTRE :
                    TipoDetector.VEICULAR;
                pair = new Pair<Integer, TipoDetector>(posicao, tipoDetector);
                callback.onEvento(new EventoMotor(DateTime.now(), te, pair));
                break;
            case FALHA_GRUPO_SEMAFORICO:
                te = TipoEvento.getByTipoECodigo(TipoEventoControlador.FALHA, ((MensagemFalhaGrupoSemaforico) mensagem).getFalha());
                callback.onEvento(new EventoMotor(DateTime.now(), te, ((MensagemFalhaGrupoSemaforico) mensagem).getPosicao()));
                break;
            case FALHA_GENERICA:
                te = TipoEvento.getByTipoECodigo(TipoEventoControlador.FALHA, ((MensagemFalhaGenerica) mensagem).getFalha());
                callback.onEvento(new EventoMotor(DateTime.now(), te));
                break;
            case REMOCAO_GENERICA:
                te = TipoEvento.getByTipoECodigo(TipoEventoControlador.REMOCAO_FALHA, ((MensagemRemocaoFalha) mensagem).getFalha());
                callback.onEvento(new EventoMotor(DateTime.now(), te, ((MensagemRemocaoFalha) mensagem).getAnel()));
                break;
            case ALARME:
                te = TipoEvento.getByTipoECodigo(TipoEventoControlador.ALARME, ((MensagemAlarme) mensagem).getAlarme());
                callback.onEvento(new EventoMotor(DateTime.now(), te));
                break;
            case INSERCAO_PLUG:
                callback.onEvento(new EventoMotor(DateTime.now(), TipoEvento.INSERCAO_DE_PLUG_DE_CONTROLE_MANUAL));
                break;
            case REMOCAO_PLUG:
                callback.onEvento(new EventoMotor(DateTime.now(), TipoEvento.RETIRADA_DE_PLUG_DE_CONTROLE_MANUAL));
                break;
            case TROCA_ESTAGIO_MANUAL:
                callback.onEvento(new EventoMotor(DateTime.now(), TipoEvento.TROCA_ESTAGIO_MANUAL));
                break;
        }

    }

    public void sendMensagem(TipoDeMensagemBaixoNivel inicio) {
        send(new MensagemInicio(TipoDeMensagemBaixoNivel.INICIO, getSequencia()));
    }

    @Override
    public int getListeningEvents() {
         return SerialPort.LISTENING_EVENT_DATA_AVAILABLE;
    }

    @Override
    public void serialEvent(SerialPortEvent event) {
        if (event.getEventType() != com.fazecast.jSerialComm.SerialPort.LISTENING_EVENT_DATA_AVAILABLE) {
            return;
        }

        while(serialPort.bytesAvailable()>0 ){
            byte[] newData = new byte[serialPort.bytesAvailable()];
            int numRead = serialPort.readBytes(newData, newData.length);

            buffer.append(new String(newData, StandardCharsets.US_ASCII));
            System.out.println("-----------------------------");
            System.out.println(buffer.toString());
            System.out.println("-----------------------------");

            if(buffer.toString().matches("<I>.*<F>")) {
                String parts[] = buffer.toString().split("<F>");
                for (String part : parts) {
                    String texto = part.substring(part.lastIndexOf("<I>") + 3);
                    if (texto.length() > 0 && texto.length() % 2 == 0) {
                        fila.push(texto);
                    }
                }
                buffer = new StringBuffer();
            }
        }
    }
}

