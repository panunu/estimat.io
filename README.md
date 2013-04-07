# Installation

```npm install```

Check out ```nginx``` for proxy configuration.

## The following makes your life easier

```npm install coffee supervisor -g```

# Development

## Server-side files

Run these on project root.

```coffee -w -c app/server.coffee```

```supervisor app/server.js```

## Client-side files

Just ```grunt```.

# Other

Requires socket.io `0.9` (documentation https://github.com/learnboost/socket.io/tree/0.9.14).