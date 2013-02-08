$(document).ready ->

  cardTemplate = _.template $('#card-small-template').html()

  socket = io.connect('http://app.planning.tunk.io', { port: 3000 })

  socket.on 'people', (count) ->
    if $('#people .icon-user').size() == count then return
    $('#people .icon-user').remove()

    while count-- > 0
      $('#people').append('<i class="icon-user"></i> ').hide().fadeIn()

  socket.on 'scale', (scale) -> $('#card-selection').html cardTemplate { scale: scale }

  $('#card').on 'click', ->
    $(@).toggleClass('ready').trigger 'cardReady'

  $('#card').on 'cardReady', ->
    if $(@).hasClass('ready')
      return socket.emit 'ready', $('.value', this).text()

    socket.emit 'cancel'

  $('#card-selection').on 'click', '.card-small', ->
    $(@).siblings('.selected').removeClass 'selected'

    $('#card .value').html $(@).data 'value'
    $(@).toggleClass 'selected'

    if $(@).hasClass('selected')
      $('#card').addClass 'ready'
    else
      $('#card').removeClass 'ready'

    $('#card').trigger 'cardReady'

  socket.on 'ready', (cards) ->
    $results = $('.results').last().clone()

    for value in ['avg', 'min', 'max']
      $('.' + value, $results).text(cards[value])

    for card in [cards.values]
      $('.cards', $results).append(card)

    $('#results').prepend($results.fadeIn())
