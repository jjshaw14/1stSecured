import angular from 'angular'

angular.module('firstsecured.core')
.factory('Dealership', ['API', '$q', function(API, $q) {
  var Dealership = {
    all: function(options) {
      return $q(function(resolve, reject) {
        API.get('dealerships', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(id) {
      return $q(function(resolve, reject) {
        API.get('dealerships', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    create: function(attrs) {
      return $q(function(resolve, reject) {
        API.post('dealerships', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: function(dealership, attrs) {
      attrs || (attrs = dealership)
      if (!dealership.id) throw 'invalid dealership id.'
      return $q(function(resolve, reject) {
        API.patch('dealerships', dealership.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: function(attrs) {
      return (attrs.id ? Dealership.update : Dealership.create)(attrs)
    }
  }

  return Dealership
}])
