import './vendor'
import './stylesheets/simplify.scss'

import angular from 'angular'
import dropdown from 'angular-ui-bootstrap/src/dropdown'

var app = angular.module('firstsecured.core', [dropdown, 'checklist-model', 'simplemde', 'ngRoute', 'ng-currency', '720kb.datepicker', 'daterangepicker'])

var cmpnt = app.component
app.component = function (name, options) {
  return cmpnt(name, angular.extend({ controllerAs: 'vm' }, options))
}

var ngFiles = require.context('./', true, /(components|directives|factories|filters).*\.js$/)
ngFiles.keys().forEach(ngFiles)
