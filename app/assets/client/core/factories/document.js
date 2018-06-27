import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured.core')
.factory('Document', ['API', '$q', function(API, $q) {
  var Document = {
    all: function(options) {
      options = _.cloneDeep(options)
      if (options.dealership) {
        options.dealership = options.dealership.id
      }
      if (options.contract) {
        options.contract = options.contract.id
      }
      return $q(function(resolve, reject) {
        API.get('documents', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(dealership, id) {
      return $q(function(resolve, reject) {
        API.get('documents', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    destroy: function(attrs) {
      if (!attrs.id) throw 'invalid contract id.'
      return $q(function(resolve, reject) {
        API.delete('documents/' + attrs.id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },
    create: function(dealership, attrs) {
      console.log(dealership, attrs)
      return $q(function(resolve, reject) {
        API.post('documents', attrs).then(function(results) {
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
        API.patch('documents', contract.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: function(dealership, attrs) {
      return (attrs.id ? Document.update : Document.create)(dealership, attrs)
    }
  }

  return Document
}])
