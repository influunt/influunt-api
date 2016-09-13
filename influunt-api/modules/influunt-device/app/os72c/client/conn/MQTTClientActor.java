package os72c.client.conn;

import akka.actor.ActorRef;
import akka.actor.Cancellable;
import akka.actor.Props;
import akka.actor.UntypedActor;
import akka.event.Logging;
import akka.event.LoggingAdapter;
import akka.routing.ActorRefRoutee;
import akka.routing.RoundRobinRoutingLogic;
import akka.routing.Routee;
import akka.routing.Router;
import com.google.gson.Gson;
import models.StatusControlador;
import org.eclipse.paho.client.mqttv3.*;
import os72c.client.protocols.Mensagem;
import os72c.client.protocols.MensagemControladorSupervisor;
import os72c.client.protocols.MensagemVerificaConfiguracao;
import os72c.client.storage.Storage;
import play.Configuration;
import play.api.Play;
import protocol.ControladorOffline;
import protocol.ControladorOnline;
import protocol.Envelope;
import scala.concurrent.duration.Duration;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * Created by rodrigosol on 7/7/16.
 */
public class MQTTClientActor extends UntypedActor implements MqttCallback {

    private final String host;

    private String id;

    private final String port;

    LoggingAdapter log = Logging.getLogger(getContext().system(), this);

    Router router;

    private MqttClient client;

    private MqttConnectOptions opts;

    private ActorRef controlador;

    private Cancellable tick;

    private Storage storage;

    public MQTTClientActor(final String id, final String host, final String port, Storage storage) {
        this.id = id;
        this.host = host;
        this.port = port;
        this.storage = storage;

        List<Routee> routees = new ArrayList<Routee>();
        for (int i = 0; i < 5; i++) {
            ActorRef r = getContext().actorOf(Props.create(MessageBroker.class, this.id));
            getContext().watch(r);
            routees.add(new ActorRefRoutee(r));
        }
        router = new Router(new RoundRobinRoutingLogic(), routees);
    }

    @Override
    public void preStart() throws Exception {
        super.preStart();
    }

    @Override
    public void aroundPostStop() {
        super.aroundPostStop();
    }

    @Override
    public void postStop() throws Exception {
        super.postStop();
    }

    @Override
    public void postRestart(Throwable reason) throws Exception {
        super.postRestart(reason);
        connect();
    }

    @Override
    public void onReceive(Object message) throws Exception {
        if (message instanceof Exception) {
            throw (Exception) message;
        } else if (message.equals("CONNECT")) {
            controlador = getSender();
            connect();
            getSender().tell("CONNECTED", getSelf());
        } else if ("Tick".equals(message)) {
            if (!client.isConnected()) {
                throw new Exception("Conexao morreu");
            }
        } else if (message instanceof MensagemControladorSupervisor) {
            String json = new Gson().toJson(((MensagemControladorSupervisor) message));
            MqttMessage status = new MqttMessage();
            status.setQos(0);
            status.setRetained(false);
            status.setPayload(json.getBytes());
            client.publish("central/status/" + id, status);
        }else if (message instanceof Envelope){
            sendMenssage((Envelope) message);
        }
    }

    private void connect() throws MqttException {
        client = new MqttClient("tcp://" + host + ":" + port, id);

        opts = new MqttConnectOptions();
        opts.setAutomaticReconnect(false);
        opts.setConnectionTimeout(10);

        Envelope controladorOffline = ControladorOffline.getMensagem(id);

        opts.setWill(controladorOffline.getDestino(), controladorOffline.toJson().getBytes(), 1, true);

        client.setCallback(this);
        client.connect(opts);
        if (tick != null) {
            tick.cancel();
        } else {
            tick = getContext().system().scheduler().schedule(Duration.Zero(),
                    Duration.create(5000, TimeUnit.MILLISECONDS), getSelf(), "Tick", getContext().dispatcher(), null);
        }

        client.subscribe("controlador/" + id + "/+", 1, (topic, message) -> {
            sendToBroker(message);
        });

        Envelope controladorOnline = ControladorOnline.getMensagem(id, System.currentTimeMillis(), "1.0", storage.getStatus());
        MqttMessage message = new MqttMessage();
        message.setQos(2);
        message.setRetained(true);
        message.setPayload(controladorOnline.toJson().getBytes());
        client.publish(controladorOnline.getDestino(), message);

        sendToBroker(new MensagemVerificaConfiguracao());
    }


    private void sendToBroker(MqttMessage message) throws MqttException {
        String parsedBytes = new String(message.getPayload());
        Envelope envelope = new Gson().fromJson(parsedBytes, Envelope.class);
        router.route(envelope, getSender());
    }

    private void sendToBroker(Mensagem message) throws MqttException {
        router.route(message, getSender());
    }


    @Override
    public void connectionLost(Throwable cause) {
        try {
            connect();
        } catch (MqttException e) {
            e.printStackTrace();
            getSelf().tell(e, getSelf());
        }
    }

    @Override
    public void messageArrived(String topic, MqttMessage message) throws Exception {

    }

    @Override
    public void deliveryComplete(IMqttDeliveryToken token) {

    }

    private void sendMenssage(Envelope envelope) throws MqttException {
        System.out.println("PUBLICANDO" + envelope);
        MqttMessage message = new MqttMessage();
        message.setQos(envelope.getQos());
        message.setRetained(true);
        message.setPayload(envelope.toJson().getBytes());
        client.publish(envelope.getDestino(), message);
    }
}
