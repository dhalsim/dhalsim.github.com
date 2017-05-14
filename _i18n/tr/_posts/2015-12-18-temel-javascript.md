---
layout: post
title: "Temel Javascript"
description: "Bu sayfada javascript'te bilinmesi gerekli ama çoğu zaman ayrıntılı bilgi sahibi olunmayan temel konular hakkında yazıyorum."
toc: true
category: ["javascript"]
tags: ["javascript", "this", "new", "property", "prototype", "call", "apply", "bind"]
excerpt: "Javascript öyle garip bir dil ki çoğu insan dilin en temel özelliklerini bilmeden onu kullanabilir. Çoğu zaman da öğrenmemiz gerekmez ancak bunları öğrenmeden de çok fazla ileri gidemeyiz. Bu yazıda javascript'in çok görünen ama bilinmeyen temellerine iniyoruz.."
image: "/assets/images/js.jpg"
---
{% include JB/setup %}

> Javascript öyle garip bir dil ki çoğu insan dilin en temel özelliklerini bilmeden onu kullanabilir. Çoğu zaman da öğrenmemiz gerekmez ancak bunları öğrenmeden de çok fazla ileri gidemeyiz. Bu yazıda javascript'in çok görünen ama bilinmeyen temellerine iniyoruz.

# This

**this** javascript'te bir fonksiyonun çağrıldığı context'ini vermektedir. Eğer fonksiyon `global` objeden çağrılmışsa **this** global objeyi gösterir. Tarayıcılarda bu global obje `window` nesnesidir.

*Tanımlandığı* değil de *çağrıldığı* yer olarak üzerinde durmamım nedeni bunun farklı şeyler olmasıdır. Örneğin:

~~~js
var obj = {
	arg1: 10,
	f: function() {
		console.log(this.arg1);
	}
};

var obj2 = { arg1: 11 };

obj.f(); // --> 10 yazar
obj2.f = obj.f;
obj2.f(); // --> 11 yazar
~~~

`obj2.f = obj.f` diyerek `f` fonksiyonunu bağlamından kopardık ve `obj2`'ye setledik. `obj2` üzerinden çağırdığımızda **this** artık `obj`'yi değil `obj2`'yi gösteriyordu. Yani **this** çağrıldığı yere göre dinamik olarak oluşan bir context'tir. Bu context'e (bağlama) **this** **keyword**'ü üzerinden erişiz.

Bu demek oluyor ki **this**'e çok güvenip bir şeyler yazarsanız bazı durumlarda bu problemlere yol açabilir.

~~~js
var obj = {
	helperFunc: function() {
		return "yardımcı kütüphane";
	},
	workerFunc: function() {
		var utilValue = this.helperFunc();
	}
};

var workFromHere = obj.workerFunc;
workFromHere(); // --> TypeError: this.helperFunc is not a function
~~~

Bunun için bir çözüm var o da **bind**. Ama bu konuya sonra bakacağız.

Şimdi **this** ile ilgili başka bir keyword'e **new**'a balalım:

# New

**new** constructor fonksiyonunu kullanmak içindir. Parametre geçirebilirsiniz veya geçirmeseniz de olur. Dönen obje artık yeni bir objedir. Her **new** yeni bir kopya oluşturur.

~~~js
function Triangle(name) {
	this.name = name;
}

var triangle = new Triangle("Üçgen");
var triangle2 = new Triangle("Üçgen2");
console.log(triangle.name);
console.log(triangle2.name);
~~~

Aynısını ES5 ile gelen `Object.create` ile de yapabiliyoruz. Yani illa bir fonksiyon olmasına gerek yok.

~~~js
var shape = {
	name: "Şekil"
};

var triangle = Object.create(shape);
triangle.name = "Üçgen";

console.log(shape.name);
console.log(triangle.name);
~~~

Mesela şu iki objenin farklarına bir bakın:

~~~js
var myObj = Object.create(null, {name: { value: "Barış" }});
console.log(myObj);
var myObj2 = { name: "Barış" };
// ya da:
// var myObj2 = Object.create({ name: "Barış" });
console.log(myObj2);

console.log(myObj instanceof(Object));
console.log(myObj2 instanceof(Object));
~~~

> Function değil Object yaratırken Object.create'de prototype'ı karıştırmayın, prototype daha çok Function'larda kullanılır.

create metodunun ilk parametresini `null` vererek aslında Object'ten türememesi sağladık. Bunun tabii ki ilginç sonuçları var. Bir nesne Object'ten türemediğinde mesela şunu yapamıyoruz:

~~~js
for(var x in myObj) {
   console.log(x);
}
~~~

`Object.create` ile birlikte ilginç iki özellik daha kullanabiliyoruz, bunlardan biri **property**, diğeri de önceden tanıdığımız ve sevdiğimiz **prototype**.

# Property

Yeni yaratılan bir obje için:

> Object.create(proto[, propertiesObject])

Zaten var olan bir objeye property eklemek için:

> Object.defineProperty(obj, prop, descriptor)

Property'nin özellikleri:

* value: property'nin değeri
* writable: (varsayılan false) false ise o property'ye setleme yapılamaz (immutable)
* enumerable: (varsayılan false) false ise Object.keys'te veya for..in'de kullanılamaz
* configurable: (varsayılan false) false ise property'nin bu özellikleri sonradan değiştirilemez veya property silinemez
* özel set: property'ye atama verilen fonksiyon üzerinden yapılır
* özet get: property'nin değeri verilen fonksiyon üzerinden döndürülür.

