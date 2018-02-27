import angular from 'angular'

angular.module('firstsecured')
.component('serviceProviderForm', {
  template: require('./template.html'),
  controller: ['ServiceProvider', '$routeParams', '$window', '$location', function(ServiceProvider, $routeParams, $window, $location) {
    var vm = this

    vm.$onInit = () => {
      if (!$routeParams.id) {
        vm.provider = {}
        return
      }

      ServiceProvider.find($routeParams.id).then((response) => {
        vm.provider = response.data
      })
    }

    vm.save = function() {
      ServiceProvider.save(vm.provider).then((response) => {
        vm.provider = response.data
        $location.path('/service-providers')
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
