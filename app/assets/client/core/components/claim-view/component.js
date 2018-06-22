require('./style.scss')

import angular from 'angular'
import _       from 'lodash'
import moment from 'moment'
angular.module('firstsecured.core')
.component('claimView', {
  template: require('./template.html'),
  controller: ['Claim', 'Me', '$window', '$location', '$routeParams', function(Claim, Me, $window, $location, $routeParams) {
    var vm = this
    vm.isAdmin = false
    vm.$onInit = () => {
      Me.get().then((me) => {
        if (!me.dealership) vm.isAdmin = true
      })
      Claim.find($routeParams.dealershipId, $routeParams.id).then((response) => {
        vm.claim = response.data
        if (vm.claim.authorized_at) vm.claim.authorized_at = moment(vm.claim.authorized_at).format('MM/DD/YY')
        if (vm.claim.repaired_at) vm.claim.repaired_at = moment(vm.claim.repaired_at).format('MM/DD/YY')
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

    vm.uploadFile = (data) => {
      Claim.update({}, vm.claim, { attachment: data }).then((response) => {
        vm.claim = response.data
      })
    }
  }]
})
