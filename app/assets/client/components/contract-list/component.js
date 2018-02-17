import angular from 'angular'

angular.module('firstsecured')
.component('contractList', {
  template: require('./template.html'),
  controller: ['Contract', 'pageTitle', function(Contract, pageTitle) {
    pageTitle.set('Contracts')
  }]
})
