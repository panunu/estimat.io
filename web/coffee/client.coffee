#$(document).ready ->
app = exports ? this

app.CardCtrl = ($scope) ->
  socket = io.connect 'http://app.estimat.tunk.io', { port: 3000 }

  $scope.scale  = []
  $scope.people = 0

  # Connect / disconnect
  socket.on 'people', (count) ->
    $scope.people = [ 1..count ]
    refresh()

  # Initial scale
  socket.on 'scale', (scale) ->
    $scope.scale = scale
    refresh()

  refresh = () -> $scope.$digest()

  # Round is over
  socket.on 'ready', (cards) ->
    $results = $('.results').last().clone()

    for value in ['avg', 'min', 'max']
      $('.' + value, $results).text(cards[value])

    for card in cards.values
      $('.cards', $results).append('<div class="card">' + card + '</div>')

    $('#results').prepend($results.fadeIn())
    $('body').scrollTo('#results', 500, { offset: -100 })

  # Select a card
  $('#card-selection').on 'click', '.card', ->
    $(@).siblings('.selected').removeClass 'selected'
    $(@).toggleClass 'selected'
    $('#card .value').html $(@).data 'value'

    if $(@).hasClass 'selected'
      return socket.emit 'ready', $('.value', @).text()

    $('#card .value').html '<img src="img/fraktio-logo.svg" alt="Fraktio" />'
    socket.emit 'cancel'###
