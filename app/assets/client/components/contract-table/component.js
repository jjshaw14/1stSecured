import angular from 'angular'

angular.module('firstsecured')
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

    vm.search = () => {
      Contract.all({ q: vm.searchText, dealership: vm.dealership }).then((response) => {
        vm.contracts = response.data
      })
    }
  }]
})
