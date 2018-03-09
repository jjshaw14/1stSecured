import angular from 'angular'
require('../core')

var app = angular.module('firstsecured.admin', ['firstsecured.core'])

var cmpnt = app.component
app.component = function (name, options) {
  return cmpnt(name, angular.extend({ controllerAs: 'vm' }, options))
}

require('./routes')

var ngFiles = require.context('./', true, /(components|directives|factories|filters|layout).*\.js$/)
ngFiles.keys().forEach(ngFiles)
