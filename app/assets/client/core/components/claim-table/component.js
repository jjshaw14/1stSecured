import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('claimTable', {
  template: require('./template.html'),
  bindings: {
    dealership: '=?',
    contract: '=?'
  },
  controller: ['Me', 'Claim', 'pageTitle', function(Me, Claim, pageTitle) {
    pageTitle.set('Claims')

    var vm = this
    Me.get().then((me) => {
      vm.isAdmin = !me.dealership
    })
    vm.searchText = ''

    vm.$onInit = () => {
      vm.search()
    }
    vm.deleteClaim = (claim) => {
      Claim.destroy(claim).then(ret => {
        vm.claims = vm.claims.filter(claim => claim.id !== ret.data.id)
        toastr.success('deleted successfully')
      })
    }
    vm.search = () => {
      Claim.all({ q: vm.searchText, dealership: vm.dealership, contract: vm.contract }).then((response) => {
        vm.claims = response.data
      })
    }
  }]
})

