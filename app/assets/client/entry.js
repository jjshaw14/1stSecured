import angular from 'angular'
import 'angular-route'
import './vendor'

import dropdown from 'angular-ui-bootstrap/src/dropdown'

var app = angular.module('firstsecured', [dropdown, 'checklist-model', 'ngInputCurrency', 'simplemde', 'ngRoute'])

var cmpnt = app.component
app.component = function (name, options) {
  return cmpnt(name, angular.extend({ controllerAs: 'vm' }, options))
}

require('./routes')

var ngFiles = require.context('./', true, /(components|directives|factories|filters).*\.js$/)
ngFiles.keys().forEach(ngFiles)
