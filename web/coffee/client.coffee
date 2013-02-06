$(document).ready ->
  socket = io.connect('http://app.planning.tunk.io', { port: 3000 })

  socket.on 'participants', (count) ->
    if $('#participants .icon-user').size() == count then return

    $('#participants .icon-user').remove();

    while count-- > 0
      $('#participants').append('<i class="icon-user"></i> ').hide().fadeIn()

  $('#card').on 'click', ->
    $(this).toggleClass('ready')
    socket.emit 'ready', $(this).hasClass('ready')

  socket.on 'ready', -> alert 'READY'