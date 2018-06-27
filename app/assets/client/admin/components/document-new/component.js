import angular from 'angular'


angular.module('firstsecured.admin')
.component('documentNew', {
  template: require('./template.html'),
  controller: ['Dealership', 'pageTitle', '$routeParams', 'Me', '$location', function(Dealership, pageTitle, $routeParams, Me, $location) {
    var vm = this
    pageTitle.set('New Document')
    vm.document = {}

    Me.get().then((me) => {

      if (me.dealership) {
        $location.path('/')
      }
      else {
        Dealership.find($routeParams.dealership_id).then((resp) => {
          console.log(resp)
          vm.document.dealership = resp.data
        })
      }
    })
  }]
})
