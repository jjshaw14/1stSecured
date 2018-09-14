import angular from 'angular'
import moment from 'moment'
angular.module('firstsecured.dealer')
.component('dashboard', {
  template: require('./template.html'),
  controller: ['Me', 'Dashboard', 'pageTitle', 'ChartJs', function(Me, Dashboard, pageTitle, ChartJs) {
    pageTitle.set('Dashboard')
    var vm = this

    let barChart = id => data => labels => {
        new ChartJs.Chart(document.getElementById(id).getContext('2d'), { // eslint-disable-line
        type: 'bar',
        data: {
          labels,
          datasets: [{
            data: data,
            backgroundColor: 'white'
          }]
        },
        options: {
          scales: {
            yAxes: [{ ticks: { fontColor: 'white' }}],
            xAxes: [{ ticks: { fontColor: 'white' }, gridLines: { color: 'rgba(0,0,0,0)'  }}]
          }
        }
      })
    }
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December' ]
    Me.get().then((me) => {
      vm.me = me
      Dashboard.find(me.dealership.id).then(results => {
        vm.dashboard = results.data
        new ChartJs.Chart(document.getElementById('amount-in-reserve').getContext('2d'), { // eslint-disable-line
          type: 'line',
          options: {
            scales: {
              yAxes: [{ gridLines: { color: 'rgba(0,0,0,0)'  }}] }
          },
          data: {
            labels: vm.dashboard.reserves.map(reserve => moment(reserve.run_at).format('MMM Do YY')),
            datasets: [{
              data: vm.dashboard.reserves.map(reserve => reserve.value / 100),
              backgroundColor: '#bc202e',
              pointRadius: 0,
              fill: true
            }]

          }
        })
        barChart('contract-bar')(vm.dashboard.contracts.map(contract => contract.value))(vm.dashboard.contracts.map(contract => months[contract.month - 1]))

        barChart('claim-bar')(vm.dashboard.claims.map(contract => contract.value))(vm.dashboard.claims.map(contract => months[contract.month - 1]))

        new ChartJs.Chart(document.getElementById('profit-pie').getContext('2d'), { // eslint-disable-line
          type: 'doughnut',
          data: {
            labels: ['Claims', 'Net Profit'],
            datasets: [{
              data: [
                vm.me.dealership.performance.claims / 100,
                parseFloat(vm.me.dealership.performance.matured)
              ],
              backgroundColor: ['#DE9196', '#CA4E56' ]
            }]
          }
        })


        console.log(vm.me)
        console.log(results.data)
      })
    })
  }]
})
