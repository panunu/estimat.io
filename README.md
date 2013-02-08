# Installation

```npm install```

Check out ```nginx``` for proxy configuration.

## The following makes your life easier

```npm install coffee supervisor -g```

Run these on project root.

```coffee -w -c app/server.coffee```

```coffee -w -c -o web/js web/coffee/client.coffee```

```supervisor app/server.js```