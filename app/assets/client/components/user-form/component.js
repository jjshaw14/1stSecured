import angular from 'angular'

angular.module('firstsecured')
.component('userForm', {
  template: require('./template.html'),
  controller: ['User', '$routeParams', '$window', function(User, $routeParams, $window) {
    var vm = this

    vm.$onInit = () => {
      if (!$routeParams.id) {
        vm.user = {}
        return
      }

      User.find($routeParams.id).then((response) => {
        vm.user = response.data
      })
    }

    vm.save = function() {
      User.save(vm.dealership).then((response) => {
        vm.user = response.data
        $window.location.path(`/users/${vm.user.id}`)
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
