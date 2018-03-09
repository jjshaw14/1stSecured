import angular from 'angular'

angular.module('firstsecured.core')
.factory('ServiceProvider', ['API', '$q', function(API, $q) {
  var ServiceProvider = {
    all: function(options) {
      return $q(function(resolve, reject) {
        API.get('service-providers', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(id) {
      return $q(function(resolve, reject) {
        API.get('service-providers', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    create: function(attrs) {
      return $q(function(resolve, reject) {
        API.post('service-providers', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: function(user, attrs) {
      attrs || (attrs = user)
      if (!user.id) throw 'invalid service provider id.'
      return $q(function(resolve, reject) {
        API.patch('service-providers', user.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: function(attrs) {
      return (attrs.id ? ServiceProvider.update : ServiceProvider.create)(attrs)
    }
  }

  return ServiceProvider
}])
