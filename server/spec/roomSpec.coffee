Room = require '../room'

describe 'Room', ->

  beforeEach ->
    @room   = new Room 'lus', ['0', '1']
    @socket = { id: 'losofeis' }

  it 'has a name and card scale', ->
    expect(@room.name).toBe 'lus'

    expect(@room.scale).toContain '0'
    expect(@room.scale).toContain '1'

  it 'can have added users', ->
    @room.addUser @socket

    expect(@room.users).toContain @socket.id

  it 'can have cards selected by users', ->
    @room.selectCard '0', @socket

    expect(@room.cards[0].id).toBe @socket.id
    expect(@room.cards[0].card).toBe '0'
