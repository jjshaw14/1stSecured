import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('claimTable', {
  template: require('./template.html'),
  bindings: {
    dealership: '=?'
  },
  controller: ['Claim', 'pageTitle', function(Claim, pageTitle) {
    pageTitle.set('Claims')

    var vm = this

    vm.searchText = ''

    vm.$onInit = () => {
      vm.search()
    }
    vm.deleteClaim = (claim) => {
      Claim.destroy(claim).then(ret => {
        vm.claims = vm.claims.filter(dealership => dealership.id !== ret.data.id)
        toastr.success('deleted successfully')
      })
    }
    vm.search = () => {
      Claim.all({ q: vm.searchText, dealership: vm.dealership }).then((response) => {
        vm.claims = response.data
      })
    }
  }]
})

