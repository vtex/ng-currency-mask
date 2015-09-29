angular.module('vtex.ngCurrencyMask', [])
.directive 'currencyMask', ($timeout, $filter) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, elem, attrs, ctrl) ->
    errorPrefix = 'VTEX ngCurrencyMask'

    if not ctrl
      return throw new Error "#{errorPrefix} requires ngModel!"

    if not (/input/i).test elem[0].tagName
      return throw new Error "#{errorPrefix} should be binded to <input />."

    clearSeparators = (value) ->
      return unless value?
      value = value.toString() if typeof value is 'number'
      value.replace(/,/g, '.').replace /\.(?![^.]*$)/g, ''

    applyCurrencyFilter = (value = ctrl.$viewValue or elem[0].value) ->
      elem[0].value = $filter('currency') clearSeparators(value), '' if value

    ctrl.$parsers.unshift (value) ->
      return unless value?
      value = clearSeparators value
      Math.abs parseInt((parseFloat(value)) * 100)

    ctrl.$formatters.unshift (value) ->
      return unless value?
      value = Math.abs (value / 100)
      value.toFixed 2

    elem[0].addEventListener 'blur', ->
      applyCurrencyFilter()

    $timeout applyCurrencyFilter
