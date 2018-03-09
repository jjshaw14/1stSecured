import angular from 'angular'

angular.module('firstsecured.admin')
.component('dealershipForm', {
  template: require('./template.html'),
  controller: ['Dealership', '$routeParams', '$window', '$location', function(Dealership, $routeParams, $window, $location) {
    var vm = this

    vm.$onInit = () => {
      if (!$routeParams.id) {
        vm.dealership = {}
        return
      }

      Dealership.find($routeParams.id).then((response) => {
        vm.dealership = response.data
      })
    }

    vm.save = function() {
      Dealership.save(vm.dealership).then((response) => {
        vm.dealership = response.data
        $location.path(`/dealerships/${vm.dealership.id}`)
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
