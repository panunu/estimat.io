_  = require 'underscore'

class Room

  constructor: (@name, @scale) ->
    @cards   = []
    @users   = []
    @results = []

  addUser: (socket) =>
    @users.push socket.id

  removeUser: (socket) =>
    @cards = @cards.filter (x) -> x.id != socket.id
    @users = @users.filter (x) -> x != socket.id

  selectCard: (card, socket) =>
    @cards = @cards.filter (x) -> x.id != socket.id

    if _.contains(@scale, card)
      @cards.push { 'id': socket.id, 'card': card }

  isRoundFinished: =>
    @cards.length == @users.length

  calculateResults: =>
    all    = @cards.map (x) -> x.card
    values = all.filter (x) -> x != '?'
    values = if values.length > 0 then values else [0]

    @cards = []
    @results.unshift {
       'values': all,
       'avg': _.reduce(values, (x, y) -> parseFloat(x) + parseFloat(y)) / values.length,
       'min': _.min(values),
       'max': _.max(values)
    }

module.exports = Room