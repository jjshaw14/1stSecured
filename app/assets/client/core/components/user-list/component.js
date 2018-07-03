require('./style.scss')

import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('userList', {
  template: require('./template.html'),
  controller: ['User', 'pageTitle', 'Me', '$location', function(User, pageTitle, Me, $location) {
    var vm = this

    pageTitle.set('Users')
    vm.deleteUser = (user) => {
      console.log(user)
      User.destroy(user).then(ret => {
        vm.users = vm.users.filter(user => user.id !== ret.data.id )
        toastr.success('deleted successfully')
      })
    }

    vm.$onInit = () => {
      Me.get().then((me) => {
        if (me.dealership) {
          if (me.user_type === 'owner') {
            vm.users = me.dealership.users
          } else {
            $location.url('/contracts')
          }
        } else {
          User.all({ admin: true }).then((response) => {
            vm.users = response.data
          })
        }
      })
    }
  }]
})
