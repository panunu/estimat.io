$(document).ready ->

  socket = io.connect 'http://app.planning.tunk.io', { port: 3000 }

  # Connect / disconnect
  socket.on 'people', (count) ->
    if $('#people .icon-user').size() == count then return
    $('#people .icon-user').remove()

    while count-- > 0
      $('#people').append('<i class="icon-user"></i> ').hide().fadeIn()

  # Initial scale
  socket.on 'scale', (scale) ->
    card = _.template $('#card-small-template').html()
    $('#card-selection').html scale.map (value) -> card { value : value }

  # Round is over
  socket.on 'ready', (cards) ->
    $results = $('.results').last().clone()

    for value in ['avg', 'min', 'max']
      $('.' + value, $results).text(cards[value])

    for card in [cards.values]
      $('.cards', $results).append(card)

    $('#results').prepend($results.fadeIn())

  # Select a card
  $('#card-selection').on 'click', '.card', ->
    $(@).siblings('.selected').removeClass 'selected'
    $(@).toggleClass 'selected'
    $('#card .value').html $(@).data 'value'

    if $(@).hasClass 'selected'
      return socket.emit 'ready', $('.value', @).text()
    $('#card .value').html '<img src="img/fraktio-logo.svg" alt="Fraktio" />'
    socket.emit 'cancel'
