import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured.core')
.factory('Contract', ['API', '$q', function(API, $q) {
  var Contract = {
    all: function(options) {
      options = _.cloneDeep(options)
      if (options.dealership) {
        options.dealership = options.dealership.id
      }

      return $q(function(resolve, reject) {
        API.get('contracts', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(dealership, id) {
      return $q(function(resolve, reject) {
        API.get('contracts', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    create: function(dealership, attrs) {
      console.log(dealership, attrs)
      return $q(function(resolve, reject) {
        API.post('contracts', attrs).then(function(results) {
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
        API.patch('contracts', contract.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: function(dealership, attrs) {
      return (attrs.id ? Contract.update : Contract.create)(dealership, attrs)
    }
  }

  return Contract
}])
