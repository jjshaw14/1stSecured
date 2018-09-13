import angular from 'angular'

angular.module('firstsecured.core')
.factory('Dashboard', ['API', '$q', function(API, $q) {
  var Dashboard = {
    find: function(id) {
      return $q(function(resolve, reject) {
        API.get('dealerships', id + '/dashboard').then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    }
  }
  return Dashboard
}])
