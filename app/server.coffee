app    = require('express')()
server = require('http').createServer(app)
io     = require('socket.io').listen(server)

server.listen(3000)

app.get '/', (request, response) ->
  response.sendfile __dirname + '/views/index.html'

participants = 0
ready = 0

io.sockets.on 'connection', (socket) ->
  io.sockets.emit('participants', ++participants)

  socket.on 'disconnect', (socket) ->
    io.sockets.emit('participants', --participants)

  socket.on 'ready', (ok) ->
    if (++ready == participants)
      io.sockets.emit('ready', true)
      ready = 0
