# Angular Currency Mask
Currency input handler for AngularJS (1.X)

## Usage

#### Reference script

Find both compiled and minified versions inside `dist` folder.

```html
<script src="ng-currency-mask.min.js"></script>
```

#### Inject `vtex.ngCurrencyMask`

```coffeescript
angular.module 'yourApp', ['vtex.ngCurrencyMask']
```

#### Bind directive `currency-mask`

```html
<input type="text" name="discount" placeholder="0.00"
       ng-model="model.value" currency-mask />
```
*Obs: __ngModel__ is required!*

## How it works

#### Model

 - Expects it to be an `int`, in cents. e.g.: `100` ($ 1), `420` ($ 4,20)
 - Always receive parsed value from view input. e.g.: `'1,250.50' -> 125050`

*Obs: Will parse both `'1.250,50'` and `'1,250.50'` inputs correctly (__i18n__ differences).*


#### View

 - Displays formatted model value (as `string`)
 - Uses `$filter('currency')`, which uses `$locale.NUMBER_FORMATS` configuration (separators, fraction size, etc).

*Obs: Currency symbol is always hidden.*
*Pro tip: For now, if you want to, prepend or append symbol `<span>` to `<input>`.*

## Development - Contribute!

Inside `src` you can find this module source code, written in **CoffeeScript**.
Tests can be found in `spec` folder.

To build the `.js` and uglify it, install npm dev-dependencies and run grunt:

    (sudo) npm i
    grunt
