import angular from 'angular'

angular.module('firstsecured.admin')
.component('quoteNew', {
  template: require('./template.html'),
  controller: ['Template', '$routeParams', '$location', 'pageTitle', function(Template, $routeParams, $location, pageTitle) {
    var vm = this

    pageTitle.set('New Quote')

    vm.$onInit = () => {
      vm.contract = {}

      Template.find($routeParams.template).then((response) => {
        vm.contract.template = response.data
      })
    }

    vm.onSave = () => {
      $location.path(`/contracts/${vm.contract.id}`)
    }
  }]
})
