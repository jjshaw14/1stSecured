import angular from 'angular'

angular.module('firstsecured.core')
.component('userForm', {
  template: require('./template.html'),
  controller: ['User', 'Dealership', '$routeParams', '$window', '$location', function(User, Dealership, $routeParams, $window, $location) {
    var vm = this

    vm.$onInit = () => {
      if ($routeParams.dealershipId) {
        vm.user = {}
        Dealership.find($routeParams.dealershipId).then((response) => {
          vm.dealership = response.data
          vm.user.dealership = vm.dealership
        })
      }

      if (!$routeParams.id) {
        vm.user = {}
        return
      }

      User.find($routeParams.id).then((response) => {
        vm.user = response.data
      })
    }

    vm.save = function() {
      User.save(vm.user).then((response) => {
        vm.user = response.data
        if (vm.user.dealership) {
          $location.path(`/dealerships/${vm.user.dealership.id}`)
          return
        }
        $location.path('/users')
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
