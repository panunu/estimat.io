app = require('express').createServer()
io  = require('socket.io').listen(app)

app.listen(80)

app.get('/', (request, response) ->
  response.sendfile(__dirname + '/index.html')

  ###
io.sockets.on('connection', function (socket) {
socket.emit('news', { hello: 'world' });
  socket.on('my other event', function (data) {
  console.log(data);
});
});###