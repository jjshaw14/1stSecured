import angular from 'angular'
import toastr from 'toastr'
import moment from 'moment'
angular.module('firstsecured.core')
.component('contractTable', {
  template: require('./template.html'),
  bindings: {
    filter: '=?',
    dealership: '=?',
    user: '=?'
  },
  controller: ['Contract', 'pageTitle', '$scope', function(Contract, pageTitle, $scope) {
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

    vm.deleteContract = (contract) => {
      Contract.destroy(contract).then(ret => {
        vm.contracts = vm.contracts.filter(dealership => dealership.id !== ret.data.id)
        toastr.success('deleted successfully')
      })
    }
    vm.search = () => {
      Contract.all({ startDate: vm.date.startDate, endDate: vm.date.endDate, q: vm.searchText, dealership: vm.dealership, unsigned: vm.unsigned, filter: (vm.filter ? vm.filter.filter : null )}).then((response) => {
        vm.contracts = response.data
      })
    }
  }]
})
