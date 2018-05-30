import angular from 'angular'
angular.module('firstsecured.dealer')
.config(['$routeProvider', '$locationProvider',  function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/contracts/new', { template: '<quote-new></quote-new>' })
    .when('/contracts/:id/edit', { template: '<quote-form></quote-form>' })
    .when('/contracts/:id', { template: '<contract-view></contract-view>' })
    .when('/contracts', { template: '<contract-list></contract-list>' })
    .when('/users/new', { template: '<user-new></user-new>' })
    .when('/users/:id/edit', { template: '<user-edit></user-edit>' })

    .when('/users', { template: '<user-list></user-list>' })
    .otherwise({ redirectTo: '/contracts' })

  $locationProvider.html5Mode(true)
}])
