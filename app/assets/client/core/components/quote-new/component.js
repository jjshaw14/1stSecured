import angular from 'angular'

angular.module('firstsecured.core')
.component('quoteNew', {
  template: require('./template.html'),
  controller: ['Template', '$routeParams', '$location', 'pageTitle', 'Me', function(Template, $routeParams, $location, pageTitle, Me) {
    var vm = this

    pageTitle.set('New Contract')

    vm.$onInit = () => {
      vm.contract = {}

      Template.find($routeParams.template).then((response) => {
        vm.contract.template = response.data
        Me.get().then((me) =>  me.dealership  && me.dealership.id !== vm.contract.template.dealership.id  && $location.path('/'))
      })
    }

    vm.onSave = () => {
      $location.path(`/contracts/${vm.contract.id}`)
    }
  }]
})
