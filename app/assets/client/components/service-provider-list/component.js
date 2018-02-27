import angular from 'angular'

angular.module('firstsecured')
.component('serviceProviderList', {
  template: require('./template.html'),
  controller: ['ServiceProvider', 'pageTitle', function(ServiceProvider, pageTitle) {
    var vm = this

    pageTitle.set('Users')

    vm.$onInit = () => {
      ServiceProvider.all().then((response) => {
        vm.serviceProviders = response.data
      })
    }
  }]
})
