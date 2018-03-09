import './style.scss'

import angular from 'angular'

angular.module('firstsecured.dealer')
.component('layout', {
  template: require('./template.html'),
  controller: ['Me', function(Me) {
    var vm = this

    Me.get().then((me) => {
      vm.me = me
    })
  }]
})
