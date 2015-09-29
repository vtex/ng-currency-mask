(function() {
  angular.module('vtex.ngCurrencyMask', []).directive('currencyMask', function($timeout, $filter) {
    return {
      restrict: 'A',
      require: '?ngModel',
      link: function(scope, elem, attrs, ctrl) {
        var applyCurrencyFilter, clearSeparators, errorPrefix;
        errorPrefix = 'VTEX ngCurrencyMask';
        if (!ctrl) {
          throw new Error(errorPrefix + " requires ngModel!");
        }
        if (!/input/i.test(elem[0].tagName)) {
          throw new Error(errorPrefix + " should be binded to <input />.");
        }
        clearSeparators = function(value) {
          if (value == null) {
            return;
          }
          if (typeof value === 'number') {
            value = value.toString();
          }
          return value.replace(/,/g, '.').replace(/\.(?![^.]*$)/g, '');
        };
        applyCurrencyFilter = function(value) {
          if (value == null) {
            value = ctrl.$viewValue || elem[0].value;
          }
          if (value) {
            return elem[0].value = $filter('currency')(clearSeparators(value), '');
          }
        };
        ctrl.$parsers.unshift(function(value) {
          if (value == null) {
            return;
          }
          value = clearSeparators(value);
          return Math.abs(parseInt((parseFloat(value)) * 100));
        });
        ctrl.$formatters.unshift(function(value) {
          if (value == null) {
            return;
          }
          value = Math.abs(value / 100);
          return value.toFixed(2);
        });
        elem[0].addEventListener('blur', function() {
          return applyCurrencyFilter();
        });
        return $timeout(applyCurrencyFilter);
      }
    };
  });

}).call(this);
