request = require 'request'
common = require '../common'

module.exports = () ->
  apiEndpoint = process.env.GOINC_API_ENDPOINT
  apiVer = process.env.GOINC_API_VERSION
  geoApiEndpoint = process.env.GEOIP_API_ENDPOINT
  geoApiKey = process.env.GEOIP_API_KEY

  my: (req, res) ->
    xForward = req.get('x-forwarded-for')
    if xForward? and (xForward isnt "")
      ipToSend = xForward.split(',')[0]
    else
      ipToSend = req.ip

    common.log "IP request: " + ipToSend
    uri = geoApiEndpoint + ipToSend + '?access_key=' + geoApiKey
    request uri, (err, response, body) ->
      common.log 'back from goinc api'
      if err?
        common.log 'error: ' + err
        res.json 500, err
      else
        common.log body
        if response.statusCode is 200
          res.json 200, JSON.parse(body)
        else
          res.json 404, {}
