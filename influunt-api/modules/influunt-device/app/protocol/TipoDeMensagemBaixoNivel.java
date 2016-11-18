package protocol;

import java.lang.reflect.Constructor;
import java.lang.reflect.InvocationTargetException;

/**
 * Created by rodrigosol on 11/3/16.
 */
public enum TipoDeMensagemBaixoNivel {

    RETORNO(MensagemRetorno.class),
    INICIO(MensagemInicio.class),
    ESTAGIO(MensagemEstagio.class),
    DETECTOR(MensagemDetector.class),
    FALHA_ANEL(MensagemFalhaAnel.class),
    FALHA_DETECTOR(MensagemFalhaDetector.class),
    FALHA_GRUPO_SEMAFORICO(MensagemFalhaGrupoSemaforico.class),
    FALHA_GENERICA(MensagemFalhaGenerica.class),
    ALARME(MensagemAlarme.class);

    private final Class clazz;

    TipoDeMensagemBaixoNivel(Class clazz){

        this.clazz = clazz;
    }

    public Mensagem getInstance(byte[] contents) {
        try {
            Constructor cl = clazz.getConstructor(byte[].class);
            return (Mensagem) cl.newInstance(contents);
        } catch (NoSuchMethodException e) {
            e.printStackTrace();
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        } catch (InstantiationException e) {
            e.printStackTrace();
        } catch (InvocationTargetException e) {
            e.printStackTrace();
        }
        return null;
    }

}
