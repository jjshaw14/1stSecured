require('./style.scss')

import angular from 'angular'
import _ from 'lodash'

import moment from 'moment'

angular.module('firstsecured.core')
.component('quoteForm', {
  template: require('./template.html'),
  bindings: {
    contract: '=?',
    onSave: '=?'
  },
  controller: ['Me', 'Template', 'Document', 'Contract', 'VIN', '$http', '$window', '$location', '$routeParams', function(Me, Template, Document, Contract, VIN, $http, $window, $location, $routeParams ) {
    var vm = this
    vm.view = 'contracts'
    Me.get().then((me) => {
      Document.all({dealership: {id: me.dealership ? me.dealership.id : $routeParams.dealership }}).then((response) => {
        vm.documents = response.data
      })
    })
    vm.documentIframeSrc = (url) => {
      return 'http://docs.google.com/gview?embedded=true&url='.concat(url)
    }
    vm.$onInit = () => {
      if (!$routeParams.id) {
        return
      }

      Contract.find(vm.dealership, $routeParams.id).then((response) => {
        vm.contract = response.data
        if (vm.contract.purchased_on) vm.contract.purchased_on = new Date(moment.utc(vm.contract.purchased_on))
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
      if (!vm.contract || !vm.contract.coverage_id) return false
      return _.find(vm.contract.template.packages, (pkg) => {
        return _.filter(pkg.coverages, { id: vm.contract.coverage_id }).length > 0
      })
    }

    vm.packageSelected = (pkg) => {
      let p = vm.selectedPackage()
      return p && pkg.id === p.id
    }

    vm.onSave = function() {
      $location.path(`/contracts/${vm.contract.id}`)
    }
    vm.save = function() {
      Contract.save(vm.dealership, vm.contract).then((response) => {
        vm.contract = response.data
        vm.onSave(response)
      }, (response) => {
        vm.contract.errors = response.data.errors
      })
    }
    vm.setDocument = function(document) {
      vm.selectedDocument = document
      vm.view = 'documents'
    }
    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
