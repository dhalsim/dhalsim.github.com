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

**new** constructor objesini kullanmak içindir. Parametre geçirebilirsiniz veya geçirmeseniz de olur. Dönen obje artık yeni bir objedir. Her **new** yeni bir kopya oluşturur..

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

> Object.create(proto[, propertiesObject])

İkinci opsiyonel parametrede *propertiesObject* var peki bu property ne oluyor? 



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

# Call, Apple ve Bind

