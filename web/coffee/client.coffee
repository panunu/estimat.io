$(document).ready ->

  cardTemplate = _.template $('#card-small-template').html()

  socket = io.connect('http://app.planning.tunk.io', { port: 3000 })

  socket.on 'people', (count) ->
    if $('#people .icon-user').size() == count then return
    $('#people .icon-user').remove()

    while count-- > 0
      $('#people').append('<i class="icon-user"></i> ').hide().fadeIn()

  socket.on 'scale', (scale) ->
    $('#card-selection').html scale.map (value) -> cardTemplate { value : value }

  $('#card').on 'click', ->
    $(@).toggleClass('ready').trigger 'cardReady'

  $('#card').on 'cardReady', ->
    if $(@).hasClass('ready')
      return socket.emit 'ready', $('.value', this).text()

    socket.emit 'cancel'

  $('#card-selection').on 'click', '.card-small', ->
    $('#card .value').html $(@).data 'value'
    $('#card').addClass('ready').trigger 'cardReady'

  socket.on 'ready', (cards) -> alert cards