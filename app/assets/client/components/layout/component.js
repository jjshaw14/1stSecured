import './style/simplify.scss'

import angular from 'angular'

angular.module('firstsecured')
.component('layout', {
  template: require('./template.html'),
  controller: [function() {
    var vm = this

    vm.sidebarCollapsed = false
    vm.menu = require('./menu.js')
  }]
})
