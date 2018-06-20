import angular from 'angular'

angular.module('firstsecured.admin')
.component('claimEdit', {
  template: require('./template.html'),
  controller: ['Claim', 'pageTitle', '$routeParams', function(Claim, pageTitle, $routeParams) {
    var vm = this

    pageTitle.set('Edit Claim')

    vm.$onInit = () => {
      Claim.find(null, $routeParams.id).then((response) => {
        console.log(response.data)
        response.data.cost = parseFloat(response.data.cost)
        if (response.data.repaired_at) response.data.repaired_at = new Date(response.data.repaired_at)
        if (response.data.authorized_at) response.data.authorized_at = new Date(response.data.authorized_at)

        vm.claim = response.data
      })
    }
  }]
})

