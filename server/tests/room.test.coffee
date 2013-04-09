Room = require '../room'

exports.RoomTest =

  'has name and scale': (test) ->
    room = new Room 'lus', ['0', '1']

    test.equal room.name, 'lus'
    test.equal room.scale[0], '0'
    test.done()

  'users can be added': (test) ->
    room = new Room 'lus', ['0', '1']
    room.addUser 'losofeie'

    test.equal room.users[0], 'losofeie'
    test.done()