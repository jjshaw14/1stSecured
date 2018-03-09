import angular from 'angular'

angular.module('firstsecured.core')
.factory('pageTitle', ['$rootScope', '$document', function($rootScope, $document) {
  var originalTitle = $document[0].getElementsByTagName('title')[0].childNodes[0].nodeValue,
      title = originalTitle

  var pageTitle = {
    set: function(title) {
      $document[0].title = title = [title, originalTitle].join(' • ')
    },
    get: function() {
      return title
    },
    clear: function() {
      $document.title = originalTitle
    }
  }

  $rootScope.$on('$routeChangeStart', function() {
    pageTitle.clear()
  })

  return pageTitle
}])
