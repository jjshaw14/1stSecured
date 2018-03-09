require('./style.scss')

import angular from 'angular'
import _       from 'lodash'

angular.module('firstsecured.core')
.component('contractView', {
  template: require('./template.html'),
  controller: ['$http', 'Contract', '$window', '$location', '$routeParams', function($http, Contract, $window, $location, $routeParams) {
    var vm = this

    vm.$onInit = () => {
      Contract.find($routeParams.dealershipId, $routeParams.id).then((response) => {
        vm.contract = response.data
        if (vm.contract.purchased_on) vm.contract.purchased_on = new Date(vm.contract.purchased_on)
        vm.refreshTimeline()
      })
    }

    vm.refreshTimeline = () => {
      vm.timeline = _.groupBy(vm.contract.history, 'request_id')
      vm.timeline = _.map(vm.timeline, (events) => {
        var topLevelEvent = _.find(events, { type: 'contract.create' }) || _.first(events)
        topLevelEvent = _.cloneDeep(topLevelEvent)
        topLevelEvent.events = events
        return topLevelEvent
      })
      console.log(vm.timeline)
    }
  }]
})
