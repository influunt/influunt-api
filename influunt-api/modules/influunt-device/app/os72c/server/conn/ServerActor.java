package os72c.server.conn;

import akka.actor.*;
import akka.event.Logging;
import akka.event.LoggingAdapter;
import akka.japi.Function;
import com.typesafe.config.ConfigFactory;
import scala.concurrent.duration.Duration;

import java.util.concurrent.TimeUnit;

/**
 * Created by rodrigosol on 7/7/16.
 */
public class ServerActor extends UntypedActor {

    LoggingAdapter log = Logging.getLogger(getContext().system(), this);
    private ActorRef mqqtCentral;

    private static SupervisorStrategy strategy =
            new OneForOneStrategy(1000, Duration.Undefined(),
                    new Function<Throwable, SupervisorStrategy.Directive>() {
                        @Override
                        public SupervisorStrategy.Directive apply(Throwable t) {
                            System.out.println("ERRO!!******************");
                            return SupervisorStrategy.stop();
                        }
                    },false);


    @Override
    public void preStart() throws Exception {
        super.preStart();
        setup();
    }

    private void setup() {
        mqqtCentral = getContext().actorOf(Props.create(MQTTServerActor.class),"CentralMQTT");
        this.getContext().watch(mqqtCentral);
        mqqtCentral.tell("CONNECT",getSelf());
    }

    @Override
    public void onReceive(Object message) throws Exception {
        log.info("---------------------------");
        log.info(message.toString());
        log.info("---------------------------");
        if (message instanceof Terminated) {
            final Terminated t = (Terminated) message;
            log.info("Ele morreu!");
            getContext().system().scheduler().scheduleOnce(Duration.create(30,TimeUnit.SECONDS),getSelf(),"RESTART",getContext().system().dispatcher(),getSelf());
        }else if("RESTART".equals(message)){
            log.info("Devo restartar ele!");
            setup();
        }

    }

    public static void main(String args[]){
        ActorSystem system = ActorSystem.create("InfluuntCentral", ConfigFactory.load());
        system.actorOf(Props.create(ServerActor.class),"ClientActor");
        system.awaitTermination();
    }

    @Override
    public SupervisorStrategy supervisorStrategy() {
        return strategy;
    }
}


