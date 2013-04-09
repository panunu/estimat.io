Room = require '../room'

exports.RoomTest =

  setUp: (callback) ->
    @room = new Room 'lus', ['0', '1']
    callback()

  'has name and scale': (test) ->
    test.equal @room.name, 'lus'
    test.equal @room.scale[0], '0'
    test.equal @room.scale[1], '1'
    test.done()

  'users can be added': (test) ->
    @room.addUser 'socketId'

    test.equal @room.users[0], 'socketId'
    test.done()