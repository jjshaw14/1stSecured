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
        vm.contract.contract_number = vm.contract.template.dealership.contract_number;
        console.log(vm.contract.template.dealership)
        Me.get().then((me) =>  me.dealership  && me.dealership.id !== vm.dealership.id  && $location.path('/'))
      })
    }


    vm.onSave = (resp) => {
      console.log(resp)
      $location.path(`/contracts/${vm.contract.id || resp.data.id}`)
    }
  }]
})
