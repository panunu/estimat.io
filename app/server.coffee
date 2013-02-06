app    = require('express')()
server = require('http').createServer(app)
io     = require('socket.io').listen(server)

server.listen(3000)

app.get '/', (request, response) ->
  response.sendfile __dirname + '/views/index.html'

io.sockets.on 'connection', (socket) ->
  socket.emit('hello', 'lussenhoff')


