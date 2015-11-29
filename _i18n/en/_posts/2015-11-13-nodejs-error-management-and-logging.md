---
layout: post
title: "Node.js Error Management and Loglama"
description: ""
toc: true
category: ["node.js", "i-have-control"]
tags: ["node.js", "logging", "error", "bugs"]
series: "I Have Control"
series_no: 2
---
{% include JB/setup %}

{% include series.html %}
<br />

Hello, that's the new article to **I Have Control** series.

Before this one, I wrote about [Node.js Debugging](/en/node.js/2015/11/13/debugging-nodejs/) and now in this part, we're going to dive into the *essential* **logging**.

Logging is much more important within node.js, because logging is crucial for the one of node's main goals: *scaling*

<!--more-->

Let's think this way: Before we've got [Monolithic](https://en.wikipedia.org/wiki/Monolithic_application) architechtured applications and they are relatively easier to manage. Application runs on a single machine, even on some cases on same machine with the DB. So writing and reading logs was easy as just couple of files or DB tables.

But with the coming use of **microservices**, wide acceptance of multi-tier architechtures, scaling etc., logging became a thorny field.

**Clustering** on multiple machines, or even on same machine with **docker containers**, multiple DB's like **redis**, **mongodb**, **hadoop** and instances of them and many more new technologies forces us to leave our safe and warm monolithic environment to this caotic one and this leads us to create radical solutions.

Before going that far, we need to act in an order. First things first: healty log management on node.js.

There are different ways to achieve this on node, though there are mandotary steps to do like **levels** on log messages, like catching **unhandled exceptions** and managing them.

My first recommendation is [Winston](https://github.com/winstonjs/winston) and strange the name comes from [this](http://www.urbandictionary.com/define.php?term=Chill+Winston) :/. By the way winston does **async** logging.

# Winston

Setup:

~~~
npm install winston --save
npm install winston-redis --save
~~~

## Levels

Levels orders from most important to least: **`error: 0, warn: 1, info: 2, verbose: 3, debug: 4, silly: 5`**

Usage:

~~~js
// default logger
var winston = require('winston');

// these are the same
winston.log('info', 'Hello distributed log files!');
winston.info('Hello again distributed logs');
~~~

## Transports

The default logger's has a default transport type of  *winston.transports.Console*, automatically outputs to console.

~~~js
winston.remove(winston.transports.Console);
winston.info('This goes to nowhere!');

winston.add(winston.transports.File, { filename: 'mylogfile.log' });
winston.info('To the file!');

winston.add(winston.transports.Console);
winston.info('Both to file and console');
~~~

Winston have a lot of [official transports](https://github.com/winstonjs/winston/blob/master/docs/transports.md#winston-transports) like *HTTP, redis, mongo* etc. Also 3rd party [options](https://github.com/winstonjs/winston/blob/master/docs/transports.md#find-more-transports) are exist.

## Metadata

You can add various data to logs:

~~~js
winston.log('info', 'test mesajı', { bilgi: 'bu bir metadatadır' });
~~~

## Interpolation

Helps to write parametrized logs. Parameter types are: `%s string, %d number, %j json`

~~~js
var util = require('util');

winston.log('info', 'test message %s %d %j', 'first', 5, {number: 123}, {meta: "this is meta" }, function callback(transport, level, msg, meta){
	console.log("logged");
	console.log(util.format("transport -> %s, level -> %s, message -> %s, meta -> %j", transport, level, msg, meta));
});
~~~

## Exceptions

~~~js
winston.handleExceptions();

// you can write unhandled exceptions to a special file if you want
winston.handleExceptions(new winston.transports.File({ filename: 'path/to/exceptions.log' }))

// or you can specify handleExceptions option while adding a transport
// humanReadableUnhandledException means it outputs readable stack trace
winston.add(winston.transports.File, {
  filename: 'path/to/all-logs.log',
  handleExceptions: true,
  level: 'warn',
  humanReadableUnhandledException: true
});

// prevent exiting from application after exception occurred:
winston.exitOnError = false;
~~~

On above code, transport level specified as `warn`. This means `warn` and **above it** (important level) will ve logs which are `warn`, `debug` and `error`. Less important levels will not be logged: `silly` and `verbose`.

# Demo

I'm determined to continue wiht our beloved repository **chatcat** :). Spoiler lovers can get codes of this chapter with:

~~~
git clone https://github.com/dhalsim/chatcat.git
cd chatchat
git checkout alti
~~~

or you can go with the tutorial by `git checkout bes` and do the necessary changes yourself.

> Note: I'm gonna use new advanced options and topics: colorize, zipping for File, tailing ve logging to Redis DB

**src/lib/logging.js:**

~~~js
var winston = require('winston');
var moment = require('moment');
var redis_config = require('src/config').redis;
var extend = require('src/lib/utils').extend;
require('winston-redis').Redis;

var redisClient = require('src/lib/redisAdapters/redisConnection').getClient();
var os = require('os');

var errorMeta = {
  hostname: os.hostname(),
  pid: process.pid,
  memory: process.memoryUsage(),
  uptime: process.uptime(),
  env: process.env.NODE_ENV || 'development'
};

var redisTransport = new (winston.transports.Redis)({
  redis: redisClient
});

var errorFileTransport = new (winston.transports.File)({
  filename: './logs/errors.log',
  level: 'error',
  colorize: true,
  timestamp: function() {
    return moment.utc().format();
  },
  maxsize: 10000, // 10 KB
  maxFiles: 5,
  //formatter: function () {},
  tailable: true,
  zippedArchive: true
});

// error: 0, warn: 1, info: 2, verbose: 3, debug: 4, silly: 5

var logger = new (winston.Logger)({
  transports: [
    new (winston.transports.Console)({
      level: 'debug',
      colorize: true,
      timestamp: function() {
        return moment.utc().format();
      },
      json: true,
      prettyPrint: true,
      humanReadableUnhandledException: true,
    }),
    errorFileTransport,
    redisTransport
  ]
});

// I override logger function
// in case of error I'll inject errorMeta to meta
logger.log = function(){
  var args = arguments;
  var level = args[0];

  if(level === 'error') {
    var originalMeta = args[2] || {};
    args[2] = extend(originalMeta, errorMeta);
  }

  winston.Logger.prototype.log.apply(this,args);
};

// logger hatası
logger.on('error', function (err) {
  console.error('Error occurred', err);
});

module.exports.log = logger;
module.exports.loggerMiddleware = function (req, res, next) {
  req.logger = logger;
  next();
};
module.exports.exceptionMiddleware = function (err, req, res, next) {
  logger.error(err.message, { stack: err.stack });
  next(err);
};
module.exports.logAndCrash = function (err) {
  logger.error(err.message, { stack: err.stack });
  throw err;
}
~~~

There are 3 exported functions here. `logger` is for general purpose in case of I need. I'll use `loggerMiddleware` in express and use it to add logger to *req* object. `exceptionMiddleware` is for exception management. This middleware will work when `next(error)` called.

`logAndCrash` function is a special one for using from **process.uncaughtException**. As you noticed, I **re-throw** the exception caught and this leads node process to exit. I'll be back on this later.

In case of an error, by *overriding* `log` function of logger, I add `errorMeta` as a useful meta.

Console transport for general purpose and File and Redis transports for error cases used. You can see a *list* called `winston` after log occurs on redis.

Now we will change a function in redisAdapter. If it couldn't find the wanted room, we will throw an **Error** object.

> Note: Use **promises** to get *asynchronous* errors easily.

**redisAdapter.js:**

~~~js
...
module.exports.getRoomById = function (roomId) {
  var key = ROOMS + ':' + roomId;
  return hgetall(key).then(function (room) {
    if(!room) {
      throw new Error('Room id not found:' + roomId);
    }

    return unflatten(room);
  });
};
...
~~~

<br />

Here we catch exceptions with **catch** (clearly!) and send it to exception handler middleware with `next(..)`.

**routes/index.js:**

~~~js
...
router.get('/room/:id', securePage, function (req, res, next) {
  var roomId = req.params.id;
  roomAdapter.getRoomById(roomId).then(function (room) {
    req.session.room = room;

    res.render('room', {
      user: JSON.stringify(req.user),
      room: JSON.stringify(room),
      socket_host: config.socket_host
    });
  }).catch(function (err) {
    next(err);
  }).done();
});
...
~~~

> **From express documentation:** "If the current middleware does not end the request-response cycle, it must call next() to pass control to the next middleware, otherwise the request will be left hanging."

**app.js:**

~~~js
...
var logger = require('src/lib/logging');
...
app.use(logger.loggerMiddleware);
app.use(logger.exceptionMiddleware);
process.on('uncaughtException', logger.logAndCrash);
...
~~~

> Let's look at **logAndCrash** now. We talked about node.js *single threaded* logic before. And with its async structure, it differs from languages/platforms like *ASP.NET* or *Java* as we can redirect a user to an error page in case of an error (like used with Application_Error on ASP.NET). We need to exit from node when we have an unhandled exception.

> The best option to take is unfortunately let the program crash. On web applications like *ASP.NET*, every request works on a seperate thread thus lets rest of the process go on without restarting. But it's not the case with node.js

> For this and other reasons (unhandled errors may broke reliability of the app), we let process to exit. To restart the application afterwards we can use solutions like [Forever](https://www.npmjs.com/package/forever) and [PM2](http://pm2.keymetrics.io/).

> Sources:
>
  * <https://www.joyent.com/developers/node/design/errors>
  * <http://stackoverflow.com/a/15874115>
  * <https://nodejs.org/api/process.html#process_event_uncaughtexception>

# Result

We proceed pretty much on error management and logging. Next article will be about logging in scaled systems. I'll write about how we log and gather these scaled node.js applications.

{% include series.html %}
<br />
