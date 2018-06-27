import angular from 'angular'
require('./style.scss')

angular.module('firstsecured.core')
.component('documentForm', {
  template: require('./template.html'),
  bindings: {
    document: '=?record',
    onSave: '=?'
  },
  controller: ['Document', '$http', '$window', '$location', function(Document, $http, $window, $location) {
    var vm = this

    vm.onSave = function() {
      $location.path(`/documents/${vm.claim.id}`)
    }
    vm.save = function() {
      Document.save(vm.dealership, vm.document).then((response) => {
        vm.claim = response.data
        vm.onSave(response)
      }, (response) => {
        vm.document.errors = response.data.errors
      })
    }

    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
