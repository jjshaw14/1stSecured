import angular from 'angular'

angular.module('firstsecured.admin')
.component('templateNew', {
  template: require('./template.html'),
  controller: ['Dealership', 'pageTitle', '$routeParams', function(Dealership, pageTitle, $routeParams) {
    var vm = this

    pageTitle.set('New Template')

    vm.$onInit = () => {
      vm.user = {}

      Dealership.find($routeParams.dealership).then((response) => {
        vm.user.dealership = response.data
      })
    }
  }]
})
