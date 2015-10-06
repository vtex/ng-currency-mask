describe 'vtex.ngCurrencyMask', ->
  beforeEach module 'vtex.ngCurrencyMask'

  $scope = null
  $compile = null
  markup = '<input type="text" name="discount" ng-model="model.value" currency-mask />'
  Utils = null

  beforeEach inject (_$compile_, _$rootScope_) ->
    $scope = _$rootScope_
    $compile = _$compile_


  describe 'CurrencyMaskUtils Service', ->

    beforeEach inject (_CurrencyMaskUtils_) ->
      Utils = _CurrencyMaskUtils_

    it 'should exist', -> expect(Utils).toBeDefined()

    it 'clearSeparators # should clear separators from input value and return float', ->
      expect(Utils.clearSeparators('1,250.90')).toBe 1250.9
      expect(Utils.clearSeparators('1,500,250.99')).toBe 1500250.99

    it 'toIntCents # should transform from float to int (cents)', ->
      expect(Utils.toIntCents(1250.90)).toBe 125090
      expect(Utils.toIntCents(1500250.99)).toBe 150025099

    it 'toFloatString # should transform from int (cents) to float', ->
      expect(Utils.toFloatString(125090)).toBe '1250.90'
      expect(Utils.toFloatString(150025099)).toBe '1500250.99'


  describe 'currencyMask directive', ->

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
