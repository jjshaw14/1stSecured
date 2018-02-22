import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured')
.factory('Contract', ['API', '$q', function(API, $q) {
  var Contract = {
    all: function(options) {
      options = _.cloneDeep(options)
      let dealership = options.dealership
      delete options.dealership

      return $q(function(resolve, reject) {
        (dealership ?
          API.get('dealerships', dealership.id, 'contracts', options) :
          API.get('contracts', options)
        )
        .then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(dealership, id) {
      if (!_.isObject(dealership)) dealership = { id: dealership }
      return $q(function(resolve, reject) {
        API.get('dealerships', dealership.id, 'contracts', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    create: function(dealership, attrs) {
      if (!_.isObject(dealership)) dealership = { id: dealership }
      return $q(function(resolve, reject) {
        API.post('dealerships', dealership.id, 'contracts', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: function(dealership, contract, attrs) {
      attrs || (attrs = contract)
      if (!contract.id) throw 'invalid contract id.'
      return $q(function(resolve, reject) {
        API.patch('dealerships', dealership.id, 'contracts', contract.id, attrs).then(function(results) {
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
