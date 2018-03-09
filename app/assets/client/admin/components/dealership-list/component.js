import angular from 'angular'

angular.module('firstsecured.admin')
.component('dealershipList', {
  template: require('./template.html'),
  controller: ['Dealership', 'pageTitle', function(Dealership, pageTitle) {
    var vm = this

    pageTitle.set('Dealerships')

    vm.$onInit = () => {
      Dealership.all().then((response) => {
        vm.dealerships = response.data
      })
    }
  }]
})
