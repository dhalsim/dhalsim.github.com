---
layout: post
title: "Çok Odalı Node.js Chat Uygulaması"
description: ""
toc: true;
category: ["node.js"]
tags: ["node.js", "socket.io", "express", "redis", "mongodb", "xp"]
---
{% include JB/setup %}

**Kullanılacak teknolojiler:**

* Node.js
* Express framework
* Grunt build manager
* Redis
* Mongo, mongoose
* Q, Bluebird promise library'leri
* Passport.js
* socket.io

# Başlarken

Node.js Linux / Mac OSX / Windows gibi daha bir çok platformda çalışabilen bir  yazılımdır. Eğer Linux / OS X terminaline aşina biriyseniz Node.js kullanmak gerçekten çok kolay ve keyifli oluyor. Ancak ülkemizde ağırlıklı olarak Windows üzerinde yazılım geliştirildiğini bildiğimden sadece bu kısımda olmak üzere Windows üzerinde nasıl gerekli yazılımları kurup çalıştırırsınız ona gireceğim.

Eğer Linux'tan korkmayan ve farklı bir dünyaya dalmak isteyen cesur bir yazılımcıysanız, sanal olarak bir Ubuntu Linux kurup işinizi kolaylaştırabilirsiniz.

**Öncelikle gereksinimlerimiz:**

* Node.js
* NPM (node paket yöneticisi)
* Git (SVN, TFS gibi ama daha iyisi)
* Text Editor / IDE

**Node** node.js uygulamalarını çalıştıracağımız program. `node dosya.js` şeklinde çalıştırabileceğimiz gibi, diğer kuracağımız programcıklar üzerinden de çalıştırılabiliyor. **npm** node kurulumu ile birlikte geliyor ve node paketlerini kurmamızı sağlayacak.

**Peki neden node.js?**

* Çünkü Javascript!
* Google'ın chrome'da da kullandığı V8 Javascript motoru üzerinde çalışır
* Event-driven (olay güdümlü), non-blocking (engellenmeyen) I/O (giriş çıkış) modelini kullanarak verimli ve hızlı çalışır: **concurrency**
* Web uygulamaları geliştirmek için uygundur
* **Scale** edilmesi (ölçeklenmesi) kolaydır
* Müthiş kütüphane ve topluluk desteği,
* Modüler, genişletilebilir yapıda olması: **extensibility**

İngilizce şu video'dan izlemenizi tavsiye ederim: [What is Node.js?](https://www.youtube.com/watch?v=e8ZLfcHxrD8&spfreload=10). Başka kaynaklardan da araştırabilirsiniz.

**NPM**, Node package manager, <https://www.npmjs.com/> üzerinde de yayımlanan paketleri indirmenize yarar. `package.json` dosyası üzerinden projenizin paketlerinin takibini yapar.

**Git**'i benim projemi indirmek için kullanacağız. Ayrıca `git branch` ile projenin farklı bölümlerinin kodlarına geçiş yapabilirsiniz.

