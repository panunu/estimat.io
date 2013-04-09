io = require('socket.io').listen(3000)
_  = require('underscore')

rooms  = []
scale  = ['0', '0.5', '1', '2', '3', '5', '8', '13', '20', '40', '100', '?']

# Horrible ribule, please refuktore!

io.sockets.on 'connection', (socket) ->
  socket.on 'join', (room) ->
    if rooms[room] is undefined then rooms[room] = { name: room, cards: [], people: [], results: [], scale: scale }
    room = rooms[room]

    socket.set 'room', room.name, () -> socket.join room.name
    room.people.push socket.id

    io.sockets.in(room.name).emit 'people', room

  socket.on 'disconnect', ->
    socket.get 'room', (e, room) ->
      room = rooms[room]

      room.people = room.people.filter (x) -> x != socket.id
      room.cards  = room.cards.filter (x) -> x != socket.id

      io.sockets.in(room.name).emit 'people', room

  socket.on 'ready', (card) ->
    socket.get 'room', (e, room) ->
      room = rooms[room]
      
      room.cards = room.cards.filter (x) -> x.id != socket.id

      if _.contains(room.scale, card)
        room.cards.push { 'id': socket.id, 'card': card }

      if room.cards.length is room.people.length
        all    = room.cards.map (x) -> x.card
        values = all.filter (x) -> x != '?'
        values = if values.length > 0 then values else [0]
        room.cards  = []
        room.results.unshift {
          'values': all,
          'avg': _.reduce(values, (x, y) -> parseFloat(x) + parseFloat(y)) / values.length,
          'min': _.min(values),
          'max': _.max(values)
        }

        io.sockets.in(room.name).emit 'ready', room

  socket.on 'cancel', ->
    socket.get 'room', (e, room) ->
      rooms[room].cards = rooms[room].cards.filter (x) -> x.id != socket.id
