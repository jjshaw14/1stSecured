import angular from 'angular'

angular.module('firstsecured.core')
.filter('termInMonthsOrYears', function() {
  return (length_in_months) => {
    return length_in_months < 12 ? `${length_in_months} months` : `${length_in_months / 12} years`
  }
})
