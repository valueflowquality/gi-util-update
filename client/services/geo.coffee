angular.module('gi.util').factory 'giGeo'
, ['$q', '$http', '$cookieStore'
, ( $q, $http, $cookies) ->

  cookieID = "giGeo"

  country: () ->
    deferred = $q.defer()
    geoInfo = sessionStorage[cookieID]
    if not geoInfo?
      $http.get("/api/geoip").success( (info) ->
        sessionStorage[cookieID] = angular.toJson(info)
        deferred.resolve info.country_code
      ).error (data) ->
        deferred.reject data
    else
      geoInfo = angular.fromJson(geoInfo)
      deferred.resolve geoInfo.country_code

    deferred.promise
]
