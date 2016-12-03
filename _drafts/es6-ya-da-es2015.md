---
layout: post
title: "What is Webpack and How does it workflow"
description: "This is another build tool (task runner) like **grunt** or **gulp** but mostly a module bundler like **browserify** and also can be used with a *transpiler* like **babel** (to be able to use ES6 javascript feautures from the future!) or **typescript** (which is cool)."
toc: true
category: ["javascript", "build", "tooling"]
tags: ["webpack", "build", "tooling"]
excerpt: "This is another build tool (task runner) like **grunt** or **gulp** but mostly a module bundler like **browserify** and also can be used with a *transpiler* like **babel** (to be able to use ES6 javascript feautures from the future!) or **typescript** (which is cool)."
image: "/assets/webpack-logo.png"
---

# ES6 Ya da ES2015

Selamlar. Bu yazıda javascript'in gelecek nesil versiyonundan bahsedeceğim: EcmaSCRIPT 6 veya EcmaScript 2015. Kullanacağım teknoloji [babel js](https://babeljs.io) olacak.

## Neden babel JS

Javascript bildiğiniz gibi hem client tarafında hem de server tarafında çalışan bir yorumlamalı dildir. Client tarafı değişkenlik gösterdiği için her özelliğin çalışması beklenemez. Mesela eski browserlarda javascript'in yeni özelliklerin çoğu yoktur.

Bu sorunu aşmak için babel js preprocessor kullanacağım. basitçe ES6'da yazdığınız javascript kodunu ES5'e çevirir.

Örnek çeviri: <http://babeljs.io/repl>

## Konular

