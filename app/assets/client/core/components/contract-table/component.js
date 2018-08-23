import angular from 'angular'
import toastr from 'toastr'
import moment from 'moment'
import range from 'lodash/range'

angular.module('firstsecured.core')
.component('contractTable', {
  template: require('./template.html'),
  bindings: {
    filter: '=?',
    dealership: '=?',
    user: '=?'
  },
  controller: ['Contract', 'pageTitle', '$scope', 'Me', function(Contract, pageTitle, $scope, Me) {
    pageTitle.set('Contracts')
    var vm = this
    $scope.$on('filterChanged', (filter) => {
      vm.filter = filter.targetScope.vm.externalFilter
      vm.search()
    })
    vm.datepickerOptions = {
      ranges: {
        'Today': [moment(), moment()],
        'Yesterday': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
        'Last 7 Days': [moment().subtract(6, 'days'), moment()],
        'Last 30 Days': [moment().subtract(29, 'days'), moment()],
        'This Month': [moment().startOf('month'), moment().endOf('month')],
        'Last Month': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
      },
      eventHandlers: {
        'apply.daterangepicker': function() {
          vm.search()
        }
      }
    }

    vm.date = {
      startDate: null,
      endDate: null
    }
    vm.searchText = ''
    vm.$onInit = () => {
      vm.search()
    }
    Me.get().then((me) =>  { vm.admin = me.dealership ? false   : true })
    vm.selected = []
    vm.lastSelected
    vm.selectRows = ($event, clicked) => {
      if (vm.admin) {
        if ($event.shiftKey) {
          if (!vm.lastSelected) {
            vm.selected = [clicked]
          } else {
            range(vm.lastSelected.ind, vm.lastSelected.ind < clicked.ind ? clicked.ind + 1 : clicked.ind - 1)
              .filter(ind => !vm.selected.some(selected => selected.ind === ind))
              .forEach(ind =>
                vm.selected.push({
                  contract: vm.contracts[ind],
                  ind
                }))
          }
        }
        else {
          if (vm.selected.some(selected => selected.contract.id === clicked.contract.id)) {
            vm.selected = vm.selected.filter((selected) => selected.contract.id !== clicked.contract.id)
          } else {
            vm.selected.push(clicked)
          }
        }
        vm.lastSelected = clicked
      }
    }

    vm.clearSelected = () => {
      vm.selected = []
    }
    vm.deleteContract = (contract) => {
      Contract.destroy(contract).then(ret => {
        vm.contracts = vm.contracts.filter(dealership => dealership.id !== ret.data.id)
        toastr.success('deleted successfully')
      })
    }
    vm.search = () => {
      Contract.all({ startDate: vm.date.startDate, endDate: vm.date.endDate, q: vm.searchText, dealership: vm.dealership, unsigned: vm.unsigned, paid: vm.unpaid, filter: (vm.filter ? vm.filter.filter : null )}).then((response) => {
        vm.contracts = response.data
      })
    }
    vm.contractSelected = (contract) => {
      return vm.selected.some(selected => selected.contract.id === contract.id)
    }

    vm.savePaid = (paid) => {
      Contract.updatePaid(vm.selected.map(selected => selected.contract.id), paid).then(() => {
        toastr.success('successfully marked as paid')
        vm.search()
      })
    }
  }]
})
