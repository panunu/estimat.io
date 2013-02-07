$(document).ready ->
  socket = io.connect('http://app.planning.tunk.io', { port: 3000 })

  socket.on 'people', (count) ->
    if $('#people .icon-user').size() == count then return
    $('#people .icon-user').remove()

    while count-- > 0
      $('#people').append('<i class="icon-user"></i> ').hide().fadeIn()

  $('#card').on 'click', ->
    if $(this).toggleClass('ready').hasClass('ready')
      return socket.emit 'ready', $('.value', this).text()

    socket.emit 'cancel'

  socket.on 'ready', (cards) -> alert cards