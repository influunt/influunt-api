package protocol;

/**
 * Created by leonardo on 9/14/16.
 */
public class DestinoControlador {

    public final static String envioDeStatus() {
        return "central/mudanca_status_controlador";
    }

    public final static String pedidoConfiguracao() {
        return "central/configuracao";
    }

    public final static String transacao(String idControlador){
        return "controlador/".concat(idControlador).concat("/transacoes");
    }
}
