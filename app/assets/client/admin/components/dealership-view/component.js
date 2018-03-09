import angular from 'angular'

angular.module('firstsecured.admin')
.component('dealershipView', {
  template: require('./template.html'),
  controller: ['Dealership', '$routeParams', 'pageTitle', function(Dealership, $routeParams, pageTitle) {
    var vm = this

    vm.view = 'contracts'

    vm.$onInit = () => {
      Dealership.find($routeParams.id).then((response) => {
        vm.dealership = response.data

        pageTitle.set(vm.dealership.name)
      })
    }
  }]
})
