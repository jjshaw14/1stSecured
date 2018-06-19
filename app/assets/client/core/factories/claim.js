import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured.core')
.factory('Claim', ['API', '$q', function(API, $q) {
  var Claim = {
    all: function(options) {
      options = _.cloneDeep(options)
      if (options.dealership) {
        options.dealership = options.dealership.id
      }

      return $q(function(resolve, reject) {
        API.get('claims', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(dealership, id) {
      return $q(function(resolve, reject) {
        API.get('claims', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    destroy: function(attrs) {
      if (!attrs.id) throw 'invalid contract id.'
      return $q(function(resolve, reject) {
        API.delete('claims/' + attrs.id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },
    create: function(dealership, attrs) {
      console.log(dealership, attrs)
      return $q(function(resolve, reject) {
        API.post('claims', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: function(dealership, contract, attrs) {
      console.log(contract, attrs)
      attrs || (attrs = contract)
      if (!contract.id) throw 'invalid contract id.'
      return $q(function(resolve, reject) {
        API.patch('claims', contract.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: function(dealership, attrs) {
      return (attrs.id ? Claim.update : Claim.create)(dealership, attrs)
    }
  }

  return Claim
}])
