import angular from 'angular'

angular.module('firstsecured.admin')
.component('layout', {
  template: require('./template.html'),
  controller: ['Me', function(Me) {
    var vm = this

    vm.sidebarCollapsed = false
    vm.menu = require('./menu.js')

    Me.get().then((me) => {
      vm.me = me
    })
  }]
})
