package os72c.client.virtual;

import akka.stream.Materializer;
import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;
import com.intellij.uiDesigner.core.GridConstraints;
import com.intellij.uiDesigner.core.GridLayoutManager;
import logger.InfluuntLogger;
import org.slf4j.LoggerFactory;
import os72c.client.Client;
import os72c.client.conf.TestDeviceConfig;
import play.Application;
import play.api.Play;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.io.*;
import java.util.HashMap;
import java.util.Properties;


/**
 * Created by rodrigosol on 11/26/16.
 */
public class ControladorSettingsForm {
    public JTextField idControlador;

    public JTextField chavePrivada;

    public JTextField chavePublica;

    public JTextField host;

    public JButton iniciarControladorButton;

    public JTextField port;

    public JPanel form;

    private JTextField senha;

    private JCheckBox cleanBD;

    public ControladorSettingsForm() {
        iniciarControladorButton.addActionListener(new ActionListener() {
            @Override
            public void actionPerformed(ActionEvent e) {
                start();
            }
        });
    }

    public static void main(String args[]) throws IOException {
        JFrame frame = new JFrame("Controlador Virtual");
        ControladorSettingsForm c = new ControladorSettingsForm();
        frame.setContentPane(c.form);
        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();

        if (new File("form.properties").exists()) {
            Properties prop = new Properties();

            FileInputStream input = new FileInputStream("form.properties");

            // load a properties file
            prop.load(input);

            c.idControlador.setText(prop.getProperty("idControlador"));
            c.host.setText(prop.getProperty("host"));
            c.port.setText(prop.getProperty("port"));
            c.senha.setText(prop.getProperty("senha"));
            c.chavePrivada.setText(prop.getProperty("privateKey"));
            c.chavePublica.setText(prop.getProperty("publicKey"));
        }

        frame.setVisible(true);


    }

