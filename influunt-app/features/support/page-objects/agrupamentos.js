'use strict';

var worldObj = require('../world');
var world = new worldObj.World();

var AgrupamentosPage = function () {
  var INDEX_PATH = '/app/agrupamentos';
  var NEW_PATH = '/app/agrupamentos/new';

  // var inputDescArea = '[name="area_descricao"]';
  // var novaAreaButton = 'a[href*="/areas/new"]';
  var formAgrupamentos = 'form[name="formAgrupamentos"]';
  var inputNomeAgrupamento = '[name="nome"]';

  var totalAgrupamentosIndex = 0;

  // this.world = world;

  this.existeAoMenosUmAgrupamento = function() {
    return world.execSqlScript('features/support/scripts/agrupamentos/create_agrupamento.sql');
  };

  this.indexPage = function() {
    world.visit(INDEX_PATH);
    world.getElements('tbody tr[data-ng-repeat="agrupamento in lista"]').then(function(elements) {
      totalAgrupamentosIndex = elements.length;
    });
    return world.waitFor('tbody tr[data-ng-repeat="agrupamento in lista"]');
  };

  this.getItensTabela = function() {
    return world.getElements('tbody tr td');
  };

  this.clicarBotaoNovoAgrupamento = function() {
    return world.clickButton('a[href*="/agrupamentos/new"]');
  };

  this.formAgrupamentos = function() {
    return world.getElement(formAgrupamentos);
  };

  this.newPage = function() {
    return world.visit(NEW_PATH).then(function(){
      return world.waitFor(formAgrupamentos);
    });
  };

  this.selecionarControlador = function(option) {
    return world.selectSelect2Option('select[name="controladores"]', option);
  };

  this.textoExisteNaTabela = function(text) {
    return world.waitForByXpath('//td[contains(text(), "'+text+'")]').then(function() {
      return world.getElementByXpath('//td[contains(text(), "'+text+'")]');
    });
  };

  this.isIndex = function() {
    return world.getElements('tbody tr[data-ng-repeat="agrupamentos in lista"]');
  };

  this.clicarLinkComTexto = function(texto) {
    return world.findLinkByText(texto).click();
  };

  this.isShow = function() {
    return world.getElement('h5 small').getText().then(function(text) {
      return text.match(/ - #/);
    });
  };

  this.textoFieldNomeAgrupamento = function() {
    return world.waitFor(inputNomeAgrupamento).then(function() {
      return world.getElement(inputNomeAgrupamento);
    }).then(function(element) {
     return element.getAttribute('value');
    });
  };

  this.textoConfirmacaoApagarRegistro = function() {
    return world.getElement('div[class*="sweet-alert"] p').getText();
  };

  this.nenhumAgrupamentoDeveSerExcluido = function() {
    return world.getElements('tbody tr[data-ng-repeat="agrupamento in lista"]').then(function(elements) {
      return elements.length === totalAgrupamentosIndex;
    });
  };

  // this.agrupamentoDeveSerExcluido = function() {
  //   return this.toastMessage().then(function() {
  //     return world.getElements('tbody tr[data-ng-repeat="agrupamento in lista"]');
  //   }).then(function(elements) {
  //     return elements.length === totalAgrupamentosIndex - 1;
  //   });
  // };


  // this.getPageTitleH2 = function() {
  //   return world.getElement('h2').then(function(element) {
  //     return element.getText();
  //   });
  // };

  this.toastMessage = function() {
    return world.waitFor('#toast-container div').then(function() {
      return world.getElement('#toast-container div').getText();
    });
  };

  // this.cidadeIdH5 = function() {
  //   return world.getElement('h5 small').then(function(element) {
  //     return element.getText();
  //   });
  // };

  // this.clicarSimConfirmacaoApagarRegistro = function() {
  //   return world.waitFor('div[class^="sweet-alert"][class$="visible"]').then(function() {
  //     return world.clickButton('div[class^="sweet-alert"] button.confirm');
  //   });
  // };

  // this.clicarNaoConfirmacaoApagarRegistro = function() {
  //   return world.waitFor('div[class^="sweet-alert"][class$="visible"]').then(function() {
  //     return world.clickButton('div[class^="sweet-alert"] button.cancel');
  //   });
  // };

};

module.exports = AgrupamentosPage;
