import angular from 'angular'
import Promise from 'promise-polyfill'
let memo

angular.module('firstsecured.core')
.factory('Me', ['API', '$q', (API, $q) => {
  var Me = {
    get: function() {
      return memo ? Promise.resolve(memo) : $q((resolve, reject) => {
        API.get('me').then((response) => {
          memo = response.data
          resolve(response.data)
        }, function(response) {
          reject(response)
        })
      })
    },

    update: (attrs) => {
      return $q((resolve, reject) => {
        API.patch('me', attrs).then((response) => {
          resolve(response.data)
        }, function(response) {
          reject(response)
        })
      })
    },

    save: (attrs) => {
      return Me.update(attrs)
    }
  }

  return Me
}])
