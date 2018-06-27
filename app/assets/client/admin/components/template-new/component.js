import angular from 'angular'


angular.module('firstsecured.admin')
.component('templateNew', {
  template: require('./template.html'),
  controller: ['Dealership', 'Template', 'pageTitle', '$routeParams', 'Me', '$location', function(Dealership, Template, pageTitle, $routeParams, Me, $location) {
    var vm = this
    pageTitle.set('New Template')
    vm.$onInit = () => {
      Template.new($routeParams.dealership_id, $routeParams.template).then((resp) => {
        resp.data.packages.forEach((p) => {
          p.coverages.forEach((coverage) => { coverage.amount = parseFloat(coverage.cost) })
          p.addons.forEach((addon) => { addon.amount = parseFloat(addon.cost) })
        })
        vm.template = resp.data
      })
      Me.get().then((me) => {
        if (me.dealership && me.dealership.id !== $routeParams.dealership_id) {
          $location.path('/')
        }
      })
    }
  }]
})
