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

`Object.create` ile birlikte ilginç bir özellik daha kullanabiliyoruz, o da **prototype**. Şimdi yine çok gördüğümüz ama hiç anlamadığımız bir konu geldi ya la.

# Prototype

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

Triangle.prototype = Shape.prototype;
Triangle.prototype.constructor = Triangle;

var triangle = new Triangle("Dik üçgen");
console.log(triangle.name);
console.log(triangle.area());
~~~

Ne bu? Aa object oriented. Ama prototype-based. (Her ne kadar ES6'da class gelse de) Javascript'in diğer OO dillerindeki `class` gibi bir yapısı olmadığından obje üzerinden inheritance sağlar. 

Burada `this.edges` nasıl çalıştı diye soracak olursak; Triangle prototype ile Shape'den türediği için aslında `Shape.prototype.area` Triangle context'iyle çalıştı.

> Bu arada context'i çok andım [şuna](https://eksisozluk.com/entry/7225385) link vermezsem olmaz.

this ve prototype ile ilgili bir başka örnek:

~~~js

~~~

# Bind



