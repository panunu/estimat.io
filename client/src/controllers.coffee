'use strict'

window.CardCtrl = ($scope, $routeParams) ->
  socket = io.connect 'http://app.estimat.tunk.io', { port: 3000 } # TODO: Configure?

  logo = '<img src="img/fraktio-logo.svg" alt="Fraktio" />'

  $scope.room     = null
  $scope.selected = logo

  # Join room
  socket.on 'connect', () ->
    socket.emit 'join', $routeParams.id

  # When people connect / disconnect
  socket.on 'people', (room) ->
    refresh(room)

  # Round is over
  socket.on 'ready', (room) ->
    refresh(room)
    $('body').scrollTo('#results', 500, { offset: -100 })

  # Select a card
  $scope.select = (card) ->
    if $scope.selected is card
      $scope.selected = logo
      return socket.emit 'cancel'

    $scope.selected = card
    socket.emit 'ready', card

  refresh = (room) ->
    $scope.room = room
    $scope.$apply() # TODO: There has to be a better way. $watch?