* [Template Strings](#templatestrings)
* [Destructuring](#destructing)
* [Generators](#generators)
* [Promises](#promises)
* [Generators ve Promises](#generators-promises)
* [Let ve Const](#letveconst)

## Template Strings

**Multiline Strings**

~~~js
"ben burada line break\nkullanabiliyorum"
//ben burada line break
//kullanabiliyorum

`ben burada line break
kullanabiliyorum`
//ben burada line break
//kullanabiliyorum
~~~

**Expression interpolation**

~~~js
var a = 5;
var b = 10;
console.log("onbeş = " + (a + b) + " dir\n" + (2 * a + b) + " değildir.");
//onbeş 15 dir
//20 değildir.

console.log(`onbeş ${a + b} dir
${2 * a + b} değildir.`);
//onbeş 15 dir
//20 değildir.
~~~

Çok hoş değil mi? Artık native olarak bu özellikleri kullanabiliyoruz.
Yalnız bu biraz da güvenlik zaafiyeti de doğurmuyor değil.

~~~js
var badString = `${document.cookie}`;
console.log(`${badString}`);
//cookie yi aldım canım geçmiş olsun :)
~~~

**Tagged Template Strings**

Templateleri kendiniz de işleyebilirsiniz. Size içindeki değerleri array olarak döndürüyor ve dönüş değerini override edebilirsiniz. Bunun için fonksiyon yazıyoruz.

```js
var who = "seni";
var when = "geceleri";

function capitalizeFirstLetter(string) {
  string = string.trim();
  return string.charAt(0).toUpperCase() + string.slice(1);
}

function ConvertPoem(strings, ...values) {
  return `${capitalizeFirstLetter(strings[2])} ${values[0]}
${values[1]} ${strings[0].toLowerCase()}`;
}

console.log(ConvertPoem`Gözlerim ${when}
${who} bekler`);
//Bekler geceleri
//seni gözlerim
```

Alın size düzyazıyı manzumeye çeviren bir programcık :)

> Yalnız ilk kısım değişken olursa strings[0] boş string dönecektir.

**Raw**

Stringin başına @ koyarak tıpkı C#'ta yaptığımız gibi özel karakterleri escape etmeden kullanabiliriz. Bunun için tagged template strings için kullanılan fonksiyonun ilk parametresindeki özel raw property'sini kullanabiliriz.

~~~js
function tag(strings, ...values) {
  console.log(strings.raw[0]);
  // "line break için \\n kullanılır"
}

tag`line break için \n kullanılır`;
~~~

ya da

~~~js
String.raw`line break için \n kullanılır ${2+4}`;
//line break için \\n kullanılır 6
~~~

## Destructuring

Fonksiyonel programlamanın pattern matching konusuna giren bu konu da tıpkı regex kullanır gibi değişken atama yapmamızı sağlıyor.

## Generators

~~~js
setTimeout(function(){
    console.log("Hello World");
},1);

function foo() {
    // çok uzun bir döngü
    for (var i=0; i<=1E10; i++) {
        console.log(i);
    }
}

foo();
// 0..1E10
// "Hello World"
~~~

Javascript, ister browserda ister serverda (node.js gibi) çalışsın; tek process, tek thread (tek millet)'tir. Yukarıda da görüldüğü gibi 1 ms sonra başlaması gereken kod ne kadar uzun sürerse sürsün foo fonksiyonunun çalışmasının bitmesini beklemek zorunda.

**Generators** kullanarak fonksiyonları çalıştır-durdur-devam modelinde kullanabiliyoruz. Burada bir fonksiyon kendi çalışmasının interrupt edilmesine izin verir. Bunu da **yield** keyword'üyle sağlarız. Ancak kendisini durduran fonksiyonun devam etmesi için dışarıdan müdahaleye ihtiyaç duyarız. Bunu da **devam** etmeyle sağlarız.

~~~js
function *foo() {
    // ..
}
~~~

Fonksiyonun generator tipi olduğunu * işaretiyle gösterebiliriz.
Bir generator fonksiyonunda iki yönlü iletişim söz konusudur. **yield** ile fonksiyon dışına veri gönderirken, **next(...)** ile fonksiyona parametre geçerek içeri veri gönderiyoruz. Fonksiyon kaldığı yerden çalışmaya devam eder.

~~~js
// not: `yaz(..)` generator değildir
function yaz(x) {
    console.log("x: " + x);
}

function *gen() {
    yield "ilk yield"; // bekle
    yaz( yield "ikinci yield" ); // bekle, sonra gelen veriyi yaz'a geçir
}

// generator'ı yarat
var g = gen();

var result = g.next(1);
console.log("sonuç:", result.value, ", done:", result.done);
result = g.next(2);
console.log("sonuç:", result.value, ", done:", result.done);
result = g.next(3);
console.log("sonuç:", result.value, ", done:", result.done);

~~~

Sonuç:

~~~
sonuç: ilk yield , done: false
sonuç: ikinci yield , done: false
x: 3
sonuç: undefined , done: true
~~~

Şimdi daha karışık bir örnek ile devam edelim:

~~~js
function *foo(x) {
    var y = 2 * (yield (x + 1));
    var z = yield (y / 3);
    return (x + y + z);
}

var it = foo( 5 );

// not: constructor'a parametre geçildiğinden
// ilk next parametresi kullanılmaz
console.log( it.next() );       // { value:6, done:false }
console.log( it.next( 12 ) );   // { value:8, done:false }
console.log( it.next( 13 ) );   // { value:42, done:true }
~~~

Arkadaş ben bu fonksiyonu bozarım!

~~~js
function foo1(x) {
    return (x + 1);
}

console.log(foo1(5));

function foo2(x) {
    var y = (2 * x) // x:12, y -> 24
    return y / 3;
}

console.log(foo2(12));

function foo3(x, y, z) {
    return x + (2 * y) + z //z:13
}

console.log(foo3(5, 12, 13));

//6
//8
//42
~~~

Karışık değil mi? Değil:

* burada **yield** gördüğünüz yeri yield ifadesi olarak düşünün.
* hesaplamaya yield ifadesinden başlayıp, yield sonucunu döndürün.
* bir sonraki çağrımda önceki yield ifadesi yerine **next(...)** ifadesini koyun
* sonraki yield'a kadar devam edin.
* tüm yield'lar bitip fonksiyondan çıktığımızda done: true oluyor.

### for..of ###

Javascriptteki *for in*'e ek olarak generator'ları **iterator pattern** olarak kullanabilmemiz için **for of** yapısı eklenmiş.

~~~js
function *factorial(n){
 var total = 1;
 var from = 1;

  while (from <= n) {
    total *= from++;
    yield total;
  }
}

for (var n of factorial(5)) {
  console.log(n)
}
// 1, 2, 6, 24, 120
~~~

> **Not:** Örnekleri recursive yapmayı tercih ettim. İsterseniz döngü kullanarak da aynı sonuçları elde edebilirsiniz.

### yield delegation ###

**yield *foo()** yardımıyla çağrımı başka generatora yönlendirebiliriz.
Mesela, iç içe array içeren bir değeri düzlemek istersek:

~~~js
function *flat (arr) {
  if (!arr.length) {
    yield arr;
  } else if (arr.length === 1) {
    yield arr[0];
  } else if (arr.length > 1) {
    yield *flat(arr.shift());
    yield *flat(arr);
  }
}

var A = [1, [2, [3, 4], 5], 6];
for (var f of flat(A)) {
    console.log( f );
}
// 1 2 3 4 5 6
~~~

> yine güzel bir **recursive** örneği oldu :)

### try catch ###

Generator içinde try catch ifadeleri kullanılabilir. Dizi içindeki değerleri büyük harfe çeviren kod:

~~~js
function *upper (items) {
  var elem = items.shift();

  if(elem){
    try {
      yield elem.toUpperCase();
    } catch (e) {
      yield null;
    }

    yield *upper(items);
  }
}

var bad_items = ['a', 'B', 1, 'c'];

for (var item of upper(bad_items)) {
  console.log(item);
}
// A, B, null, C
~~~

> **Not:** Nümerik 1 değeri *toUpperCase()*'de hataya yol açar, ancak biz **try catch** ile bunu telafi edip yolumuza devam ettik.

> **Not2:** generator'a özel **throw()** metodunu kullanarak en yakın **try catch** blokunda yakalanmasını sağlayabiliriz. Eğer bulunmuyorsa bir sonraki blokta başarılı bir şekilde yakalanacaktır. Bu özelliği bildiğimiz **callback** async yöntemlerde kullanamıyorduk.

### Generator'lar ile Asynchronicity

Senkron çalışan kodun okunabilirliğini kaybetmeden asenkron yapıları generatorlar vasıtasıyla yapabiliriz. Şu örnek normal bir içiçe asenkron çağrımdır:

~~~js
function makeAjaxCall(url,cb) {
    // do some ajax fun
    // call `cb(result)` when complete
}

makeAjaxCall( "http://some.url.1", function(result1){
    var data = JSON.parse( result1 );

    makeAjaxCall( "http://some.url.2/?id=" + data.id, function(result2){
        var resp = JSON.parse( result2 );
        console.log( "The value you asked for: " + resp.value );
    });
});
~~~

Konunun başında şunu yazmışım:

> *Generators* kullanarak fonksiyonları çalıştır-durdur-devam modelinde kullanabiliyoruz. Burada bir fonksiyon kendi çalışmasının interrupt edilmesine izin verir. Bunu da *yield* keyword'üyle sağlarız. **Ancak kendisini durduran fonksiyonun devam etmesi için dışarıdan müdahaleye ihtiyaç duyarız.** Bunu da *devam* etmeyle sağlarız.

Aslında fonksiyon içinden de kendisinin devamını sağlayabiliyoruz. Şimdi üstteki örneği değiştirdiğimiz şu örneği inceleyelim:

~~~js
function request(url) {
    makeAjaxCall( url, function(response){
        it.next( response );
    } );
}

function *main() {
    var result1 = yield request( "http://some.url.1" );
    var data = JSON.parse( result1 );

    var result2 = yield request( "http://some.url.2?id=" + data.id );
    var resp = JSON.parse( result2 );
    console.log( "The value you asked for: " + resp.value );
}

var it = main();
it.next(); // get it all started
~~~

main metodu içinde yield dışarıdan veri aldığımız yapılardı ve fonksiyonun çalışmasını durduruyordu. Biz *makeAjaxCall* içinden callback'te generator'un *next(...)* metodunu ajaxtan dönen değeri göndermek için kullandık. Daha sonra aynı yöntemi de 2. çağrımda gerçekleştirdik. Görüldüğü gibi asenkron metotları (ajax) senkron çalışıyormuş gibi yazabildik.

Şimdi de node.js'te bir örnek inceleyelim:

**helpers.js:**

~~~js
exports.AsyncFunc = function (swear, callback){
  setTimeout(function() {
    if(swear){
      callback(null, "fuck you!");
    } else {
      callback(null, "love you!");
    }
  }, 2000);
}

exports.Run = function (generator) {
  var g = generator(done);

  function done(err, result){
    g.next(result);
  };

  g.next();
}
~~~

<br />

**program.js:**

~~~js
var run= require('./helpers.js').Run;
var asyncFunc = require('./helpers.js').AsyncFunc;

run(function* (done) {
  try {
    var message = yield asyncFunc(false, done);
    console.log(message);

    message = yield asyncFunc(true, done);
    console.log(message);
  } catch (e) {
    console.log("null");
  }
});
~~~

**sonuç:**

~~~
node program.js
love you!
fuck you!
~~~

> 2'şer saniye arayla love you! ve fuck you! yazdı, terbiyesiz...

Syntax çok karışık gelmiş olabilir diye programı ikiye ayırdım. helpers.js'e programı kullanabilmek için gerekli iki fonksiyonu koydum. Böylece başka yerlerde de kullanabiliriz.

**AsyncFunc** *setTimeout* ile asenkronize ettiğim fonksiyonum. işi bitince kendisine verilen callback fonksiyonunu çağırıyor.

**Runner** asıl sihrin gerçekleştiği yer:

* parametre olarak aldığı generator fonksiyonunu alıyor
* aldığı generator fonksiyonunu yaratıyor
* fonksiyonun parametre olarak aldığı callback tanımlanıyor
* callback içinde generator'ın devam etmesi ve veriyi dışarı gönderebilmesi için **next(...)** tanımlanıyor
* kendi kendini başlatan **next()** tanımlanıyor

**program.js** de ise çalıştırmak sadece çalıştırılacak generator fonksiyonunun tanımı mevcut. Runner'a parametre olarak bu fonksiyon gönderiliyor. İçinde:

* dışarıdan parametreyle gelen callback handle'ı **asyncFunc**'a geçilir.
* **asyncFunc** işini bitince devam edebilmesi için **yield** ile çağrılır.
* bu işlem farklı bir parametreyle tekrarlanır.

## Promises ##

Bu konuyu en iyi özetleyen budur herhalde:

<https://www.youtube.com/watch?v=hUFPooqKllA> asdfasdfasdffds

Şaka bir yana generators konusununu iyiyce anladıktan sonra **promise** o kadar da karışık değil. **Promise**ler de tıpkı generator'lar gibi asenkron yapıları kurmamıza yardım ederler. Ama bunu generator'ların karmaşıklığından uzak yapabiliriz. Hemen örnekle konuya dalıyorum.

~~~js
function asyncFunc() {
    return new Promise( function(resolve,reject){
        // işimiz bittiğinde resolve(...) veya reject(...)
        // callbacklerini çağırmamız lazım
    });
}

var p = asyncFunc();

p.then(
    function(){
        // sonuç başarılı :)
    },
    function(){
        // hata var :(
    }
);
~~~
<br />

**Promise'in genel özellikleri:**

* sadece resolve veya reject tetiklenir
* birden fazla kez tetiklenme ihtimali yoktur
* promise resolve olursa success mesajı gönderir ve biz bunu success callback'ten alabiliriz
* ya reject yoluyla ya da beklenmeyen javascript hatası oluştuğunda bunu error callbackten alabiliriz

**helpers.js:**

~~~js
exports.AsyncAdd2 = function(initialValue) {
  return new Promise(function(resolve,reject){
    console.log('asyncAdd2 enter');
    setTimeout(function () {
      resolve({message: 'asyncAdd2 exit', value: initialValue + 2});
    }, 1000);
  });
}

exports.AsyncMul2 = function(initialValue) {
  return new Promise(function(resolve, reject) {
    console.log('asyncMul2 enter');
    setTimeout(function () {
      resolve({message: 'asyncMul2 exit', value: initialValue * 2});
    }, 1000);
  });
}

exports.ErrorFunc = function(initialValue) {
  return new Promise(function (resolve, reject) {
    console.log('errorFunc enter'); // (1)
    throw 'error happenned';        // (2)
    // reject(Error('error happenned in errorFunc'));
    // resolve(JSON.parse("This ain't JSON"));
    setTimeout(function () {
      throw 'error happenned';      // (3)
      resolve('errorFunc exit');
    }, 1000);
  });
}
~~~

**program.js:**

~~~js
var asyncAdd2 = require('./helpers.js').AsyncAdd2;
var asyncMul2 = require('./helpers.js').AsyncMul2;
var errorFunc = require('./helpers.js').ErrorFunc;

var p = asyncAdd2(1);

p.then(function (ctx) {
  console.log(ctx.message);
  console.log(ctx.value);
  return ctx.value;
}).then(function (result) {
  return asyncMul2(result);
}).then(function (ctx) {
  console.log(ctx.message);
  console.log(ctx.value);
  // throw 'thats a new error';   (4)
}).then(
  errorFunc
).catch(function(error){
  console.error(error);
}).then(function () {
  console.log('end of execution...');
});
~~~

<br />
**Çıktısı:**

~~~
asyncAdd2 enter
asyncAdd2 exit
3
asyncMul2 enter
asyncMul2 exit
6
errorFunc enter
error happenned
end of execution...
~~~

<br />

**Neler oluyor?**

* helpers.js'te *Promise* döndüren function'larımız var
* bunları **then** kullanarak çağırıyoruz
* **then**'ler birbirine bağlanabiliyor ve bağlananlar da birer promise
* **resolve** ile gönderdiğimiz veriyi **then** içinde parametre olarak alabiliyoruz. sonucu *return* ile sonraki promise'e parametre olarak geçebiliyoruz.
* **catch** ile hataları yakalıyoruz
* son **then** ile tüm işlemler sonunda yapılacakları belirtiyoruz.

**Hata yakalama kısmındaki açıklamalar:**

1. numaralı satır henüz hata olmadığı için çalışır
2. numaralı satır hata fırlatıyor. **catch** tarafından yakalacak. bu satır yerine aşağıdaki **reject** veya diğer satır da kullanılabilirdi.
3. numaralı satır setTimeout içinde olduğundan **catch** tarafından yakalanamıyor. bu duruma tekrar döneceğiz.
4. numaralı satır açılırsa da **catch** içinde *başarıyla* yakalanır

### Promise.all ###

İçine verilen tüm promise'lerin işinin bitmesini bekleyebiliriz.

~~~js
var asyncAdd2 = require('./helpers.js').AsyncAdd2;
var asyncMul2 = require('./helpers.js').AsyncMul2;

Promise.all([
  asyncAdd2(),
  asyncMul2()
]).then(
  function (results) {
    console.log(results[0]);
    console.log(results[1]);
    console.log('success');
  },
  function (error) {
    console.error(error);
  }
);
~~~

<br />

**Çıktı:**

~~~
asyncAdd2 enter
asyncMul2 enter
{ message: 'asyncAdd2 exit', value: 2 }
{ message: 'asyncMul2 exit', value: 0 }
success
~~~

### Promise.race ###

Promise.all gibi ancak içlerinden hangisi daha önce biterse onun sonucu döner.

~~~js
var asyncAdd2 = require('./helpers.js').AsyncAdd2;
var asyncMul2 = require('./helpers.js').AsyncMul2;

Promise.race([
  asyncAdd2(),
  asyncMul2()
]).then(
  function (result) {
    console.log('and the winner is: ');
    console.log(result.message);
  },
  function (error) {
    console.error(error);
  }
).catch(function (error) {
  console.error(error);
});
~~~

<br />
**Çıktı:**

~~~
asyncAdd2 enter
asyncMul2 enter
and the winner is:
asyncMul2 exit
~~~

> Helper metotlarının setTimeout değerlerini değiştirerek deneyin

## Generators & Promises ##

Şimdi size **Promise**'leri **Generator**'lar ile birlikte kullanıldığında nasıl kolaylık sağladığını göstereceğim.

**helpers.js**

~~~js
var Promise = require('bluebird');

module.exports.spawn = function spawn(generatorFunc) {
  function continuer(verb, arg) {
    var result;
    try {
      result = generator[verb](arg);
    } catch (err) {
      return Promise.reject(err);
    }
    if (result.done) {
      return result.value;
    } else {
      return Promise.resolve(result.value).then(onFulfilled, onRejected);
    }
  }
  var generator = generatorFunc();
  var onFulfilled = continuer.bind(null, "next");
  var onRejected = continuer.bind(null, "throw");
  return onFulfilled();
};

function MyCustomError(message) {
  this.message = message;
  this.name = "MyCustomError";
  Error.captureStackTrace(this, MyCustomError);
}

MyCustomError.prototype = Object.create(Error.prototype);
MyCustomError.prototype.constructor = MyCustomError;

module.exports.MyCustomError = MyCustomError;

module.exports.delay = function(ms, func, errorType, reject) {
  var args = Array.prototype.slice.call(arguments, 4);
  return Promise.delay(ms).then(function() {
    func.apply(null, args);
  }).catch(errorType, function(err) {
    reject(err);
  }).catch(function(err){
    // tanımlıysa diğer tipteki Error'ları yut
    if(!errorType){
      reject(err);
    } else {
      console.error(err);
    }
  });
};
~~~

**app.js:**

~~~js
var spawn = require('./helpers').spawn;
var MyCustomError = require('./helpers').MyCustomError;
var delay = require('./helpers').delay;

var promiseFunction = function(name, ms, throwError){
  return new Promise(function(resolve, reject){
    delay(ms, function(throwError) {
      if(throwError)
        throw new MyCustomError(name);
      resolve("Resolved: " + name);
    }, MyCustomError, reject, throwError);
  });
};

spawn(function *() {
  try {
    var a1 = yield promiseFunction('async 1', 1000);
    console.log(a1);
    var a2 = yield promiseFunction('async 2', 1000);
    console.log(a2);
    var a3 = yield promiseFunction('async 3', 1000, true);
    console.log(a3);
  }
  catch (err) {
    // try/catch just works, rejected promises are thrown here
    console.error("Error handled: (" + err + ')');
  }
});
~~~

<br />

Çıktısı:

~~~
Resolved: async 1
Resolved: async 2
Error handled: (MyCustomError: async 3)
~~~

<br />
Şimdi n'aptık n'oldu WTF!?

* **generator** pattern'i kullanarak **Promise**'lerimizi *then* *then* diye bağlamak zorunda kalmadık.
* *Sync* kod ile *async* kodu bir güzel birleştirebildik.

Peki nasıl yaptık?

* **bluebird** adında yeni bir *Promise* kütüphanesi kullandık
* **spawn** adında bir helper fonksiyonu yazdık ki bu fonksiyon *generator*'ı yaratıp *next*'i çağırıyor ve dönen *promise*'in bir sonraki *promise*'e bağlanmasını sağlıyor
* **Promise.delay** fonksiyonunu **bluebird**'den aldık. *setTimeout* oluşan hataları yutuyordu ve bunları yakalamak için ayrı *try catch* yapıları kullanmamız gerekiyordu. Şimdi hataları *promise*'lerdeki gibi yakalayıp **reject** etmemiz gerekiyor.
* javascript'te *try catch* yapılarında hataların tip kontrolünü C#, Java gibi *strong-typed* dillerdeki gibi yapamıyorduk, burada **bluebird** bize tip kontrolü imkanı verdi.
* kendimize **delay** adında helper bir function yazdık. Error handling için kod yazdık. Yakalamak istediğimiz *Error* tipini ve **reject** fonksiyonunu gönderdik.

> NOT: **bluebird** bize **spawn** fonksiyonunu [Promise.coroutine](https://github.com/petkaantonov/bluebird/blob/master/API.md#promisecoroutinegeneratorfunction-generatorfunction---function) vasıtasıyla zaten veriyor, ama kütüphane kullanmak istemezsek diye veya nasıl çalıştığı hakkında bir bilgimiz olsun diye buraya koymak istedim.

> NOT: burada **bluebird** ile kullandığım örnekleri üç aşağı beş yukarı diğer pek çok promise kütüphanesi de sunuyor. Örnek olması açısından bunu da göstermek istedim.

## Let ve Const ##

### Let ###

**let** aynı **var** gibi değişken tanımlamamızı sağlar. ama bu sefer bu tanım sadece içinde bulunduğu **kavram** (scope) içinde geçerli olacaktır.

**var**ın scope'e tanımlı en yakın fonksiyonken (fonksiyon içinde değilse globaldir), **let** tanımlı en yakın scope/block'a aittir. bu **if**, **for**'larda gördüğümüz { .. } parantezleri de olabileceği gibi düz parantez de bir scope'tur.

~~~js
for (let i=1; i<=5; i++) { // --> scope
    { // --> scope
    	let a=3;
    	...
    }

    console.log(i);
    console.log(a); // ReferenceError: `a` is not defined
}
~~~

Ee? Nolmuş yani bu gerçek hayatımızda ne işe yarayacak?

~~~js
for (var i=1; i<=5; i++) {
    setTimeout(function(){
        console.log("i:",i);
    },i*1000);
}

// 6 6 6 6 6

for (let i=1; i<=5; i++) {
    setTimeout(function(){
        console.log("i:",i);
    },i*1000);
}
~~~
// 1 2 3 4 5

**for** içinde **let** kullandığımızda aslında şuna dönüşmüş oluyor:

~~~js
{ let k;
    for (k=1; k<=5; k++) {
        let i = k; // --> her döngü için yeni bir `i`
        setTimeout(function(){
            console.log("i:",i);
        },i*1000);
    }
}
~~~

Ayrıca bu kullanımın memory açısından faydası olacağı kesindir. Bilahare kod içinde karışıklık ve potansiyel bugların önüne geçmek adına, her zaman global/genel değişkenlerden uzak durmalıyız. Gelecekte kodun bakımı sırasında yol gösterecek, bozulmayı önleyecek şekilde kod yazmalıyız.

### Const ###

**let**'den daha güzel birşey varsa o da herhalde **const**'tur. Çoğu fonksiyonel programlama dilinde verilerin değişmemesini kontrol eden yapılar vardır. JavaScript'te de değişmeyen veriler için **const** kullanabiliriz.

~~~js
const myVar = 5;

myVar = 10 // Hata fırlatır

console.log(myvar) // 5
~~~

Görüldüğü gibi tekrar atama yaptığımızda hata alıyoruz ve eski değerimiz böylece korunuyor. Ama daha kompleks veri tiplerine geçtiğimizde işler düşündüğümüz gibi olmuyor.

~~~js
const myObject = { nick: 'dhalsim', age:'32' };

myObject = { nick: 'dhalsim', age:'22' }; // Hata fırlatır

myObject.age = 22; // Hata falan fırlatmaz

console.log(myObject) // { nick: 'dhalsim', age:'22' }
~~~

Yeni atama yapamasak da verinin değişmesine engel olamıyoruz. Eğer öyle bir niyetiniz varsa [https://facebook.github.io/immutable-js/](Immutable.js) veya [http://swannodette.github.io/mori/](Mori) gibi gerçek immutable veri yapıları kütüphanelerine bakmalısınız.
