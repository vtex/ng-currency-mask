describe 'vtex.ngCurrencyMask', ->
  beforeEach module 'vtex.ngCurrencyMask'

  $scope = null
  $compile = null
  markup = '<input type="text" name="discount" ng-model="model.value" currency-mask />'

  beforeEach inject (_$compile_, _$rootScope_) ->
    $scope = _$rootScope_
    $compile = _$compile_

  describe 'currency-mask directive', ->

    compileEl = (scope) ->
      el = $compile(markup) scope
      scope.$digest()
      return el

    it 'should format model (int cents) to view (float-like string)', ->
      $scope.model = value: 100 # $ 1
      el = compileEl $scope

      expect(el[0].value).toBe '1.00'

      $scope.model.value = 1250 # $ 12.50
      $scope.$digest()

      expect(el[0].value).toBe '12.50'

    it 'should keep model value in cents (int)', ->
      $scope.model = value: 1050 # $ 10.50
      el = compileEl $scope

      expect($scope.model.value).toBe 1050

    it 'should apply currency filter on blur', ->
      $scope.model = value: 420 # $ 4.20
      el = compileEl $scope

      expect(el[0].value).toBe '4.20'

      el[0].value = '5'
      expect(el[0].value).toBe '5'

      el[0].blur()
      setTimeout ->
        expect(el[0].value).toBe '5.00'
      , 200
