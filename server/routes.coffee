exports.configure = (app, rest) ->
  rest.routeResource 'timePatterns', app
  , app.middleware.userAction, app.controllers.timePattern