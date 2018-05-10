import angular from 'angular'

angular.module('firstsecured.core')
.component('dealershipView', {
  template: require('./template.html'),
  controller: ['$window', 'Me', 'Dealership', '$routeParams', 'pageTitle', function($window, Me, Dealership, $routeParams, pageTitle) {
    var vm = this
    Me.get().then((me) => {
      if (me.dealership && String(me.dealership.id) !== $routeParams.id) {
        $window.history.back()
      }
    })
    vm.view = 'contracts'

    vm.$onInit = () => {
      Dealership.find($routeParams.id).then((response) => {
        vm.dealership = response.data

        pageTitle.set(vm.dealership.name)
      })
    }
  }]
})
