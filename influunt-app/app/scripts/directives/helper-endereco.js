'use strict';

/**
 * @ngdoc directive
 * @name influuntApp.directive:helperEndereco
 * @description
 * # helperEndereco
 */
angular.module('influuntApp')
  .directive('helperEndereco', function () {
    return {
      template: '<input type="text" placeholder="{{\'controladores.endereco\' | translate }}" class="form-control" data-ng-model="result" g-places-autocomplete>',
      restrict: 'E',
      scope: {
        latitude: '=',
        longitude: '=',
        localizacao: '='
      },
      link: function postLink(scope, element) {
        scope.$watch('result', function(value) {
          if (value && angular.isObject(value)) {
            if (value.geometry && value.geometry.location) {
              scope.latitude = value.geometry.location.lat();
              scope.longitude = value.geometry.location.lng();
            }
            if (value.address_components && angular.isArray(value.address_components)) {
              var foundName = false;
              for (var i = 0; i < value.address_components.length && !foundName; i++) {
                if (value.address_components[i].types) {
                  for (var j = 0; j < value.address_components[i].types.length && !foundName; j++) {
                    if (value.address_components[i].types[j] === 'route') {
                      scope.localizacao = value.address_components[i].short_name;
                      foundName = true;
                    }
                  }
                }
              }
            }
          }
        });
      }
    };
  });
