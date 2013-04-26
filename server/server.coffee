io   = require('socket.io').listen(3000)
_    = require('underscore')
Room = require('./room')

rooms = [] # Could we utilize e.g. Redis here?
scale = ['0', '0.5', '1', '2', '3', '5', '8', '13', '20', '40', '100', '?']

# Refuktore.

io.sockets.on 'connection', (socket) ->
  socket.on 'join', (roomName) ->
    if rooms[roomName] is undefined then rooms[roomName] = new Room roomName, scale
    room = rooms[roomName]
    room.addUser socket
    socket.set 'room', room.name, () -> socket.join room.name
    io.sockets.in(room.name).emit 'people', room

  socket.on 'disconnect', ->
    socket.get 'room', (e, room) ->
      room = rooms[room]
      room.removeUser socket
      io.sockets.in(room.name).emit 'people', room

  socket.on 'ready', (card) ->
    socket.get 'room', (e, room) ->
      room = rooms[room]
      room.selectCard card, socket

      if room.isRoundFinished()
        room.calculateResults()
        io.sockets.in(room.name).emit 'ready', room

  socket.on 'cancel', ->
    socket.get 'room', (e, room) ->
      room = rooms[room]
      room.unselectCard socket

