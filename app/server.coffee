app    = require('express')()
server = require('http').createServer(app)
io     = require('socket.io').listen(server)
_      = require('underscore')

server.listen 3000

app.get '/', (request, response) ->
  response.sendfile __dirname + '/views/index.html'

people = []
cards  = []

io.sockets.on 'connection', (socket) ->
  people.push socket.id
  io.sockets.emit 'people', people.length

  socket.on 'disconnect', ->
    people = people.filter (x) -> x != socket.id
    cards = cards.filter (x) -> x != socket.id
    io.sockets.emit 'people', people.length

  socket.on 'ready', (card) ->
    cards.push { 'id': socket.id, 'card': card }

    if cards.length == people.length
      values = cards.map (x) -> x.card
      io.sockets.emit 'ready', { 'values': values, 'avg': values / values.length, 'min': _.min(values), 'max': _.max(values) }
      cards = []

  socket.on 'cancel', ->
    cards = cards.filter (x) -> x.id != socket.id
