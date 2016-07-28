package models;

import checks.ControladorAneisCheck;
import checks.Erro;
import checks.InfluuntValidator;
import com.fasterxml.jackson.databind.JsonNode;
import controllers.routes;
import org.hamcrest.Matchers;
import org.junit.Test;
import play.libs.Json;
import play.mvc.Http;
import play.mvc.Result;
import play.test.Helpers;

import javax.validation.groups.Default;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

import static org.junit.Assert.*;
import static play.mvc.Http.Status.OK;
import static play.mvc.Http.Status.UNPROCESSABLE_ENTITY;
import static play.test.Helpers.route;

/**
 * Created by rodrigosol on 6/22/16.
 */
public class ControladorAneisTest extends ControladorTest {

    @Override
    @Test
    public void testVazio() {

        Controlador controlador = getControladorDadosBasicos();
        controlador.save();

        List<Erro> erros = getErros(controlador);

        assertThat(erros, org.hamcrest.Matchers.hasItems(
                new Erro("Controlador", "Ao menos um anel deve estar ativo", "")
        ));

        Anel anel1 = controlador.getAneis().get(0);
        anel1.setAtivo(true);

        erros = getErros(controlador);

        assertThat(erros, org.hamcrest.Matchers.hasItems(
                new Erro("Controlador", "Um anel ativo deve ter ao menos dois estágios e no máximo o limite do modelo do controlador", "aneis[0]")
        ));

        anel1.setEstagios(Arrays.asList(new Estagio(), new Estagio()));

        erros = getErros(controlador);

        assertThat(erros, org.hamcrest.Matchers.hasItems(
                new Erro("Controlador", "Latitude deve ser informada", "aneis[0].latitudeOk"),
                new Erro("Controlador", "Longitude deve ser informada", "aneis[0].longitudeOk")
        ));

        anel1.setLatitude(1.0);
        anel1.setLongitude(1.0);

        anel1.setEstagios(Arrays.asList(new Estagio(), new Estagio(), new Estagio(), new Estagio(), new Estagio(), new Estagio(),
                new Estagio(), new Estagio(), new Estagio(), new Estagio(), new Estagio(), new Estagio(), new Estagio(), new Estagio(), new Estagio()));

        erros = getErros(controlador);

        assertThat(erros, org.hamcrest.Matchers.empty());
    }


    @Override
    @Test
    public void testNoValidationErro() {
        Controlador controlador = getControladorAneis();
        controlador.save();
        List<Erro> erros = getErros(controlador);
        assertThat(erros, Matchers.empty());
    }

    @Override
    @Test
    public void testORM() {
        Controlador controlador = getControladorAneis();
        controlador.save();
        assertNotNull(controlador.getId());
        assertEquals("Criação de aneis", 4, controlador.getAneis().size());
        assertEquals("Total de aneis ativos", 1, controlador.getAneis().stream().filter(anel -> anel.isAtivo()).count());
        assertEquals("Criação de grupos semafóricos", 0, controlador.getGruposSemaforicos().size());
        Anel anelAtivo = controlador.getAneis().stream().filter(anel -> anel.isAtivo()).findFirst().get();
        assertEquals("Detectores", 0, anelAtivo.getDetectores().size());
    }

    @Override
    @Test
    public void testJSON() {
        Controlador controlador = getControladorAneis();
        controlador.save();

        Controlador controladorJson = Json.fromJson(Json.toJson(controlador), Controlador.class);

        assertEquals(controlador.getId(), controladorJson.getId());
        assertControladorAnel(controlador, controladorJson);
        assertNotNull(controladorJson.getId());
        assertEquals("Criação de aneis", 4, controladorJson.getAneis().size());
        assertEquals("Total de aneis ativos", 1, controladorJson.getAneis().stream().filter(anel -> anel.isAtivo()).count());
        Anel anelAtivo = controladorJson.getAneis().stream().filter(anel -> anel.isAtivo()).findFirst().get();
        assertEquals("Criação de grupos semafóricos", 0, anelAtivo.getGruposSemaforicos().size());
        assertEquals("Detectores", 0, anelAtivo.getDetectores().size());
    }

    private void assertControladorAnel(Controlador controlador, Controlador controladorJson) {
        Anel anel = controlador.getAneis().stream().filter(anelInterno -> anelInterno.isAtivo()).findFirst().get();
        Anel anelJson = controladorJson.getAneis().stream().filter(anelInterno -> anelInterno.isAtivo()).findFirst().get();

        assertEquals(anel.getDescricao(), anelJson.getDescricao());
        assertEquals(anel.getLatitude(), anelJson.getLatitude());
        assertEquals(anel.getLongitude(), anelJson.getLongitude());
        assertEquals(anel.getGruposSemaforicos().size(), anelJson.getGruposSemaforicos().size());
        assertEquals(anel.getDetectores().size(), anelJson.getDetectores().size());
        assertEquals(anel.getNumeroSMEE(), anelJson.getNumeroSMEE());
        assertEquals(anel.getEstagios().size(), anelJson.getEstagios().size());
    }

