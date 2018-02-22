import angular from 'angular'

angular.module('firstsecured')
.filter('phone', ['$sce', function($sce) {
  return function (tel, options) {
    if (!tel) { return '' }

    options || (options = { link: false })

    var value = tel.toString().trim().replace(/^\+/, '').replace(/\-/g, '')

    if (value.match(/[^0-9]/)) {
      return tel
    }

    var country, city, number

    switch (value.length) {
    case 10: // +1PPP####### -> C (PPP) ###-####
      country = 1
      city = value.slice(0, 3)
      number = value.slice(3)
      break
    case 11: // +CPPP####### -> CCC (PP) ###-####
      country = value[0]
      city = value.slice(1, 4)
      number = value.slice(4)
      break
    case 12: // +CCCPP####### -> CCC (PP) ###-####
      country = value.slice(0, 3)
      city = value.slice(3, 5)
      number = value.slice(5)
      break
    default:
      return tel
    }

    if (country === 1) {
      country = ''
    }

    number = number.slice(0, 3) + '-' + number.slice(3)

    if (options.link) {
      return $sce.trustAsHtml('<a href="tel:' + (country + city + number) + '">' + (country + ' (' + city + ') ' + number).trim() + '</a>')
    }

    return (country + ' (' + city + ') ' + number).trim()
  }
}])
