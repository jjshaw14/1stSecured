import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('dealershipView', {
  template: require('./template.html'),
  controller: ['$window', 'Me', 'Dealership', '$routeParams', 'pageTitle', 'Template', function($window, Me, Dealership, $routeParams, pageTitle, Template) {
    var vm = this

    Me.get().then((me) => {
      if (me.dealership && String(me.dealership.id) !== $routeParams.id) {
        $window.history.back()
      }
      vm.isAdmin = me.dealership ? false  : true
      if (vm.isAdmin) {
      	Template.all().then((resp) => { vm.templates = resp.data })
      }
    })
    vm.view = 'contracts'

    vm.deleteTemplate = (t) => {
      Template.destroy(t).then(ret => {
        vm.dealership.templates = vm.dealership.templates.filter(template => template.id !== ret.data.id)
        toastr.success('deleted successfully')
      })
    }

    vm.$onInit = () => {
      Dealership.find($routeParams.id).then((response) => {
        vm.dealership = response.data

        pageTitle.set(vm.dealership.name)
      })
    }

  }]
})
