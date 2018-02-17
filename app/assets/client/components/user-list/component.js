require('./style.scss')

import angular from 'angular'

angular.module('firstsecured')
.component('userList', {
  template: require('./template.html'),
  controller: ['User', 'pageTitle', function(User, pageTitle) {
    var vm = this

    pageTitle.set('Users')

    vm.$onInit = () => {
      User.all({ admin: true }).then((response) => {
        vm.users = response.data
      })
    }
  }]
})
