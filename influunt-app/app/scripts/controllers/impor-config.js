'use strict';

/**
 * @ngdoc function
 * @name influuntApp:ImporConfigCtrl
 * @description
 * # ImporConfigCtrl
 * Controller of the influuntApp
 */
angular.module('influuntApp')
  .controller('ImporConfigCtrl', ['$scope', '$controller', '$filter', 'Restangular',
                                  'influuntBlockui', 'pahoProvider', 'eventosDinamicos', 'mqttTransactionStatusService',
    function ($scope, $controller, $filter, Restangular,
              influuntBlockui, pahoProvider, eventosDinamicos, mqttTransactionStatusService) {

      var setData, setAneisPlanosImpostos, updateImposicoesEmAneis, registerWatcher, envelopeTracker, filtraObjetosAneis;

      $controller('CrudCtrl', {$scope: $scope});
      $scope.inicializaNovoCrud('controladores');
      $scope.dadosControlador = {erros: ''};
      $scope.dadosTransacao = {tempoMaximoEspera: 60};

      $scope.pesquisa = {
        campos: [
          {
            nome: 'filtrarPor',
            label: 'relatorios.filtarPor',
            tipo: 'select',
            options: ['Subarea', 'Agrupamento']
          },
          {
            nome: 'subareaAgrupamento',
            label: 'relatorios.subareaAgrupamento',
            tipo: 'texto'
          },
          {
            nome: 'nomeDoEndereco',
            label: 'controladores.nomeEndereco',
            tipo: 'texto'
          }
        ]
      };

      $scope.pagination = {
        perPage: 30,
        current: 1
      };

      $scope.esconderPerPage = true;

      $scope.aneisSelecionados = [];
      $scope.aneisSelecionadosObj = [];
      $scope.dataSincronizar = {};
      $scope.dataImposicaoModo = {};
      $scope.isAnelChecked = {};
      $scope.statusTransacoes = {};

      $scope.index = function() {
        var query = $scope.buildQuery($scope.pesquisa);
        return Restangular.all('controladores').customGET('imposicao', query)
          .then(function(res) {
            setData(res);
            return Restangular.one('monitoramento', 'status_aneis').get();
          })
          .then(setAneisPlanosImpostos)
          .finally(influuntBlockui.unblock);
      };

      filtraObjetosAneis = function() {
        $scope.aneisSelecionadosObj = _.filter($scope.lista, function(anel) {
          return $scope.aneisSelecionados.indexOf(anel.id) >= 0;
        });

        return $scope.aneisSelecionadosObj;
      };

      $scope.selecionaAnel = function(anelId) {
        $scope.aneisSelecionados.push(anelId);
        filtraObjetosAneis();
      };

      $scope.desselecionaAnel = function(anelId) {
        _.pull($scope.aneisSelecionados, anelId);
        filtraObjetosAneis();
      };

      $scope.isAnelCheckedFilter = function(anel) {
        return $scope.isAnelChecked && anel && $scope.isAnelChecked[anel.id];
      };

      $scope.continuar = function() {
      };

      $scope.abortar = function() {

      };

      setData = function(response) {
        $scope.lista = response.data;

        $scope.idsTransacoes = {};
        _.each($scope.lista, function(anel) {
          $scope.idsTransacoes[anel.controladorFisicoId] = null;
        });

        $scope.pagination.totalItems = $scope.lista.length;
      };

      setAneisPlanosImpostos = function(statusObj) {
        return updateImposicoesEmAneis(statusObj.statusPlanos);
      };

      updateImposicoesEmAneis = function(statuses) {
        return _.map(statuses, function(status) {
          return _
            .chain($scope.lista)
            .find({controlador: {id: status.idControlador}, posicao: parseInt(status.anelPosicao)})
            .set('hasPlanoImposto', status.hasPlanoImposto)
            .set('modoOperacao', _.chain(status.modoOperacao).lowerCase().upperFirst().value())
            .set('inicio', status.inicio)
            .value();
        });
      };

      $scope.lerDados = function(controladorId) {
        envelopeTracker(controladorId);
        return Restangular
          .one('controladores')
          .customPOST({id: controladorId}, 'ler_dados')
          .finally(influuntBlockui.unblock);
      };

      envelopeTracker = function(id) {
        return mqttTransactionStatusService
          .watchDadosControlador(id)
          .then(function(conteudo) {
            return Restangular.one("monitoramento/").customGET('erros_controladores/'+id+'/historico_falha/0/60', null)
              .then(function(response) {
                $scope.dadosControlador = conteudo;
                $scope.dadosControlador.erros = response;
              })
              .finally(influuntBlockui.unblock);
          });
      };

      $scope.$watch('statusObj.transacoes', function(transacoesPorControlador) {
        $scope.transacoesPendentes = $scope.transacoesPendentes || [];
        if (transacoesPorControlador) {
          $scope.transacoesPendentes = _
            .chain(transacoesPorControlador)
            .values()
            .filter({status: 'PENDING'})
            .map('id')
            .uniq()
            .value();
        }
      }, true);
    }]);
