app    = require('express')()
server = require('http').createServer(app)
io     = require('socket.io').listen(server)

server.listen(3000)

app.get '/', (request, response) ->
  response.sendfile __dirname + '/views/index.html'

people = []
ready  = []

io.sockets.on 'connection', (socket) ->
  people.push socket.id
  io.sockets.emit('people', people.length)

  socket.on 'disconnect', ->
    people = people.filter (x) -> x != socket.id
    ready = ready.filter (x) -> x != socket.id
    io.sockets.emit('people', people.length)

  socket.on 'ready', (isReady) ->
    if isReady then ready.push socket.id
    else ready = ready.filter (x) -> x != socket.id

    if ready.length == people.length
      io.sockets.emit 'ready'
      ready = []
