package controllers;

import be.objectify.deadbolt.java.actions.DeferredDeadbolt;
import be.objectify.deadbolt.java.actions.Dynamic;
import checks.AreasCheck;
import checks.Erro;
import checks.InfluuntValidator;
import com.fasterxml.jackson.databind.JsonNode;
import models.Area;
import play.db.ebean.Transactional;
import play.libs.Json;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import security.Secured;
import utils.InfluuntQueryBuilder;
import utils.InfluuntResultBuilder;

import javax.validation.groups.Default;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;

@DeferredDeadbolt
@Security.Authenticated(Secured.class)
@Dynamic("Influunt")
public class AreasController extends Controller {


    @Transactional
    public CompletionStage<Result> create() {
        JsonNode json = request().body().asJson();

        if (json == null) {
            return CompletableFuture.completedFuture(badRequest("Expecting Json data"));
        } else {

            Area area = Json.fromJson(json, Area.class);
            List<Erro> erros = new InfluuntValidator<Area>().validate(area, javax.validation.groups.Default.class, AreasCheck.class);

            if (erros.isEmpty()) {
                area.save();
                area.refresh();
                return CompletableFuture.completedFuture(ok(Json.toJson(area)));
            } else {
                return CompletableFuture.completedFuture(status(UNPROCESSABLE_ENTITY, Json.toJson(erros)));
            }
        }
    }

    @Transactional
    public CompletionStage<Result> findOne(String id) {
        Area area = Area.find.fetch("cidade").where().eq("id", UUID.fromString(id)).findUnique();
        if (area == null) {
            return CompletableFuture.completedFuture(notFound());
        } else {
            return CompletableFuture.completedFuture(ok(Json.toJson(area)));
        }
    }

    @Transactional
    public CompletionStage<Result> findAll() {
        InfluuntResultBuilder result = new InfluuntResultBuilder(new InfluuntQueryBuilder(Area.class, request().queryString()).fetch(Collections.singletonList("cidade")).query());
        return CompletableFuture.completedFuture(ok(result.toJson()));
    }

    @Transactional
    public CompletionStage<Result> delete(String id) {
        Area area = Area.find.byId(UUID.fromString(id));
        if (area == null) {
            return CompletableFuture.completedFuture(notFound());
        }
        area.delete();
        return CompletableFuture.completedFuture(ok());
    }

    @Transactional
    public CompletionStage<Result> update(String id) {
        JsonNode json = request().body().asJson();
        if (json == null) {
            return CompletableFuture.completedFuture(badRequest("Expecting Json data"));
        }
        Area areaExistente = Area.find.byId(UUID.fromString(id));
        if (areaExistente == null) {
            return CompletableFuture.completedFuture(notFound());
        }

        Area area = Json.fromJson(json, Area.class);
        area.setId(areaExistente.getId());
        List<Erro> erros = new InfluuntValidator<Area>().validate(area, Default.class, AreasCheck.class);

        if (erros.isEmpty()) {
            area.update();
            area.refresh();
            return CompletableFuture.completedFuture(ok(Json.toJson(area)));
        } else {
            return CompletableFuture.completedFuture(status(UNPROCESSABLE_ENTITY, Json.toJson(erros)));
        }

    }

}
