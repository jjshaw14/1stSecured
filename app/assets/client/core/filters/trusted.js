import angular from 'angular'
angular.module('firstsecured.core').filter('trusted', ['$sce', function ($sce) {
  return function(url) {
    return $sce.trustAsResourceUrl(url)
  }
}])
