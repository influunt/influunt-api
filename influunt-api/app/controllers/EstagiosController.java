package controllers;

import be.objectify.deadbolt.java.actions.DeferredDeadbolt;
import be.objectify.deadbolt.java.actions.Dynamic;
import com.google.inject.Inject;
import com.google.inject.Provider;
import models.Estagio;
import play.Application;
import play.db.ebean.Transactional;
import play.mvc.Controller;
import play.mvc.Result;
import play.mvc.Security;
import security.Secured;

import java.util.UUID;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.CompletionStage;

@DeferredDeadbolt
@Security.Authenticated(Secured.class)
@Dynamic("Influunt")
public class EstagiosController extends Controller {

    @Inject
    private Provider<Application> provider;

    @Transactional
    public CompletionStage<Result> delete(String id) {
        Estagio estagio = Estagio.find.byId(UUID.fromString(id));
        if (estagio == null) {
            return CompletableFuture.completedFuture(notFound());
        } else {
            if (estagio.delete(provider.get().path())) {
                return CompletableFuture.completedFuture(ok());
            } else {
                return CompletableFuture.completedFuture(badRequest());
            }
        }
    }
}
