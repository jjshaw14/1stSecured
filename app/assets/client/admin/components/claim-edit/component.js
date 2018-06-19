import angular from 'angular'

angular.module('firstsecured.admin')
.component('templateEdit', {
  template: require('./template.html'),
  controller: ['Claim', 'pageTitle', '$routeParams', function(Claim, pageTitle, $routeParams) {
    var vm = this

    pageTitle.set('Edit Claim')

    vm.$onInit = () => {
      Claim.find($routeParams.id).then((response) => {
        response.data.cost = parseFloat(response.data.cost)
        vm.claim = response.data
      })
    }
  }]
})

