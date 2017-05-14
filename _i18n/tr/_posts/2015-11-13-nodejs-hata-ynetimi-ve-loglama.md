---
layout: post
title: "Node.js Hata Yönetimi ve Loglama"
description: "Bu makalede node.js uygulamalarının Winston kütüphanesi ile nasıl kolay ve doğru bir şekilde loglama yapılacağını ve Express üzerinden hata yönetiminin nasıl yapılabileceğini okuyabilirsiniz."
toc: true
category: ["node.js", "kontrol-bende"]
tags: ["javascript", "node.js", "log", "error", "hata"]
series: "Kontrol Bende"
series_category: "kontrol-bende"
series_no: 2
image: "/assets/images/nodejs.png"
---
{% include JB/setup %}

{% include series.html %}
<br />

Merhaba, **"Kontrol Bende"** serisine yeni bir konu daha ekliyoruz.

Bundan önce [Node.js Debugging](/node.js/2015/11/13/debugging-nodejs/) konusunu işlemiştik. Şimdi ise hem debugging'te hem de production'da olmazsa olmaz **loglama** konusuna dalıyoruz.

Loglama konusu node.js ile birlikte daha da önemli bir hale geliyor. Bunun nedeni node.js'in kullanım amaçlarından biri olan *scaling*'te ne kadar yaşamsal olduğunu bilmemiz.

<!--more-->

