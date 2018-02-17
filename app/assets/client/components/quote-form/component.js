require('./style.scss')

import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured')
.component('quoteForm', {
  template: require('./template.html'),
  controller: ['Dealership', 'Contract', 'VIN', '$http', '$window', '$location', '$routeParams', function(Dealership, Contract, VIN, $http, $window, $location, $routeParams) {
    var vm = this

    vm.$onInit = () => {
      vm.dealership = { id: $routeParams.dealershipId }

      Dealership.find($routeParams.dealershipId).then((response) => {
        vm.dealership = response.data
        vm.contract.template = _.find(vm.dealership.templates, { id: parseInt($routeParams.template) })
      })

      if (!$routeParams.id) {
        vm.contract = {}
        return
      }

      Contract.find(vm.dealership, $routeParams.id).then((response) => {
        vm.contract = response.data

        vm.contract.coverage = _.find(_.flatten(_.map(vm.contract.template.packages, 'coverages')), { id: vm.contract.coverage.id })

        if (vm.contract.purchased_on) vm.contract.purchased_on = new Date(vm.contract.purchased_on)
      })
    }

    vm.checkVIN = () => {
      if (_.trim(vm.contract.vin).length !== 17) return

      VIN.get(vm.contract.vin).then((response) => {
        vm.contract.make  = response.data.make
        vm.contract.model = response.data.model
        vm.contract.year  = response.data.year
      })
    }

    vm.uncheckAddons = () => {
      let currentPackage = vm.selectedPackage()
      if (!currentPackage) return

      vm.contract.addons = _.filter(vm.contract.addons, (addon) => {
        return _.find(currentPackage.addons, { id: addon.id })
      })
    }

    vm.selectedPackage = () => {
      if (!vm.contract || !vm.contract.coverage) return false

      return _.find(vm.contract.template.packages, (pkg) => {
        return _.filter(pkg.coverages, { id: vm.contract.coverage.id }).length > 0
      })
    }

    vm.packageSelected = (pkg) => {
      let p = vm.selectedPackage()
      return p && pkg.id === p.id
    }

    vm.save = function() {
      Contract.save(vm.dealership, vm.contract).then(() => {
        $location.path(`/dealerships/${vm.dealership.id}`)
      }, (response) => {
        vm.contract.errors = response.data.errors
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
