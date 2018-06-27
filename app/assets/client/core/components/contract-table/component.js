import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('contractTable', {
  template: require('./template.html'),
  bindings: {
    dealership: '=?'
  },
  controller: ['Contract', 'pageTitle', function(Contract, pageTitle) {
    pageTitle.set('Contracts')

    var vm = this

    vm.searchText = ''

    vm.$onInit = () => {
      vm.search()
    }
    vm.deleteContract = (contract) => {
      Contract.destroy(contract).then(ret => {
        vm.contracts = vm.contracts.filter(dealership => dealership.id !== ret.data.id)
        toastr.success('deleted successfully')
      })
    }
    vm.search = () => {
      Contract.all({ q: vm.searchText, dealership: vm.dealership, unsigned: vm.unsigned }).then((response) => {
        vm.contracts = response.data
      })
    }
  }]
})
