import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured.core')
.directive('fileUpload', function() {
  return {
    restrict: 'A',
    scope: {
      fileUpload: '@'
    },
    link: (scope, element, attrs) => {
      let $el = angular.element(element),
          $input = _.find($el.find('input'), (el) => { return el.type === 'file' })

      function uploadFile(file) {
        var reader = new FileReader()
        reader.addEventListener('load', () => {
          scope.$parent.$eval(attrs.fileUpload, { $data: reader.result })
        })
        reader.readAsDataURL(file)
      }

      angular.element($input).on('change', () => {
        uploadFile($input.files[0])
      })

      $el.on('dragover', (e) => {
        e.preventDefault()
        $el.addClass('hovering')
      })

      $el.on('dragleave', (e) => {
        e.preventDefault()
        $el.removeClass('hovering')
      })

      $el.on('drop', (e) => {
        e.preventDefault()
        $el.removeClass('hovering')
        uploadFile(e.dataTransfer.files[0])
      })

      $el.on('click', () => {
        $input.click()
      })
    }
  }
})
