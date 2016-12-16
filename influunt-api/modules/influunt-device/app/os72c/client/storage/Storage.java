package os72c.client.storage;

import com.fasterxml.jackson.databind.JsonNode;
import engine.TipoEvento;
import models.Controlador;
import models.StatusDevice;

/**
 * Created by leonardo on 9/13/16.
 */
public interface Storage {
    public StatusDevice getStatus();

    public void setStatus(StatusDevice statusDevice);

    public Controlador getControlador();

    public void setControlador(Controlador controlador);

    public Controlador getControladorStaging();

    public void setControladorStaging(Controlador controlador);

    public JsonNode getControladorJson();

    public JsonNode getControladorJsonStaging();

    public JsonNode getPlanos();

    public void setPlanos(JsonNode plano);

    public JsonNode getPlanosStaging();

    public void setPlanosStaging(JsonNode plano);

    public String getPrivateKey();

    public void setPrivateKey(String publicKey);

    public String getCentralPublicKey();

    public void setCentralPublicKey(String publicKey);

    public long getHorarioEntradaTabelaHoraria();

    public void setHorarioEntradaTabelaHoraria(long horarioEntrada);

    public void addFalha(TipoEvento falha);

    public void removeFalha(TipoEvento falha);

    public boolean emFalha();

    public void setTempData(String id, String key, String value);

    public String getTempData(String id,String key);

    public void clearTempData(String id);

    public String getMarca();

    public String getModelo();

    public String getFirmware();
}
