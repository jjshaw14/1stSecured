import angular from 'angular'


angular.module('firstsecured.admin')
.component('claimNew', {
  template: require('./template.html'),
  controller: ['Dealership', 'Contract', 'pageTitle', '$routeParams', 'Me', '$location', function(Dealership, Contract, pageTitle, $routeParams, Me, $location) {
    var vm = this
    pageTitle.set('New Claim')
    vm.claim = {}
    Contract.find($routeParams.contract_id).then((resp) => {
      vm.claim.contract = resp.data
      console.log(vm.claim.contract)
      Me.get().then((me) => {
        if (me.dealership && me.dealership.id !== vm.claim.contract.dealership_id) {
          $location.path('/')
        }
      })
    })
  }]
})
