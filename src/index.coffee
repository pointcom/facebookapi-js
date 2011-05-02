https = require 'https'
url = require 'url'

class GraphRequest
  constructor: (path) ->
    @events = {}
    @path = path
    @accessToken = null

  on: (name, func) ->
    @events[name] = func

  setAccessToken: (accessToken) ->
    @accessToken = accessToken

  send: ->
    if @accessToken?
      @path += "?access_token=#{@accessToken}"

    params =
      host: "graph.facebook.com"
      path: @path

    console.log @path

    https.request params, (res) =>
      res.setEncoding 'utf8'
      @data = ""
      res.on 'data', (chunk) =>
        @data += chunk
      res.on 'end', =>
        response = JSON.parse(@data)
        if response.error?
          @events["error"].apply(response, [response.error.type, response.error.message])
        else
          @events["response"].apply(response, [response])
    .end()



GraphApi = (object_id, callback) ->
  req = new GraphRequest("/#{object_id}")
  callback.apply(req, [req])
  req.send()



