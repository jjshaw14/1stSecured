import angular from 'angular'

angular.module('firstsecured')
.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/contracts', { template: '<contract-list></contract-list>' })
    .when('/dealerships/:dealershipId/contracts/new', { template: '<quote-form></quote-form>' })
    .when('/dealerships/:dealershipId/contracts/:id/edit', { template: '<quote-form></quote-form>' })
    .when('/dealerships/:dealershipId/contracts/:id', { template: '<contract-view></contract-view>' })
    .when('/dealerships/:dealershipId/templates/new', { template: '<template-form></template-form>' })
    .when('/dealerships/:dealershipId/templates/:id/edit', { template: '<template-form></template-form>' })
    .when('/dealerships/new', { template: '<dealership-form></dealership-form>' })
    .when('/dealerships/:id/edit', { template: '<dealership-form></dealership-form>' })
    .when('/dealerships/:id', { template: '<dealership-view></dealership-view>' })
    .when('/dealerships', { template: '<dealership-list></dealership-list>' })
    .when('/service-providers/new', { template: '<service-provider-form></service-provider-form>' })
    .when('/service-providers/:id/edit', { template: '<service-provider-form></service-provider-form>' })
    .when('/service-providers', { template: '<service-provider-list></service-provider-list>' })
    .when('/users/new', { template: '<user-form></user-form>' })
    .when('/users/:id/edit', { template: '<user-form></user-form>' })
    .when('/users', { template: '<user-list></user-list>' })
    .otherwise({ redirectTo: '/contracts' })

  $locationProvider.html5Mode(true)
}])
