import angular from 'angular'

angular.module('firstsecured.dealer')
.component('contractList', {
  template: require('./template.html'),
  controller: ['Me', 'pageTitle', '$scope', function(Me, pageTitle, $scope) {
    pageTitle.set('Contracts')
    var vm = this
    vm.externalFilter = {
      filter: null
    }
    vm.filter = (filter) => {
      vm.externalFilter = { filter }
      $scope.$broadcast('filterChanged', vm.externalFilter)
    }
    Me.get().then((me) => {
      vm.me = me
    })
  }]
})
