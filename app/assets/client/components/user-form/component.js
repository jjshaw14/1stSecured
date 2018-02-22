import angular from 'angular'

angular.module('firstsecured')
.component('userForm', {
  template: require('./template.html'),
  controller: ['User', '$routeParams', '$window', '$location', function(User, $routeParams, $window, $location) {
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
      User.save(vm.user).then((response) => {
        vm.user = response.data
        $location.path('/users')
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
