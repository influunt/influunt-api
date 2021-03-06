'use strict';

/**
 * @ngdoc function
 * @name influuntApp.controller:ControladoresVerdesConflitantesCtrl
 * @description
 * # ControladoresVerdesConflitantesCtrl
 * Controller of the influuntApp
 */
angular.module('influuntApp')
  .controller('ControladoresVerdesConflitantesCtrl', ['$scope', '$state', '$controller', 'assertControlador',
    function ($scope, $state, $controller, assertControlador) {
      $controller('ControladoresCtrl', {$scope: $scope});

      var buildMatrizVerdesConflitantes, inicializaMatrizVerdesConflitantes, adicionaVerdeConflitante, removeVerdeConflitante;

      /**
       * Pré-condições para acesso à tela de verdes conflitantes: Somente será possível acessar
       * esta tela se o objeto possuir grupos semafóricos relacionados. Isto é feito no passo anterior,
       * na tela de associações.
       *
       * @return     {boolean}  { description_of_the_return_value }
       */
      $scope.assertVerdesConflitantes = function() {
        var valid = assertControlador.assertStepVerdesConflitantes($scope.objeto);
        if (!valid) {
          $state.go('app.wizard_controladores.configuracao_grupo', {id: $scope.objeto.id});
        }

        return valid;
      };

      $scope.inicializaVerdesConflitantes = function() {
        return $scope.inicializaWizard().then(function() {
          if ($scope.assertVerdesConflitantes()) {
            $scope.objeto.aneis = _.orderBy($scope.objeto.aneis, ['posicao']);
            $scope.aneis = _.filter($scope.objeto.aneis, {ativo: true});

            $scope.objeto.gruposSemaforicos = _.orderBy($scope.objeto.gruposSemaforicos, ['posicao']);
            $scope.grupoIds = _.map($scope.objeto.gruposSemaforicos, 'idJson');

            $scope.selecionaAnelVerdesConflitantes(0);
            buildMatrizVerdesConflitantes();
            inicializaMatrizVerdesConflitantes();
          }
        });
      };

      $scope.toggleVerdeConflitante = function(x, y, disabled) {
        if (disabled) {
          return false;
        }

        var grupoX = _.find($scope.currentGruposSemaforicos, {idJson: $scope.grupoIds[x]});
        var grupoY = _.find($scope.currentGruposSemaforicos, {idJson: $scope.grupoIds[y]});
        // grupos são ordenados pela posição para garantir que ao marcar a
        // posição (G1, G3), seja possível desmarcar clicando no (G3, G1).
        var grupos = _.orderBy([grupoX, grupoY], ['posicao']);

        var obj = _.find(
          $scope.objeto.verdesConflitantes,
          {
            origem: { idJson: grupos[0].idJson },
            destino: { idJson: grupos[1].idJson }
          }
        );

        if ($scope.verdesConflitantes[x][y]) {
          removeVerdeConflitante(obj, grupos);
        } else {
          adicionaVerdeConflitante(obj, grupos);
        }

        // Deve marcar/desmarcar os coordenadas (x, y) e (y, x) simultaneamente.
        $scope.verdesConflitantes[x][y] = !$scope.verdesConflitantes[x][y];
        $scope.verdesConflitantes[y][x] = !$scope.verdesConflitantes[y][x];
      };

      $scope.closeMensagensVerdes = function() {
        $scope.messages = [];
      };

      $scope.selecionaAnelVerdesConflitantes = function(index) {
        $scope.selecionaAnel(index);
        $scope.atualizaGruposSemaforicos();
        $scope.atualizaEstagios();
      };

      adicionaVerdeConflitante = function(verdeConflitante, grupos) {
        if (verdeConflitante) {
          delete verdeConflitante._destroy;
        } else {
          var novoVerdeConflitante = {
            idJson: UUID.generate(),
            origem: {
              idJson: grupos[0].idJson
            },
            destino: {
              idJson: grupos[1].idJson
            }
          };

          grupos[0].verdesConflitantesOrigem = grupos[0].verdesConflitantesOrigem || [];
          grupos[0].verdesConflitantesOrigem.push({idJson: novoVerdeConflitante.idJson});

          grupos[1].verdesConflitantesDestino = grupos[1].verdesConflitantesDestino || [];
          grupos[1].verdesConflitantesDestino.push({idJson: novoVerdeConflitante.idJson});

          $scope.objeto.verdesConflitantes = $scope.objeto.verdesConflitantes || [];
          $scope.objeto.verdesConflitantes.push(novoVerdeConflitante);
        }
      };

      removeVerdeConflitante = function(verdeConflitante, grupos) {
        var index = _.findIndex($scope.objeto.verdesConflitantes, verdeConflitante);

        var indexX = _.findIndex(grupos[0].verdesConflitantesOrigem, {idJson: verdeConflitante.idJson});
        var indexY = _.findIndex(grupos[1].verdesConflitantesDestino, {idJson: verdeConflitante.idJson});

        if (angular.isDefined($scope.objeto.verdesConflitantes[index].id)) {
          $scope.objeto.verdesConflitantes[index]._destroy = true;
        } else {
          grupos[0].verdesConflitantesOrigem.splice(indexX, 1);
          grupos[1].verdesConflitantesDestino.splice(indexY, 1);
          $scope.objeto.verdesConflitantes.splice(index, 1);
        }
      };

      /**
       * Constroi uma matriz quadrada para representação gráfica da tabela de
       * verdes conflitantes.
       */
      buildMatrizVerdesConflitantes = function() {
        $scope.verdesConflitantes = [];
        for (var i = 0; i < $scope.objeto.limiteGrupoSemaforico; i++) {
          for (var j = 0; j < $scope.objeto.limiteGrupoSemaforico; j++) {
            $scope.verdesConflitantes[i] = $scope.verdesConflitantes[i] || [];
            $scope.verdesConflitantes[i][j] = false;
          }
        }
      };

      /**
       * inicializa os dados da matriz de entreverdes.
       */
      inicializaMatrizVerdesConflitantes = function() {
        return $scope.objeto.gruposSemaforicos &&
          $scope.objeto.gruposSemaforicos.forEach(function(gs) {
            return gs.verdesConflitantesOrigem && gs.verdesConflitantesOrigem.forEach(function(vc) {
              var obj = _.find($scope.objeto.verdesConflitantes, vc);
              var origem = _.find($scope.objeto.gruposSemaforicos, {idJson: obj.origem.idJson});
              var destino = _.find($scope.objeto.gruposSemaforicos, {idJson: obj.destino.idJson});

              $scope.verdesConflitantes[origem.posicao - 1][destino.posicao - 1] = true;
              $scope.verdesConflitantes[destino.posicao - 1][origem.posicao - 1] = true;
            });
          });
      };

    }]);
