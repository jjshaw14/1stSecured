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
      vm.menu = me.user_type === 'owner' ? [
        {
          'label': 'MENU',
          'isLabel': true
        },
        {
          'path': '/users',
          'label': 'Users',
          'icon': { 'class': 'material-icons', 'content': 'people' }
        }, {
          'path': '/contracts',
          'label': 'Contracts',
          'icon': {'class': 'material-icons', 'content': 'assignment' }
        }
      ] : undefined
    })
  }]
})
