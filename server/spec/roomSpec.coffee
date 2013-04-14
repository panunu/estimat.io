Room = require '../room'

describe 'Room', ->

  it 'has a name and card scale', ->
    room = new Room 'lus', ['0', '1']

    expect(room.name).toBe 'lus'

    expect(room.scale).toContain('0')
    expect(room.scale).toContain('1')
