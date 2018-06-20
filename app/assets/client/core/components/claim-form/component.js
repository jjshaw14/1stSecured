import angular from 'angular'
require('./style.scss')

angular.module('firstsecured.core')
.component('claimForm', {
  template: require('./template.html'),
  bindings: {
    claim: '=?record',
    onSave: '=?'
  },
  controller: ['Template', 'Claim', 'VIN', '$http', '$window', '$location', function(Template, Claim, VIN, $http, $window, $location) {
    var vm = this

    vm.onSave = function() {
      $location.path(`/claims/${vm.claim.id}`)
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
