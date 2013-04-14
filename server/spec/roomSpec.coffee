Room = require '../room'

describe 'Room', ->
  room   = null
  socket = null

  beforeEach ->
    room   = new Room 'lus', ['0', '1']
    socket = { id: 'losofeis' }
    #console.log room

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
###
  it 'can have users removed, which also removes their card selection', ->
    room.addUser socket
    room.selectCard '0', socket

    room.removeUser socket

    expect(room.users[0]).toBeUndefined()
    expect(room.cards[0]).toBeUndefined()

  it 'can determine if a round is over', ->
    room.addUser socket
    expect(room.isReady()).toBeFalsy()

    room.selectCard '0', socket
    expect(room.isReady()).toBeTruthy()
###

