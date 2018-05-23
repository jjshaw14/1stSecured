import angular from 'angular'
import toastr from 'toastr'
angular
  .module('firstsecured.core')
  .factory('$exceptionHandler', ['$log', function($log) {
    return function toastrHandler(exception) {
      $log.warn('exception: ', exception)
      if (exception.status === 500) {
        toastr.error('Internal Server Error, Please Call Administration')
      }
      if (exception.status === 422 && exception.data) {
        Object.keys(exception.data.errors).forEach((error) => {
          toastr.error('<span style="text-transform:capitalize">' +
            error.replace(/_/g, ' ') + ': ' + exception.data.errors[error].join(', ') +
          '</span>')
        })
      }
    }
  }])

angular.module('firstsecured.core')
  .factory('httpErrorHandler', ['$exceptionHandler', '$q', function($exceptionHandler, $q) {
    return {
      'responseError': function(rejection) {
        $exceptionHandler(rejection)
        return $q.reject(rejection)
      }
    }
  }])

angular.module('firstsecured.core').config(['$httpProvider', function($httpProvider) {
  $httpProvider.interceptors.push('httpErrorHandler')
}])
