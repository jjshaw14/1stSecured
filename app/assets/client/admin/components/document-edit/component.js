import angular from 'angular'

angular.module('firstsecured.admin')
.component('documentEdit', {
  template: require('./template.html'),
  controller: ['Document', 'pageTitle', '$routeParams', function(Document, pageTitle, $routeParams) {
    var vm = this

    pageTitle.set('Edit Document')

    vm.$onInit = () => {
      Document.find(null, $routeParams.id).then((response) => {
        vm.document = response.data
      })
    }
  }]
})

