import angular from 'angular'

angular.module('firstsecured')
.factory('Template', ['API', '$q', function(API, $q) {
  var Template = {
    all: (dealership, options) => {
      return $q(function(resolve, reject) {
        API.get('dealerships', dealership.id, 'templates', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: (dealership, id) => {
      return $q(function(resolve, reject) {
        API.get('dealerships', dealership.id, 'templates', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    create: (dealership, attrs) => {
      return $q(function(resolve, reject) {
        API.post('dealerships', dealership.id, 'templates', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: (dealership, template, attrs) => {
      attrs || (attrs = template)
      if (!template.id) throw 'invalid template id.'
      return $q(function(resolve, reject) {
        API.patch('dealerships', dealership.id, 'templates', template.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    preview: (dealership, attrs) => {
      return $q(function(resolve, reject) {
        API.post('dealerships', dealership.id, 'templates', 'preview.html', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: (dealership, attrs) => {
      return (attrs.id ? Template.update : Template.create)(dealership, attrs)
    }
  }

  return Template
}])
