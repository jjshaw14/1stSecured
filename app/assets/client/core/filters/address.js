import angular from 'angular'
import _ from 'lodash'

angular.module('firstsecured.core')
.filter('address', function() {
  return (input, _default) => {
    if (!input) return ''
    return _.compact([input.address1, input.address2, input.address3, input.city, [input.state, input.zip].join(' ')]).join(', ') || _default
  }
})
