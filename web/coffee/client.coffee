socket = io.connect('http://app.planning.tunk.io', { port: 3000 })

socket.on 'participants', (count) ->
  if $('#participants .icon-user').size() == count then return
  $('#participants .icon-user').remove();

  while count-- > 0
    $('#participants').append('<i class="icon-user"></i> ').hide().fadeIn()

$('#card').on 'click', (e) ->
  socket.emit 'ready', true

socket.on 'ready', (ready) ->
  if ready then alert 'READY'