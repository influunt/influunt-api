'use strict';

describe('Directive: influuntKnob', function () {
  var element,
    scope,
    $compile;

  var getComponentsValue = function(element) {
    var value = $(element).find('input[type=hidden]').val();
    return parseInt(value);
  };

  var setComponentsValue = function(element, val) {
    $(element).find('.knob-shape').roundSlider('setValue', val).trigger({
      type: 'change',
      value: val
    });
    scope.$apply();
  };


  beforeEach(inject(function ($rootScope, _$compile_) {
    $compile = _$compile_;
    scope = $rootScope.$new();
    scope.teste = {
      min: 0,
      max: 100,
      knob: null,
      title: 'teste knob',
      label: 'SEG'
    };

    element = angular.element('<influunt-knob title="{{ teste.title }}" label="{{ teste.label }}" ng-model="teste.knob" max="teste.max" min="teste.min"></influunt-knob>');
    element = $compile(element)(scope);
    scope.$apply();
  }));

  it('Deve ter o titulo igual ao valor passado por parametro', function() {
    var title = $(element).find('.title').html();
    expect(title).toBe(scope.teste.title);
  });
  it('Deve ter a label igual ao valor passado por parametro', function() {
    var label = $(element).find('.knob-label').html();
    expect(label).toBe(scope.teste.label);
  });
  it('Se houver valor de ng-model, o componente deverá ter o valor atual igual ao ng-model', function() {
    scope.teste.knob = 42;
    element = angular.element('<influunt-knob title="{{ teste.title }}" label="{{ teste.label }}" ng-model="teste.knob" max="teste.max" min="scope.min"></influunt-knob>');
    element = $compile(element)(scope);
    scope.$apply();

    var value = getComponentsValue(element);
    expect(value).toBe(scope.teste.knob);
  });
  it('Se não houver valor de ng-model, o valor do componente será igual ao valor minimo.', function() {
    var value = getComponentsValue(element);
    expect(value).toBe(scope.teste.min);
  });
  it('Se houver atualizacao no valor de model, o valor do componente também deverá ser atualizado', function() {
    scope.teste.knob = 42;
    scope.$apply();

    var value = getComponentsValue(element);
    expect(value).toBe(scope.teste.knob);
  });
  it('Se houver atualizacao no valor do componente, o valor do model também deverá ser alterado', function() {
    setComponentsValue(element, 42);
    setComponentsValue(element, 42);
    expect(scope.teste.knob).toBe(42);
  });
  it('Se não houver valor de ng-model, ele deverá ser atualizado para o valor mínimo', function() {
    expect(scope.teste.knob).toBe(scope.teste.min);
  });

  describe('Valores acima do máximo permitido.', function () {
    var influuntAlert;
    beforeEach(inject(function(_influuntAlert_) {
      influuntAlert = _influuntAlert_;
      spyOn(influuntAlert, 'alert');

      setComponentsValue(element, 142);
      scope.$apply();
    }));
    beforeEach(function(done) {setTimeout(done, 500);});

    it('Se o valor setado para o knob for maior que o limite informado, o usuário deverá ser alertado', function() {
      expect(influuntAlert.alert).toHaveBeenCalled();
    });
  });

  describe('valores abaixo do mínimo permitido', function () {
    var influuntAlert;
    beforeEach(inject(function(_influuntAlert_) {
      influuntAlert = _influuntAlert_;
      spyOn(influuntAlert, 'alert');

      setComponentsValue(element, -42);
      scope.$apply();
    }));
    beforeEach(function(done) {setTimeout(done, 500);});

    it('Se o valor setado para o knob for menor que o limite informado, o usuário deverá ser alertado', function() {
      expect(influuntAlert.alert).toHaveBeenCalled();
    });
  });


});
