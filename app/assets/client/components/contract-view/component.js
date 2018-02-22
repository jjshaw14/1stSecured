require('./style.scss')

import angular from 'angular'

angular.module('firstsecured')
.component('contractView', {
  template: require('./template.html'),
  controller: ['$http', 'Contract', '$window', '$location', '$routeParams', function($http, Contract, $window, $location, $routeParams) {
    var vm = this

    vm.$onInit = () => {
      Contract.find($routeParams.dealershipId, $routeParams.id).then((response) => {
        vm.contract = response.data
        if (vm.contract.purchased_on) vm.contract.purchased_on = new Date(vm.contract.purchased_on)
      })
    }
  }]
})
