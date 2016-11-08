'use strict';

/**
* @ngdoc function
* @name influuntApp.controller:SimulacaoCtrl
* @description
* # SimulacaoCtrl
* Controller of the influuntApp
**/

angular.module('influuntApp')

.controller('SimulacaoCtrl', ['$scope', '$controller', 'Restangular', 'influuntBlockui', 'HorariosService', 'influuntAlert',
                              '$filter', 'handleValidations', '$stateParams', 'MQTT_ROOT',
function ($scope, $controller, Restangular, influuntBlockui, HorariosService, influuntAlert,
          $filter, handleValidations, $stateParams, MQTT_ROOT) {

  var loadControlador, atualizaDetectores, atualizaPlanos, iniciarSimulacao, getMoment, resetParametros, abrirModalSimulacao;

  $scope.init = function() {
    var controladorId = $stateParams.id;
    loadControlador(controladorId);

    $scope.velocidades = [
      { value: 0.25 },
      { value: 0.5 },
      { value: 1 },
      { value: 2 },
      { value: 4 },
      { value: 8 }
    ];

    $scope.parametrosSimulacao = {
      idControlador: controladorId,
      velocidade: 1,
      disparoDetectores: [{}],
      imposicaoPlanos: [{}],
      falhasControlador: [{}],
      alarmesControlador: [{}]
    };

    $scope.inicioControlador = { hora: '0', minuto: '0', segundo: '0', date: new Date(new Date().setHours(0, 0, 0, 0)) };
    $scope.inicioSimulacao = { hora: '0', minuto: '0', segundo: '0', date: new Date(new Date().setHours(0, 0, 0, 0)) };
    $scope.fimSimulacao = { hora: '0', minuto: '5', segundo: '0', date: new Date(new Date().setHours(0, 0, 0, 0)) };

    $scope.disparosDetectores = { disparos: [] };
    $scope.imposicoesPlanos = { imposicoes: [] };
    $scope.falhasControlador = { falhas: [] };
    $scope.alarmesControlador = { alarmes: [] };

    $scope.horas = HorariosService.getHoras();
    $scope.minutos = HorariosService.getMinutos();
    $scope.segundos = HorariosService.getSegundos();

    $scope.dateOptions = {
      showWeeks: false
    };
  };

  loadControlador = function(controladorId) {
    return Restangular.one('controladores', controladorId).customGET('simulacao')
      .then(function(response) {
        $scope.controlador = response.controlador;
        $scope.alarmes = response.alarmes;
        $scope.falhas = response.falhas;
        $scope.controlador.aneis = _.orderBy($scope.controlador.aneis, 'posicao');
        _.forEach($scope.controlador.aneis, function(anel) {
          anel.detectores = _.orderBy(anel.detectores, ['tipo', 'posicao']);
          _.forEach(anel.detectores, function(detector) {
            detector.nome = 'Anel ' + anel.posicao + ' - D' + detector.tipo[0] + detector.posicao;
          });
          _.forEach(anel.planos, function(plano) {
            plano.nome = 'Plano ' + plano.posicao;
          });
        });
        atualizaDetectores($scope.controlador);
        atualizaPlanos($scope.controlador);
      }).finally(influuntBlockui.unblock);
  };

  atualizaDetectores = function(controlador) {
    if (controlador) {
      $scope.detectores = _
        .chain(controlador.aneis)
        .map('detectores')
        .flatten()
        .value();

      $scope.detectoresVeicular = _
        .chain($scope.detectores)
        .filter({ tipo: 'VEICULAR' })
        .value();

      $scope.detectoresPedestre = _
        .chain($scope.detectores)
        .filter({ tipo: 'PEDESTRE' })
        .value();
    }
  };

  atualizaPlanos = function(controlador) {
    if (controlador) {
      $scope.planos = _
        .chain(controlador.aneis)
        .map('planos')
        .flatten()
        .uniqBy('posicao')
        .orderBy('posicao')
        .value();
    }
  };

  $scope.$watch('parametrosSimulacao.disparoDetectores', function(parametro) {
    if (parametro) {
      var length = $scope.parametrosSimulacao.disparoDetectores.length;
      if (length > 0) {
        var disparo = $scope.parametrosSimulacao.disparoDetectores[length - 1];
        if (disparo && disparo.detector && disparo.disparo) {
          $scope.parametrosSimulacao.disparoDetectores.push({});
        }
      }
      }
  }, true);

  $scope.$watch('parametrosSimulacao.imposicaoPlanos', function(parametro) {
    if (parametro) {
      var length = $scope.parametrosSimulacao.imposicaoPlanos.length;
      if (length > 0) {
        var imposicao = $scope.parametrosSimulacao.imposicaoPlanos[length - 1];
        if (imposicao && imposicao.plano && imposicao.disparo) {
          $scope.parametrosSimulacao.imposicaoPlanos.push({});
        }
      }
      }
  }, true);

  $scope.$watch('parametrosSimulacao.falhasControlador', function(parametro) {
    if (parametro) {
      var length = $scope.parametrosSimulacao.falhasControlador.length;
      if (length > 0) {
        var falha = $scope.parametrosSimulacao.falhasControlador[length - 1];
        var possuiParam = falha.falha && ((falha.falha.tipoParam && falha.parametro) || !falha.falha.tipoParam);
        if (falha && falha.falha && falha.disparo && possuiParam) {
          $scope.parametrosSimulacao.falhasControlador.push({});
        }
      }
    }
  }, true);

  $scope.$watch('parametrosSimulacao.alarmesControlador', function(parametro) {
    if (parametro) {
      var length = $scope.parametrosSimulacao.alarmesControlador.length;
      if (length > 0) {
        var alarme = $scope.parametrosSimulacao.alarmesControlador[length - 1];
        if (alarme && alarme.alarme && alarme.disparo) {
          $scope.parametrosSimulacao.alarmesControlador.push({});
        }
      }
      }
  }, true);


  $scope.$watch('inicioControlador', function(inicioControlador) {
    if (inicioControlador && inicioControlador.date && inicioControlador.hora && inicioControlador.minuto && inicioControlador.segundo) {
      var date = moment(inicioControlador.date);
      var dateMoment = getMoment(date.year(), date.month()+1, date.date(), inicioControlador.hora, inicioControlador.minuto, inicioControlador.segundo);
      $scope.parametrosSimulacao.inicioControlador = dateMoment;
    }
  }, true);

  $scope.$watch('inicioSimulacao', function(inicioSimulacao) {
    if (inicioSimulacao && inicioSimulacao.date && inicioSimulacao.hora && inicioSimulacao.minuto && inicioSimulacao.segundo) {
      var date = moment(inicioSimulacao.date);
      var dateMoment = getMoment(date.year(), date.month()+1, date.date(), inicioSimulacao.hora, inicioSimulacao.minuto, inicioSimulacao.segundo);
      $scope.parametrosSimulacao.inicioSimulacao = dateMoment;
    }
  }, true);

  $scope.$watch('fimSimulacao', function(fimSimulacao) {
    if (fimSimulacao && fimSimulacao.date && fimSimulacao.hora && fimSimulacao.minuto && fimSimulacao.segundo) {
      var date = moment(fimSimulacao.date);
      var dateMoment = getMoment(date.year(), date.month()+1, date.date(), fimSimulacao.hora, fimSimulacao.minuto, fimSimulacao.segundo);
      $scope.parametrosSimulacao.fimSimulacao = dateMoment;
    }
  }, true);


  $scope.$watch('disparosDetectores.disparos', function(disparos) {
    if (disparos) {
      _.forEach($scope.disparosDetectores.disparos, function(disparo, index) {
        if (disparo.date && disparo.hora && disparo.minuto && disparo.segundo) {
          var date = moment(disparo.date);
          var dateMoment = getMoment(date.year(), date.month()+1, date.date(), disparo.hora, disparo.minuto, disparo.segundo);
          $scope.parametrosSimulacao.disparoDetectores[index].disparo = dateMoment;
        }
      });
    }
  }, true);

  $scope.$watch('imposicoesPlanos.imposicoes', function(imposicoes) {
    if (imposicoes) {
      _.forEach($scope.imposicoesPlanos.imposicoes, function(imposicao, index) {
        if (imposicao.date && imposicao.hora && imposicao.minuto && imposicao.segundo) {
          var date = moment(imposicao.date);
          var dateMoment = getMoment(date.year(), date.month()+1, date.date(), imposicao.hora, imposicao.minuto, imposicao.segundo);
          $scope.parametrosSimulacao.imposicaoPlanos[index].disparo = dateMoment;
        }
      });
    }
  }, true);

  $scope.$watch('falhasControlador.falhas', function(falhas) {
    if (falhas) {
      _.forEach($scope.falhasControlador.falhas, function(falha, index) {
        if (falha.date && falha.hora && falha.minuto && falha.segundo) {
          var date = moment(falha.date);
          var dateMoment = getMoment(date.year(), date.month()+1, date.date(), falha.hora, falha.minuto, falha.segundo);
          $scope.parametrosSimulacao.falhasControlador[index].disparo = dateMoment;
        }
      });
    }
  }, true);

  $scope.$watch('alarmesControlador.alarmes', function(alarmes) {
    if (alarmes) {
      _.forEach($scope.alarmesControlador.alarmes, function(alarme, index) {
        if (alarme.date && alarme.hora && alarme.minuto && alarme.segundo) {
          var date = moment(alarme.date);
          var dateMoment = getMoment(date.year(), date.month()+1, date.date(), alarme.hora, alarme.minuto, alarme.segundo);
          $scope.parametrosSimulacao.alarmesControlador[index].disparo = dateMoment;
        }
      });
    }
  }, true);

  getMoment = function(ano, mes, dia, hora, minuto, segundo) {
    var str = '' + ano + '-' + _.padStart(mes, 2, '0') + '-' + _.padStart(dia, 2, '0') + ' ' + _.padStart(hora, 2, '0') + ':' +  _.padStart(minuto, 2, '0') + ':' + _.padStart(segundo, 2, '0');
    return moment(str, 'YYYY-MM-DD HH:mm:ss');
  };

  $scope.removerDisparoDetector = function(index) {
    var title = $filter('translate')('simulacao.detectorAlert.title'),
        text = $filter('translate')('simulacao.detectorAlert.text');
    return influuntAlert.confirm(title, text)
      .then(function(confirmado) {
        if (confirmado) {
          if ($scope.parametrosSimulacao.disparoDetectores.length > 1) {
            $scope.parametrosSimulacao.disparoDetectores.splice(index, 1);
            $scope.disparosDetectores.disparos.splice(index, 1);
          } else {
            $scope.parametrosSimulacao.disparoDetectores = [{}];
            $scope.disparosDetectores.disparos = [];
          }
        }
      });
  };

  $scope.removerImposicaoPlano = function(index) {
    var title = $filter('translate')('simulacao.planoAlert.title'),
        text = $filter('translate')('simulacao.planoAlert.text');
    return influuntAlert.confirm(title, text)
      .then(function(confirmado) {
        if (confirmado) {
          if ($scope.parametrosSimulacao.imposicaoPlanos.length > 1) {
            $scope.parametrosSimulacao.imposicaoPlanos.splice(index, 1);
            $scope.imposicoesPlanos.imposicoes.splice(index, 1);
          } else {
            $scope.parametrosSimulacao.imposicaoPlanos = [{}];
            $scope.imposicoesPlanos.imposicoes = [];
          }
        }
      });
  };

  $scope.removerFalhaControlador = function(index) {
    var title = $filter('translate')('simulacao.falhaAlert.title'),
        text = $filter('translate')('simulacao.falhaAlert.text');
    return influuntAlert.confirm(title, text)
      .then(function(confirmado) {
        if (confirmado) {
          if ($scope.parametrosSimulacao.falhasControlador.length > 1) {
            $scope.parametrosSimulacao.falhasControlador.splice(index, 1);
            $scope.falhasControlador.falhas.splice(index, 1);
          } else {
            $scope.parametrosSimulacao.falhasControlador = [{}];
            $scope.falhasControlador.falhas = [];
          }
        }
      });
  };

  $scope.removerDisparoAlarme = function(index) {
    var title = $filter('translate')('simulacao.alarmeAlert.title'),
        text = $filter('translate')('simulacao.alarmeAlert.text');
    return influuntAlert.confirm(title, text)
      .then(function(confirmado) {
        if (confirmado) {
          if ($scope.parametrosSimulacao.alarmesControlador.length > 1) {
            $scope.parametrosSimulacao.alarmesControlador.splice(index, 1);
            $scope.alarmesControlador.alarmes.splice(index, 1);
          } else {
            $scope.parametrosSimulacao.alarmesControlador = [{}];
            $scope.alarmesControlador.alarmes = [];
          }
        }
      });
  };

  $scope.submitForm = function() {
    $scope.parametrosSimulacao.disparoDetectores = _.filter($scope.parametrosSimulacao.disparoDetectores, 'detector');
    $scope.parametrosSimulacao.imposicaoPlanos = _.filter($scope.parametrosSimulacao.imposicaoPlanos, 'plano');
    $scope.parametrosSimulacao.alarmesControlador = _.filter($scope.parametrosSimulacao.alarmesControlador, 'alarme');
    $scope.parametrosSimulacao.falhasControlador = _.filter($scope.parametrosSimulacao.falhasControlador, 'falha');

    return Restangular.all('simulacao').post($scope.parametrosSimulacao)
      .then(function(response) {
        $scope.errors = {};
        abrirModalSimulacao();
        iniciarSimulacao($scope.parametrosSimulacao, response);
        resetParametros();
      })
      .catch(function(response) {
        if (response.status === 422) {
          $scope.errors = handleValidations.buildValidationMessages(response.data);
          console.log('scope.errors: ', $scope.errors)
          resetParametros();
        } else {
          console.error(response);
        }
      })
      .finally(influuntBlockui.unblock);
  };

  abrirModalSimulacao = function() {
    $('#modal-simulacao').modal();
  };

  resetParametros = function() {
    if (_.isEmpty($scope.parametrosSimulacao.disparoDetectores))
      $scope.parametrosSimulacao.disparoDetectores = [{}];
    if (_.isEmpty($scope.parametrosSimulacao.imposicaoPlanos))
      $scope.parametrosSimulacao.imposicaoPlanos = [{}];
    if (_.isEmpty($scope.parametrosSimulacao.alarmesControlador))
      $scope.parametrosSimulacao.alarmesControlador = [{}];
    if (_.isEmpty($scope.parametrosSimulacao.falhasControlador))
      $scope.parametrosSimulacao.falhasControlador = [{}];
  };

  iniciarSimulacao = function(params, config) {
    var inicioSimulacao = moment(params.inicioSimulacao),
        fimSimulacao = moment(params.fimSimulacao),
        velocidade = params.velocidade;
    $scope.simulacao = new influunt.components.Simulador(
      inicioSimulacao, fimSimulacao, velocidade, config, MQTT_ROOT.url, MQTT_ROOT.port
    );
  };

  $scope.pararSimulacao = function() {
    $scope.simulacao.state.destroy();
    $('#canvas').html('');
  };

}]);
