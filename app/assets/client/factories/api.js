import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured')
.factory('API', ['$http', '$httpParamSerializer', function($http, $httpParamSerializer) {

  var PREFIX = '/api/v1/'

  var headers = {
    'Content-Type': 'application/json'
  }

  var api = {
    search: function(params) {
      return api.get('search', params)
    },
    head: function() {
      var url = Array.prototype.slice.call(arguments, 0, arguments.length)

      return $http({
        method: 'HEAD', url: PREFIX + _.compact(url).join('/'),
        headers: headers
      })
    },
    get: function() {
      var query = _.first(Array.prototype.slice.call(arguments, -1)),
          url   = Array.prototype.slice.call(arguments, 0, (typeof query === 'object') ? -1 : arguments.length)
      if (typeof query === 'object') {
        query = '?' + $httpParamSerializer(query)
      } else {
        query = ''
      }

      return $http({
        method: 'GET', url: PREFIX + _.compact(url).join('/') + query,
        headers: headers
      })
    },
    post: function() {
      var url  = Array.prototype.slice.call(arguments, 0, -1).join('/'),
          data = _.first(Array.prototype.slice.call(arguments, -1) )

      if (!data) throw 'no data to POST.'

      return $http({
        method: 'POST', url: PREFIX + url,
        data: JSON.stringify(data),
        headers: headers
      })
    },
    put: function() {
      var url  = Array.prototype.slice.call(arguments, 0, -1).join('/'),
          data = _.first(Array.prototype.slice.call(arguments, -1))

      if (!data) throw 'no data to PUT.'

      return $http({
        method: 'PUT', url: PREFIX + url,
        data: JSON.stringify(data),
        headers: headers
      })
    },
    patch: function() {
      var url  = Array.prototype.slice.call(arguments, 0, -1).join('/'),
          data = _.first(Array.prototype.slice.call(arguments, -1))

      if (!data) throw 'no data to PATCH.'

      return $http({
        method: 'PATCH', url: PREFIX + url,
        data: JSON.stringify(data),
        headers: headers
      })
    },
    delete: function() {
      var url  = Array.prototype.slice.call(arguments, 0, -1).join('/'),
          data = _.first(Array.prototype.slice.call(arguments, -1))

      if (typeof data === 'string') {
        url += '/' + data
        data = undefined
      }

      return $http({
        method: 'DELETE', url: PREFIX + url,
        data: JSON.stringify(data),
        headers: headers
      })
    }
  }

  return api
}])
