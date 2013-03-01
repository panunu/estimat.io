app = exports ? this

app.CardCtrl = ($scope) ->
  socket = io.connect 'http://app.estimat.tunk.io', { port: 3000 } # TODO: Configure?

  $scope.scale   = []
  $scope.people  = 0
  $scope.results = []

  # Connect / disconnect
  socket.on 'people', (count) ->
    $scope.people = [ 1..count ]
    refresh()

  # Initial scale
  socket.on 'scale', (scale) ->
    $scope.scale = scale
    refresh()

  # Round is over
  socket.on 'ready', (cards) ->
    $scope.results.unshift cards
    refresh()
    $('body').scrollTo('#results', 500, { offset: -100 })

  refresh = -> $scope.$apply() # TODO: There has to be a better way. $watch?

  # TODO: Angularify
  # Select a card
  $('#card-selection').on 'click', '.card', ->
    $(@).siblings('.selected').removeClass 'selected'
    $(@).toggleClass 'selected'
    $('#card .value').html $(@).data 'value'

    if $(@).hasClass 'selected'
      return socket.emit 'ready', $('.value', @).text()

    $('#card .value').html '<img src="img/fraktio-logo.svg" alt="Fraktio" />'
    socket.emit 'cancel'