* Git'le ilgili çok iyi bir türkçe kaynak ([Türkçe Git 101](https://aliozgur.gitbooks.io/git101/content)) var. Bilmiyorsanız okuyup öğrenin, göz atın.
* Resmi hakkında sayfası da birçok yararlı bilgi veriyor <https://git-scm.com/about>
* [Git'in 10 senesi](https://www.atlassian.com/git/articles/10-years-of-git): Git'in tarihçesini çok güzel bir şekilde anlatmışlar efendim.

**Atom** benim son dönemde kullanmaktan keyif aldığım, **github**'ın bir ürünü. Her işletim sisteminde çalışması da cabası. Çıplak haliyle de yeterince iyi olan bu editör, tıpkı *npm* gibi **apm** adında bir paket yönetim programına sahip. İster atom'un arayüzünden ister komut satırından kullanabilirsiniz. Arayüzden popüler paketleri inceleyip yükleyebilirsiniz.

* Mesela şu kullanım çok mantıklı: <http://www.atomtips.com/file-navigation-in-atom/>
* ya da şu <https://atom.io/packages/linter>
* atom'un özelleştirilmesinin sonu yok diyorum ve konuyu kilitliyorum

Şimdi reklamlar: <https://www.youtube.com/watch?time_continue=133&v=Y7aEiVwBAdk>

## Windows

> Komut satırı *cmd*'yi *administrator* olarak açmanız gerekebilir.
> Yüklenen programların tanınması için komut satırını yeniden açmanız gerekebilir

1. [Chocalatey](https://chocolatey.org) kurun. Ubuntu *apt-get* benzeri kurulum yapmanızı sağlayacak. Bu sayede windows cmd üzerinden kurulum yapabileceksiniz:
1. `choco install git`
1. `choco install node`
1. `choco install atom`

## Linux (Ubuntu)

Linux'unu sanal olarak kullanmak isteyenler için:

1. [Download VirtualBox](https://www.virtualbox.org/wiki/Downloads)
1. [Download Ubuntu](http://www.ubuntu.com/download/desktop)
2. Altından kalkamadınız mı sizi google yada şuraya alalım <https://mylifemypc.wordpress.com/appserv/oracle-virtualbox-ile-ubuntu-kurulum>

Terminal açıp komut yazacağız, yönetici hakkı gerektiren işlemde komutların başına `sudo` koyuyoruz ve parolamızı giriyoruz.

~~~
sudo apt-get update
sudo apt-get install nodejs
~~~

> Kurulumlarla ilgili problem yaşarsanız şuradan bakabilirsiniz: <https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server>

## Mac OS X

OS X'te de **Homebrew** kullanalım. Kurulum için:

~~~
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
~~~

Ardından `brew` ile kurulum yapıyoruz:

~~~
brew install node
brew install git
~~~

Atom kurun: <https://atom.io/download/mac>

# Proje Başlasın

Şimdi node.js'te yeni bir proje nasıl oluşturulur görelim:

~~~
npm init
~~~

> **package.json** dosyasını oluşturmak için bir takım sorular sorar

Kullanacağımız node paketlerini kuralım:

~~~
npm install express --save
npm install hogan-express --save
~~~

Uygulamamızın genel yapısı şu şekilde olacak:

~~~
project/
	public/
		css/
		images/
	views/   
	routes/
	Gruntfile.js
	app.js
	package.json
~~~

> Uygulama ile ilgili her dosyayı buradan paylaşamıyorum. O yüzden ister ara ara bakmak için kullanın, isterseniz de indirip üzerinden devam edin, şu linkten uygulamanın ilk halini görebilirsiniz: <https://github.com/dhalsim/chatcat>. Tavsiyem **bir** branch'ini bilgisayarınıza kurup devam etmeniz:

~~~
git clone https://github.com/dhalsim/chatcat.git
cd chatchat
npm install
npm instal grunt-cli -g
grunt dev
~~~

Browser'dan <http://localhost:3000> açıp test edin.

# Geliştirme

Meteor.js'te uygulama geliştirirken çok büyük kolaylık sağlayan bir sistem var. Gavurların **hot-code reloading** dedikleri bu sistem, sizin uygulama dosyalarınızı izliyor ve bir değişiklik olduğunda node.js'i baştan başlatıyor. Üstelik açık olan browser'da kendini yeniliyor. Yani siz editörünüzde çalışıp Ctrl+S'ye basıp browser'a döndüğünüzde yeni kodu çalışmış halde buluyorsunuz. Development'ı çok hızlandıran bir durum.

Node.js için bu sistemi yapabilmek için **grunt.js** denen bir build sistemi kullanacağım. Grunt kısaca sizin javascript ile bir takım işleri otomatikleştirmenizi sağlıyor. Örneğin **less** dosyalarını **css** dosyalarına çevirmenizi, javascriptleri **minify** etmenizi sağlayabilir. Üstelik birçok **grunt-contrib** hazır paketi var.

## Grunt.js'i tanıyalım

Grunt.js aslında bir task manager'dır. Veriler taskları komut satırından çalıştırabilirsiniz.

~~~
grunt dev
~~~

Çalıştırılan directory içinde **Gruntfile.js**'yi arar ve içinde verilen tasklardan **dev** ismindekini çakıştırır.

~~~js
grunt.registerTask('dev', ['express:dev', 'watch:all']);
~~~
* **dev** isminde bir task yaratır.
* Bu task başka iki task'ı çalıştırır.
* grunt-express-server ile eklenen **express** task'ının **dev** target'i ile
* grunt-contrib-watch ile eklenen **watch** task'ının **all** target'ini çalıştırır.
* target'ler **initConfig** içinde tanımlanmış olmalıdır (anlatacağım)

## Grunt.js kurulum

Öncelikle grunt'ı yükleyelim:

~~~
npm install -g grunt-cli
~~~

> grunt komut satırı çalıştırabilir programını global olarak yükler

~~~
npm install grunt --save
~~~
> grunt node.js library'sini uygulama altına yükler

Kullanacağımız diğer paketleri de yukarıdaki gibi npm ile yükleyelim:

~~~
npm install grunt-contrib-watch --save
npm install grunt-express-server --save
npm install load-grunt-tasks --save
npm install connect-livereload --save-dev
~~~

* **grunt-contrib-watch:** Verdiğiniz ayarlardan **file watcher**'lar oluşturur, değişikliklerde veriler task'ları çalıştırır
* **grunt-express-server:** *express.js* node uygulamanızı çalıştırır
* **connect-livereload:** *express.js*'de template'lerinize **livereload** script'ini inject eder.
* **load-grunt-tasks:** *package.json* içindeki dependency'lerinizi okuyup otomatik olarak onları *gruntfile.js*'te yükler. [Ayrıntılı bilgi](https://github.com/sindresorhus/load-grunt-tasks)

Farkettiyseniz bu komutlar **package.json** dosyasında değişikliklere yol açtılar:

~~~js
{
  "name": "chatcat",
  "version": "1.0.0",
  "description": "",
  "main": "app.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^4.13.3",
    "grunt": "^0.4.5",
    "hogan-express": "^0.5.2"
  },
  "devDependencies": {
    "connect-livereload": "^0.5.3",
    "grunt-contrib-watch": "^0.6.1",
    "grunt-express-server": "^0.5.1",
    "load-grunt-tasks": "^3.3.0"
  }
}
~~~

Peki **dependencies** yanında bu **devDependencies** nedir diye sorarsanız cevabı [burada]( http://stackoverflow.com/questions/18875674/whats-the-difference-between-dependencies-devdependencies-and-peerdependencies)

## Gruntfile.js

Bir sonraki yapmamız gerekenlerden **Gruntfile.js** dosyasını oluşturmak:

~~~js
module.exports = function(grunt) {
  require('load-grunt-tasks')(grunt);
  var path = require('path');

  grunt.initConfig({
    express: {
      dev: {
        options: {
          script: path.resolve('./app.js')
        }
      }
    },
    watch: {
      options: {
        livereload: true
      },
      all: {
        files: [
          'app.js',
          'Gruntfile.js',
          'public/**/*.*',
          'views/**/*.*'
        ]
      }
    }
  });

  grunt.event.on('watch', function(action, filepath, target) {
    grunt.log.writeln(target + ': ' + filepath + ' has ' + action);
  });

  grunt.registerTask('dev', ['express:dev', 'watch:all']);
}
~~~

* **initConfig** içine task'ların gerekli parametrelerini belirtiyoruz
* express task'ına dev, watch task'ına all isminde target'ler tanımlanmış
* express > dev > options > server ile çalışacak express uygulamasının dosya ismini verdim
* watch > all > files ile değişikliklerini izlemek istediğim dosya ve klasörleri belirttim

Evet artık **grunt dev** komutuyla uygulamamızı başlattıktan sonra <http://localhost:3000> altından test edebiliriz. Herhangi bir dosyayı değiştirin ve kaydedin. grunt'ın uygulamayı yeniden başladığını ve browser'ın sayfayı yenilediğini göreceksiniz.

# Express

**Grunt**'ın yaptığı bir takım sihirbazlıkları anlamadan önce, **express** nedir ne işe yarar ona bakalım.

Express, node.js ile birlikte çok basit bir http server yapabilmenize olanak sağlarken, **middleware** yapısıyla istenidiğiniz esnekliğe sahiptir. İster REST servisi yazabilir isterseniz bir web uygulaması yazabilirsiniz.

## Middleware nedir?

Middleware request objesine (req), response objesine (res) ve sonraki middleware'e (next) erişimi olan bir fonksiyondur.

![](/assets/images/middleware.png)

* Her tür kodu çalıştırabilir
* Request ve response objelerini değiştirebilir.
* Request-response çağrımını durdurabilir
* Sıradaki middleware'i çağırabilir

Application level veya route level tanımlanabilir. Error handling (hata yönetimi) için kullanımı farklıdır. Ayrıntılı bilgi: <http://expressjs.com/guide/using-middleware.html>

## View'lar

Biz **hogan** (mustache) template engine'i kullanarak bir chat web uygulaması yazacağız.

Hogan ile ayrıntılı bilgi: <https://github.com/vol4ok/hogan-express>
<br />
Mustache: <http://mustache.github.io/mustache.5.html>

Hadi uygulamamızı inceleyelim:

**app.js:**

~~~js
var express = require('express');
var path = require('path');

var app = express();

app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'html');

// template'ler için .html uzantısını kullan
app.engine('html', require('hogan-express'));

app.use(express.static(path.join(__dirname, 'public')));
app.use(require('connect-livereload')());

require('./routes/routes.js')(express, app);

app.listen(3000, function () {
  console.log('chatcat 3000 portunda çalışıyor');
});

module.exports = app;
~~~

* İlk üç satır **hogan**'ı template engine için ayarlamak üzere kullanılıyor
* sonraki satırda *public* klasörü statik dosyaların sunumu için ayarlanıyor
* **connect-livereload** middleware'i ekleniyor
* ayrı bir dosyadan (routes.js) route'ların tanımı ayarları yapılıyor
* 3000 portunda uygulama çalıştırılıyor
* son satır uygulamanın **grunt** üzerinden çalışabilmesi için gerekli

# Session

> Git ile bu kısımdan sonra yapılan değişiklikleri almak için aşağıdaki komutu kullanın. Böylece bu kısımda anlatacağım değişiklikleri elle yapmak zorunda kalmazsınız.

~~~
git checkout iki
npm install
~~~

Uygulamamızı çalıştırdık yalnız express uygulamasının kullanıcı bazında bilgi tutabilmesi için **session** adı verilen bir yönteme ihtiyacı var bunu da aşağıdaki paketi kurarak sağlayacağım:

~~~
npm install express-session --save
~~~

ve artık session'ı kullanabiliriz. session'la birlikte farkettiyseniz **cookie** paketi de yüklendi. Artık express cookie'de session ID'yi kullanarak kullanıcının bilgisini server tarafında takip edebileceğiz. Çok çeşitli ayarları olmakla birlikte biz hepsini kullanmayacağız. İncelemek isterseniz: <https://github.com/expressjs/session>

~~~js
var session = require('express-session');

app.use(session({
  secret: 'gizlişey',
  resave: false,
  saveUninitialized: true,
  cookie: { secure: true }
}));
~~~

> Not: cookie secure=true değeri HTTPS bağlantıda geçerlidir, HTTP bağlantıda (mesela development ortamında) cookie çalışmayacaktır. Bunu önlemek için kodumuza hangi ortamda (development, production, vb.) çalıştığıyla ilgili kontroller eklemeliyiz. Bu kontrolleri kolay yönetilebilir yapmak için kendi **environment** modülümüzü yazacağız

# Environment Modülü

Şimdi projemize yeni dosyalar ekliyoruz

~~~
project/
	...
	config/
		development.json
		production.json
		environment.js
	...
~~~

**environment.js:**

~~~js
module.exports = require('./' +
	(process.env.NODE_ENV || 'development') + '.json');
~~~

* **process.env.NODE_ENV** üzerinde çalıştığı bilgisayarın işletim sisteminde *NODE_ENV* ismindeki variable'ı bize verir. Bu variable set edilmemişse *undefined* olacağından varsayılan olarak *development* olarak çalışacak.
* Production ortamında bu variable *production* olarak setlenmelidir. [İlgili yöntemler](http://stackoverflow.com/a/9204973)
* variable'ın o anki değeri ile birlikte ilgili *.json* dosyasını okur ve export eder.

> NOT: local ortamda production ayarlarını deneyebilmek için *test* diye bir environment uydurdum. *production*'dan tek farkı cookie secure değil ama redis cloud üzerinden çalışacak.

**development.json:**

~~~json
{
  "cookie_secret": "gizlişey",
  "cookie": {
    "secure": false
  },
  "redis": {
    "port": 6379,
    "host": "localhost"
  }
}
~~~

**test.json:**

~~~json
{
  "cookie_secret": "gizlishey",
  "cookie": {
    "secure": false
  },
  "redis": {
    "port": 11386,
    "host": "pub-redis-11386.us-east-1-2.4.ec2.garantiadata.com",
    "pass": "chatcat"
  }
}
~~~

**production:**

~~~json
{
  "cookie_secret": "gizlishey",
  "cookie": {
    "secure": true
  },
  "redis": {
    "port": 11386,
    "host": "pub-redis-11386.us-east-1-2.4.ec2.garantiadata.com",
    "pass": "chatcat"
  }
}
~~~

**app.js'te:**

~~~js
var config = require('./config/environment');

app.use(session({
  secret: config.cookie_secret,
  resave: false,
  saveUninitialized: true,
  cookie: config.cookie
}));
~~~

# Session (Devam)

Artık session verilerimizi kullanabildiğimize göre, bir sonraki işimiz **session store** kullanmak olacaktır. Daha önceden de bahsettiğimiz gibi session ile birlikte veri asıl olarak server tarafında tutulmaktadır. Ancak biz store belirtmediğimiz için varsayılan olarak **MemoryStore** kullanılıyor.

Biz de bu *store*'u değiştireceğiz. Bunu **Redis** olarak ayarlayacağız.

> Redis, hafızada çalışan bir *key-valued* NoSQL veritabanı. Daha birçok yararlı kullanım alanları var ancak ilerledikçe bakacağız. Çok merak ediyorsan [buradan](#nedenredis) bakabilirsin.

*MemoryStore*'da veriler bilgisayarın geçici hafızasında tutulmaktadır. Sunucu restart vb. durumlarda bu verileri kaybedebiliriz. Daha da önemlisi ileride uygulamamızı birden fazla bilgisayar üzerinde -veya **cluster**'da- çalıştırmak istediğimizde her *process*'in kendi hafızasında bilgi tutmasından dolayı senkron problemleri yaşanacaktır. **Redis**'le bu problemlerin üstesinden gelmeye çalışacağız.

* Öncelikle redisi kendi bilgisayarımıza kuralım: <http://redis.io/download>
* Çalıştıralım:

~~~
redis-server
~~~

Redis server port 6379 üzerinden çalışıyor. Bunu kapatmadan başka bir terminal'de:

~~~
redis-cli
~~~

yazıp bir kaç komut deneyelim:

~~~
127.0.0.1:6379> SET my:key 'A value'
OK
127.0.0.1:6379> GET my:key
"A value"
~~~

* İstersek de cloud üzerinden redis'i kullanabiliriz.
* <https://redislabs.com/> üzerinden **free cloud database** seçeneğini kullanın. Üye olup bir adet redis database'i yaratın.

Artık redis'i localde veya cloud'da çalıştırabilme imkanımız var
Şimdi de node uygulamamızdan bağlanmayı deneyelim. Hatta önceki konularda uyguladığımız gibi eğer *development* modundaysak local redis'e, bağlanamazsa *MemoryStore*'a, *production* modundaysak da **redislab** üzerinden bağlanalım.

Kurmamız gereken paketler:

~~~
npm install redis -save
npm install connect-redis -save
npm install q --save
~~~

Projemizin yeni yapısı:

~~~
project/
	...
	lib/
		sessionStore.js
	...
~~~

**sessionStore.js:**

~~~js
module.exports = function(session, redis_config){
  var Q = require("q");

  var environment = (process.env.NODE_ENV || 'development');
  function getStore() {
    return new Promise(function(resolve, reject) {
      var redis = require('redis');
      var client = redis.createClient(
        redis_config.port,
        redis_config.host,
        {no_ready_check: true});
      var RedisStore = require('connect-redis')(session);

      client.on('error', function (err) {
        reject(err);
      });

      if(redis_config.pass){
        client.auth(redis_config.pass, function (err) {
            if (err)
              reject(err);
        });
      }

      client.on('ready', function () {
        resolve(new RedisStore({
          client: client
        }));
      });
    });
  }

  var store;

  var promise = Q.fcall(getStore)
    .then(function (value) {
      store = value;
    });

  if(environment === 'development'){
    promise = promise.fail(function (error) {
      console.log(error);
      console.log("falling back to MemoryStore");
      store = new session.MemoryStore();
    });
  }

  promise.done();

  return store;
};
~~~

> redis client'ını oluşturmak asenkron çalıştığı için ve callback'lerle uğraşıp durmamak için yapıyı senkron çalışacak şekilde geliştirdim. **Promise**'lerle ilgili ayrıntılı bilgiye ES6 yazılarımdan bakabilirsiniz. Kabaca callback'lerin işini bitirdikten sonra devam ettiğimizi düşünebilirsiniz.

**app.js:**

~~~js
//...
var session = require('express-session');
var store =  require('./lib/sessionStore.js')(session);

app.use(session({
  secret: config.cookie_secret,
  store: store,
  resave: false,
  saveUninitialized: true,
  cookie: config.cookie
}));
//...
~~~

Ayrıca artık **grunt** script'imiz *environment* variable'ını bizim için ayarlıyor. **dev** task'ı yanında yeni bir **prod** task'ımız da var:

**Gruntfile.js:**

~~~js
  //...
  grunt.initConfig({
    setEnvironment:{
      dev: 'development',
      prod: 'production',
      test: 'test'
    },
  //...
  grunt.registerMultiTask('setEnvironment',
    'sets environment variable to development or production',
    function () {
      process.env.NODE_ENV = this.data;
    }
  );

  grunt.registerTask('dev', [
    'setEnvironment:dev',
    'express:all',
    'watch:all'
  ]);

  grunt.registerTask('test', [
    'setEnvironment:test',
    'express:all',
    'watch:all'
  ]);

  grunt.registerTask('prod', [
    'setEnvironment:prod',
    'express:all',
    'watch:all'
  ]);
  //...
~~~

> **grunt dev** diyerek uygulamayı başlatırken NODE_ENV'ı da **development** diye setleyecek.

**routes.js** dosyasını aşağıdaki şekilde düzenleyelim:

~~~js
router.get('/chatrooms', function (req, res, next) {
var session = req.session;

if (!session) {
  return next(new Error('oh no')) // handle error
}

session.viewCount = session.viewCount
  ? session.viewCount + 1
  : 1;

res.render('chatrooms', {title: 'Chatrooms ' +
  session.viewCount});
});
~~~

> Her **chatrooms** ziyaret edildiğinde session bazında gösterim sayısı hesaplanıp title'a yazılıyor

~~~
redis-server
grunt dev
~~~

Şimdi redis'i test edelim ve çalışıp çalışmadığını görelim: <http://localhost:3000/chatrooms>

~~~
redis-cli
127.0.0.1:6379> KEYS *
1) "my:key"
2) "sess:s80MXIPbWE5iRxpU8F9j2QlxAJVe9our"
127.0.0.1:6379> GET sess:s80MXIPbWE5iRxpU8F9j2QlxAJVe9our
"{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"viewCount\":3}"
~~~

Görüldüğü gibi *viewCount* 3 olarak doğru bir şekilde kaydedilmiş.

Peki daha önceden düşündüğümüz local redis'in çalışmaması durumuna bakalım. redis-server'ı durdurun ve tekrar

~~~
grunt dev
~~~

~~~
{ [Error: Redis connection to localhost:6379 failed - connect ECONNREFUSED 127.0.0.1:6379]
  code: 'ECONNREFUSED',
  errno: 'ECONNREFUSED',
  syscall: 'connect',
  address: '127.0.0.1',
  port: 6379 }
falling back to MemoryStore
~~~

> Görüldüğü gibi error callback'ten hatayı **Promise** **reject**'ten döndürdüğümüzde catch kısmında yakalayıp gerekli düzeltmeyi yapmış olduk. redis-cli'den başarılı bağlantı geldiğinde de *ready* callback'iyle **Promise** **resolve** çalıştırıp programın devam etmesini sağladık.

Şimdi de production'da kullanmayı düşündüğümüz cloud redis'i localde test ediyoruz.

~~~
grunt test
~~~

Şimdi de cloud üzerinden çalışan **RedisStore**'u test edelim: <http://localhost:3000/chatrooms>

Farklı yöntemlerle cloud redis'e bağlanabilirsiniz. Ben komut satırından bağlanacağım:

~~~
redis-cli -h pub-redis-11386.us-east-1-2.4.ec2.garantiadata.com -p 11386 -a chatcat

pub-redis-11386.us-east-1-2.4.ec2.garantiadata.com:11386> KEYS *
1) "sess:LFKHQuh7UY8Cnsx8TWmyPcuqBASZbBsh"
pub-redis-11386.us-east-1-2.4.ec2.garantiadata.com:11386> GET "sess:LFKHQuh7UY8Cnsx8TWmyPcuqBASZbBsh"
"{\"cookie\":{\"originalMaxAge\":null,\"expires\":null,\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"viewCount\":4}"
~~~

Kodun her kısmını test ettik cloud redis'imizde de bir problem olmadığına göre redis ve session konusunu burada bitiriyorum :)

# Mongo DB

Facebook login'e geçmeden önce, kullanıcılarımızı kaydetmemiz gereken bir database'e ihtiyacımız var. Redis'i bu iş için de kullanabilirdik ama ben burada **mongo** ve **mongoose** kullanmak istiyorum. **Mongo** kullanımı kolay bir **Document Database**'idir. Ayrıntılı bilgi ve kurumun için [buraya](https://docs.mongodb.org/getting-started/shell/introduction/) bakabilirsiniz.

> NOT: Benim burada kullandığım komutlar işletim sistemine veya mongo versiyonuna göre değişebilir. Ben genellikle Mac OS için olan komutları kullanıyorum. Mac OS komutları çoğunlukla GNU/Linux sistemlerle benzer olmakla beraber burada farklı. Windows içinse verdiğim kaynaklara bakabilirsiniz.

Kurulum için:

~~~
brew install mongo
sudo chown -R $USER /data/db
~~~

Kurduktan sonra *server*'ı çalıştırmak için:

~~~
mongod
~~~

Ayrı bir terminalde:

~~~
mongo
~~~

Evet burası local mongo'nuz. Hayırlı olsun. Ancak ben yine <https://mongolab.com/> üzerinden cloud bir hesap açtım. ilgili environment ayarlarını aynı redis'te yaptığım gibi giriyorum.

Ve fakat mongo'ya node tarafından bağlanabilmek için mongoose kurmalıyız:

~~~
npm install mongoose --save
~~~

Kod yazma işlerini sonra göreceğiz. Şimdi biraz daha teori:

# Mongoose.js

**Mongo** normalde *schemaless* denilen tipsiz (: bir database'dir. Ancak gerçek hayatta bu bize bazı zorluklara yol açıyor. **Mongoose** bunları aşmak için güzel bir library.

* **Model**'leriniz için **schema**'lar tanımlayabilirsiniz
* Bu **schema**'lar **type**d field'lar içerir
* Bu modeller üzerinden database işlemleri (CRUD) yapabilirsiniz.
* Daha da bilgi: <http://mongoosejs.com/>

# Facebook Login

> Yine git kullanarak sıradaki kısımın kodlarını alabilirsiniz:

~~~
git checkout uc
~~~

Facebook login gerçekletirebilmek için, bir adet facebook hesabına ihtiyacımız var:

* Daha sonra <https://developers.facebook.com/apps/> adresine girin
* `add new app` kısmından yeni bir uygulama tanımlayın.
* Tip olarak, www web site seçin.
* Çıkan kutuda bir isim girin ve `Create new facebook App ID` ye tıklayın.
* Sağ üstteki `Skip Quick Start`'a tıklayarak çıkın
* Settings > Website > Site URL kısmına `localhost:3000` olarak girin
* Save changes diyip, Uygulama kodunu (App ID) ve App Secret'i kopyalayıp,
* **development.json**, **test.json** config dosyalarına şu şekilde ekleyin:

~~~
"fb": {
  "appId": "<APP ID>",
  "appSecret": "<APP SECRET>",
  "callbackURL": "http://localhost:3000/auth/facebook/callback"
}
~~~

## Problem: Node.js içindeki local module path'leri

Node.js local module'leri nasıl yüklediğimizi gördünüz. Projenin root directory'sindeki **app.js**'te şunu yazmıştık:

~~~js
var store =  require('./lib/sessionStore.js')(session);
~~~

Ancak mesela *lib/sessionStore.js* içinde *model/user.js* dosyasındaki modüle ulaşmak için şunu yazmamış gerekecekti:

~~~js
var user =  require('../model/user.js');
~~~

Günün birinde canımız sessionStore.js dosyasını *lib/session/sessionStore.js*'e taşımak istese bu sefer **require** içindeki path'leri şu şekilde tekrar düzeltmemiz gerekecekti:

~~~js
var user =  require('../../model/user.js');
~~~

> require içine yazılan path yazıldığı yere ve istenen modülün yerine göre değişiklik gösteriyor.

Bu problemi çözmek için [çeşitli yollar](https://gist.github.com/branneman/8048520) bulunuyor, ancak benim içinden ileride başımızı en az ağrıtacak yöntem  şu oldu: <https://www.npmjs.com/package/app-module-path>. Ancak bu bile bizi bir takım düzenlemeler yapmaktan kurtarmıyor :(

~~~
npm install app-module-path --save
~~~

**app-module-path** bize öneriler sunmuş: local modüllerin *node_modules* altındaki modüllerden ayrı olduğunun anlaşılması için bu modülleri ortak bir directory altına alınması.

Bu yüzden proje structure'ımız biraz değişecek ve şöyle olacak:

~~~
project/
	src/
		lib/
		models/
		config/
		routes/
	views/
	public/
	app.js
	Gruntfile.js
~~~

Ayrıca yine kullanımı kısaltmak amacıyla directory altında tek modül varsa bu modül dosya isimlerini **index.js** yapıyorum. Bunu *config/environment.js* ve *routes/route.js*'te uyguladım.

İlgili düzenlemeleri yaptıktan sonra **app.js**'te ilk satıra şunu ekliyoruz:

~~~js
require('app-module-path').addPath(__dirname);
~~~

Ve artık local modüllerimizi şu şekilde yerinden bağımsız bir şekilde kullanabiliriz:

~~~js
var config = require('src/config');
~~~

# Facebook Login (devam)

Facebook login'i **passport.js** üzerinden sağlayacağız. Kurmak için:

~~~
npm install passport --save
npm install passport-facebook --save
~~~

**Passport** ister local olarak, isterse birçok *external provider*'lar üzerinden *Authentication* (Kimlik Doğrulama) sağlayan bir kütüphane. Biz facebook bağlantısı için kullanacağız. [Websitesi](http://passportjs.org/) üzerinden diğer yöntemlere ve seçeneklere de bakabilirsiniz.

Peki external provider üzerinden bağlanmak nasıl çalışıyor?

![](/assets/images/facebook-login2.png)

Buradaki tüm yapılması gerken işlemleri *passport* bizim yerimize yapıyor. Peki implementasyonu nasıl yapıyoruz?

**src/lib/facebookLogin.js:**

~~~js
var passport = require('passport'),
  FacebookStrategy = require('passport-facebook').Strategy;

module.exports.init = function(config) {
  var facebook_config = config.fb,
    mongoose = require('mongoose'),
    User = require('src/models/user.js')(mongoose),
    userModel = mongoose.model('loginUser', User),
    mongoConnection = false;

  // user, id property'si ile serialize ediliyor
  // session'a yazılacak
  passport.serializeUser(function(user, done) {
    done(null, user.id);
  });

  // user, id'si kullanılarak deserialize ediliyor
  passport.deserializeUser(function(id, done) {
    userModel.findById(id, function(err, user) {
      done(err, user);
    });
  });

  var verifyCallback = function(accessToken, refreshToken, profile, done) {
    var mongo_config = config.mongo;
    var promise;

    if(!mongoConnection){
      promise = require('src/lib/mongoConnection.js')(mongo_config, mongoose).then(function() {
        mongoConnection = true;
      }).catch(function (err) {
        console.error(err);
        done(err);
      });
    } else {
      promise = new Promise(function(resolve, reject){ resolve(); });
    }

    promise.then(function() {
      return userModel.findOne({profileID: profile.id}).exec();
    }).then(function(dbUser) {
      if(!dbUser){
        dbUser = new userModel();
        dbUser.profileID = profile.id;
        dbUser.fullName = profile.displayName;
        dbUser.profilePictureURL = profile.photos[0].value;
        dbUser.save();
      }

      done(null, dbUser);
    });
  };

  var strategy = new FacebookStrategy({
    clientID: facebook_config.appId,
    clientSecret: facebook_config.appSecret,
    callbackURL: facebook_config.callbackURL,
    profileFields: ['id', 'displayName', 'photos']
  }, verifyCallback);

  passport.use(strategy);

  return passport;
};
~~~

**routes/index.js:**

~~~js
...
router.get('/auth/facebook',
  passport.authenticate('facebook', { scope : 'email' })
);

// facebook authenticate olduktan sonra
router.get('/auth/facebook/callback',
  passport.authenticate('facebook', { failureRedirect: '/login' }),
  function(req, res) {
    // authentication başarılı
    res.redirect('/chatrooms');
  }
);
...
~~~

* **passport.js**'nin **FacebookStrategy**'sini kullanarak *verifyCallback* içinde *user* profilini *facebook*'tan aldık
* bu kişi db'de yoksa kaydettik
* bu bizi callback url'in success function'ına düşürdü, oradan */chatrooms*'a yönlendirme yaptık
* **req.user** üzerinden kullanıcı bilgilerini kullandık

Mongo bağlantısını da aşağıdaki dosyayla sağlıyoruz:

**mongoConnection.js:**

~~~js
module.exports = function(mongo_config, mongoose) {
  var q = require('q');

  var promise = new Promise(function(resolve, reject) {
    mongoose.connect(mongo_config.url);
    var db = mongoose.connection;

    db.on('error', function(error) {
      reject(error);
    });
    db.once('open', function() {
      resolve();
    });
  });

  return q(promise);
};
~~~

> Değişiklik veya ekleme yapılan tüm dosyaları *git* ile alıp inceleyebilirsiniz.

* Sonuç olarak *Login* linkine tıklayıp */auth/facebook/* route'ına düşüyoruz
* ardından **passport** bizi facebook'a yönlendiriyor.
* Facebook login işlemini yaptıktan sonra bizi **config** ile verdiğimiz **callbackURL** adresine döndürüyor
* */auth/facebook/callback* route'ına düşüyoruz ve **passport** facebook'un gönderdiği bilgileri alıp **verifyCallback** fonksiyonunu kullanıp *user*'ın database üzerinde olup olmadığını kontrol ediyoruz
* Yoksa kaydediyoruz, **done** callback'ini çağırıp işlemi tamamlıyoruz
* **passport** done ile gönderdiğimiz *user* verisini alıp **passport.serializeUser** ile *session*'a kaydediyor.
* artık **user.id** *session*'da *req.user* üzerinden alınıp kullanılabilir durumda
* **passport** yine *user* nesnesini kullanacağımız zaman otomatik olarak **passport.deserializeUser** ile db'den çekiyor
* *authentication* işlemi başarılıysa kullanıcıyı */chatrooms* route'ına yönlendiriyoruz.
* Artık kullanıcının bilgileri elimizde, *view* üzerinde bu bilgileri gösterebiliyoruz.

> NOT: db gibi **asenkron** işlemlerde, **promise** adı verilen yapıları **then** ile bol bol kullandım. Bu yazının konusu olmadığından bunlara değinmiyorum. Javascript'te asenkronron kavramlarını açıkladığım diğer yazılarımdan bakabilirsiniz.

## Güvenli sayfalar

Artık bağlanma işlemini kolaylıkla sağlayabildiğimize göre */chatrooms* gibi sayfaları kullanıcı login olup olmadı mı gibi kontrolleri de yapmamız lazım.

**routes/index.js:**

~~~js
...

function securePage(req, res, next){
  if (req.isAuthenticated()) {
    next();
  } else {
    res.redirect('/');
  }
}

router.get('/chatrooms', securePage, function (req, res, next) {

...
~~~

* **securePage** adında bir **middleware** tanımladık.
* Bunu ilgili route'a koyduk.
* Bu route browser tarafından çağrıldığında önce bizim yazdığımız **middleware**'e düşecektir.
* **passport**'un sağladığı **req.isAuthenticated** fonksiyonu ile kullanıcı login olmuş mu kontrolü yapıyoruz.
* **next** ile bir sonraki **middleware**'e devam et diyoruz
* aksi durumda ana sayfaya yönlendiriyoruz.

# Geliştirme (mongo, redis, nodemon)

Artık *dev* ortamındayken, **mongo** ve **redis** server'larını elle başlatma işini de **grunt** ile otomatize edebiliriz.

Bu iş için iki yeni grunt kütüphanesi daha kullanacağız (concurrent, exec):

~~~
sudo npm install --save-dev grunt-concurrent
npm install grunt-exec --save-dev
npm install grunt-concurrent --save-dev
~~~

> **sudo**, **root** access gerektiren komutlarda kullandığımız bazı Linux/UNIX işletim sistemlerindeki bir ön komuttur. Şifrenizi girmeniz gerekebilir.

**initConfig**'e iki yeni tanım giriyoruz:

~~~js
exec: {
  mongo: {
    command: './mongo.sh'
  },
  redis: {
    command: './redis.sh'
  }
}
~~~

İki yeni dosya oluşturuyoruz:

**redis.sh:**

~~~sh
#!/bin/sh

OUTPUT="$(redis-cli ping)"

if [ "$OUTPUT" = "PONG" ]; then
  echo "redis-server is already running."
else
  redis-server
fi
~~~

**mongo.sh:**

~~~sh
#!/bin/sh

OUTPUT="$(pgrep mongod)"

if [ "$OUTPUT" = "" ]; then
  mongod
else
  echo "mongo service is already running."
fi
~~~

Dosyalara çalıştırma hakkı veriyoruz:

~~~
chmod a+x redis.sh
chmod a+x mongo.sh
~~~

## nodemon

Şimdi de *livereload* için bir yükseltme yapacağız. Normalde kullandığımız ayarlarla node uygulaması yeniden başlamıyordu. Bu da yenilemelerin view'larla sınırlı olmasına yol açıyordu. Artık **grunt-express-server** yerine **nodemon** kullanacağız. **nodemon**, dosyaları izleyip değişiklik olduğunda *node*'u yeniden başlatacak.

~~~
npm remove grunt-express-server --save-dev
sudo npm install -g nodemon
~~~

> NOT: *Gruntfile.js* dosyasında birçok değişiklik oldu. **git** üzerinden bakınız.

> NOT: Özellikle **exec** ile çalıştırdığım script'ler işletim sistemi bağımlı olup gerekli değişiklikleri kendiniz yapmalısınız.

<br />

> NOT: Bir sonraki chapter kodlarını *git* ile aşağıdaki gibi alabilirsiniz.

~~~
git checkout dort
~~~

# Socket.IO

> Gerçek zamanlı, iki yönlü, event-based (olay tabanlı) iletişim için kullanılır. Her platformda, tarayıcıda veya cihazda çalışır.

Altında kullanılan teknolojileri, bunu nasıl yaptığı gibi kısımları geçiyorum. Socket.IO kullandığınız tarayıcının yetenekleri dolayısıyla farklı teknolojileri devreye sokarak bunu yapıyor.

Bizim kullanma amacımız da client'lar arasında gerçek zamanlı bilgi akışını sağlamak olacak.

İlk işimiz chat odalarının DB üzerinden kaydedilmesi ve bu bilginin client'lara gönderilmesi şeklinde olacak. Bunun için hem *node* tarafında kodlar yazacağız hem de *client* tarafı için yazılacak.

~~~
npm install socket.io --save
~~~

Daha sonra da **app.js**'te bir takım değişiklikler yaptık:

~~~js
...
var server = require('http').createServer(app);
var io = require('socket.io').listen(server);
require('src/lib/socket')(io);

server.listen(config.port, function () {
  console.log('chatcat ' + config.port + ' portunda çalışıyor');
});
~~~

Ayrıca client tarafı için kullanmak istediğimiz *template*'lerde şu script'leri eklememiz gerekiyor:

~~~html
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="/socket.io/socket.io.js" charset="utf-8"></script>
<script type="text/javascript">
	window.socket_host = '{{socket_host}}';
</script>
<script src="../js/chatrooms.js" charset="utf-8"></script>
~~~

*/socket.io/socket.io.js* otomatik olarak *express* ve *socket.io* tarafından yakalanıp *client*'a sunum için hazırlanacaktır. Artık *client* tarafında **socket** ile ilgili **event**'leri kullanabiliriz:

**window.socket_host** üzerine *template*'e *route*'da gönderdiğimiz parametreyi geçiyoruz. Böylece bir alttaki **chatrooms.js** dosyasında kullanabileceğiz:

**public/js/chatrooms.js:**

~~~js
$(function () {
  var roomChannel = io.connect(window.socket_host + '/roomlist');

  roomChannel.on('connect', function () {
    console.log('socket connection established');
  });
});
~~~

* kendimize */roomlist* diye bir namespace oluşturup buna bağlanıyoruz. Daha sonra bu *channel*'ın **connect** event'ini dinliyoruz. Server tarafında bağlantı kabul edildiğinde browser console'unda log'u göreceğiz.

Server tarafında da, **src/lib/socket.js:**

~~~js
module.exports = function (io) {
  var chatrooms = io.of('/roomlist').on('connection', function (socket) {
    console.log('socket connection established on server');
  });
};
~~~

~~~
grunt dev
~~~

Herşey yolundaysa şunun gibi bir çıktı almamız lazım:

![](/assets/images/socket_io_connection.png)

Basit olarak sistemi kurduk denebilir. Artık bu iletişim çerçevesinde DB üzerinde işlemler yapılacak. **mongo** üzerinde daha kolay çalışabilmek, kod karmaşasını önleyip düzenlemek amacıyla yine kodumuzda düzenlemelere gidiyoruz, son değişiklikler:

~~~
...
public/
	...
	js/
		chatRoom.js
...
src/lib
	mongoAdapters/
		mongoConnection.js
		roomAdapter.js
		userAdapter.js
	redisAdapters/
	...
	facebookLogin.js
	socket.js
	utils.js
	...
...
src/models
	user.js
	room.js
...
~~~

> Burada dediğim gibi tüm kodlara tek tek girmeyeceğim. Özellikle **mongoConnect** ve **facebookLogin** üzerinde yaptığım değişiklikleri inceleyin.

Şimdi buradaki tüm kodlara girmeden kısaca **mongo** ve **socket.io** ile yaptığım oda yaratma kodlarını açıklayacağım. Daha sonra bu kodların bir de **redis** ile nasıl yazılabileceğine bakacağız.

## Server-side

**socket.js:**

~~~js
var roomAdapter = require('src/lib/adapters/roomAdapter'),
  Promise = require('bluebird'),
  channel = null,
  rooms = null;

module.exports = function (io, userId) {
  if (!channel) {
    channel = io.of('/roomlist').on('connection', function (socket) {
      console.log('socket connection established on server');

      function broadcastClient (data) {
        var stringified = JSON.stringify(data);
        socket.emit('room_update', stringified);
        rooms = data;
      }

      function broadcastAll (data) {
        var stringified = JSON.stringify(data);
        socket.broadcast.emit('room_update', stringified);
        socket.emit('room_update', stringified);
        rooms = data;
      }

      var promise = rooms ? Promise.resolve(rooms) : roomAdapter.getRooms();
      promise.then(broadcastClient);

      socket.on('create_room', function (room) {
        room.createdBy = userId;

        roomAdapter.createRoom(room).then(function () {
          return roomAdapter.getRooms();
        }).then(broadcastAll);
      });
    });
  }
};
~~~

* server tarafında */roomlist* channel'ı üzerinden gelen bağlantıları dinliyoruz.
* channel'ı birden çok açmamak için kontrol ekledik
* her client için mongo'ya gidip çekmemek için server tarafında *rooms* **cache**'i kullandık.
* Her bağlanan client için *rooms* verisini *broadcastClient* ile gönderdik
* **create_room** mesajını dinlemeye aldık
* mesaj geldiğinde ilgili verileri **roomAdapter.createRoom** ile mongo'ya kaydedip, tüm client'lara *rooms* verisini *broadcastAll* ile gönderdik
* bu bilgileri client'lara **room_update** mesajıyla gönderdik.

> NOT: **socket.broadcast.emit**, o anki client dışındaki client'lara bilgi gönderir. **socket.emit** sadece o client için gönderir.

**roomAdapter.js**

~~~js
var mongo_config = require('src/config').mongo,
  mongoose = require('mongoose'),
  init = require('src/lib/adapters/mongoConnection').mongoInit,
  Room = require('src/models/room.js')(mongoose),
  roomModel = mongoose.model('room', Room),
  moment = require('moment');

module.exports.createRoom = function (data) {
  return init(mongo_config, mongoose).then(function () {
    var room = new roomModel();
    room.name = data.name;
    room.createdBy = data.userId;
    room.createdAt = moment.utc();
    room.save();

    return room;
  });
};

module.exports.getRooms = function () {
  return init(mongo_config, mongoose).then(function () {
    return roomModel.find({}).exec();
  });
};
~~~

Çok basit bir şekilde *rooms* bilgisi çeken, ve *room* kaydeden fonksiyonlar.

## Client-side

**chatRoom.js:**

~~~js
$(function () {
  var roomChannel = io.connect(window.socket_host + '/roomlist');

  roomChannel.on('connect', function () {
    console.log('socket connection established');
  });

  roomChannel.on('room_update', function(rooms) {
    rooms = JSON.parse(rooms);

    var $ul = $('ul.roomlist');
    $ul.html('');

    rooms.forEach(function(room){
      var $li = $("<li>");
      $li.text(room.name);
      $li.attr('data-id', room._id);
      $li.attr('data-createdby', room.createdBy);
      $li.attr('data-cratedat', room.createdAt);

      $ul.append($li);
    });
  });

  $('#create').click(function () {
    var $roomNameInput = $('.newRoom');
    var roomName = $roomNameInput.val();
    if(!roomName) {
      alert('Oda ismini giriniz');
      return;
    }

    roomChannel.emit('create_room', { name: roomName });
    $roomNameInput.val('');
  });
});
~~~

* Client tarafında server'dan gelen **room_update** mesajı dinleniyor
* Gelen bilgi DOM'a jquery ile basılıyor
* Oda yarat, butonu ile girilen oda ismi **create_room** ile server'a gönderiliyor.

Buradaki tek sorun, **mongo** üzerinde bu oda bilgilerinin paylaşımının socket.io üzerinden gitmesi, yani mongo üzerinde **remove** işlemi yaptığınızda bu siteye yansımayacak.

Bu tarz işlemlerin bir de **redis** üzerinden nasıl yapıldığına ve bu sorunu nasıl çözeceğimize bakalım.

~~~
npm install shortid --save
npm install flat --save
npm install moment --save
~~~

Redis üzerinde mongo'daki gibi otomatik **ID** oluşturma mekanizması yok. Bu yüzden **shortid** kullanacağım. **node-uuid** de seçebilirdik ama URL'de göstermek için fazla uzun.

**Flat** ise redis'e veri gönderirken kullanacağımız fayfalı bir kütüphane, redis'e objelerimizi ister JSON olarak koyabiliriz veya bu şekilde *gezilebilir* objelere döndürerek:

~~~js
var flatten = require('flat')

flatten({
    key1: {
        keyA: 'valueI'
    },
    key2: {
        keyB: 'valueII'
    },
    key3: { a: { b: { c: 2 } } }
})

// {
//   'key1.keyA': 'valueI',
//   'key2.keyB': 'valueII',
//   'key3.a.b.c': 2
// }
~~~

Bununla ilgili kodlarımızı **utils.js**'de görebilirsiniz.

Tabii toplamda çok kod değişti ama ben en ilginç olanlara burada değineceğim. Diğerleri kodu inceleyerek anlaşılabilir.

## <a name="nedenredis"></a>Neden Redis

Şimdi daha önceden *session* için **redis** kullandık fakat bu sefer kullanma mantığımız biraz daha farklı. O yüzden konuya biraz daha derinlemesine girelim.

> Şimdi NoSQL nedir, neden kullanılır, çeşitleri nelerdir, hangisi hangi durumda seçilmelidir, avantajları, dezavantajları nelerdir gibi bu konuda gırla bilgi vermek gerekir. Hem ben bu konuları bu kadar profesyonel şekilde açıklayamam hem de konu çok dağılır. Bu yüzden burada hangi amaçla kullandık onun üzerinden kısaca açıklayacağım.

Şimdi mongo yerine redis kullanmamızın ana sebebi, chat gibi bir uygulamanın çok hızlı çalışması gereğidir. Redis, in-memory DB olmasından kaynaklı buna mongo'dan daha yatkın.

Bir de kullanıcılar arasındaki senkronizasyonu redis üzerinden yapmaya karar verdim. Bu hem kodlamayı kolaylaştıracak, hem de db - server - client arasındaki veri bütünlüğü tek bir yerden sağlanmış olacak. Redis bunu destekliyor.

Şimdi ilk yapacağımız iş redis'in çalıştırılmasındaki ayarın değiştirilmesi olacak. *redis-server*'ı çalıştırırken bir adet configuration dosyası belirtmemiz gerekecek. Bu dosya **redis.conf**'tur. Ancak işletim sistemine göre ismi ve yeri değişebilir. Ben OS X'e göre belirteceğim.

Favori editörünüzle dosyayı açın, ben *atom* ile açıyorum. *NIX'te nano seçeneğini kullanabilirsiniz.

~~~
atom /usr/local/etc/redis.conf
~~~

> notify-keyspace-events ile başlayan satırı bulup aşağıdaki gibi düzenleyin ve kaydedin.

~~~
notify-keyspace-events "Kgs"
~~~

Artık **redis.sh**'ta çalıştırma komutunu değiştirelim

~~~
redis-server /usr/local/etc/redis.conf
~~~

Artık redis verdiğimiz parametrelere göre bir takım event'leri dinliyor. Eğer biz de bu bilgilere talip olursak alabileceğiz. Ama önce redis'le ilgili biraz daha bilgi vermem gerekiyor.

* Redis key-value şeklinde string tabanlı bir NoSQL veritabanıdır
* In-memory çalışır, istenirse belli zamanlarda diske snapshot alınabilir
* Veri yapıları servisidir. String, List, Hash, Set, Bitmap gibi veri yapılarını destekler
* Master/slave replication ve clustering destekler
* Üzerinde PUB/SUB mekanizması vardır. Belli key'lere *subscribe* olan client'lar, *publish* gerçekleştiği durumda *notify* olurlar.

Bu özelliklerin **socket.io** ile birlikte kullanılmasıyla dinamik bir chat uygulaması kullanabilmiş olacağız. Mongo db'den farklı olarak ise:

* JSON desteklemiyor, bu yüzden javascript'ten kullanırken flat gibi yardımcı fonksiyonlara gerek duydum.
* Otomatik unique id oluşturamıyor. Uniqueness adına da **shortid** kullandım.
* Oda bilgilerini tutmak için iki tip yapı kullandım. İlki *room:key* şeklinde girdiğim key'i shortid ile ürettiğim hash.
* İkincisi de bu odaları tuttuğum *rooms* *set*'i.

**redisAdapter.js:**

~~~js
var shortid = require('src/lib/utils').shortid,
  objToArray = require('src/lib/utils').objToFlattenArray,
  unflatten = require('src/lib/utils').unflatten,
  redis = require('redis'),
  redisConnection = require('src/lib/redisAdapters/redisConnection'),
  client = redisConnection.getClient(),
  subscriberClient = redisConnection.getClient(true),
  Promise = require('bluebird');

module.exports.createRoom = function(data) {
  var key = 'room:' + shortid();

  Promise.promisifyAll(redis.Multi.prototype);
  var multi = client.multi();
  multi.hmset(key, objToArray(data));
  multi.sadd('rooms', key);
  return multi.execAsync();
};

module.exports.getRooms = function () {
  var smembers = Promise.promisify(client.smembers, client);
  var hgetall = Promise.promisify(client.hgetall, client);

  return smembers('rooms').then(function (keys) {
    var getJobs = keys.map(function (key) {
      return hgetall(key);
    });

    return Promise.all(getJobs);
  }).then(function (results) {
    return results.map(function (result) {
      return unflatten(result);
    });
  });
};

module.exports.subscribeRooms = function (callback) {
  subscriberClient.subscribe('__keyspace@0__:rooms');

  subscriberClient.on("message", function (key, command) {
    console.log(key, command);
    callback();
  });
};
~~~

* **createRoom** ile başlarsak, önce unique bir key oluşturuyoruz
* redis.Multi'yi **promisify** ederek *thenable* hale getirdik
* **multi** komutuyla redis'e tek *request*'te ve *transaction* içinde birden çok komut gönderebiliyoruz
* **hmset** ile *hash* objemizi setliyoruz. Objemizi array tipinde kaydediyoruz.

~~~
client.hmset(key, ["key1", "value1", "key2", "value2", ...]);
~~~

* **sadd** ile de *rooms* key'li *set*'imize *hash*'in *key*'ini ekliyoruz.
* **execAsync** ile *Promise* oluşturup dönüyoruz.
* **getRooms** ise yukarıda yaptıklarımızın tam tersini yapıp bize **rooms** javascript object array'ini alıyoruz.
* **subscribeRooms** ile key'leri takip ediyoruz.

## Kaynaklar, notlar

> [Redis notifications ayrıntılı bilgi](http://redis.io/topics/notifications)

> [Redis komutlar](http://redis.io/commands)

> [Redis node client](https://www.npmjs.com/package/redis)

> [socket.io-redis](https://www.npmjs.com/package/socket.io-redis): Birbiri arasında haberleşebilen socket.io sunucuları çalıştırabilirsiniz.

Bol bol kullandığım, *room* ile başlayan key'leri silen *bash* script:

~~~
redis-cli KEYS "room*" | xargs redis-cli DEL
~~~

Redis OK, socket'te ne gibi değişiklikler var:

* **app.js**'te socket.io ile express'in aynı session'a ulaşabilmesi sağlandı
* mongo user kodları **userAdapter.js**'e taşındı
* Promise library olarak *bluebird* denendi

# Socket.io (devam)

Sıra chat room'un gösterilmesi ve chat'leşmeye geldi.

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
    });
  });
...
~~~

* Gerekli bilgileri çekip, room *template*'imize gönderiyoruz.
* `room:id` dediğimizde `req.params.id` ile route'ın parametresini alabildik.
* Bu bilgiyse *redis*'e gidip ilgili room'u çekiyoruz.

`/messages` adında yeni bir *channel* oluşturuyoruz.

**soket.js:** (server)

~~~js
var messagesChannel = io.of('/messages').on('connection', function (socket) {
  if(!socket.request.session.room){
    return;
  }

  socket.on('disconnect', function() {
    var roomId = socket.request.session.room.id;
    updateUsersList(roomId);
  });

  socket.on('joinroom', function (user) {
    var roomId = socket.request.session.room.id;

    // bu user'la join olacağız, bu bilgi daha sonra clients'dan alınabilir
    socket.user = user;
    socket.roomId = roomId;
    socket.join(roomId);

    updateUsersList(roomId);
  });

  socket.on('sendMessage', function (data) {
    var stringified = JSON.stringify(data);
    socket.broadcast.to(data.roomId).emit('receiveMessage', stringified);
  });

  function updateUsersList(roomId){
    var clients = messagesChannel.in(roomId).sockets.filter(function(socket) {
      return socket.roomId === roomId;
    });
    var users = clients.map(function(socket) {
      return socket.user;
    });
    messagesChannel.in(roomId).emit('receiveUsersList', JSON.stringify(users));
  }
});
~~~

* *socket.io* için yeni bir kavram: **room**
* `socket.broadcast.to(data.roomId).emit` ile o odaya ait kullanıcılara mesaj gönderiliyor
* yalnız *socket.io*'nun bu versiyonunda eksik bir [kısım](https://github.com/socketio/socket.io/pull/1630) var, bunu kendi kodumuzla aşacağız:
* **updateUsersList**'te ise kısaca yeni bağlantılar ve kopmalar/ayrılmalarda kullanıcı listesinin o room'a bağlı kullanıcılara gönderilmesi sağlanıyor
* socket, room'a *join* edilirken **user** ve **roomId** bilgileri üzerine setleniyor.
* `filter` ile bu socket'lerden o **roomId**'ye bağlı olanlar seçilip, **user** bilgileri toplanıyor, yine ilgili client'lara gönderiliyor.

**public/js/room.js:** (client)

~~~js

function insertMessage(message, me){
  var $profilePic = $('<img>');
  $profilePic.attr('src', message.profilePictureURL);
  $profilePic.attr('alt', message.userName);

  var $pic = $('<div>');
  if(me) {
    $pic.attr('class', 'mypic');
  } else {
    $pic.attr('class', 'pic');
  }

  $pic.append($profilePic);

  var $msg = $('<div>');
  if (me) {
    $msg.attr('class', 'mymsg');
  } else {
    $msg.attr('class', 'msg');
  }

  $msg.append($('<p>')).append(message.message);

  var $msgBox = $('<div>');
  $msgBox.attr('class', 'msgbox');
  $msgBox.append($pic).append($msg);
  $msgBox = $('<li>').append($msgBox);

  $msgBox.hide().prependTo($('ul.messages')).slideDown(100);
}

function onKeyUp() {
  $(document).on('keyup', '.newmessage', function (e) {
    var value = this.value;
    if(e.which === 13 && value !== ''){
      var messageData = {
        userId: user._id,
        userName: user.fullName,
        profilePictureURL: user.profilePictureURL,
        roomId: room.id,
        message: value
      };

      this.value = '';
      insertMessage(messageData, true);
      roomChannel.emit('sendMessage', messageData);
    }
  });
}

function addUsers(users) {
  var $usersList = $('ul.users');
  $usersList.html('');

  users.forEach(function (user) {
    var $user = $('<span>').text(user.fullName);
    var $profilePic = $('<img>').attr('src', user.profilePictureURL);
    var $userName = $('<h5>').text(user.fullName);
    $usersList.append($('<li>').append($profilePic).append($userName));
  });
}

roomChannel.on('connect', function () {
  console.log('socket connection established');
  roomChannel.emit('joinroom', user);
  onKeyUp();
});

roomChannel.on('receiveMessage', function (data) {
  data = JSON.parse(data);
  insertMessage(data);
});

roomChannel.on('receiveUsersList', function (data) {
  users = JSON.parse(data);
  addUsers(users);
});
...
~~~

* ilgili socket.io event'lerini yakalayıp, data'yı **jquery** ile DOM'a basıyoruz
* **onKeyUp** ile, kullanıcı **enter** tuşuna bastığında input'ta yazan mesajı alıp `roomChannel.emit` ile gönderiyoruz.
* `roomChannel.on('receiveMessage')` ile server'dan gelen dönüşü yazıyoruz.
* `roomChannel.on('receiveUsersList')` ile server'dan **joinroom** ve **disconnect** sonucu değişen oda kullanıcı listesi ilgili client'lara gönderiliyor.

# Sonuç

Evet, artık uygulamamamızı yeterince geliştirdik ve çoklu odalı, gerçek zamanlı bir uygulamayı node.js üzerinde nasıl yaparız denemiş olduk.

Bunu yaparken tabii çok düz bir şekilde yapmadık. Kodları incelerseniz az çok kodların ileriye dönük biçimde gelişmeye açık olduğunu görebilirsiniz. Minimum düzeyde kod tekrarı, anlaşılır kodlama, basit mimari ile bunları gerçekleştirdik.

Çıkan sonuç kadar, geliştirme ortamı da burada önemli oldu. Özellikle **grunt** kullanarak basit ama tekrara dayalı işleri otomatize ettik. Geliştirmeyi hızlandıran *hot-code-push* özelliğini kullandık.

Geliştirme ortamlarını ayırarak, geliştirme, test ve canlı ortamları için ayrı konfigurasyonlar sağladık.

**Passport.js** ile facebook bağlantı yapmayı gördük.

**Mongo** ve **mongoose* ile *Document-based* veritabanları nasıldır, nasıl kullanılır bilgimiz oldu. **Redis** ile uygulama arasında çift yönlü bir bağlantı kullandık, DB taraflı data güncellemelerinden haberdar olduk.

**Socket.io** ile client-server ve client-client arası haberleşmeyi sağladık.

**Promise**'lerle *callback* tipi çağrımları dönüştürdük.

Tüm bunları yaparken irili ufaklı birçok kütüphane kullandık. **express** *middleware* yapısına aşina olduk. Uygulamayı ihtiyaç duydukça **refactor** ettik.

Sonuç olarak ortaya başarılı bir web uygulaması çıktı.

Afiyet olsun :)
