'use strict';

describe('Controller: ControladoresCtrl', function () {

  // helper functions
  var fakeInicializaWizard = function(scope, $q, objeto, fn) {
    spyOn(scope, 'inicializaWizard').and.callFake(function() {
      var deferred = $q.defer();
      deferred.resolve({});
      return deferred.promise;
    });

    scope.objeto = objeto;
    fn();
    scope.$apply();
  };

  // load the controller's module
  beforeEach(module('influuntApp', function(RestangularProvider) {
    RestangularProvider.setBaseUrl('');
  }));

  var ControladoresCtrl,
    scope,
    $q,
    Restangular,
    $httpBackend,
    $state;

  beforeEach(inject(function ($controller, $rootScope, _$q_, _$httpBackend_, _Restangular_, _$state_) {
    scope = $rootScope.$new();
    ControladoresCtrl = $controller('ControladoresCtrl', {
      $scope: scope
    });

    $q = _$q_;
    Restangular = _Restangular_;
    $httpBackend = _$httpBackend_;
    $state = _$state_;
  }));


  describe('CRUD de contrladores', function() {
    it('Deve conter as definições das funções de CRUD', function() {
      expect(scope.index).toBeDefined();
      expect(scope.show).toBeDefined();
      expect(scope.new).toBeDefined();
      expect(scope.save).toBeDefined();
      expect(scope.confirmDelete).toBeDefined();
    });

    it('Inicializa Index:', function() {
      var controladores = [{}, {}];
      $httpBackend.expectGET('/controladores').respond(controladores);
      scope.inicializaIndex();
      $httpBackend.flush();

      expect(scope.lista.length).toBe(2);
      expect(scope.filtros).toEqual({});
      expect(scope.filtroLateral).toEqual({});
    });

    it('before show: carrega a lista de areas', function() {
      var areas = [{}, {}];
      $httpBackend.expectGET('/areas').respond(areas);
      scope.beforeShow();
      $httpBackend.flush();

      expect(scope.areas.length).toBe(2);
    });
  });

  describe('Wizard para novo controlador', function() {
    var helpers;

    beforeEach(function() {
      helpers = {cidades:[{},{}],fabricantes:[{},{},{}]};
      $httpBackend.expectGET('/helpers/controlador').respond(helpers);
      scope.inicializaWizard();
      $httpBackend.flush();
    });

    describe('inicializaWizard', function() {
      it('Deve retornar o objeto vazio.', function() {
        expect(scope.objeto).toEqual({});
      });

      it('Deve inicializar o objeto de dados acessórios', function() {
        expect(scope.data.fabricantes).toEqual(helpers.fabricantes);
        expect(scope.data.cidades).toEqual(helpers.cidades);
      });

      it('Deve inicializar a cidade com a primeira cidade da lista de cidades, do dados acessórios',
        function() {
          expect(scope.helpers.cidade).toEqual(scope.data.cidades[0]);
        });
    });


    describe('InicializaAneis', function () {
      beforeEach(function() {
        var objeto = {'id':'69e52a0f-bd25-4b56-810e-750ba003b9b6','descricao':'teste','numeroSMEE':'teste','numeroSMEEConjugado1':'123','numeroSMEEConjugado2':'123','numeroSMEEConjugado3':'123','firmware':'1232','latitude':-19.9809899,'longitude':-44.03494549999999,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','CLC':'1.000.0999','area':{'id':'41648354-f83a-4680-8571-621630e16008','descricao':1,'dataCriacao':'24/06/2016 11:38:32','dataAtualizacao':'24/06/2016 11:38:32','cidade':{'id':'15b83474-f4bf-499b-a41d-a12f04429cb4','nome':'Belo Horizonte','dataCriacao':'24/06/2016 11:38:24','dataAtualizacao':'24/06/2016 11:38:24','areas':[{'id':'41648354-f83a-4680-8571-621630e16008','descricao':1},{'id':'ed522abb-85c4-425d-a65d-d5947cd46888','descricao':2}]},'limites':[]},'modelo':{'id':'cb0489e1-a0ad-4145-a2cf-7cca7e19f8f2','descricao':'opa 2 fab2','dataCriacao':'24/06/2016 11:39:59','dataAtualizacao':'24/06/2016 11:39:59','fabricante':{'id':'b195beea-4f3b-4614-83f3-2da0f7d2874b','nome':'fabricante 2','dataCriacao':'24/06/2016 11:39:59','dataAtualizacao':'24/06/2016 11:39:59','modelos':[{'id':'cb0489e1-a0ad-4145-a2cf-7cca7e19f8f2','descricao':'opa 2 fab2','configuracao':{'id':'f3e4293d-e406-4f0d-a2cb-5ddae54e3a72','descricao':'opa 2','limiteEstagio':8,'limiteGrupoSemaforico':8,'limiteAnel':8,'limiteDetectorPedestre':8,'limiteDetectorVeicular':32,'dataCriacao':'24/06/2016 11:39:07','dataAtualizacao':'24/06/2016 11:39:07'}},{'id':'dd1b1175-a2ea-4dde-aa0d-5ec80ad886c7','descricao':'opa 1 fab2','configuracao':{'id':'f20a1b3a-c43b-43da-a9ba-6e2d7da4afc9','descricao':'opa 1','limiteEstagio':4,'limiteGrupoSemaforico':4,'limiteAnel':4,'limiteDetectorPedestre':4,'limiteDetectorVeicular':16,'dataCriacao':'24/06/2016 11:38:58','dataAtualizacao':'24/06/2016 11:38:58'}}]},'configuracao':{'id':'f3e4293d-e406-4f0d-a2cb-5ddae54e3a72','descricao':'opa 2','limiteEstagio':8,'limiteGrupoSemaforico':8,'limiteAnel':8,'limiteDetectorPedestre':8,'limiteDetectorVeicular':32,'dataCriacao':'24/06/2016 11:39:07','dataAtualizacao':'24/06/2016 11:39:07'}},'aneis':[{'id':'02022a0a-fe52-4580-bf68-004ad0bf2340','ativo':false,'posicao':3,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]},{'id':'0a38f42d-a3bf-4611-941d-bb3ff3ade8c3','ativo':false,'posicao':8,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]},{'id':'162a59a1-b0ff-4bf1-9f18-d86071f60060','ativo':false,'posicao':4,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]},{'id':'251eebf4-ec8d-4516-8577-c66b41b5ea5f','ativo':false,'posicao':2,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]},{'id':'799c1329-af11-43da-b6c3-4e1df36b3a5c','ativo':false,'posicao':6,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]},{'id':'940dbe1c-e74a-4ac6-8ddf-014a28785a5c','ativo':false,'posicao':5,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]},{'id':'aa24a196-8d2d-4dac-a28b-6097f59536c1','ativo':false,'posicao':1,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]},{'id':'d9136a28-f275-4288-ab97-3ffd5ce1ca11','ativo':false,'posicao':7,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 18:40:45','dataAtualizacao':'24/06/2016 18:40:45','estagios':[],'gruposSemaforicos':[]}],'gruposSemaforicos':[]};
        fakeInicializaWizard(scope, $q, objeto, scope.inicializaAneis);
      });

      it('Deve iniciar a tela com o primeiro anel selecionado', function() {
        expect(scope.currentAnelIndex).toBe(0);
        expect(scope.currentAnel).toBe(scope.aneis[0]);
      });

      it('Deve criar a uma quantidade de aneis igual ao limite de aneis do modelo', function() {
        expect(scope.objeto.aneis.length).toBe(scope.objeto.modelo.configuracao.limiteAnel);
        expect(scope.aneis.length).toBe(scope.objeto.modelo.configuracao.limiteAnel);
      });

      it('Os aneis devem ser nomeados com o padrao idControlador + indice do anel', function() {
        expect(scope.objeto.aneis[0].idAnel).toEqual('1.000.0999-1');
      });
    });

    describe('InicializaAssociacao', function() {
      beforeEach(function() {
        var objeto = {'id':'13ae1e96-f66c-41e5-8649-70da9a36c3e7','descricao':'teste','numeroSMEE':'teste','numeroSMEEConjugado1':'123','numeroSMEEConjugado2':'123','numeroSMEEConjugado3':'132','firmware':'123','latitude':-19.9809899,'longitude':-44.03494549999999,'dataCriacao':'24/06/2016 14:18:15','dataAtualizacao':'24/06/2016 17:41:38','CLC':'1.000.0999','area':{'id':'41648354-f83a-4680-8571-621630e16008','descricao':1,'dataCriacao':'24/06/2016 11:38:32','dataAtualizacao':'24/06/2016 11:38:32','cidade':{'id':'15b83474-f4bf-499b-a41d-a12f04429cb4','nome':'Belo Horizonte','dataCriacao':'24/06/2016 11:38:24','dataAtualizacao':'24/06/2016 11:38:24','areas':[{'id':'41648354-f83a-4680-8571-621630e16008','descricao':1},{'id':'ed522abb-85c4-425d-a65d-d5947cd46888','descricao':2}]},'limites':[]},'modelo':{'id':'cb0489e1-a0ad-4145-a2cf-7cca7e19f8f2','descricao':'opa 2 fab2','dataCriacao':'24/06/2016 11:39:59','dataAtualizacao':'24/06/2016 11:39:59','fabricante':{'id':'b195beea-4f3b-4614-83f3-2da0f7d2874b','nome':'fabricante 2','dataCriacao':'24/06/2016 11:39:59','dataAtualizacao':'24/06/2016 11:39:59','modelos':[{'id':'cb0489e1-a0ad-4145-a2cf-7cca7e19f8f2','descricao':'opa 2 fab2','configuracao':{'id':'f3e4293d-e406-4f0d-a2cb-5ddae54e3a72','descricao':'opa 2','limiteEstagio':8,'limiteGrupoSemaforico':8,'limiteAnel':8,'limiteDetectorPedestre':8,'limiteDetectorVeicular':32,'dataCriacao':'24/06/2016 11:39:07','dataAtualizacao':'24/06/2016 11:39:07'}},{'id':'dd1b1175-a2ea-4dde-aa0d-5ec80ad886c7','descricao':'opa 1 fab2','configuracao':{'id':'f20a1b3a-c43b-43da-a9ba-6e2d7da4afc9','descricao':'opa 1','limiteEstagio':4,'limiteGrupoSemaforico':4,'limiteAnel':4,'limiteDetectorPedestre':4,'limiteDetectorVeicular':16,'dataCriacao':'24/06/2016 11:38:58','dataAtualizacao':'24/06/2016 11:38:58'}}]},'configuracao':{'id':'f3e4293d-e406-4f0d-a2cb-5ddae54e3a72','descricao':'opa 2','limiteEstagio':8,'limiteGrupoSemaforico':8,'limiteAnel':8,'limiteDetectorPedestre':8,'limiteDetectorVeicular':32,'dataCriacao':'24/06/2016 11:39:07','dataAtualizacao':'24/06/2016 11:39:07'}},'aneis':[{'id':'29e5bfb6-6e18-4208-ba17-8a627bda21ab','numeroSMEE':'laksfdj','descricao':'Estagio opa','ativo':true,'posicao':1,'latitude':-19.9431826,'longitude':-43.911083599999984,'quantidadeGrupoPedestre':2,'quantidadeGrupoVeicular':2,'quantidadeDetectorPedestre':2,'quantidadeDetectorVeicular':2,'dataCriacao':'24/06/2016 14:18:15','dataAtualizacao':'24/06/2016 17:41:38','estagios':[{'id':'4d77cf1c-536e-480b-85ae-cb95dc7de633','imagem':{'id':'b70cd222-e70e-41f8-9b5d-8d15082c60bc','filename':'12321359_986438248070903_1173574894423312875_n.jpg','contentType':'image/jpeg','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'tempoMaximoPermanencia':12,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'},{'id':'d11740e4-f6ae-4797-b839-46fdde078374','imagem':{'id':'1e988fa7-335f-40cd-bebf-fd9befe19c69','filename':'Screen Shot 2016-06-17 at 15.08.57.png','contentType':'image/png','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'demandaPrioritaria':false,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}],'gruposSemaforicos':[{'id':'05a01a08-9d1f-4fc2-8d2a-c5b21a022861','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'PEDESTRE','posicao':3,'estagioGrupoSemaforicos':[{'id':'64e79cbe-096b-407e-9a56-b71ed7debd13','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'d11740e4-f6ae-4797-b839-46fdde078374','imagem':{'id':'1e988fa7-335f-40cd-bebf-fd9befe19c69','filename':'Screen Shot 2016-06-17 at 15.08.57.png','contentType':'image/png','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'demandaPrioritaria':false,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'ba6a03d0-c500-4edb-80a2-ecfda27850e9','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'PEDESTRE','posicao':4,'estagioGrupoSemaforicos':[{'id':'0f68dc01-3463-4485-95e5-7bdbc669218f','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'4d77cf1c-536e-480b-85ae-cb95dc7de633','imagem':{'id':'b70cd222-e70e-41f8-9b5d-8d15082c60bc','filename':'12321359_986438248070903_1173574894423312875_n.jpg','contentType':'image/jpeg','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'tempoMaximoPermanencia':12,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'c8a7f4c8-6f36-4ed6-a80a-4a6d77c1df5a','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'VEICULAR','posicao':1,'estagioGrupoSemaforicos':[{'id':'962d5c95-9c8a-47f3-8ff2-24cfceafc77c','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'4d77cf1c-536e-480b-85ae-cb95dc7de633','imagem':{'id':'b70cd222-e70e-41f8-9b5d-8d15082c60bc','filename':'12321359_986438248070903_1173574894423312875_n.jpg','contentType':'image/jpeg','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'tempoMaximoPermanencia':12,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'fc525f6c-6ba4-463c-84ef-5631126711e8','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'VEICULAR','posicao':2,'estagioGrupoSemaforicos':[{'id':'17a2006b-b4ff-4ab4-a63f-fc7f65e0596f','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'d11740e4-f6ae-4797-b839-46fdde078374','imagem':{'id':'1e988fa7-335f-40cd-bebf-fd9befe19c69','filename':'Screen Shot 2016-06-17 at 15.08.57.png','contentType':'image/png','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'demandaPrioritaria':false,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]}]},{'id':'554a799a-5510-4ca5-bf18-37b7c8a778b9','ativo':false,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','estagios':[],'gruposSemaforicos':[]},{'id':'61c6028e-7084-4a23-9dde-31f54f282d6c','ativo':false,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','estagios':[],'gruposSemaforicos':[]},{'id':'6ce94531-6943-4b09-b476-3658ea153659','ativo':false,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','estagios':[],'gruposSemaforicos':[]},{'id':'72094c61-72f5-41bc-b3b5-24f01c2e9a0a','ativo':false,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','estagios':[],'gruposSemaforicos':[]},{'id':'bf5e48bc-1612-44ae-96ba-6ace83e37f8e','ativo':false,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','estagios':[],'gruposSemaforicos':[]},{'id':'c6cb37cb-5f13-4913-ae7a-e5ba1f3ec260','ativo':false,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','estagios':[],'gruposSemaforicos':[]},{'id':'cf11fe89-9f46-4620-94d5-557ad198777b','ativo':false,'quantidadeGrupoPedestre':0,'quantidadeGrupoVeicular':0,'quantidadeDetectorPedestre':0,'quantidadeDetectorVeicular':0,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','estagios':[],'gruposSemaforicos':[]}],'gruposSemaforicos':[{'id':'05a01a08-9d1f-4fc2-8d2a-c5b21a022861','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'PEDESTRE','posicao':3,'estagioGrupoSemaforicos':[{'id':'64e79cbe-096b-407e-9a56-b71ed7debd13','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'d11740e4-f6ae-4797-b839-46fdde078374','imagem':{'id':'1e988fa7-335f-40cd-bebf-fd9befe19c69','filename':'Screen Shot 2016-06-17 at 15.08.57.png','contentType':'image/png','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'demandaPrioritaria':false,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'337e7d90-e6aa-4d98-a97b-e16c8185f94a','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'VEICULAR','posicao':5,'estagioGrupoSemaforicos':[{'id':'a4826476-d603-44ea-a885-296ede07432d','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'54ad4d85-ca9d-487a-8022-1e5e100b5a3a','imagem':{'id':'e974c74b-254b-4776-81c7-bb7a9874fac7','filename':'12963901_10154615163486840_8455352346796368737_n.jpg','contentType':'image/jpeg','dataCriacao':'24/06/2016 15:48:10','dataAtualizacao':'24/06/2016 15:48:10'},'tempoMaximoPermanencia':21,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'34d4b6a9-56b3-43b6-9bad-9f456ed353df','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'PEDESTRE','posicao':8,'estagioGrupoSemaforicos':[{'id':'56873032-81b3-4eed-b7dc-1233b4e5a04d','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'54ad4d85-ca9d-487a-8022-1e5e100b5a3a','imagem':{'id':'e974c74b-254b-4776-81c7-bb7a9874fac7','filename':'12963901_10154615163486840_8455352346796368737_n.jpg','contentType':'image/jpeg','dataCriacao':'24/06/2016 15:48:10','dataAtualizacao':'24/06/2016 15:48:10'},'tempoMaximoPermanencia':21,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'ba6a03d0-c500-4edb-80a2-ecfda27850e9','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'PEDESTRE','posicao':4,'estagioGrupoSemaforicos':[{'id':'0f68dc01-3463-4485-95e5-7bdbc669218f','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'4d77cf1c-536e-480b-85ae-cb95dc7de633','imagem':{'id':'b70cd222-e70e-41f8-9b5d-8d15082c60bc','filename':'12321359_986438248070903_1173574894423312875_n.jpg','contentType':'image/jpeg','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'tempoMaximoPermanencia':12,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'c8a7f4c8-6f36-4ed6-a80a-4a6d77c1df5a','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'VEICULAR','posicao':1,'estagioGrupoSemaforicos':[{'id':'962d5c95-9c8a-47f3-8ff2-24cfceafc77c','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'4d77cf1c-536e-480b-85ae-cb95dc7de633','imagem':{'id':'b70cd222-e70e-41f8-9b5d-8d15082c60bc','filename':'12321359_986438248070903_1173574894423312875_n.jpg','contentType':'image/jpeg','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'tempoMaximoPermanencia':12,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'d2ced644-bcfa-4a23-9c67-0900479e4be2','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'VEICULAR','posicao':6,'estagioGrupoSemaforicos':[{'id':'9ed8ed59-e311-4b07-9853-4a4d5764c0b4','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'986b4dbe-9358-4eea-a199-28ab94d30e6b','imagem':{'id':'b11a4ff2-e9c5-4d07-ac50-62a166ec8dab','filename':'Screen Shot 2016-06-13 at 23.45.32.png','contentType':'image/png','dataCriacao':'24/06/2016 15:48:10','dataAtualizacao':'24/06/2016 15:48:10'},'tempoMaximoPermanencia':12,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'da50d895-5208-4da4-a0ec-2bb4c83667f4','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'PEDESTRE','posicao':7,'estagioGrupoSemaforicos':[{'id':'ffa6bb61-52b5-45bb-ba9e-373dbbb50e9f','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'986b4dbe-9358-4eea-a199-28ab94d30e6b','imagem':{'id':'b11a4ff2-e9c5-4d07-ac50-62a166ec8dab','filename':'Screen Shot 2016-06-13 at 23.45.32.png','contentType':'image/png','dataCriacao':'24/06/2016 15:48:10','dataAtualizacao':'24/06/2016 15:48:10'},'tempoMaximoPermanencia':12,'demandaPrioritaria':true,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]},{'id':'fc525f6c-6ba4-463c-84ef-5631126711e8','dataCriacao':'24/06/2016 15:50:59','dataAtualizacao':'24/06/2016 17:41:38','tipo':'VEICULAR','posicao':2,'estagioGrupoSemaforicos':[{'id':'17a2006b-b4ff-4ab4-a63f-fc7f65e0596f','dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38','ativo':true,'estagio':{'id':'d11740e4-f6ae-4797-b839-46fdde078374','imagem':{'id':'1e988fa7-335f-40cd-bebf-fd9befe19c69','filename':'Screen Shot 2016-06-17 at 15.08.57.png','contentType':'image/png','dataCriacao':'24/06/2016 15:47:46','dataAtualizacao':'24/06/2016 15:47:46'},'demandaPrioritaria':false,'dataCriacao':'24/06/2016 17:41:38','dataAtualizacao':'24/06/2016 17:41:38'}}]}]};
        fakeInicializaWizard(scope, $q, objeto, scope.inicializaAssociacao);
      });

      it('Deve carregar o scope.aneis com a lista de aneis ativos', function() {
        expect(scope.aneis.length).toBe(1);
      });

      it('Não deve acessar a tela de associações caso não haja ao menos um estágio declarado', function () {
          scope.objeto = {idControlador: '1234567', aneis: [{}], modelo: {configuracao: {limiteAnel: 4}}};
          scope.inicializaAssociacao();
          scope.$apply();

          expect($state.current.name).not.toBe('app.wizard_controladores.associacao');
        });

      it('Os grupos semaforicos deverão estar ordenados por posicao', function() {
        expect(scope.aneis[0].gruposSemaforicos[0].posicao).toBe(1);
        expect(scope.aneis[0].gruposSemaforicos[1].posicao).toBe(2);
      });
    });

    describe('inicializaVerdesConflitantes', function() {
      beforeEach(function() {
        scope.objeto = {idControlador: '1234567', aneis: [{}], modelo: {configuracao: {limiteAnel: 4}}};
        fakeInicializaWizard(scope, $q, scope.objeto, scope.inicializaVerdesConflitantes);
        scope.$apply();
      });

      it('Não deve acessar a tela de verdes conflitantes caso não haja ao menos um grupo semaforico declarado',
        function () {
          expect($state.current.name).not.toBe('app.wizard_controladores.verdes_conflitantes');
        });
    });

    describe('inicializaTransicoesProibidas', function () {
      beforeEach(function() {
        scope.objeto = {idControlador: '1234567', aneis: [{}], modelo: {configuracao: {limiteAnel: 4}}};
        fakeInicializaWizard(scope, $q, scope.objeto, scope.inicializaTransicoesProibidas);
        scope.$apply();
      });

      it('Não deve acessar a tela de transicoes proibidas caso não haja aneis e estagios.',
        function () {
          expect($state.current.name).not.toBe('app.wizard_controladores.transicoes_proibidas');
        });
    })
  });

  describe('Wizard para edição de contrladores', function () {
    var helpers, id, objeto;
    beforeEach(inject(function($state) {
      id = 'id';
      $state.params.id = id;

      helpers = {"cidades":[{},{}],"fabricantes":[{},{},{}]};
      objeto = {id: 1, area: {id: 'area', cidade: {id: 'cidade'}}, modelo: {id: 'modelo', fabricante: {id: 'fab1'}}};
      $httpBackend.expectGET('/controladores/' + id).respond(objeto);
      $httpBackend.expectGET('/helpers/controlador').respond(helpers);
      scope.inicializaWizard();
      $httpBackend.flush();
    }));

    it('Inicializa Wizard: Deve inicializar o objeto conforme retornado pela api', function() {
      expect(scope.objeto.id).toEqual(objeto.id);
      expect(scope.objeto.area).toEqual(objeto.area);
      expect(scope.objeto.modelo).toEqual(objeto.modelo);
    });

    it('Inicializa Wizard: Deve atualizar os helpers com os dados do objeto', function() {
      expect(scope.helpers.cidade).toEqual(objeto.area.cidade);
      expect(scope.helpers.fornecedor).toEqual(objeto.modelo.fabricante);
    });

    describe('InicializaAneis', function () {
      beforeEach(function() {
        spyOn(scope, 'inicializaWizard').and.callFake(function() {
          var deferred = $q.defer();
          deferred.resolve({});
          return deferred.promise;
        });
      });

      it('Deve inicializar os campos de idAnel e posicao dos aneis', function() {
        scope.objeto = {idControlador: '1234567', aneis: [{}, {}], modelo: {configuracao: {limiteAnel: 4}}};
        scope.inicializaAneis();
        scope.$apply();

        expect(scope.objeto.aneis[0].idAnel).toBeDefined();
        expect(scope.objeto.aneis[0].posicao).toBeDefined();
      });

      it('Não deve acessar a tela de configuracao de aneis se ao menos um anel não for declarado para o controlador',
        function() {
          scope.objeto = {idControlador: '1234567', aneis: [], modelo: {configuracao: {limiteAnel: 4}}};
          scope.inicializaAneis();
          scope.$apply();

          expect($state.current.name).not.toBe('app.wizard_controladores.aneis');
        });
    });
  });

  describe('Funções auxiliares', function () {
    describe('desativaProximosAneis', function () {
      beforeEach(function() {
        scope.aneis = [{posicao: 1,ativo: true},{posicao: 2,ativo: true},{posicao: 3,ativo: true}];
      });

      it('Deve desativar os aneis 2 e 3, caso o anel 1 seja desativado', function() {
        var currentAnel = scope.aneis[0];
        scope.desativaProximosAneis(currentAnel);
        expect(scope.aneis[1].ativo).toBe(false);
        expect(scope.aneis[2].ativo).toBe(false);
      });
    });

    describe('toggleEstagioAtivado', function () {
      var grupo, estagio;

      beforeEach(function() {
        estagio = {id: '123'};
        grupo = {
          estagioGrupoSemaforicos: [{estagio: {id: '123'}}],
          estagiosAtivados: {'123': true}
        };
      });

      it('Deve desativar o estagio do grupo semaforicos caso este estaja ativo', function () {
        grupo.estagioGrupoSemaforicos[0].ativo = true;
        scope.toggleEstagioAtivado(grupo, estagio);
        expect(grupo.estagioGrupoSemaforicos[0].ativo).not.toBeTruthy();
      });

      it('Deve ativar o estagio do grupo semaforicos caso este não estaja ativo', function () {
        grupo.estagioGrupoSemaforicos[0].ativo = true;
        scope.toggleEstagioAtivado(grupo, estagio);
        expect(grupo.estagioGrupoSemaforicos[0].ativo).not.toBeTruthy();
      });

      it('Não deve alterar o status de nenhum estagio caso um estagio inexistente seja apresentado', function () {
        var grupoOriginal = _.cloneDeep(grupo);
        scope.toggleEstagioAtivado(grupo, {id: 456});
        expect(grupoOriginal).toEqual(grupo);
      });
    });

    describe('relacionaImagemAoEstagio', function () {
      it('Deve atribuir uma imagem ao estagio.', function() {
        var estagio = {};
        var imagem = 'img';
        scope.relacionaImagemAoEstagio(estagio, null, imagem);
        expect(estagio.imagem).toBe(imagem);
      });
    });

    describe('limpaTempoPermanencia', function () {
      it('quando o usuário desmarca o checkbox para "desativação de tempo máximo", ' +
        'o tempo de permanecia do estágio deverá ser excluido.', function () {
          var estagio = {tempoMaximoPermanencia: 1};
          scope.limpaTempoPermanencia(estagio);
          expect(estagio.tempoMaximoPermanencia).toBeNull();
        });
    });

    describe('closeAlert', function () {
      beforeEach(function() {
        scope.errors = {
          aneis: [{
            general: {},
            other: {},
          }]
        };
      });

      it('Ao fechar o alert de aneis, deve limpar a lista de general notifications', function() {
        scope.closeAlert(0);
        expect(scope.errors.aneis[0].general).toBeUndefined();
      });

      it('Deve limpar uma lista customizada, se houver um segundo parametro informado', function() {
        scope.closeAlert(0, 'other');
        expect(scope.errors.aneis[0].other).toBeUndefined();
      });

      it('Deve manter o objeto de erros inalterado se um anel incorreto for informado', function() {
        var originalErrors = _.cloneDeep(scope.errors);
        scope.closeAlert(1);
        expect(scope.errors).toEqual(originalErrors);
      });
    });

    describe('anelTemErro', function () {
      beforeEach(function() {
        scope.errors = {aneis: [{a: 1}]};
      });

      it('se houver algum erro listado, o objeto deve retornar true', function () {
        expect(scope.anelTemErro(0)).toBeTruthy();
      });

      it('se não houver erros listados, o objeto deve retornar false', function () {
        scope.errors.aneis = [];
        expect(scope.anelTemErro(0)).not.toBeTruthy();
      });
    });

    describe('toggleTransicaoProibida', function () {
      beforeEach(function() {
        var objeto = {"id":"ce3ee3dd-7f5e-4357-9663-f47f37c150f8","localizacao":"area 1","numeroSMEE":"area 1","numeroSMEEConjugado1":"12","numeroSMEEConjugado2":"123","numeroSMEEConjugado3":"123","firmware":"321","latitude":-19.9513211,"longitude":-43.921468600000026,"dataCriacao":"28/06/2016 23:31:32","dataAtualizacao":"28/06/2016 23:32:27","CLC":"1.000.0999","area":{"id":"6a2e0afd-616b-40eb-a834-60e33195b009","descricao":1,"dataCriacao":"28/06/2016 19:35:03","dataAtualizacao":"28/06/2016 19:35:03","cidade":{"id":"6db983c9-8b03-42f7-ac8b-f19d9b0b92d1","nome":"Belo Horizonte","dataCriacao":"28/06/2016 19:34:54","dataAtualizacao":"28/06/2016 19:34:54","areas":[{"id":"6a2e0afd-616b-40eb-a834-60e33195b009","descricao":1},{"id":"b9a85f3a-ac49-436b-a121-9af51db9b9a8","descricao":2}]},"limites":[]},"modelo":{"id":"820c1ede-f516-4377-9754-f8339f1f3071","descricao":"fab 1 opa","dataCriacao":"28/06/2016 19:36:07","dataAtualizacao":"28/06/2016 19:36:07","fabricante":{"id":"ecedfd9f-4649-470d-a10a-acaf10350da1","nome":"fab 1","dataCriacao":"28/06/2016 19:36:07","dataAtualizacao":"28/06/2016 19:36:07","modelos":[{"id":"820c1ede-f516-4377-9754-f8339f1f3071","descricao":"fab 1 opa","configuracao":{"id":"eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao":"opa","limiteEstagio":8,"limiteGrupoSemaforico":8,"limiteAnel":8,"limiteDetectorPedestre":8,"limiteDetectorVeicular":8,"dataCriacao":"28/06/2016 19:35:52","dataAtualizacao":"28/06/2016 19:35:52"}}]},"configuracao":{"id":"eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao":"opa","limiteEstagio":8,"limiteGrupoSemaforico":8,"limiteAnel":8,"limiteDetectorPedestre":8,"limiteDetectorVeicular":8,"dataCriacao":"28/06/2016 19:35:52","dataAtualizacao":"28/06/2016 19:35:52"}},"aneis":[{"id":"16a2cf30-3957-4d99-a6bf-bdec16e5891f","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"19883586-ff33-4585-a004-311dcb3aada0","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"41bfb905-3950-414c-9ee6-147b13bc70f8","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"578ac07c-68ce-4e72-8368-424b8ef506a2","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"aba2b4c3-de65-4baa-b064-1375199e40b8","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"d7c5dc59-3f83-4c66-ac05-4dcfb5429de7","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"efc70dee-08d1-4bf2-b38d-5143dde2a84e","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"fabea98b-bd33-480b-8b10-48332849fe9b","numeroSMEE":"teste","ativo":true,"posicao":1,"latitude":-19.9513211,"longitude":-43.921468600000026,"quantidadeGrupoPedestre":2,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:31:32","dataAtualizacao":"28/06/2016 23:32:27","estagios":[{"id":"6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem":{"id":"4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename":"13406967_1003062549749489_543993289383831132_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},{"id":"f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem":{"id":"8e58963d-2b83-43ec-82eb-8609b2016bfd","filename":"12321359_986438248070903_1173574894423312875_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"}],"gruposSemaforicos":[{"id":"5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":1,"descricao":"veicular g1","estagioGrupoSemaforicos":[{"id":"3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem":{"id":"4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename":"13406967_1003062549749489_543993289383831132_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id":"82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":2,"descricao":"veicular g2","estagioGrupoSemaforicos":[{"id":"48030015-0332-4a56-a02b-c9fa54521462","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem":{"id":"8e58963d-2b83-43ec-82eb-8609b2016bfd","filename":"12321359_986438248070903_1173574894423312875_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"82b80f5f-82b8-4905-865e-932e324a9796"}}]}]}],"gruposSemaforicos":[{"id":"5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":1,"descricao":"veicular g1","estagioGrupoSemaforicos":[{"id":"3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem":{"id":"4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename":"13406967_1003062549749489_543993289383831132_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id":"82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":2,"descricao":"veicular g2","estagioGrupoSemaforicos":[{"id":"48030015-0332-4a56-a02b-c9fa54521462","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem":{"id":"8e58963d-2b83-43ec-82eb-8609b2016bfd","filename":"12321359_986438248070903_1173574894423312875_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"82b80f5f-82b8-4905-865e-932e324a9796"}}]}],"route":"controladores","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false};
        fakeInicializaWizard(scope, $q, objeto, scope.inicializaTransicoesProibidas);
      });

      it('se a intercessão e1xe1 for clicada, o metodo deverá ser interrompido sem causar alterações', function() {
        var estagio1 = scope.currentAnel.estagios[0];
        scope.toggleTransicaoProibida(estagio1, estagio1, true);

        expect(estagio1.origemDeTransicoesProibidas).not.toBeDefined();
        expect(estagio1.destinoDeTransicoesProibidas).not.toBeDefined();
      });

      describe('Ativação/desativação da intercessão dos estágios E1-E2', function() {
        var estagio1, estagio2;
        beforeEach(function() {
          estagio1 = scope.currentAnel.estagios[0];
          estagio2 = scope.currentAnel.estagios[1];
          scope.toggleTransicaoProibida(estagio1, estagio2, false);
        });

        it('O estagio e1 será origem de uma transicao proibida para e2 em "origemDeTransicoesProibidas" do estagio1', function() {
          expect(estagio1.origemDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
        });

        it('O estágio e1 será origem de uma transicao proibida para e2 em "destinoDeTransicoesProibidas" do estagio2', function() {
          expect(estagio2.destinoDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
        });

        it('O estagio e2 será destino de uma transição proibida para e1 em "origemDeTransicoesProibidas do estagio1"', function() {
          expect(estagio1.origemDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
        });

        it('O estagio e2 será destino de uma transição proibida para e1 em "destinoDeTransicoesProibidas" do estagio2', function() {
          expect(estagio2.destinoDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
        });

        it('O objeto de transicoesProibidasDoAnel deverá ter um atributo igual a "`e1.posicao`_`e2.posicao`"', function() {
          var transicao = 'E' + estagio1.posicao + '-E' + estagio2.posicao;
          var transicaoNoAnel = scope.currentAnel.transicoesProibidas[transicao];
          expect(transicaoNoAnel).toBeDefined();
          expect(transicaoNoAnel.id).toEqual(estagio1.origemDeTransicoesProibidas[0].id);
        });

        it('Quando o usuario desativa a intercessão E1-E2, os campos de origem e destino de ambos deverão ser removidos', function() {
          scope.toggleTransicaoProibida(estagio1, estagio2, false);
          expect(estagio1.origemDeTransicoesProibidas.length).toBe(0);
          expect(estagio2.destinoDeTransicoesProibidas.length).toBe(0);
          expect(estagio1.origemDeTransicoesProibidas.length).toBe(0);
          expect(estagio2.destinoDeTransicoesProibidas.length).toBe(0);
        });

        it('Quando o usuario desativa a intercessão E1-E2, o atributo "`e1.id`_`e2.id`" de transicoesProibidasDoAnel deverá ser removido', function() {
          scope.toggleTransicaoProibida(estagio1, estagio2, false);
          var transicao = 'E' + estagio1.posicao + '-E' + estagio2.posicao;
          expect(scope.currentAnel.transicoesProibidas[transicao]).not.toBeDefined();
        });
      });
    });

    describe('marcarTransicaoAlternativa', function () {
      var estagio1, estagio2, estagio3, estagio4;
      describe('Dado que a transicacao E1-E2 receba o estágio E3 como alternativo', function () {
        beforeEach(function() {
          var objeto = {"id": "ce3ee3dd-7f5e-4357-9663-f47f37c150f8","localizacao": "area 1","numeroSMEE": "area 1","numeroSMEEConjugado1": "12","numeroSMEEConjugado2": "123","numeroSMEEConjugado3": "123","firmware": "321","latitude": -19.9513211,"longitude": -43.921468600000026,"dataCriacao": "28/06/2016 23:31:32","dataAtualizacao": "28/06/2016 23:32:27","CLC": "1.000.0999","area": {"id": "6a2e0afd-616b-40eb-a834-60e33195b009","descricao": 1,"dataCriacao": "28/06/2016 19:35:03","dataAtualizacao": "28/06/2016 19:35:03","cidade": {"id": "6db983c9-8b03-42f7-ac8b-f19d9b0b92d1","nome": "Belo Horizonte","dataCriacao": "28/06/2016 19:34:54","dataAtualizacao": "28/06/2016 19:34:54","areas": [{"id": "6a2e0afd-616b-40eb-a834-60e33195b009","descricao": 1},{"id": "b9a85f3a-ac49-436b-a121-9af51db9b9a8","descricao": 2}]},"limites": []},"modelo": {"id": "820c1ede-f516-4377-9754-f8339f1f3071","descricao": "fab 1 opa","dataCriacao": "28/06/2016 19:36:07","dataAtualizacao": "28/06/2016 19:36:07","fabricante": {"id": "ecedfd9f-4649-470d-a10a-acaf10350da1","nome": "fab 1","dataCriacao": "28/06/2016 19:36:07","dataAtualizacao": "28/06/2016 19:36:07","modelos": [{"id": "820c1ede-f516-4377-9754-f8339f1f3071","descricao": "fab 1 opa","configuracao": {"id": "eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao": "opa","limiteEstagio": 8,"limiteGrupoSemaforico": 8,"limiteAnel": 8,"limiteDetectorPedestre": 8,"limiteDetectorVeicular": 8,"dataCriacao": "28/06/2016 19:35:52","dataAtualizacao": "28/06/2016 19:35:52"}}]},"configuracao": {"id": "eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao": "opa","limiteEstagio": 8,"limiteGrupoSemaforico": 8,"limiteAnel": 8,"limiteDetectorPedestre": 8,"limiteDetectorVeicular": 8,"dataCriacao": "28/06/2016 19:35:52","dataAtualizacao": "28/06/2016 19:35:52"}},"aneis": [{"id": "16a2cf30-3957-4d99-a6bf-bdec16e5891f","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "19883586-ff33-4585-a004-311dcb3aada0","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "41bfb905-3950-414c-9ee6-147b13bc70f8","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "578ac07c-68ce-4e72-8368-424b8ef506a2","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "aba2b4c3-de65-4baa-b064-1375199e40b8","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "d7c5dc59-3f83-4c66-ac05-4dcfb5429de7","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "efc70dee-08d1-4bf2-b38d-5143dde2a84e","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "fabea98b-bd33-480b-8b10-48332849fe9b","numeroSMEE": "teste","ativo": true,"posicao": 1,"latitude": -19.9513211,"longitude": -43.921468600000026,"quantidadeGrupoPedestre": 2,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:31:32","dataAtualizacao": "28/06/2016 23:32:27","estagios": [{"id": "estagio-1"},{"id": "estagio-2"},{"id": "estagio-3"},{"id": "estagio-4"}],"gruposSemaforicos": [{"id": "5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 1,"descricao": "veicular g1","estagioGrupoSemaforicos": [{"id": "3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem": {"id": "4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename": "13406967_1003062549749489_543993289383831132_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id": "82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 2,"descricao": "veicular g2","estagioGrupoSemaforicos": [{"id": "48030015-0332-4a56-a02b-c9fa54521462","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem": {"id": "8e58963d-2b83-43ec-82eb-8609b2016bfd","filename": "12321359_986438248070903_1173574894423312875_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "82b80f5f-82b8-4905-865e-932e324a9796"}}]}]}],"gruposSemaforicos": [{"id": "5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 1,"descricao": "veicular g1","estagioGrupoSemaforicos": [{"id": "3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem": {"id": "4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename": "13406967_1003062549749489_543993289383831132_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id": "82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 2,"descricao": "veicular g2","estagioGrupoSemaforicos": [{"id": "48030015-0332-4a56-a02b-c9fa54521462","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem": {"id": "8e58963d-2b83-43ec-82eb-8609b2016bfd","filename": "12321359_986438248070903_1173574894423312875_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "82b80f5f-82b8-4905-865e-932e324a9796"}}]}],"route": "controladores","reqParams": null,"restangularized": true,"fromServer": true,"parentResource": null,"restangularCollection": false};
          fakeInicializaWizard(scope, $q, objeto, scope.inicializaTransicoesProibidas);
          estagio1 = scope.currentAnel.estagios[0];
          estagio2 = scope.currentAnel.estagios[1];
          estagio3 = scope.currentAnel.estagios[2];
          estagio4 = scope.currentAnel.estagios[3];
          scope.toggleTransicaoProibida(estagio1, estagio2, false);
          scope.marcarTransicaoAlternativa(
            {origem: {id: estagio1.id}, destino: {id: estagio2.id}, alternativo: {id: estagio3.id}}
          );
        });

        it('O estágio E1 deve ter um objeto em origemDeTransicoesProibidas, com origem = E1, destino = E2 e alternativo = E3',
          function() {
            expect(estagio1.origemDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
            expect(estagio1.origemDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
            expect(estagio1.origemDeTransicoesProibidas[0].alternativo.id).toBe(estagio3.id);
          });
        it('O estágio E2 deve ter um objeto em destinoDeTransicoesProibidas, com origem = E1, destino = E2 e alternativo = E3',
          function() {
            expect(estagio2.destinoDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
            expect(estagio2.destinoDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
            expect(estagio2.destinoDeTransicoesProibidas[0].alternativo.id).toBe(estagio3.id);
          });
        it('O estágio E3 deve ter um objeto em alternativaDeTransicoesProibidas, com origem = E1, destino = E2 e alternativo = E3',
          function() {
            expect(estagio3.alternativaDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
            expect(estagio3.alternativaDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
            expect(estagio3.alternativaDeTransicoesProibidas[0].alternativo.id).toBe(estagio3.id);
          });
        it('O estagio E4 não deverá ter objetos em nenhum dos campos de transicoesProibidas',
          function() {
            expect(estagio4.origemDeTransicoesProibidas).not.toBeDefined();
            expect(estagio4.destinoDeTransicoesProibidas).not.toBeDefined();
            expect(estagio4.alternativaDeTransicoesProibidas).not.toBeDefined();
          });

        describe('Dado que a alternativa de E1-E2 seja alterada para E4', function () {
          beforeEach(function() {
            scope.marcarTransicaoAlternativa(
              {origem: {id: estagio1.id}, destino: {id: estagio2.id}, alternativo: {id: estagio4.id}}
            );
          });

          it('O estágio E1 deve ter um objeto em origemDeTransicoesProibidas, com origem = E1, destino = E2 e alternativo = E4',
            function() {
              expect(estagio1.origemDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
              expect(estagio1.origemDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
              expect(estagio1.origemDeTransicoesProibidas[0].alternativo.id).toBe(estagio4.id);
            });
          it('O estágio E2 deve ter um objeto em destinoDeTransicoesProibidas, com origem = E1, destino = E2 e alternativo = E4',
            function() {
              expect(estagio2.destinoDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
              expect(estagio2.destinoDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
              expect(estagio2.destinoDeTransicoesProibidas[0].alternativo.id).toBe(estagio4.id);
            });
          it('O estagio E3 não deverá ter objetos em nenhum dos campos de transicoesProibidas',
            function() {
              expect(estagio3.origemDeTransicoesProibidas).not.toBeDefined();
              expect(estagio3.destinoDeTransicoesProibidas).not.toBeDefined();
              expect(estagio3.alternativaDeTransicoesProibidas[0]).not.toBeDefined();
            });
          it('O estágio E4 deve ter um objeto em alternativaDeTransicoesProibidas, com origem = E1, destino = E2 e alternativo = E4',
            function() {
              expect(estagio4.alternativaDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
              expect(estagio4.alternativaDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
              expect(estagio4.alternativaDeTransicoesProibidas[0].alternativo.id).toBe(estagio4.id);
            });
        });

        describe('Dado que a alternativa de E1-E2 seja apagada', function () {
          beforeEach(function() {
            scope.marcarTransicaoAlternativa(
              {origem: {id: estagio1.id}, destino: {id: estagio2.id}, alternativo: null}
            );
          });

          it('O estágio E1 deve ter um objeto em origemDeTransicoesProibidas, com origem = E1 e destino = E2',
            function() {
              expect(estagio1.origemDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
              expect(estagio1.origemDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
              expect(estagio1.origemDeTransicoesProibidas[0].alternativo).toBe(null);
            });
          it('O estágio E2 deve ter um objeto em destinoDeTransicoesProibidas, com origem = E1 e destino = E2',
            function() {
              expect(estagio2.destinoDeTransicoesProibidas[0].origem.id).toBe(estagio1.id);
              expect(estagio2.destinoDeTransicoesProibidas[0].destino.id).toBe(estagio2.id);
              expect(estagio2.destinoDeTransicoesProibidas[0].alternativo).toBe(null);
            });
          it('O estagio E3 não deverá ter objetos em nenhum dos campos de transicoesProibidas',
            function() {
              expect(estagio3.origemDeTransicoesProibidas).not.toBeDefined();
              expect(estagio3.destinoDeTransicoesProibidas).not.toBeDefined();
              expect(estagio3.alternativaDeTransicoesProibidas[0]).not.toBeDefined();
            });
          it('O estagio E4 não deverá ter objetos em nenhum dos campos de transicoesProibidas',
            function() {
              expect(estagio4.origemDeTransicoesProibidas).not.toBeDefined();
              expect(estagio4.destinoDeTransicoesProibidas).not.toBeDefined();
              expect(estagio4.alternativaDeTransicoesProibidas).not.toBeDefined();
            });
        });
      });
    });

    describe('filterEstagiosAlternativos', function () {
      var estagio1, estagio2, estagio3;
      beforeEach(function() {
        var objeto = {"id": "ce3ee3dd-7f5e-4357-9663-f47f37c150f8","localizacao": "area 1","numeroSMEE": "area 1","numeroSMEEConjugado1": "12","numeroSMEEConjugado2": "123","numeroSMEEConjugado3": "123","firmware": "321","latitude": -19.9513211,"longitude": -43.921468600000026,"dataCriacao": "28/06/2016 23:31:32","dataAtualizacao": "28/06/2016 23:32:27","CLC": "1.000.0999","area": {"id": "6a2e0afd-616b-40eb-a834-60e33195b009","descricao": 1,"dataCriacao": "28/06/2016 19:35:03","dataAtualizacao": "28/06/2016 19:35:03","cidade": {"id": "6db983c9-8b03-42f7-ac8b-f19d9b0b92d1","nome": "Belo Horizonte","dataCriacao": "28/06/2016 19:34:54","dataAtualizacao": "28/06/2016 19:34:54","areas": [{"id": "6a2e0afd-616b-40eb-a834-60e33195b009","descricao": 1},{"id": "b9a85f3a-ac49-436b-a121-9af51db9b9a8","descricao": 2}]},"limites": []},"modelo": {"id": "820c1ede-f516-4377-9754-f8339f1f3071","descricao": "fab 1 opa","dataCriacao": "28/06/2016 19:36:07","dataAtualizacao": "28/06/2016 19:36:07","fabricante": {"id": "ecedfd9f-4649-470d-a10a-acaf10350da1","nome": "fab 1","dataCriacao": "28/06/2016 19:36:07","dataAtualizacao": "28/06/2016 19:36:07","modelos": [{"id": "820c1ede-f516-4377-9754-f8339f1f3071","descricao": "fab 1 opa","configuracao": {"id": "eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao": "opa","limiteEstagio": 8,"limiteGrupoSemaforico": 8,"limiteAnel": 8,"limiteDetectorPedestre": 8,"limiteDetectorVeicular": 8,"dataCriacao": "28/06/2016 19:35:52","dataAtualizacao": "28/06/2016 19:35:52"}}]},"configuracao": {"id": "eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao": "opa","limiteEstagio": 8,"limiteGrupoSemaforico": 8,"limiteAnel": 8,"limiteDetectorPedestre": 8,"limiteDetectorVeicular": 8,"dataCriacao": "28/06/2016 19:35:52","dataAtualizacao": "28/06/2016 19:35:52"}},"aneis": [{"id": "16a2cf30-3957-4d99-a6bf-bdec16e5891f","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "19883586-ff33-4585-a004-311dcb3aada0","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "41bfb905-3950-414c-9ee6-147b13bc70f8","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "578ac07c-68ce-4e72-8368-424b8ef506a2","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "aba2b4c3-de65-4baa-b064-1375199e40b8","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "d7c5dc59-3f83-4c66-ac05-4dcfb5429de7","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "efc70dee-08d1-4bf2-b38d-5143dde2a84e","ativo": false,"quantidadeGrupoPedestre": 0,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","estagios": [],"gruposSemaforicos": []},{"id": "fabea98b-bd33-480b-8b10-48332849fe9b","numeroSMEE": "teste","ativo": true,"posicao": 1,"latitude": -19.9513211,"longitude": -43.921468600000026,"quantidadeGrupoPedestre": 2,"quantidadeGrupoVeicular": 0,"quantidadeDetectorPedestre": 0,"quantidadeDetectorVeicular": 0,"dataCriacao": "28/06/2016 23:31:32","dataAtualizacao": "28/06/2016 23:32:27","estagios": [{"id": "6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem": {"id": "4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename": "13406967_1003062549749489_543993289383831132_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},{"id": "f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem": {"id": "8e58963d-2b83-43ec-82eb-8609b2016bfd","filename": "12321359_986438248070903_1173574894423312875_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},{"id": "f6d285ef-83a3-4498-a4da-d8c1d2c6d7ee"}],"gruposSemaforicos": [{"id": "5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 1,"descricao": "veicular g1","estagioGrupoSemaforicos": [{"id": "3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem": {"id": "4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename": "13406967_1003062549749489_543993289383831132_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id": "82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 2,"descricao": "veicular g2","estagioGrupoSemaforicos": [{"id": "48030015-0332-4a56-a02b-c9fa54521462","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem": {"id": "8e58963d-2b83-43ec-82eb-8609b2016bfd","filename": "12321359_986438248070903_1173574894423312875_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "82b80f5f-82b8-4905-865e-932e324a9796"}}]}]}],"gruposSemaforicos": [{"id": "5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 1,"descricao": "veicular g1","estagioGrupoSemaforicos": [{"id": "3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem": {"id": "4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename": "13406967_1003062549749489_543993289383831132_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id": "82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao": "28/06/2016 23:31:55","dataAtualizacao": "28/06/2016 23:32:27","tipo": "PEDESTRE","posicao": 2,"descricao": "veicular g2","estagioGrupoSemaforicos": [{"id": "48030015-0332-4a56-a02b-c9fa54521462","dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27","ativo": true,"estagio": {"id": "f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem": {"id": "8e58963d-2b83-43ec-82eb-8609b2016bfd","filename": "12321359_986438248070903_1173574894423312875_n.jpg","contentType": "image/jpeg","dataCriacao": "28/06/2016 23:31:52","dataAtualizacao": "28/06/2016 23:31:52"},"demandaPrioritaria": false,"dataCriacao": "28/06/2016 23:32:27","dataAtualizacao": "28/06/2016 23:32:27"},"grupoSemaforico": {"id": "82b80f5f-82b8-4905-865e-932e324a9796"}}]}],"route": "controladores","reqParams": null,"restangularized": true,"fromServer": true,"parentResource": null,"restangularCollection": false};
        fakeInicializaWizard(scope, $q, objeto, scope.inicializaTransicoesProibidas);

        estagio1 = scope.currentAnel.estagios[0];
        estagio2 = scope.currentAnel.estagios[1];
        estagio3 = scope.currentAnel.estagios[2];
        scope.toggleTransicaoProibida(estagio1, estagio2, false);
        scope.marcarTransicaoAlternativa({origem: estagio1, destino: estagio2, alternativo: estagio3});
      });

      it('Em uma lista de estágios (E1, E2, E3), a transicao E1-E2 pode ter somente E3 como alternativa',
        inject(function($filter) {
          var filter = $filter('filter')(
            scope.currentAnel.estagios,
            scope.filterEstagiosAlternativos(estagio1, estagio2)
          );
          expect(filter.length).toBe(1);
        }));
    })

    describe('toggleVerdeConflitante', function () {
      beforeEach(function() {
        var objeto = {"id":"ce3ee3dd-7f5e-4357-9663-f47f37c150f8","localizacao":"area 1","numeroSMEE":"area 1","numeroSMEEConjugado1":"12","numeroSMEEConjugado2":"123","numeroSMEEConjugado3":"123","firmware":"321","latitude":-19.9513211,"longitude":-43.921468600000026,"dataCriacao":"28/06/2016 23:31:32","dataAtualizacao":"28/06/2016 23:32:27","CLC":"1.000.0999","area":{"id":"6a2e0afd-616b-40eb-a834-60e33195b009","descricao":1,"dataCriacao":"28/06/2016 19:35:03","dataAtualizacao":"28/06/2016 19:35:03","cidade":{"id":"6db983c9-8b03-42f7-ac8b-f19d9b0b92d1","nome":"Belo Horizonte","dataCriacao":"28/06/2016 19:34:54","dataAtualizacao":"28/06/2016 19:34:54","areas":[{"id":"6a2e0afd-616b-40eb-a834-60e33195b009","descricao":1},{"id":"b9a85f3a-ac49-436b-a121-9af51db9b9a8","descricao":2}]},"limites":[]},"modelo":{"id":"820c1ede-f516-4377-9754-f8339f1f3071","descricao":"fab 1 opa","dataCriacao":"28/06/2016 19:36:07","dataAtualizacao":"28/06/2016 19:36:07","fabricante":{"id":"ecedfd9f-4649-470d-a10a-acaf10350da1","nome":"fab 1","dataCriacao":"28/06/2016 19:36:07","dataAtualizacao":"28/06/2016 19:36:07","modelos":[{"id":"820c1ede-f516-4377-9754-f8339f1f3071","descricao":"fab 1 opa","configuracao":{"id":"eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao":"opa","limiteEstagio":8,"limiteGrupoSemaforico":8,"limiteAnel":8,"limiteDetectorPedestre":8,"limiteDetectorVeicular":8,"dataCriacao":"28/06/2016 19:35:52","dataAtualizacao":"28/06/2016 19:35:52"}}]},"configuracao":{"id":"eeff04ca-ed6e-4ead-9b6a-0ba84b4adbb0","descricao":"opa","limiteEstagio":8,"limiteGrupoSemaforico":8,"limiteAnel":8,"limiteDetectorPedestre":8,"limiteDetectorVeicular":8,"dataCriacao":"28/06/2016 19:35:52","dataAtualizacao":"28/06/2016 19:35:52"}},"aneis":[{"id":"16a2cf30-3957-4d99-a6bf-bdec16e5891f","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"19883586-ff33-4585-a004-311dcb3aada0","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"41bfb905-3950-414c-9ee6-147b13bc70f8","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"578ac07c-68ce-4e72-8368-424b8ef506a2","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"aba2b4c3-de65-4baa-b064-1375199e40b8","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"d7c5dc59-3f83-4c66-ac05-4dcfb5429de7","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"efc70dee-08d1-4bf2-b38d-5143dde2a84e","ativo":false,"quantidadeGrupoPedestre":0,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","estagios":[],"gruposSemaforicos":[]},{"id":"fabea98b-bd33-480b-8b10-48332849fe9b","numeroSMEE":"teste","ativo":true,"posicao":1,"latitude":-19.9513211,"longitude":-43.921468600000026,"quantidadeGrupoPedestre":2,"quantidadeGrupoVeicular":0,"quantidadeDetectorPedestre":0,"quantidadeDetectorVeicular":0,"dataCriacao":"28/06/2016 23:31:32","dataAtualizacao":"28/06/2016 23:32:27","estagios":[{"id":"6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem":{"id":"4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename":"13406967_1003062549749489_543993289383831132_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},{"id":"f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem":{"id":"8e58963d-2b83-43ec-82eb-8609b2016bfd","filename":"12321359_986438248070903_1173574894423312875_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"}],"gruposSemaforicos":[{"id":"5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":1,"descricao":"veicular g1","estagioGrupoSemaforicos":[{"id":"3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem":{"id":"4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename":"13406967_1003062549749489_543993289383831132_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id":"82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":2,"descricao":"veicular g2","estagioGrupoSemaforicos":[{"id":"48030015-0332-4a56-a02b-c9fa54521462","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem":{"id":"8e58963d-2b83-43ec-82eb-8609b2016bfd","filename":"12321359_986438248070903_1173574894423312875_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"82b80f5f-82b8-4905-865e-932e324a9796"}}]}]}],"gruposSemaforicos":[{"id":"5225d0bc-5b41-4b40-8647-73a985e54997","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":1,"descricao":"veicular g1","estagioGrupoSemaforicos":[{"id":"3e61befa-e09c-4e2e-8470-f0224f494712","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"6b95029b-bba8-4186-9875-fd62b8f0d1de","imagem":{"id":"4b1a186f-df95-4cf0-8bf6-9fe01cb89bfe","filename":"13406967_1003062549749489_543993289383831132_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"5225d0bc-5b41-4b40-8647-73a985e54997"}}]},{"id":"82b80f5f-82b8-4905-865e-932e324a9796","dataCriacao":"28/06/2016 23:31:55","dataAtualizacao":"28/06/2016 23:32:27","tipo":"PEDESTRE","posicao":2,"descricao":"veicular g2","estagioGrupoSemaforicos":[{"id":"48030015-0332-4a56-a02b-c9fa54521462","dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27","ativo":true,"estagio":{"id":"f6d285ef-83a3-4498-a4da-d8c1d2c6d7ff","imagem":{"id":"8e58963d-2b83-43ec-82eb-8609b2016bfd","filename":"12321359_986438248070903_1173574894423312875_n.jpg","contentType":"image/jpeg","dataCriacao":"28/06/2016 23:31:52","dataAtualizacao":"28/06/2016 23:31:52"},"demandaPrioritaria":false,"dataCriacao":"28/06/2016 23:32:27","dataAtualizacao":"28/06/2016 23:32:27"},"grupoSemaforico":{"id":"82b80f5f-82b8-4905-865e-932e324a9796"}}]}],"route":"controladores","reqParams":null,"restangularized":true,"fromServer":true,"parentResource":null,"restangularCollection":false};
        fakeInicializaWizard(scope, $q, objeto, scope.inicializaVerdesConflitantes);
      });

      it('se a caixa de verde conflitante clicada estiver desabilitada, os verdes conflitantes não serão alterados',
        function() {
          scope.toggleVerdeConflitante(0, 0, true);
          expect(scope.verdesConflitantes[0][0]).not.toBeTruthy();
        });

      describe('Ativação de um verde conflitante.', function () {
        it('Deve adicionar o id do grupo "y" nos verdes conflitantes do grupo "x"', function() {

          var gruposAneis = _.chain(scope.objeto.aneis).map('gruposSemaforicos').flatten().value();
          var grupo0 = _.find(gruposAneis, {posicao: 1});
          var grupo1 = _.find(gruposAneis, {posicao: 2});
          scope.toggleVerdeConflitante(0, 1);

          expect(grupo0.verdesConflitantes.length).toBe(1);
          expect(grupo0.verdesConflitantes[0].id).toBe(grupo1.id);
        });

        it('A matriz deve marcar a posicao 0x1 como verde conflitante.', function() {
          scope.toggleVerdeConflitante(0, 1);
          expect(scope.verdesConflitantes[0][1]).toBeTruthy();
        });

        it('se a posicao 0x1 é verde conflitante, a posicao 1x0 também deverá ser.', function() {
          scope.toggleVerdeConflitante(0, 1);
          expect(scope.verdesConflitantes[0][1]).toBeTruthy();
          expect(scope.verdesConflitantes[1][0]).toBeTruthy();
        });

        it('Dado que o elemento (x, y) foi marcado como verde conflitante, o elemento (y, x) ' +
          'também deverá ser marcado.', function () {
          var gruposAneis = _.chain(scope.objeto.aneis).map('gruposSemaforicos').flatten().value();
          var grupo0 = _.find(gruposAneis, {posicao: 1});
          var grupo1 = _.find(gruposAneis, {posicao: 2});
          scope.toggleVerdeConflitante(0, 1);

          expect(grupo0.verdesConflitantes.length).toBe(1);
          expect(grupo0.verdesConflitantes[0].id).toBe(grupo1.id);
          expect(grupo1.verdesConflitantes.length).toBe(1);
          expect(grupo1.verdesConflitantes[0].id).toBe(grupo0.id);
        });
      });

      describe('desativação de um verde conflitante.', function () {
        beforeEach(function() {
          scope.toggleVerdeConflitante(0, 1);
        });

        it('O grupo "x" não deve ter verdes conflitantes', function() {
          var gruposAneis = _.chain(scope.objeto.aneis).map('gruposSemaforicos').flatten().value();
          var grupo0 = _.find(gruposAneis, {posicao: 1});
          scope.toggleVerdeConflitante(0, 1);
          expect(grupo0.verdesConflitantes.length).toBe(0);
        });

        it('A matriz deve apontar a posicao 0x0 como um verde não conflitante', function () {
          scope.toggleVerdeConflitante(0, 1);
          expect(scope.verdesConflitantes[0][1]).not.toBeTruthy();
        });
      });
    });

    describe('relacionaImagemAoEstagio', function () {
      var imagem;
      beforeEach(function() {
        scope.currentAnel = {};
        imagem = {id: 1};
      });

      it('Deve criar um array de estagios no estagio, caso nao exista', function() {
        scope.associaImagemAoEstagio(null, {id: 1});
        expect(scope.currentAnel.estagios).toBeDefined();
      });

      it('Deve adicionar mais um elemento à lista de estagios, caso este já esteja definido', function() {
        scope.currentAnel.estagios = [];
        scope.associaImagemAoEstagio(null, {id: 1});
        expect(scope.currentAnel.estagios).toBeDefined();
      });

      it('Deve atribuir uma imagem ao estagio.', function() {
        scope.associaImagemAoEstagio(null, {id: 1});
        expect(scope.currentAnel.estagios[0].imagem).toEqual(imagem);
      });
    });
  });
});
