# Installation

```npm install socket.io express```

Check out ```nginx``` for proxy configuration.

## The following makes your life easier

```npm install coffee supervisor -g```

```coffee -w -c app/server.coffee```
```coffee -w -c -o web/js web/coffee/client.coffee```
```supervisor app/server.js```