Room = require '../room'

exports.RoomTest =

  setUp: (callback) ->
    @room = new Room 'lus', ['0', '1']
    callback()

  'has name and scale': (test) ->
    test.equal @room.name, 'lus'
    test.ok @room.scale
    test.done()