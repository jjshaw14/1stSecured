import angular from 'angular'

angular.module('firstsecured.core')
.component('userForm', {
  template: require('./template.html'),
  bindings: {
    user: '=record',
    edit: '=edit'
  },
  controller: ['User', 'Dealership', '$routeParams', '$window', '$location', 'Me', function(User, Dealership, $routeParams, $window, $location, Me) {
    var vm = this
    vm.dealerships = []
    vm.user_types = [
      'owner',
      'employee'
    ]

    Me.get().then((me) => {
      vm.me = me
      console.log(vm.user)
      if (me.dealership) {
        vm.user.dealership = vm.user.dealership ? vm.user.dealership : me.dealership
        if (!vm.user.dealership || me.dealership.id !== vm.user.dealership.id || me.user_type !== 'owner') {
          $location.path('/contracts')
        }
      }
    })
    Dealership.all().then(function(response) {
      vm.dealerships = response.data
    })
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
