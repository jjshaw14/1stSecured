import angular from 'angular'


angular.module('firstsecured.core')
.component('claimForm', {
  template: require('./template.html'),
  bindings: {
    contract: '=?record',
    onSave: '=?'
  },
  controller: ['Template', 'Claim', 'VIN', '$http', '$window', '$location', '$routeParams', function(Template, Claim, VIN, $http, $window, $location, $routeParams ) {
    var vm = this
    vm.$onInit = () => {
      if (!$routeParams.id) {
        return
      }

      Claim.find(vm.dealership, $routeParams.id).then((response) => {
        vm.claim = response.data

      })
    }

    vm.onSave = function() {
      $location.path(`/claims/${vm.contract.id}`)
    }
    vm.save = function() {
      Claim.save(vm.dealership, vm.claim).then((response) => {
        vm.claim = response.data
        vm.onSave(response)
      }, (response) => {
        vm.claim.errors = response.data.errors
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
