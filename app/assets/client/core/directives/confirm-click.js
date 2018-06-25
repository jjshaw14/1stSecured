import angular from 'angular'
angular.module('firstsecured.core')
.directive('ngConfirmClick', [
  function() {
    return {
      link: function (scope, element, attr) {
        var msg = attr.ngConfirmClick || 'Are you sure?'
        var clickAction = attr.confirmedClick
        element.bind('click', function () {
          if ( window.confirm(msg) ) {
            scope.$eval(clickAction)
          }
        })
      }
    }
  }
])

