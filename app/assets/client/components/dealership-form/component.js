import angular from 'angular'

angular.module('firstsecured')
.component('dealershipForm', {
  template: require('./template.html'),
  controller: ['Dealership', '$routeParams', '$window', function(Dealership, $routeParams, $window) {
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
        $window.location.path(`/dealerships/${vm.dealership.id}`)
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