    @Override
    @Test
    public void testControllerValidacao() {
        Controlador controlador = getControladorDadosBasicos();
        controlador.save();

        Http.RequestBuilder postRequest = new Http.RequestBuilder().method("POST")
                .uri(routes.ControladoresController.aneis().url()).bodyJson(Json.toJson(controlador));
        Result postResult = route(postRequest);

        assertEquals(UNPROCESSABLE_ENTITY, postResult.status());

        JsonNode json = Json.parse(Helpers.contentAsString(postResult));
        assertEquals(1, json.size());

    }

    @Override
    @Test
    public void testController() {
        Controlador controlador = getControladorAneis();


        Http.RequestBuilder postRequest = new Http.RequestBuilder().method("POST")
                .uri(routes.ControladoresController.aneis().url()).bodyJson(Json.toJson(controlador));
        Result postResult = route(postRequest);

        assertEquals(OK, postResult.status());

        JsonNode json = Json.parse(Helpers.contentAsString(postResult));
        Controlador controladorRetornado = Json.fromJson(json, Controlador.class);

        assertControladorAnel(controlador, controladorRetornado);
        assertNotNull(controladorRetornado.getId());
        assertEquals("Criação de aneis", 4, controladorRetornado.getAneis().size());
        assertEquals("Total de aneis ativos", 1, controladorRetornado.getAneis().stream().filter(anel -> anel.isAtivo()).count());
        assertEquals("Criação de grupos semafóricos", 0, controladorRetornado.getAneis().stream().filter(anelInterno -> anelInterno.isAtivo()).findFirst().get().getGruposSemaforicos().size());
    }

    @Override
    public List<Erro> getErros(Controlador controlador) {
        return new InfluuntValidator<Controlador>().validate(controlador,
                Default.class, ControladorAneisCheck.class);
    }

    @Test
    public void testCLA() {
        Cidade cidade = new Cidade();
        cidade.setNome("BH");
        cidade.save();

        Area area = new Area();
        area.setCidade(cidade);
        area.setDescricao(2);
        area.save();

        Controlador c1A1 = getControladorAneis();
        Controlador c2A1 = getControladorAneis();

        Controlador c1A2 = getControladorAneis();
        Area antiga = c1A2.getArea();
        c1A2.setArea(area);
        c1A2.save();

        assertNotEquals(antiga.getId(), c1A2.getId());


        Controlador c2A2 = getControladorAneis();

        c2A2.setArea(area);

        c1A1.update();
        c2A1.update();

        c1A2.update();
        c1A2.refresh();

        c2A2.update();
        c2A2.refresh();

        assertEquals(c1A1.getArea().getId().toString(), c2A1.getArea().getId().toString());
        assertEquals(c1A2.getArea().getId().toString(), c2A2.getArea().getId().toString());
        assertNotEquals(c1A1.getArea().getId().toString(), c1A2.getArea().getId().toString());

        assertEquals("1.000.0001", c1A1.getCLC());
        assertEquals("1.000.0002", c2A1.getCLC());
        assertEquals("2.000.0001", c1A2.getCLC());
        assertEquals("2.000.0002", c2A2.getCLC());

        List<Anel> aneisC1A1 = c1A1.getAneis().stream().sorted((o1, o2) -> o1.getPosicao().compareTo(o2.getPosicao())).collect(Collectors.toList());
        List<Anel> aneisC2A1 = c2A1.getAneis().stream().sorted((o1, o2) -> o1.getPosicao().compareTo(o2.getPosicao())).collect(Collectors.toList());
        List<Anel> aneisC1A2 = c1A2.getAneis().stream().sorted((o1, o2) -> o1.getPosicao().compareTo(o2.getPosicao())).collect(Collectors.toList());
        List<Anel> aneisC2A2 = c2A2.getAneis().stream().sorted((o1, o2) -> o1.getPosicao().compareTo(o2.getPosicao())).collect(Collectors.toList());


        assertEquals("1.000.0001.1", aneisC1A1.get(0).getCLA());
        assertEquals("1.000.0001.2", aneisC1A1.get(1).getCLA());
        assertEquals("1.000.0001.3", aneisC1A1.get(2).getCLA());
        assertEquals("1.000.0001.4", aneisC1A1.get(3).getCLA());

        assertEquals("1.000.0002.1", aneisC2A1.get(0).getCLA());
        assertEquals("1.000.0002.2", aneisC2A1.get(1).getCLA());
        assertEquals("1.000.0002.3", aneisC2A1.get(2).getCLA());
        assertEquals("1.000.0002.4", aneisC2A1.get(3).getCLA());

        assertEquals("2.000.0001.1", aneisC1A2.get(0).getCLA());
        assertEquals("2.000.0001.2", aneisC1A2.get(1).getCLA());
        assertEquals("2.000.0001.3", aneisC1A2.get(2).getCLA());
        assertEquals("2.000.0001.4", aneisC1A2.get(3).getCLA());

        assertEquals("2.000.0002.1", aneisC2A2.get(0).getCLA());
        assertEquals("2.000.0002.2", aneisC2A2.get(1).getCLA());
        assertEquals("2.000.0002.3", aneisC2A2.get(2).getCLA());
        assertEquals("2.000.0002.4", aneisC2A2.get(3).getCLA());


    }

}
