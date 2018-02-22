var angular = require('angular')

angular.module('firstsecured')
.filter('email', ['$sce', function($sce) {
  return function (address) {
    if (!address) { return '' }
    return $sce.trustAsHtml('<a href="mailto:' + address + '">' + address + '</a>')
  }
}])
