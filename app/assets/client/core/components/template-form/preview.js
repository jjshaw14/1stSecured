import angular from 'angular'

angular.module('firstsecured.core')
.directive('templatePreview', function() {
  return {
    restrict: 'A',
    scope: {
      templatePreview: '@'
    },
    link: function(scope, el, attrs) {
      attrs.$observe('templatePreview', function(content) {
        el[0].src = 'data:text/html;charset=utf-8,' + encodeURI(content)
      })
    }
  }
})
