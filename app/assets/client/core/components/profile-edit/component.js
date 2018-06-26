import angular from 'angular'
import toastr from 'toastr'
angular.module('firstsecured.core')
.component('profileEdit', {
  template: require('./template.html'),
  controller: ['Me', 'API', 'pageTitle', '$window', function(Me, API, pageTitle, $window) {
    var vm = this

    pageTitle.set('Edit Profile')

    vm.$onInit = () => {
      Me.get().then(me =>  {
        vm.user = me
        vm.user.password = null
      })
    }
    vm.save = function() {
      Me.update(vm.user).then((me) => {
        if (me.id) {
          toastr.success('Password changed successfully')
          vm.user = me
        }
      })
    }
    vm.cancel = function() {
      $window.history.back()
    }
  }]
})
