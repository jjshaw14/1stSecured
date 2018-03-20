import angular from 'angular'

angular.module('firstsecured.admin')
.component('userEdit', {
  template: require('./template.html'),
  controller: ['User', 'pageTitle', '$routeParams', function(User, pageTitle, $routeParams) {
    var vm = this

    pageTitle.set('Edit User')

    vm.$onInit = () => {
      User.find($routeParams.id).then((response) => {
        vm.user = response.data
      })
    }
  }]
})
