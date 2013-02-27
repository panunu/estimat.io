io = require('socket.io').listen(3000)
_  = require('underscore')

people = []
cards  = []
scale  = ['0', '0.5', '1', '2', '3', '5', '8', '13', '20', '40', '100', '?']

io.sockets.on 'connection', (socket) ->
  people.push socket.id
  io.sockets.emit 'people', people.length
  io.sockets.emit 'scale', scale

  socket.on 'disconnect', ->
    people = people.filter (x) -> x != socket.id
    cards  = cards.filter (x) -> x != socket.id
    io.sockets.emit 'people', people.length

  socket.on 'ready', (card) ->
    cards = cards.filter (x) -> x.id != socket.id

    if _.contains(scale, card)
      cards.push { 'id': socket.id, 'card': card }

    if cards.length is people.length
      all    = _.sortBy((cards.map (x) -> x.card), (x) -> x)
      values = all.filter (x) -> x != '?'
      cards  = []

      io.sockets.emit 'ready', {
        'values': all,
        'avg': _.reduce(values, (x, y) -> parseFloat(x) + parseFloat(y)) / values.length,
        'min': _.min(values),
        'max': _.max(values)
      }

  socket.on 'cancel', ->
    cards = cards.filter (x) -> x.id != socket.id
