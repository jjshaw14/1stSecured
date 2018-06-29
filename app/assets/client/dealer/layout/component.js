import './style.scss'

import angular from 'angular'

angular.module('firstsecured.dealer')
.component('layout', {
  template: require('./template.html'),
  controller: ['Me', function(Me) {
    var vm = this

    Me.get().then((me) => {
      vm.me = me
      vm.sidebarCollapsed = false
      vm.menu = [
        {
          'label': 'MENU',
          'isLabel': true
        }, {
          'path': '/contracts',
          'label': 'Contracts',
          'icon': {'class': 'material-icons', 'content': 'assignment' }
        }, {
          'path': '/documents',
          'label': 'Documents',
          'icon': { 'class': 'material-icons', 'content': 'assignment' }
        }
      ]
      if (me.user_type === 'owner') {
        vm.menu = vm.menu.concat([{
          'path': '/users',
          'label': 'Users',
          'icon': { 'class': 'material-icons', 'content': 'people' }
        }, {
          'path': '/claims',
          'label': 'Claims',
          'icon': { 'class': 'material-icons', 'content': 'people' }
        }])
      }
    })
  }]
})
