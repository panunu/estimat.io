# Installation

```npm install socket.io express```

Check out ```nginx``` for proxy configuration.

## Makes your life easier

```npm install coffee supervisor -g```

```coffee -w -c app/server.coffee```
```coffee -w -c web/coffee/client.coffee```
```supervisor app/server.js```