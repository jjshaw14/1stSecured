import angular from 'angular'

angular.module('firstsecured.core')
.component('userForm', {
  template: require('./template.html'),
  bindings: {
    user: '=record'
  },
  controller: ['User', 'Dealership', '$routeParams', '$window', '$location', function(User, Dealership, $routeParams, $window, $location) {
    var vm = this

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
