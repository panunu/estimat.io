app = exports ? this

app.CardCtrl = ($scope) ->
  socket = io.connect 'http://app.estimat.tunk.io', { port: 3000 } # TODO: Configure?

  logo = '<img src="img/fraktio-logo.svg" alt="Fraktio" />'

  $scope.scale    = []
  $scope.people   = 0
  $scope.results  = []
  $scope.selected = logo

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

  # Select a card
  $scope.select = (card) ->
    if $scope.selected is card
      $scope.selected = logo
      return socket.emit 'cancel'

    $scope.selected = card
    socket.emit 'ready', card

  refresh = -> $scope.$apply() # TODO: There has to be a better way. $watch?

