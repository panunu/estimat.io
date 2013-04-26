_    = require 'underscore'
Room = require '../room'

describe 'Room', ->
  room   = null
  socket = null

  beforeEach ->
    room   = new Room 'lus', ['0', '1']
    socket = { id: 'losofeis' }

  it 'has a name and card scale', ->
    expect(room.name).toBe 'lus'
    expect(room.scale).toContain '0'
    expect(room.scale).toContain '1'

  it 'can have added users', ->
    room.addUser socket

    expect(room.users).toContain socket.id

  it 'can have cards selected by users', ->
    room.addUser socket
    room.selectCard '0', socket

    expect(room.cards[0].id).toBe socket.id
    expect(room.cards[0].card).toBe '0'

  it 'can have users removed, which also removes their card selection', ->
    room.addUser socket
    room.selectCard '0', socket

    room.removeUser socket

    expect(room.users[0]).toBeUndefined()
    expect(room.cards[0]).toBeUndefined()

  it 'can determine if a round is over', ->
    room.addUser socket
    expect(room.isRoundFinished()).toBeFalsy()

    room.selectCard '0', socket
    expect(room.isRoundFinished()).toBeTruthy()

  it 'calculates results', ->
    room.addUser socket
    room.addUser { id: 'lousou' }

    room.selectCard '0', socket
    room.selectCard '1', { id: 'lousou' }

    room.calculateResults()

    results = room.results.pop()
    expect(results.avg).toBe 0.5
    expect(results.min).toBe '0'
    expect(results.max).toBe '1'
    expect(results.values).toContain('0')
    expect(results.values).toContain('1')





