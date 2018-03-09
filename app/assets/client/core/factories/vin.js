import angular from 'angular'

angular.module('firstsecured.core')
.factory('VIN', ['API', '$q', function(API, $q) {
  var VIN = {
    get: function(vin) {
      return $q(function(resolve, reject) {
        API.get('vin', { q: vin }).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    }
  }

  return VIN
}])
