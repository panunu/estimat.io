_  = require('underscore')

module.exports = class Room
  cards: []
  users: []
  results: []

  constructor: (@name, @scale) ->

  addUser: (socket) ->
    @users.push socket.id

  removeUser: (socketId) ->


  selectCard: (card, socket) ->
    @cards = @cards.filter (x) -> x.id != socket.id

    if _.contains(@scale, card)
      @cards.push { 'id': socket.id, 'card': card }

