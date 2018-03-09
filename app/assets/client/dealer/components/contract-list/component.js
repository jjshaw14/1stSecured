import angular from 'angular'

angular.module('firstsecured.dealer')
.component('contractList', {
  template: require('./template.html'),
  controller: ['Me', 'pageTitle', function(Me, pageTitle) {
    pageTitle.set('Contracts')

    Me.get().then((me) => {
      this.me = me
    })
  }]
})
