'use strict';

/**
 * @ngdoc directive
 * @name influuntApp.directive:influuntDropzone
 * @description
 * # influuntDropzone
 *
 * CORRIGIR: As traduções das labels ainda estão estáticas, porque o filter é
 * carregado antes mesmo do angular-translate estar pronto (ele carrega o arquivo
 * i18n de forma assincrona).
 */
angular.module('influuntApp')
  .directive('influuntDropzone', ['APP_ROOT', '$timeout', 'Restangular', 'toast', function (APP_ROOT, $timeout, Restangular, toast) {
    return {
      restrict: 'A',
      scope: {
        url: '@',
        anel: '=',
        imagensUrl: '=',
        onSuccess: '&',
        onDelete: '&'
      },
      link: function postLink(scope, element) {
        /**
         * A cada troca de anel, este watcher deverá esconder os itens que
         * não são deste anel e exibir aqueles que são deles.
         */
        var filterVisiblePreviews = function() {
          $timeout(function() {
            $('.dz-preview[data-anel-id="' + scope.anel.idAnel + '"]').show();
            $('.dz-preview:not([data-anel-id="' + scope.anel.idAnel + '"])').hide();
          }, 0);
        };

        var deleteImage = function(imagemId, dropzoneFile, dropzone) {
          return Restangular.one('imagens', imagemId).remove().then(function() {
            scope.onDelete({ imagem: { id: imagemId } });
            dropzone.removeFile(dropzoneFile);
          }).catch(function() {
            toast.error('Não foi possível apagar a imagem.');
          });
        };

        scope.$watch('anel.idAnel', function(value) {
          return value && filterVisiblePreviews();
        });

        scope.$watch(function() {
          return $(element).children('.dz-preview').length;
        }, function(val) {
          return val > 0 && filterVisiblePreviews();
        });

        new Dropzone('#'+element.attr('id'), {
          url: APP_ROOT + '/imagens',
          dictDefaultMessage: 'Arraste imagens para este local',
          dictFallbackMessage: 'Seu navegador não suporta arrastar e soltar upload de arquivos.',
          autoProcessQueue: true,
          uploadMultiple: false,
          parallelUploads: 100,
          thumbnailHeight: 100,
          thumbnailWidth: 100,
          clickable: true,
          paramName: 'imagem',
          maxFiles: 100,
          headers: {
            authToken: localStorage.token
          },
          success: function(upload, imagem) {
            var anel = scope.anel;
            // Adiciona o anel id ao elemento do preview. Este id será utilizado
            // para filtrar as imagens de estagios para os diferentes aneis.
            $(upload.previewElement).attr('data-anel-id', anel.idAnel);
            $(upload.previewElement).attr('data-imagem-id', imagem.id);
            return scope.onSuccess({upload: upload, imagem: imagem});
          },
          init: function() {
            this.on("addedfile", function(file) {
              var removeButton = Dropzone.createElement("<button class='remove-image' title='Remover estágio'>&times;</button>");
              var _this = this;
              removeButton.addEventListener("click", function(e) {
                e.preventDefault();
                e.stopPropagation();
                var imagemId = $(this).parent('.dz-image-preview').attr('data-imagem-id');
                deleteImage(imagemId, file, _this);
              });
              file.previewElement.appendChild(removeButton);
            });
          }
        });
      }
    };
  }]);