    private void start() {

        Properties prop = new Properties();
        OutputStream output = null;

        try {

            output = new FileOutputStream("form.properties");

            // set the properties value
            prop.setProperty("idControlador", idControlador.getText());
            prop.setProperty("host", host.getText());
            prop.setProperty("port", port.getText());
            prop.setProperty("privateKey", chavePrivada.getText());
            prop.setProperty("password", senha.getText());
            prop.setProperty("publicKey", chavePublica.getText());


            // save properties to project root folder
            prop.store(output, null);

            TestDeviceConfig deviceConfig = new TestDeviceConfig();
            deviceConfig.setDeviceId(idControlador.getText());
            deviceConfig.setHost(host.getText());
            deviceConfig.setPort(port.getText());
            deviceConfig.setCentralPublicKey(chavePublica.getText());
            deviceConfig.setPrivateKey(chavePrivada.getText());
            if (!"".equals(senha.getText())) {
                deviceConfig.setLogin(idControlador.getText());
            } else {
                deviceConfig.setLogin("");
            }
            deviceConfig.setSenha(senha.getText());
            deviceConfig.setDeviceBridge(new ControladorForm());


            form.getParent().setVisible(false);


            Application app = Client.createApplication(new HashMap(), cleanBD.isSelected());
            Play.start(app.getWrappedApplication());
            Materializer mat = app.getWrappedApplication().materializer();


            LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();
            ConsoleAppender appender = new ConsoleAppender(lc);
            InfluuntLogger.logger.addAppender(appender);
            InfluuntLogger.logger.setLevel(Level.INFO);
            appender.start();


            new Client(deviceConfig);

        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    {
// GUI initializer generated by IntelliJ IDEA GUI Designer
// >>> IMPORTANT!! <<<
// DO NOT EDIT OR ADD ANY CODE HERE!
        $$$setupUI$$$();
    }

    /**
     * Method generated by IntelliJ IDEA GUI Designer
     * >>> IMPORTANT!! <<<
     * DO NOT edit this method OR call it in your code!
     *
     * @noinspection ALL
     */
    private void $$$setupUI$$$() {
        form = new JPanel();
        form.setLayout(new GridLayoutManager(9, 2, new Insets(10, 10, 10, 10), -1, -1));
        final JLabel label1 = new JLabel();
        label1.setText("ID do Controlador");
        form.add(label1, new GridConstraints(0, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_FIXED, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        idControlador = new JTextField();
        form.add(idControlador, new GridConstraints(0, 1, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_HORIZONTAL, GridConstraints.SIZEPOLICY_WANT_GROW, GridConstraints.SIZEPOLICY_FIXED, null, new Dimension(150, -1), null, 0, false));
        final JLabel label2 = new JLabel();
        label2.setText("Chave Privada");
        form.add(label2, new GridConstraints(2, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_FIXED, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        chavePrivada = new JTextField();
        form.add(chavePrivada, new GridConstraints(2, 1, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_HORIZONTAL, GridConstraints.SIZEPOLICY_WANT_GROW, GridConstraints.SIZEPOLICY_FIXED, null, new Dimension(150, -1), null, 0, false));
        final JLabel label3 = new JLabel();
        label3.setText("MQTT Host");
        form.add(label3, new GridConstraints(3, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_FIXED, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        host = new JTextField();
        host.setText("mosquitto.rarolabs.com.br");
        form.add(host, new GridConstraints(3, 1, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_HORIZONTAL, GridConstraints.SIZEPOLICY_WANT_GROW, GridConstraints.SIZEPOLICY_FIXED, null, new Dimension(150, -1), null, 0, false));
        iniciarControladorButton = new JButton();
        iniciarControladorButton.setText("Iniciar Controlador");
        form.add(iniciarControladorButton, new GridConstraints(8, 1, 1, 1, GridConstraints.ANCHOR_CENTER, GridConstraints.FILL_HORIZONTAL, GridConstraints.SIZEPOLICY_CAN_SHRINK | GridConstraints.SIZEPOLICY_CAN_GROW, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        final JLabel label4 = new JLabel();
        label4.setText("MQTT Port");
        form.add(label4, new GridConstraints(4, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_FIXED, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        port = new JTextField();
        port.setText("1883");
        form.add(port, new GridConstraints(4, 1, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_HORIZONTAL, GridConstraints.SIZEPOLICY_WANT_GROW, GridConstraints.SIZEPOLICY_FIXED, null, new Dimension(150, -1), null, 0, false));
        final JLabel label5 = new JLabel();
        label5.setText("MQTT Login");
        form.add(label5, new GridConstraints(5, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_FIXED, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        final JLabel label6 = new JLabel();
        label6.setText("MQTT Senha");
        form.add(label6, new GridConstraints(6, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_FIXED, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        final JPanel panel1 = new JPanel();
        panel1.setLayout(new GridLayoutManager(1, 1, new Insets(0, 0, 0, 0), -1, -1));
        form.add(panel1, new GridConstraints(7, 1, 1, 1, GridConstraints.ANCHOR_CENTER, GridConstraints.FILL_BOTH, GridConstraints.SIZEPOLICY_CAN_SHRINK | GridConstraints.SIZEPOLICY_CAN_GROW, GridConstraints.SIZEPOLICY_CAN_SHRINK | GridConstraints.SIZEPOLICY_CAN_GROW, null, null, null, 0, false));
        cleanBD = new JCheckBox();
        cleanBD.setText("Limpar Banco de Dados");
        panel1.add(cleanBD, new GridConstraints(0, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_CAN_SHRINK | GridConstraints.SIZEPOLICY_CAN_GROW, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        chavePublica = new JTextField();
        chavePublica.setText("");
        form.add(chavePublica, new GridConstraints(1, 1, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_HORIZONTAL, GridConstraints.SIZEPOLICY_WANT_GROW, GridConstraints.SIZEPOLICY_FIXED, null, new Dimension(150, -1), null, 0, false));
        final JLabel label7 = new JLabel();
        label7.setText("Chave Publica");
        form.add(label7, new GridConstraints(1, 0, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_NONE, GridConstraints.SIZEPOLICY_FIXED, GridConstraints.SIZEPOLICY_FIXED, null, null, null, 0, false));
        senha = new JPasswordField();
        form.add(senha, new GridConstraints(6, 1, 1, 1, GridConstraints.ANCHOR_WEST, GridConstraints.FILL_HORIZONTAL, GridConstraints.SIZEPOLICY_WANT_GROW, GridConstraints.SIZEPOLICY_FIXED, null, new Dimension(150, -1), null, 0, false));
    }

    /**
     * @noinspection ALL
     */
    public JComponent $$$getRootComponent$$$() {
        return form;
    }
}
