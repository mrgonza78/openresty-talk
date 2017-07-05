# OpenResty

OpenResty is a full-fledged platform that integrates Nginx and Lua.

It aims to run your server-side web apps completely in the Nginx server.

In this workshop we're going to build an small sample app to show Lua's full power and flexibility in Nginx

## Prerequisites

Install Docker, then ...

```
$ docker pull postgres
$ docker run --name postgres -d postgres
$ docker build . -t openresty
$ docker run --rm -i -t -v $(pwd):/code -p 3000:3000 -p 3001:3001 --link postgres openresty
```

to verify if it is working
```
$ curl localhost:3000
Hello from Lua http
```

and
```
$ telnet localhost 3001
Trying ::1...
Connected to localhost.
Escape character is '^]'.
Hello from Lua stream
Connection closed by foreign host.
```
