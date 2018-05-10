import angular from 'angular'

angular.module('firstsecured.admin')
.config(['$routeProvider', '$locationProvider', function($routeProvider, $locationProvider) {
  $routeProvider
    .when('/contracts/new', { template: '<quote-new></quote-new>' })
    .when('/contracts/:id/edit', { template: '<quote-form></quote-form>' })
    .when('/contracts/:id', { template: '<contract-view></contract-view>' })
    .when('/contracts', { template: '<contract-list></contract-list>' })
    .when('/users/new', { template: '<user-form></user-form>' })
    .when('/users/:id/edit', { template: '<user-form></user-form>' })
    .when('/templates/new', { template: '<template-new></template-new>' })
    .when('/templates/:id/edit', { template: '<template-edit></template-edit>' })
    .when('/dealerships/new', { template: '<dealership-form></dealership-form>' })
    .when('/dealerships/:id/edit', { template: '<dealership-form></dealership-form>' })
    .when('/dealerships/:id', { template: '<dealership-view></dealership-view>' })
    .when('/dealerships/:dealership_id/templates/new', {template: '<template-new></template-new>'})
    .when('/dealerships', { template: '<dealership-list></dealership-list>' })
    .when('/service-providers/new', { template: '<service-provider-form></service-provider-form>' })
    .when('/service-providers/:id/edit', { template: '<service-provider-form></service-provider-form>' })
    .when('/service-providers', { template: '<service-provider-list></service-provider-list>' })
    .when('/users/new', { template: '<user-new></user-new>' })
    .when('/users/:id/edit', { template: '<user-edit></user-edit>' })
    .when('/users', { template: '<user-list></user-list>' })
    .otherwise({ redirectTo: '/contracts' })

  $locationProvider.html5Mode(true)
}])
