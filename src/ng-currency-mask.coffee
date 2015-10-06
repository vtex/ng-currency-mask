angular.module('vtex.ngCurrencyMask', [])

.service 'CurrencyMaskUtils', ->
  class CurrencyMaskUtils

    @clearSeparators: (value) ->
      return unless value?
      value = value.toString() if typeof value is 'number'
      parseFloat ( value.replace(/,/g, '.').replace /\.(?![^.]*$)/g, '' )

    @toIntCents: (value) => Math.abs parseInt(@clearSeparators(value) * 100) if value?

    @toFloatString: (value) -> ( Math.abs(value / 100) ).toFixed 2 if value?


.directive 'currencyMask', ($timeout, $filter, CurrencyMaskUtils) ->
  restrict: 'A'
  require: '?ngModel'
  link: (scope, elem, attrs, ctrl) ->
    errorPrefix = 'VTEX ngCurrencyMask'

    if not ctrl
      return throw new Error "#{errorPrefix} requires ngModel!"

    if not (/input/i).test elem[0].tagName
      return throw new Error "#{errorPrefix} should be binded to <input />."

    Utils = CurrencyMaskUtils

    applyCurrencyFilter = (value = ctrl.$viewValue or elem[0].value) ->
      elem[0].value = $filter('currency') Utils.clearSeparators(value), '' if value?

    elem[0].addEventListener 'blur', -> applyCurrencyFilter()

    ctrl.$parsers.unshift Utils.toIntCents
    ctrl.$formatters.unshift Utils.toFloatString

    $timeout applyCurrencyFilter
