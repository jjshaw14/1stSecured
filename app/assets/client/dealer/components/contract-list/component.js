import angular from 'angular'

angular.module('firstsecured.dealer')
.component('contractList', {
  template: require('./template.html'),
  controller: ['Me', 'pageTitle', '$scope', function(Me, pageTitle, $scope) {
    pageTitle.set('Contracts')
    var vm = this
    vm.view = 'contracts'
    vm.externalFilter = {
      filter: null
    }
    vm.filter = (filter) => {
      vm.externalFilter = { filter }
      $scope.$broadcast('filterChanged', vm.externalFilter)
      vm.view = 'contracts'
    }
    vm.changeView = (view) => {
      vm.externalFilter = { filter: view }
      vm.view = 'lossRatio'
    }
    Me.get().then((me) => {
      vm.me = me
    })
  }]
})
