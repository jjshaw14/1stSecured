import angular from 'angular'
import _ from 'lodash'
require('./style.scss')

angular.module('firstsecured.core')
.component('templateForm', {
  template: require('./template.html'),
  bindings: {
    template: '=record'
  },
  controller: ['Template', 'Dealership', 'Fee', '$routeParams', '$window', '$location', function(Template, Dealership, Fee, $routeParams, $window, $location) {
    var vm = this
    vm.$onInit = () => {
      vm.mode = 'config'
      Fee.all().then((response) => {
        vm.terms = _.map(response.data, (fee) => {
          let months = fee.length_in_months
          if (months < 12) {
            return { label: `${months} months`, value: months }
          }
          return { label: `${Math.floor(months / 12)} years`, value: months }
        })
      })
    }

    vm.updatePreview = () => {
      vm.previewHTML = 'Rendering...'

      Template.preview(vm.template).then((response) => {
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
      pkg.coverages.push({
        fee: 125,
        up_to: false
      })
    }

    vm.removeCoverage = (pkg, coverage) => {
      _.remove(pkg.coverages, coverage)
    }

    vm.addAddon = (pkg) => {
      pkg.addons.push({
        fee: 0
      })
    }

    vm.removeAddon = (pkg, addon) => {
      _.remove(pkg.addons, addon)
    }

    vm.save = function() {
      Template.save(vm.template).then((response) => {
        console.log(response.data)
        vm.template = response.data
        $location.path(`/dealerships/${vm.template.dealership.id}`)
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
