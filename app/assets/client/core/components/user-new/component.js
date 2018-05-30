import angular from 'angular'

angular.module('firstsecured.core')
.component('userNew', {
  template: require('./template.html'),
  controller: ['Dealership', 'pageTitle', function(Dealership, pageTitle) {
    var vm = this

    pageTitle.set('New User')

    vm.$onInit = () => {
      vm.user = {}
    }
  }]
})
