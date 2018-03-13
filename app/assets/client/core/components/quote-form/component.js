require('./style.scss')

import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured.core')
.component('quoteForm', {
  template: require('./template.html'),
  bindings: {
    contract: '=',
    onSave: '='
  },
  controller: ['Template', 'Contract', 'VIN', '$http', '$window', '$location', '$routeParams', function(Template, Contract, VIN, $http, $window, $location, $routeParams) {
    var vm = this

    vm.$onInit = () => {
      console.log(vm.contract)
      if (!$routeParams.id) {
        return
      }

      Contract.find(vm.dealership, $routeParams.id).then((response) => {
        vm.contract = response.data

        // Dealership.find(vm.contract.dealership.id).then((response) => {
        //   vm.dealership = response.data
        //   if (!$routeParams.id) {
        //     vm.contract.template = _.find(vm.dealership.templates, { id: parseInt($routeParams.template) })
        //   }
        // })

        // vm.contract.coverage = _.find(_.flatten(_.map(vm.contract.template.packages, 'coverages')), { id: vm.contract.package.coverage.id })

        if (vm.contract.purchased_on) vm.contract.purchased_on = new Date(vm.contract.purchased_on)
      })
    }

    vm.checkVIN = () => {
      if (_.trim(vm.contract.vin).length !== 17) {
        delete vm.contract.make
        delete vm.contract.model
        delete vm.contract.year
        return
      }

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

    vm.coverageAllowed = (coverage) => {
      return vm.contract.odometer < coverage.limit_in_miles
    }

    vm.packageAllowed = (pkg) => {
      return _.some(pkg.coverages, vm.coverageAllowed)
    }

    vm.save = function() {
      Contract.save(vm.dealership, vm.contract).then((response) => {
        vm.contract = response
        vm.onSave(response)
      }, (response) => {
        vm.contract.errors = response.data.errors
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