Şöyle düşünelim. Daha önceden [Monolithic](https://en.wikipedia.org/wiki/Monolithic_application) mimarideki uygulamalarımızı yönetmek görece kolaydı. Tek bir makinede Uygulama ve DB çalışıyordu ve bakmamız gereken DB üzerindeki bir tablo veya birkaç log dosyasından ibaretti.

Ama **microservice**'lerin kullanımı, multi-tier uygulamaların kabul görmesi ve **scaling** ile beraber loglama ve analizi çetrefilli bir hal aldı.

Uygulamanın çoklu makinede (sanal da olabilir) **Docker container**'lar üzerinde **clustered** bir yapıda çalışması, **redis**, **mongodb** **hadoop** ve daha nice teknolojinin farklı makinelerde ve hatta yerlerde kurulu olması (cloud computing) bizi logging ve hata yönetiminde radikal çözümler üretmemizi gerektiriyor.

Ancak bu kadar ileri gitmeden önce işleri sırayla yapmalıyız. İlk önceliğimiz node.js uygulamamızdaki logların sağlıklı bir şekilde yazılmasıdır.

Node.js'te bunu başarabilmenin çeşitli yolları mevcut. Ancak uygulama tarafında yapılması zorunlu kısımlar da var. Mesela loglamanın **level**'lar bazında yapılması. **Unhandeled Exception**'ların (yakalanmamış istisnalar/hatalar) yönetimi gibi.

Dediğim gibi node.js'te bunun çok farklı yöntemleri mevcut. Benim ilk önereceğim [Winston](https://github.com/winstonjs/winston) olacak. İsmi de [şuradan](http://www.urbandictionary.com/define.php?term=Chill+Winston) geliyormuş :/. Bu arada kendisi **async** loglama yapıyor.

# Winston

Kurulum:

~~~
npm install winston --save
npm install winston-redis --save
~~~

## Seviyeler

Önemliden önemsize varsayılan seviyeler (levels): **`error: 0, warn: 1, info: 2, verbose: 3, debug: 4, silly: 5`**

Kullanımı:

~~~js
// varsayılan logger
var winston = require('winston');

// bu ikisi de aynı
winston.log('info', 'Hello distributed log files!');
winston.info('Hello again distributed logs');
~~~

## Transports

Varsayılan logger'ın winston.transports.Console tipinde varsayılan bir transportu vardır. Yani otomatik olarak çıktıyı Console'a verecektir.

~~~js
winston.remove(winston.transports.Console);
winston.info('Bu hiçbir yere yazılmıyor!');

winston.add(winston.transports.File, { filename: 'logdosyam.log' });
winston.info('Dosyaya yazacak!');

winston.add(winston.transports.Console);
winston.info('Hem dosyaya hem console'a yazacak');
~~~

Winston [official transport'ları](https://github.com/winstonjs/winston/blob/master/docs/transports.md#winston-transports) çokçadır. *HTTP, redis, mongo* vb. buradan bulabilirsiniz. Bunun dışında 3rd party **zibilyon** tane [seçenek](https://github.com/winstonjs/winston/blob/master/docs/transports.md#find-more-transports) de mevcuttur.

## Metadata

Farklı bilgileri de log'a ekleyebiliyoruz:

~~~js
winston.log('info', 'test mesajı', { bilgi: 'bu bir metadatadır' });
~~~

## Ekleme (interpolation)

Parametreli mesaj yazdırma konusunda yardımcı olur. Parametre tipleri: `%s string, 	%d number, %j json`

~~~js
var util = require('util');

winston.log('info', 'test mesajı %s %d %j', 'ilk', 5, {number: 123}, {meta: "bu meta" }, function callback(transport, level, msg, meta){
	console.log("loglama gerçekleşti");
	console.log(util.format("transport -> %s, level -> %s, mesaj -> %s, meta -> %j", transport, level, msg, meta));
});
~~~

## Exceptions

~~~js
winston.handleExceptions();

// unhandled exception'ların özel bir dosyaya yazdırılmasını isteyebilirsiniz
winston.handleExceptions(new winston.transports.File({ filename: 'path/to/exceptions.log' }))

// ya da transport eklerken handleExceptions ile belirtilebiliyor
// humanReadableUnhandledException ise okunaklı stack trace demek
winston.add(winston.transports.File, {
  filename: 'path/to/all-logs.log',
  handleExceptions: true,
  level: 'warn',
  humanReadableUnhandledException: true
});

// exception logladıktan sonra uygulamadan çıkmasın:
winston.exitOnError = false;
~~~

Üstteki kodda transport level'ı `warn` olarak ayarlanmış. Bu demektir ki `warn` **ve üzeri** önemdeki log'lar verilen transport'a uygulanacak. Bunlar `warn`, `debug` ve `error`'dür. Alt level'lar loglanmayacak: `silly` ve `verbose`.

# Demo

Konumuzu emektar repository'miz **chatcat** üzerinden götürmeye kararlıyım :) Spoiler sevenler:

~~~
git clone https://github.com/dhalsim/chatcat.git
cd chatchat
git checkout alti
~~~

Şeklinde tüm kodları alabilir, veya `git checkout bes` üzerinden değişiklikleri kendiniz de ekleyebilirsiniz.

> Not: Burada önceden belirtmediğim ileri seviye konuları kullanacağım. Bunlar: renklendirme, File için zipleme, tailing ve Redis loglama olacak

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

// log fonksiyonunu override ediyorum
// error durumunda meta'ya errorMeta'yı inject edeceğim
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

3 tane export ettiğim fonksiyonum var. `logger` genel amaçlı kullanmak için nolur nolmaz koydum. `loggerMiddleware`, express'te kullanacağım ve *req* objesine logger property'si inject etmemi sağlayacak. `exceptionMiddleware`'ı ise hataların yönetilmesi için kullanacağım. `next(error)` kullanımı bu middleware'e yönlendirecektir.

`logAndCrash` fonksiyonu ise özel bir fonksiyon ve **process uncaughtException** tarafından kullanmak için yazdım. Burada farkettiyseniz hatayı logladıktan sonra tekrar **throw** ediyoruz. Bu node process'inin kapanmasına neden olacaktır. Bu konuya daha ayrıntılı ileride değineceğim.

logger'ın `log` fonksiyonunu *override* (üzerine yazma, ezme) ederek yararlı olacağını düşündüğüm `errorMeta`'yı error durumunda meta olarak ekliyorum.

Kullandığım transportlar, genel durumlar için Console, hata durumumları için File ve Redis. Loglama olduktan sonra redis'e girip bakarsanız `winston` adında bir *list* bulacaksınız.

Şimdi redisAdapter'da bir fonksiyonu değiştireceğiz. Redis'ten ilgili room'u bulamadığında bir **Error** throw ediyoruz:

> Not: **Promise** kullanarak *asenkron* hataların yakalanmasını kolaylaştırabiliriz.

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

Burada da *promise*'deki hatayı **catch** ile yakalayıp `next(..)` ile exception handler'a gönderiyoruz.

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

> **Express dökümantasyonundan:** "If the current middleware does not end the request-response cycle, it must call next() to pass control to the next middleware, otherwise the request will be left hanging."
>
> Express'te ya request sonlanmalı ya da sonraki middleware için next() çağrılmalıdır. Böylece request-response döngüsü bitirilir.

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

> Şimdi gelelim **logAndCrash**'e. Node.js'in tek *thread* üzerinde çalışan bir uygulama olduğuna daha önceden değinmiştik. Asenkron yapısı nedeniyle de klasik *ASP.NET*, *Java* gibi web uygulamalarındaki gibi kullanıcıyı unhandled hata durumunda bir sayfaya yönlendirip hata oluştu diyemiyoruz (mesela Application_Error ile yapılabiliyor).

> Burada yapılabilecek en doğru seçenek, ne yazıkki programı patlamasına izin vermektir. *ASP.NET* gibi web uygulamalarında her request farklı bir thread'de çalıştığından uygulamanın kalanı process durmadan devam edebilir ama node.js için aynı şeyi söyleyemeyiz.

> Bu ve bunun gibi nedenlerden (unhandled hataların programın çalışmasını bozabilmesi, yanlış sonuçlar gibi) dolayı process'in çıkmasına izin veriyoruz. Uygulamanın tekrar çalışması için [Forever](https://www.npmjs.com/package/forever), [PM2](http://pm2.keymetrics.io/) gibi çözümleri kullanabilirsiniz.

> Kaynaklar:
>
  * <https://www.joyent.com/developers/node/design/errors>
  * <http://stackoverflow.com/a/15874115>
  * <https://nodejs.org/api/process.html#process_event_uncaughtexception>

# Sonuç

Hata yönetimi ve loglamayla ilgili epey mesafe katettik. Sonraki yazım ölçeklenebilir loglama üzerine olacak. Node.js scaled yapıdaki sistemlerde nasıl loglarız, bu logları nasıl toplarız ve değerlendiririz konusunda yazacağım.

<br />
{% include series.html %}
<br />
