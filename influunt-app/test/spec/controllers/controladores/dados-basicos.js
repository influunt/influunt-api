'use strict';

describe('Controller: ControladoresDadosBasicosCtrl', function () {

  // load the controller's module
  beforeEach(module('influuntApp'));

  var ControladoresDadosBasicosCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    ControladoresDadosBasicosCtrl = $controller('ControladoresDadosBasicosCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(ControladoresDadosBasicosCtrl.awesomeThings.length).toBe(3);
  });
});
