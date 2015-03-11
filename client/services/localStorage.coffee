angular.module('gi.util').factory 'giLocalStorage'
, ['$window'
, ($window) ->
  get: (key) ->
    if $window.localStorage[key]
      cart = angular.fromJson($window.localStorage[key])
      return JSON.parse(cart)
    false

  set: (key, val) ->
    if not val?
      $window.localStorage.removeItem(key)
    else
      $window.localStorage[key] = angular.toJson(val)
    $window.localStorage[key]
]
