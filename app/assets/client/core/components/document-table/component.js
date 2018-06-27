import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('documentTable', {
  template: require('./template.html'),
  bindings: {
    dealership: '=?',
    contract: '=?'
  },
  controller: ['Document', 'pageTitle', function(Document, pageTitle) {
    pageTitle.set('Documents')

    var vm = this

    vm.searchText = ''

    vm.$onInit = () => {
      vm.search()
    }
    vm.deleteDocument = (document) => {
      Document.destroy(document).then(ret => {
        vm.documents = vm.documents.filter(document => document.id !== ret.data.id)
        toastr.success('deleted successfully')
      })
    }
    vm.search = () => {
      Document.all({ dealership: vm.dealership }).then((response) => {
        vm.documents = response.data
      })
    }
  }]
})

