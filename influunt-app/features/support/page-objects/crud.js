'use strict';

var worldObj = require('../world');
var world = new worldObj.World();

var CrudPage = function () {

  var campos = {
    'Área':                            'select[name="area"]',
    'Cidade':                          'select[name="cidade"]',
    'Chave':                           '[name="chave"]',
    'Configuração Controlador':        'select[name="configuracao"]',
    'Configuração':                    'select[name="configuracao"]',
    'Controladores':                   'select[name="controladores"]',
    'Descrição':                       '[name="descricao"]',
    'Fabricante':                      'select[name="fabricante"]',
    'Grupos Semafóricos de pedestre':  '[name="quantidadeGrupoPedestre"]',
    'Grupos Semafóricos veiculares':   '[name="quantidadeGrupoVeicular"]',
    'Latitude':                        '[name="latitude"]',
    'Localização':                     '[name="localizacao"]',
    'Longitude':                       '[name="longitude"]',
    'Modelo':                          'select[name="modelo"]',
    'Nome':                            '[name="nome"]',
    'Número CTA':                      '[name="area_descricao"]',
    'Número de detectores pedestres':  '[name="quantidadeDetectorPedestre"]',
    'Número de detectores veiculares': '[name="quantidadeDetectorVeicular"]',
    'Tipo Grupo Semafórico':           'select[name="tipoGrupoSemaforico"]',
    'Tipo':                            '[name="tipo"]'
  };

  this.preencherCampo = function(campo, valor) {
    return world.setValue(campos[campo], valor);
  };

  this.selecionarValor = function(campo, valor) {
    return world.selectOption(campos[campo], valor);
  };

};

module.exports = CrudPage;
