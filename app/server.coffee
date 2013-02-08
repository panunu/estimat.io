app    = require('express')()
server = require('http').createServer(app)
io     = require('socket.io').listen(server)
_      = require('underscore')

server.listen 3000

app.get '/', (request, response) ->
  response.sendfile __dirname + '/views/index.html'

people = []
cards  = []
scale  = [0, 0.5, 1, 2, 3, 5, 8, 13, 20, 40, 100, '?']

io.sockets.on 'connection', (socket) ->
  people.push socket.id
  io.sockets.emit 'people', people.length
  io.sockets.emit 'scale', scale

  socket.on 'disconnect', ->
    people = people.filter (x) -> x != socket.id
    cards = cards.filter (x) -> x != socket.id
    io.sockets.emit 'people', people.length

  socket.on 'ready', (card) ->
    cards = cards.filter (x) -> x.id != socket.id
    cards.push { 'id': socket.id, 'card': card }

    if cards.length is people.length
      values = _.sortBy((cards.map (x) -> x.card), (x) -> x)
      cards = []

      io.sockets.emit 'ready', {
        'values': values,
        'avg': _.reduce(values, (x, y) -> parseFloat(x) + parseFloat(y)) / values.length,
        'min': _.min(values),
        'max': _.max(values)
      }

  socket.on 'cancel', ->
    cards = cards.filter (x) -> x.id != socket.id
