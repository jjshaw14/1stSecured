require('./style.scss')

import angular from 'angular'
import _       from 'lodash'
import moment from 'moment'
angular.module('firstsecured.core')
.component('documentView', {
  template: require('./template.html'),
  controller: ['Document', 'Me', '$window', '$location', '$routeParams', function(Document, Me, $window, $location, $routeParams) {
    var vm = this
    vm.isAdmin = false
    vm.$onInit = () => {
      Me.get().then((me) => {
        if (!me.dealership) vm.isAdmin = true
      })
      Document.find($routeParams.dealershipId, $routeParams.id).then((response) => {
        console.log(response.data)
        vm.document = response.data
      })
    }

    vm.uploadFile = (data) => {
      Document.update({}, vm.document, { attachment: data }).then((response) => {
        vm.document = response.data
      })
    }
  }]
})
