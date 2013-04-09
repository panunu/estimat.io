class Room
  cards: []
  users: []
  results: []

  constructor: (@name, @scale) ->

  addUser: (socketId) ->
    @users.push socketId

module.exports = Room