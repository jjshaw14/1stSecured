import angular from 'angular'

angular.module('firstsecured')
.factory('User', ['API', '$q', function(API, $q) {
  var User = {
    all: function(options) {
      return $q(function(resolve, reject) {
        API.get('users', options).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    find: function(id) {
      return $q(function(resolve, reject) {
        API.get('users', id).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    create: function(attrs) {
      return $q(function(resolve, reject) {
        API.post('users', attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    update: function(user, attrs) {
      attrs || (attrs = user)
      if (!user.id) throw 'invalid user id.'
      return $q(function(resolve, reject) {
        API.patch('users', user.id, attrs).then(function(results) {
          resolve(results)
        }, function(results) {
          reject(results)
        })
      })
    },

    save: function(attrs) {
      return (attrs.id ? User.update : User.create)(attrs)
    }
  }

  return User
}])
