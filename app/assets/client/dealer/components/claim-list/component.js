import angular from 'angular'

angular.module('firstsecured.dealer')
.component('claimList', {
  template: require('./template.html'),
  controller: ['Me', 'pageTitle', function(Me, pageTitle) {
    pageTitle.set('Contracts')
    var vm = this
    Me.get().then((me) => {
      vm.me = me
    })
  }]
})
