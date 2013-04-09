Room = require '../room'

exports.RoomTest =

  'has name and scale': (test) ->
    room = new Room 'lus', ['0', '1']

    test.equal room.name, 'lus'
    test.equal room.scale[0], '0'
    test.done()

  'users can be added': (test) ->
    room = new Room 'lus', ['0', '1']
    room.addUser { id: 'losofeie'}

    test.equal room.users[0], 'losofeie'
    test.done()

  'user can select a card': (test) ->
    room   = new Room 'lus', ['0', '1']
    socket = { id: 'loso' }

    room.addUser socket

    room.selectCard '0', socket

    test.equal room.cards[0].id, 'loso'
    test.equal room.cards[0].card, '0'
    test.done()

  'users can be removed, which also removes their current card selection': (test) ->
    room   = new Room 'lus', ['0', '1']
    socket = { id: 'losonaama' }

    room.addUser socket

    test.equal room.users[1], 'losonaama'
    test.done()