package os.cet.driver.controladores;

import akka.actor.ActorRef;
import jssc.SerialPort;
import os.cet.driver.models.EstadoGrupo;

/**
 * Created by rodrigosol on 6/28/16.
 */
public class ControladorArduino extends Controlador {
    private SerialPort serialPort;

    @Override
    protected void supervisorPronto(ActorRef supervisor) {
        serialPort = new SerialPort("/dev/tty.usbmodem1421");
        try {
            serialPort.openPort();//Open serial port
            serialPort.setParams(SerialPort.BAUDRATE_115200,
                    SerialPort.DATABITS_8,
                    SerialPort.STOPBITS_1,
                    SerialPort.PARITY_NONE);//Set params. Also you can set params by this string: serialPort.setParams(9600, 8, 1, 0);

            Thread.sleep(2000);

        } catch (Exception e) {
            e.printStackTrace();
        }

        pronto("Raro Labs","Arduino","1.0");
    }

    @Override
    protected void entrarEmModoAmarelhoIntermitente() {

    }

    @Override
    protected void onChange(EstadoGrupo[] estadoDosGrupos) {
        String command = "";
        for(EstadoGrupo estado: estadoDosGrupos){
            switch (estado) {
                case VERDE:
                    command += "1,";
                    break;
                case AMARELHO:
                    command += "2,";
                    break;
                case VERMELHO:
                    command += "3,";
                    break;
                case DESLIGADO:
                    command += "0,";
                    break;
                case VERMELHO_INTERMITENTE:
                    command += "4,";
                    break;
            }

        }
            try {

                System.out.println("*************:" + command);
                System.out.println(System.currentTimeMillis());
                serialPort.writeBytes(command.getBytes());
                System.out.println(System.currentTimeMillis());
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

}
