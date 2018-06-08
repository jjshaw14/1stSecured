import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.admin')
.component('dealershipList', {
  template: require('./template.html'),
  controller: ['Dealership', 'pageTitle', function(Dealership, pageTitle) {
    var vm = this

    pageTitle.set('Dealerships')

    vm.deleteDealership = function(dealership) {
      Dealership.destroy(dealership).then(ret => {
        vm.dealerships = vm.dealerships.filter(dealership => dealership.id !== ret.data.id )
        toastr.success('deleted successfully')
      })
    }

    vm.$onInit = () => {
      Dealership.all().then((response) => {
        vm.dealerships = response.data
      })
    }
  }]
})
