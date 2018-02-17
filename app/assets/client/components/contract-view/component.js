require('./style.scss')

import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured')
.component('contractView', {
  template: require('./template.html'),
  controller: ['$http', '$window', '$location', '$routeParams', function($http, $window, $location, $routeParams) {
    var vm = this

    vm.$onInit = () => {
      $http.get('/api/v1/dealerships').then((response) => {
        vm.dealerships = response.data
      })

      $http.get('/api/v1/templates/1').then((response) => {
        vm.template = response.data
      })

      if (!$routeParams.id) {
        vm.contract = {}
        return
      }

      $http.get('/api/v1/contracts/' + $routeParams.id).then((response) => {
        vm.contract = response.data

        if (vm.contract.purchased_on) vm.contract.purchased_on = new Date(vm.contract.purchased_on)
      })
    }

    vm.checkVIN = () => {
      if (_.trim(vm.contract.vin).length !== 17) return

      $http.get('/api/v1/vin?q=' + vm.contract.vin).then((response) => {
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

      return _.find(vm.template.packages, (pkg) => {
        return _.filter(pkg.coverages, { id: vm.contract.coverage.id }).length > 0
      })
    }

    vm.packageSelected = (pkg) => {
      let p = vm.selectedPackage()
      return p && pkg.id === p.id
    }

    vm.save = function() {
      (vm.contract.id ? $http.put('/api/v1/contracts/' + vm.contract.id, vm.contract) : $http.post('/api/v1/contracts', vm.contract)).then(() => {
        $location.path('/contracts')
      }, (response) => {
        vm.contract.errors = response.data.errors
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
