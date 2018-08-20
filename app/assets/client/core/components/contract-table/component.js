import angular from 'angular'
import toastr from 'toastr'
import moment from 'moment'
import range from 'lodash'

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
    Me.get().then((me) => vm.admin = me.dealership ? false   : true)
    vm.selectedRows = {}
    vm.lastAdded = ''
    vm.selectRows = (contract, $index, $event) => {
      if (vm.admin) {

        if ($event.shiftKey === true) {
          if (vm.selectedRows === {}) {
            vm.selectedRows[$index] = contract
            vm.lastAdded = $index
            console.log('****')
            console.log(vm.lastAdded)
          } else {
            // let max = Math.max(...Object.keys(vm.selectedRows));
            console.log('&&&&&&&')
            console.log(vm.lastAdded)
            // (vm.lastAdded < $index ? vm.lastAdded : $index ), (vm.lastAdded < $index ? $index + 1 : vm.lastAdded + 1)
            Object.assign(vm.selectedRows, _.range(vm.lastAdded, $index).map(ind => ({ [ind]: vm.contracts[ind] })))
            console.log(_.range(vm.lastAdded, $index))
          }
          console.log('shift click')
          console.log(vm.selectedRows)
        }
        else if ($event.ctrlKey === true) {
          console.log('control click')
          if (vm.selectedRows[$index] === contract) {
            delete vm.selectedRows[$index]
          } else {
            vm.selectedRows[$index] = contract
            vm.lastAdded = $index
            console.log('****')
            console.log(vm.lastAdded)
          }
          console.log(vm.selectedRows)
        }
        else {
          console.log('regular click')
          vm.selectedRows = {}
          vm.selectedRows[$index] = contract
          vm.lastAdded = $index
          console.log('****')
          console.log(vm.lastAdded)
          console.log(vm.selectedRows)
        }
      }
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
