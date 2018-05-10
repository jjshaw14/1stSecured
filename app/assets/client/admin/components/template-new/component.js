import angular from 'angular'

angular.module('firstsecured.admin')
.component('templateNew', {
  template: require('./template.html'),
  controller: ['Dealership', 'pageTitle', '$routeParams', 'Me', '$location', function(Dealership, pageTitle, $routeParams, Me, $location) {
    var vm = this
    pageTitle.set('New Template')
    vm.$onInit = () => {
      Me.get().then((me) => {
        if (me.dealership && me.dealership.id !== $routeParams.dealership_id) {
          $location.path('/')
        } else {
          vm.template = {
            packages: [],
            dealership_id: $routeParams.dealership_id
          }
        }
      })
    }
  }]
})
