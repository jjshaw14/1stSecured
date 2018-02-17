import angular from 'angular'
import _ from 'lodash'

require('./style.scss')

angular.module('firstsecured')
.component('templateForm', {
  template: require('./template.html'),
  controller: ['Template', 'Dealership', '$routeParams', '$window', '$location', function(Template, Dealership, $routeParams, $window, $location) {
    var vm = this

    vm.$onInit = () => {
      vm.dealership = { id: $routeParams.dealershipId }

      vm.mode = 'config'
      vm.terms = []

      for (let i = 1; i < 12; i++) {
        if (i % 3 === 0) {
          vm.terms.push({ label: `${i} months`, value: i })
        }
      }
      for (let i = 1; i < 7; i++) {
        vm.terms.push({ label: `${i} years`, value: i * 12 })
      }

      if (!$routeParams.id) {
        vm.template = { packages: [] }
        Dealership.find($routeParams.dealershipId).then((response) => {
          vm.template.dealership = response.data
        })
        return
      }

      Template.find(vm.dealership, $routeParams.id).then((response) => {
        vm.template = response.data
      })
    }

    vm.updatePreview = () => {
      vm.previewHTML = 'Rendering...'

      Template.preview(vm.dealership, vm.template).then((response) => {
        vm.previewHTML = response.data
      }, () => {
        vm.previewHTML = 'An error occurred while rendering.'
      })
    }

    vm.addPackage = () => {
      vm.template.packages.push({ coverages: [], addons: [] })
    }

    vm.removePackage = (pkg) => {
      _.remove(vm.template.packages, pkg)
    }

    vm.addCoverage = (pkg) => {
      pkg.coverages.push({})
    }

    vm.removeCoverage = (pkg, coverage) => {
      _.remove(pkg.coverages, coverage)
    }

    vm.addAddon = (pkg) => {
      pkg.addons.push({})
    }

    vm.removeAddon = (pkg, addon) => {
      _.remove(pkg.addons, addon)
    }

    vm.save = function() {
      Template.save(vm.dealership, vm.template).then((response) => {
        vm.template = response.data
        $location.path(`/dealerships/${vm.template.dealership.id}`)
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
