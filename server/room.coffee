_  = require('underscore')

class Room
  cards: []
  users: []
  results: []

  constructor: (@name, @scale) ->

  addUser: (socket) ->
    @users.push socket.id

  removeUser: (socket) ->
    @cards = @cards.filter (x) -> x.id != socket.id
    @users = @users.filter (x) -> x != socket.id

  selectCard: (card, socket) ->
    @cards = @cards.filter (x) -> x.id != socket.id

    if _.contains(@scale, card)
      @cards.push { 'id': socket.id, 'card': card }

module.exports = Room