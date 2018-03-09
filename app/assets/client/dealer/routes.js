import angular from 'angular'

angular.module('firstsecured.dealer')
.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/contracts/new', { template: '<quote-form></quote-form>' })
    .when('/contracts/:id/edit', { template: '<quote-form></quote-form>' })
    .when('/contracts/:id', { template: '<contract-view></contract-view>' })
    .when('/contracts', { template: '<contract-list></contract-list>' })
    .otherwise({ redirectTo: '/contracts' })

  $locationProvider.html5Mode(true)
}])
