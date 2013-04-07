io = require('socket.io').listen(3000)
_  = require('underscore')

cards  = []
rooms  = []
scale  = ['0', '0.5', '1', '2', '3', '5', '8', '13', '20', '40', '100', '?']

# Horrible ribule, please refuktore!

io.sockets.on 'connection', (socket) ->
  socket.on 'join', (room) ->
    socket.set 'room', room, () -> socket.join room

    if rooms[room] is undefined then rooms[room] = { cards: [], people: [], results: [], scale: scale }
    rooms[room].people.push socket.id

    io.sockets.in(room).emit 'people', rooms[room]

  socket.on 'disconnect', ->
    socket.get 'room', (e, room) ->
      rooms[room].people = rooms[room].people.filter (x) -> x != socket.id
      rooms[room].cards  = rooms[room].cards.filter (x) -> x != socket.id

      io.sockets.in(room).emit 'people', rooms[room]

  socket.on 'ready', (card) ->
    socket.get 'room', (e, room) ->
      rooms[room].cards = rooms[room].cards.filter (x) -> x.id != socket.id

      if _.contains(rooms[room].scale, card)
        rooms[room].cards.push { 'id': socket.id, 'card': card }

      if rooms[room].cards.length is rooms[room].people.length
        all    = rooms[room].cards.map (x) -> x.card
        values = all.filter (x) -> x != '?'
        values = if values.length > 0 then values else [0]
        rooms[room].cards  = []
        rooms[room].results.unshift {
          'values': all,
          'avg': _.reduce(values, (x, y) -> parseFloat(x) + parseFloat(y)) / values.length,
          'min': _.min(values),
          'max': _.max(values)
        }

        io.sockets.in(room).emit 'ready', rooms[room]

  socket.on 'cancel', ->
    socket.get 'room', (e, room) ->
      rooms[room].cards = rooms[room].cards.filter (x) -> x.id != socket.id
