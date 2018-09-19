import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('documentTable', {
  template: require('./template.html'),
  bindings: {
    dealership: '=?',
    contract: '=?'
  },
  controller: ['Me', 'Document', 'pageTitle', function(Me, Document, pageTitle) {
    pageTitle.set('Documents')

    var vm = this
    Me.get().then((me) => {
      vm.isAdmin = !me.dealership
      if (me.dealership) {
        vm.dealership = me.dealership
        vm.search()
      }
    })
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

