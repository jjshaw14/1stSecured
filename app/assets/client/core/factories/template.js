import angular from 'angular'

angular.module('firstsecured.core')
.factory('Template', ['API', '$q', function(API, $q) {
  var Template = {
    all: (dealership, options) => {
      return $q(function(resolve, reject) {
        API.get('templates', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },
    new: (dealershipId) => {
      return $q(function(res, rej) {
        API.get('templates/new?dealership_id='.concat(dealershipId)).then(function(results) {
          res(results)
        }, function(results) {
          rej(results)
        })
      })
    },
    destroy: function(attrs) {
      if (!attrs.id) throw 'invalid template id.'
      return $q(function(resolve, reject) {
        API.delete('templates/' + attrs.id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },
    find: (id) => {
      return $q(function(resolve, reject) {
        API.get('templates', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },
    create: (attrs) => {
      return $q(function(resolve, reject) {
        API.post('templates', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: (template, attrs) => {
      attrs || (attrs = template)
      if (!template.id) throw 'invalid template id.'
      return $q(function(resolve, reject) {
        API.patch('templates', template.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    preview: (attrs) => {
      return $q(function(resolve, reject) {
        API.post('templates', 'preview.html', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: (attrs) => {
      return (attrs.id ? Template.update : Template.create)(attrs)
    }
  }

  return Template
}])
