
import jquery from 'jquery'
import moment from 'moment'
window.$ = jquery

import 'angular'
import 'angular-route'
import 'font-awesome-webpack'
require('simplemde/dist/simplemde.min.css')
require('expose-loader?SimpleMDE!simplemde/dist/simplemde.min.js')
import 'simplemde-angular/dist/simplemde-angular.js'
import 'bootstrap-daterangepicker/daterangepicker.css'
import 'bootstrap-daterangepicker/daterangepicker.js'
require('imports-loader?moment=moment!angular-daterangepicker/js/angular-daterangepicker.js')
import 'angularjs-datepicker/dist/angular-datepicker.js'
import 'angularjs-datepicker/dist/angular-datepicker.css'
require('ng-currency')
import './vendor.scss'
import 'checklist-model'
import 'angular-ui-bootstrap/src/dropdown'

import 'toastr/build/toastr.css'
