require('./style.scss')

import angular from 'angular'
import _       from 'lodash'
import moment from 'moment'
angular.module('firstsecured.core')
.component('contractView', {
  template: require('./template.html'),
  controller: ['Me', 'Contract', '$window', '$location', '$routeParams', function(Me, Contract, $window, $location, $routeParams) {
    var vm = this
    vm.view = 'changes'
    vm.$onInit = () => {
      Me.get().then((me) => {
        if (!me.dealership || me.user_type === 'owner') {
          vm.canSeeStats = true
        }
      })
      Contract.find($routeParams.dealershipId, $routeParams.id).then((response) => {
        vm.contract = response.data
        if (vm.contract.purchased_on) vm.contract.purchased_on = moment(vm.contract.purchased_on).toDate()
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
    }

    vm.uploadFile = (data) => {
      Contract.update({}, vm.contract, { signed_copy: data }).then((response) => {
        vm.contract = response.data
      })
    }
  }]
})