Define property ile ilgili örnekler: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty>

Object.create ile birlikte kullanımı: <https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/create#Using_propertiesObject_argument_with_Object.create()>

# Prototype

> **Prototype chain**: If you try to look up a key on an object and it is not found, JavaScript will look for it in the prototype. It will follow the "prototype chain" until it sees a null value. In that case, it returns undefined

~~~js
function Shape(name) {
	this.name = name;
}

Shape.prototype.area = function () {
	return this.edges[0] * this.edges[1] / 2;
}

function Triangle(name) {
	Shape.call(this, name);
	this.edges = [3, 4, 5];
}

// Burada object create diyerek yeni bir obje yaratılmış oluyor.
// Kullanmasaydık Triangle prototype ile Shape prototype aynı nesneyi gösterecekti
// Bu yüzden Triangle'a özel prototype fonksiyonları tanımlayamayacaktık (Otomatik Shape'e de tanımlanırdı)
Triangle.prototype = Object.create(Shape.prototype);
Triangle.prototype.constructor = Triangle;

var triangle = new Triangle("Dik üçgen");
console.log(triangle.name);
console.log(triangle.area());
~~~

Ne bu? Aa object oriented. Ama prototype-based. Her ne kadar ES6'da **class** keyword'ü gelse de (syntax olarak değişse bile temelde yapı aynı) Javascript'in diğer OO dillerindeki `class` gibi bir yapısı olmadığından obje üzerinden inheritance sağlar.

Burada `this.edges` nasıl çalıştı diye soracak olursak; Triangle prototype ile Shape'den türediği için aslında `Shape.prototype.area` Triangle context'iyle çalıştı.

> Bu arada context'i çok andım [şuna](https://eksisozluk.com/entry/7225385) link vermezsem olmaz.

~~~
...
Shape.call(this, name);
...
console.log(triangle.name);
~~~

Burada da Shape'in constructor'ını Triangle'ın this'ini geçirerek çağırdık ve Shape içindeki this'e olan atama aslında Triangle'a olmuş oldu. Ve bu bize yepyeni konuları açtı: **call**, **apply**, ve **bind**

# Call ve Apply

Eğer **call**'u anlarsak **apply**'ı da anlayacağız, ikisi de aynı şey aslında.

> fun.call(thisArg[, arg1[, arg2[, ...]]])

> fun.apply(thisArg, [argsArray])

İkisinde de ilk parametre *thisArg*, call'da diğer parametreleri sırayla geçirirken apply'da kalan parametreler bir array içinde geçirilebiliyor. Uygun durumlarda bunlardan birini seçip kullanabilirsiniz. Örneğin prototype hiyerarşisini sağlayabilmek için parent/üst constructor'ı call ile çağırdık. Bu *this* argümanını geçirebilmek için gereklidir.

Peki apply ne işe yarayacak. apply benim gördüğüm kadarıyla javascript framework'ü yazanlar için oldukça kullanışlı. Özellikle **arguments** değişkeniyle birlikte kullanıldığında. Örneğin aşağıdaki koddaki **loggerFunc** varolan herhangibir fonksiyonun parametrelerini ve sonucunu yazdırır.

~~~js
var testFunc = function(arg1, arg2, arg3) {
		return arg1 + arg2 + arg3;
};

loggerFunc = function(originalFunc) {
	return function() {
		// fonksiyon parametrelerini yazdır
	  console.log(arguments);

		// orijinal fonksiyonu çalıştır
	  var result = originalFunc.apply(this, arguments);

		// sonucu yazdır
		console.log(result);

		// sonucu döndür
		return result;
	};
}

var wrapped = loggerFunc(testFunc);
wrapped(3, 4, 5);
~~~

# Bind

> fun.bind(thisArg[, arg1[, arg2[, ...]]])

Bind ise yine **apply** ve **call** gibi parametrelerin setlenmesini sağlar ancak bu sefer fonksiyonu direkt çalıştırmaz, yerine; verilen parametrelerin hazır setli bir versiyonunu yeniden üretir. bind'dan dönen değer yine bir fonksiyondur ve siz istediğiniz zaman çağırabilirsiniz. Çağırdığınızda, önceden setlediğiniz parametrelerle çalışacaktır.

~~~js
function test(arg1, arg2, arg3) {
		this.arg1 = arg1;
		this.arg2 = arg2;
		console.log(arg3);
}

var results {};
var testWithBind = test.bind(results, 1, 2);
testWithBind(3); 			// 3
console.log(results); // 1, 2
~~~

Gördüğünüz gibi **this** yerine **results** objesini geçirdim, böylece arg1 ve arg2 results objesine setlendi. Aynı zamanda bind ile 1 ve 2 parametrelerini de setledim. İlk iki parametre artık verdiğim değerlere bağlı bir şekilde çalışacak. O yüzden testWithBind fonksiyonunu tek parametreyle çağırdığım halde bu arg3 parametresine denk geldi.

> Eğer eski tarayıcı sürümlerine bağımlılığınız varsa (müşterilerinizin bir kısmı IE 7/8 kullanıyor olabilir, şu siteden kullanacağınız özelliği kontrol etmekte ve gerektiği durumlarda polyfill kullanmakta yarar var. <http://kangax.github.io/compat-table/es5/> (Show obselete browsers seçeneğini seçin)

> Denk geldikçe bu yazıya javascript'le ilgili bilinmesi gereken temel konuları ekleyeceğim.
