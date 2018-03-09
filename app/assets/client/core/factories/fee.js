import angular from 'angular'

angular.module('firstsecured.core')
.factory('Fee', ['API', '$q', function(API, $q) {
  var Fee = {
    all: function(options) {
      return $q(function(resolve, reject) {
        API.get('fees', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(id) {
      return $q(function(resolve, reject) {
        API.get('fees', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    create: function(attrs) {
      return $q(function(resolve, reject) {
        API.post('fees', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: function(fee, attrs) {
      attrs || (attrs = fee)
      if (!fee.id) throw 'invalid fee id.'
      return $q(function(resolve, reject) {
        API.patch('fees', fee.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: function(attrs) {
      return (attrs.id ? Fee.update : Fee.create)(attrs)
    }
  }

  return Fee
}])
