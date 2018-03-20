import angular from 'angular'

angular.module('firstsecured.admin')
.component('templateEdit', {
  template: require('./template.html'),
  controller: ['Template', 'pageTitle', '$routeParams', function(Template, pageTitle, $routeParams) {
    var vm = this

    pageTitle.set('Edit Template')

    vm.$onInit = () => {
      Template.find($routeParams.id).then((response) => {
        vm.template = response.data
      })
    }
  }]
})
