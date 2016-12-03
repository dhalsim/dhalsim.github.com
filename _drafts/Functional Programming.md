# Functional Programming

> TL;DR is: it is simple, although very different to what you see and learn, so is difficult to understand. But at the same time very beneficial and fun. So give attention especially to the theories behind, you won't regret it. 

> Bonus: While you are learning functional programming, you can use the principles you learned in a non-functional language. You will see the benefits and you'll want to use it more and more.

# Functional Programming in General

## Differences with Non-functional Programming

There is no shortcut without making definitions (sorry)!

> What is Functional Programming

C#, Java, C gibi imperative paradigm kullanılarak yazılan programlardan farklı olarak olarak declaritive paradigma kullanır. Evet tanım yapacak 2 terimimiz daha oldu (sorry)!

> What is Imperative Programming

* Değişken tanımı olması. Program süresince değişebilen durumların izlenebilmesi, tutulması.
* Atama işleminin
* ve kontrol yapılarının (if-then-else, döngüler, break, continue, return gibi) olması.

Örnek vermek gerekirse, bir programın nasıl çalıştıracağını adım adım değişken, atama işlemleri ve kontrol yapılarını kullanarak anlatmak. 

"Bunlar olmadan zaten nasıl anlatabiliriz ki?" diye soruyorsanız da şimdiye kadar okulda, işte yazılımı zaten hep böyle geliştiriyor olmak ve bunun dışında bir yol olduğunu duymamak çok sık görülen bir durum. Bu nedenle öğrenilenlerin unutulması gerektiği durumlar oluyor ve programlamaya sıfırdan girenlerin bu anlamda daha çabuk fonksiyonel programlayı anlayıp kullanabildiği görülüyor. Bunu göz önüne alıp bu işe girişmek gerektiği kanısındayım.

> What is Declerative Programming

En can alıcı ve açıklayıcı olarak düşündüğümden doğrudan SQL örneğiyle başlıyorum. Evet, SQL declaritive'dir. Kelime anlamıyla; sadece açıklar. Ne istediğini söyler, ama nasıl istemesi gerektiyle ilgilenmez ve hatta bilmez bile. Bu cümlede de aslında soyutlamanın tanımını yapmış olduk. 

> Soyutlama neden önemli?

    “Programs must be written for people to read, and only incidentally for machines to execute.” Harold Abelson
    
Abartılı bir ifade olsa da, neden programlamada makine kodu kullanmadığımızın belki nedenlerinden de biridir. İnsan beyninin aynı anda 3, 4 özelliği işleyebildiğinden her zaman soyutlamaya ihtiyaç duyarız. Yazılan kodun sürekli gözden geçirilmesi ihtiyacından dolayı da soyutlama çok elzemdir. Aksi durumda kompleks sistemlerin geliştirmesini ve bakımını devam ettiremeyiz.

> Paradigma nedir

Kabul edilmiş kurallar bütünüdür. Fonksiyonel programlama paradigması dediğimizde de aslında fonksiyonel dillerde kullanılmasının kolaylaştırıldığı belli başlı kuralların (sayısı çok değil) daha etkin kullanılmasının çalışılmasıdır.

> Fonksiyonel olmayan nedir?

Imperative dillerde, mesela object-oriented programlama dillerinin çoğunda bu kurallar zorunlu değil hatta kendi üzerinde bundan uzaklaştırıcı etkisi bulunur. Halbuki object-orinted prensipleri ve patternleri dediğimiz kuralların da son olarak çıkacağı bu noktadadır.  

> Fonksiyon nedir?

Hepimizin lisede gördüğü fonksiyonlardır. Aslında bilimdir. Ve kuralları da çok az ve basittir. Google'dan 9. sınıf matematikte yaptığı tanımı aynen alıyorum:

A ve B boş olmayan iki küme olsun. A’nın her elemanını B’nin yalnız bir elemanına eşleyen A’dan B’ye bir f bağıntısına, A’dan B’ye bir fonksiyon denir.

Fonksiyon olması için;

1) A’nın her elamanı B’ye gidecek.
2) A kümesinde açıkta eleman kalmayacak.
3) A’nın herhangi bir elamanı B’ye iki defa gitmeyecek.

> Fonksiyonel programlama nedir?

Matematikteki fonksiyonun özelliklerini ve kurallarını kullanarak programlama yapmaktır. Tanımı bu kadar az ve öz!

> Faydaları

Pratikte faydaları gerçekten çok fazla. Programlamayı bu seviyede matematiksel olarak yaptığınızda arkanıza matematiği ve nimetlerini alarak çok güçlü yapılar kurabilme imkanına kavuşuyorsunuz.

Ve bizim hem günlük işlerimizde (varolan sistemin bakımı, zaman içerisinde yeni özelliklerin yapılabilmesi veya baştan yazılan büyük projelerde yine zaman içerisindeki tıkanmalar) hem de bilhassa ölçeklendirme anlamındaki (günümüzde çoğu geliştirilen yazılımın çok kullanıcıya aynı anda cevap vermesi gerekmekte oluşundan kaynaklı) zorluklarda bize faydaları oluyor. 

> Şimdiye kadar neden kullanılmıyordu

Yeni yeni moda olmaya başladığı doğrudur. Bunun tarihsel kısmına çok girmek istemiyorum o yüzden kabaca şöyle açıklayacağım. Eskiden bu programların çalıştığı donanımlar pahalı ve yeterince performanslı değildi. Bu yüzden programların çok verimli çalışması gerekiyordu. 

Mesela C'nin makine diline çok yakın olması ([mesela](http://stackoverflow.com/questions/252552/why-do-we-need-c-unions)) ve bu nedenle de performans açısından avantajlı olması nedeniyle tercih edilmesi örnek olabilir. Garbage collection, VM gibi kavramlar bile çok sonradan hayatımıza girmiştir. 

Fonksiyonel diller de bunun yanında makine dillerininki gibi optimizasyonlara olanak vermediğinden tercih edilmiyordu.

Neden sonra donanımların hızlanması ve ucuzlamasıyla biz bu teknikleri kullanabilmeye başlayabiliyoruz. İlk fonksiyonel programlamanın 1960'larda başladığını düşünürsek uzun yıllar sadece akademik alanda kullanıldığını söyleyebiliriz. Buna rağmen son dönemdeyse dağıtık sistemlerin kullanımının artmasıyla ihtiyaç haline gelmiştir bile diyebiliriz. 

İyi bildiğimden söyleyebilirim ki Microsoft son dönemde F#'ı yapması yanında C#'a da sürekli fonksiyonel özellikleri ekliyor (Lambda, Linq, closures, Extensions, Read-Only Auto-Properties, mmutable Collections ve [devamı](https://github.com/dotnet/roslyn/issues/2136)). Aynı şekilde Javascript'te de fonksiyonel tarzda kullanım artıyor (unserscrore.js, Rambda.js, RxJS).

> Dolaylı faydaları

* Kodunuzun test edilmesi çok kolaydır
* Bir yerde yazdığınız kodun başka bir yerde daha kullanılması daha kolay
* Dolaylı olarak basit fonksiyonlar yazmaya ve bunları birleştirerek karmaşıklığı oluşturmanıza teşvik eder. Fonksiyon gibi basit yapılarla abstractionlar oluşturursunuz.
* Bağımlılıkları doğru oluşturmanızı sağlar, büyük projelerde önemlidir.
* Multi-core, distrubuted hesaplamalar için uygun
* Lazy, concurrent hesaplamalar için uygun
* Optimize etmeye uygun
* Mutable yapılara izin vermediğinden "the code is easy to reason about"
* Global state izin vermediğinden hata oluşma ihtimali daha az

> Nasıl?

Çok basit: bunu yazılım dünyasında pure function'larla yapabiliyoruz.

Pure function özellikleri:

* Mutlaka bir değer dönecek
* Sadece parametre ile verilen değerlere erişimi var.
* Gönderilen parametreler üzerinde bir değişiklik yapmayacak

Bu özellikleri sağlayan bir fonksiyon yazdığınızda, hangi dilde yazarsanız yazın bu pure function olur. Bu fonksiyonların içerisini de bu şekilde yazdığınızda zaten fonksiyonel programlama yapmış oluyorsunuz.

Fonksiyonun içinin de `fonksiyonel` şekilde olması için atama işlemleri, döngüler gibi yapıları kullanmamamız gerekiyor. Peki bunları yerine ne kullanacağız? Tabii ki `özyineli (recursive)` yapılar kullanmamız gerekiyor.

> Özyineli (recursive) nedir?

Is a method where the solution to a problem depends on solutions to smaller instances of the same problem as opposed to *iteration*.

> Tail-recursive functions

Tail-recursive functions are functions in which all recursive calls are tail calls and hence do not build up any deferred operations. For example, the gcd function (shown again below) is tail-recursive. In contrast, the factorial function (also below) is not tail-recursive; because its recursive call is not in tail position, it builds up deferred multiplication operations that must be performed after the final recursive call completes. With a compiler or interpreter that treats tail-recursive calls as jumps rather than function calls, a tail-recursive function such as gcd will execute using constant space. Thus the program is essentially iterative, equivalent to using imperative language control structures like the "for" and "while" loops.

> Fonksiyonel dillerin sahip olduğu özellikler

Fonksiyonel dillerde de hem bu tarz yazmanız için sizi teşvik eden kuralları ve yasakları oluyor, hem de fonksiyonları first-class citizen dedikleri şekilde değer olarak kullanabilmenize olanak veriyor.

* First-Class ya da High-Order Functions
* Pure Functions
* Closures
* Immutable State

> First-class ya da High-order functions da ne ola ki?

Supporting passing functions as arguments to other functions, returning them as the values from other functions, and assigning them to variables or storing them in data structures.

They can be defined anywhere, including inside other functions. Like any other value, they can be passed as parameters to functions and returned as results. As for other values, there exists a set of operators to compose functions.

> Closure da ne ki?

A closure is an inner function that has access to the outer (enclosing) function's variables—scope chain

> Curry

> Immutable, buyur!

An immutable object (unchangeable object) is an object whose state cannot be modified after it is created.

If we want to implement high-level concepts following their mathematical theories, there's no place for mutation.

> Object-oriented'dan farkı ne?

Object-oriented programlama dilleri de bize bir takım abstraction yöntemleri önermektedir. Desing patterns dediğimiz şey de aslında budur. Aynı şekilde SOLID prensiplerini düşündüğümüzde aynı kapıya çıkıyoruz.

Object-oriented ve functional programming arasında benzer kısım ise object-oriented dillerdeki *dynamic dispatch of methods* yani bize *polymorhism* imkanını sunan yapı, functional dillerdeki *higher-order functions* kullanılarak birbirlerinin yerine geçebilir.

* *higher-order functions* kullanarak nesneleri
* nesneleri kullanarak *higher-order functions*

yapılarını implement edebilir miyiz?

~~~cs
using System;
					
public class Program
{
	public static void Main()
	{
		Arac arac = new Araba();
		Arac arac2 = new Doblo();
		
		arac.Sur(2);
		arac2.Sur(3);
	}
}

abstract class Arac 
{
    public abstract void Sur(int x);
}

class Araba : Arac 
{
	public override void Sur(int x)
	{
		Console.WriteLine(x + " araba vınn");
	}
}

class Doblo : Arac 
{
	public override void Sur(int x)
	{
		Console.WriteLine(x + " doblo vınn");
	}
}
~~~

~~~scala
object test {
  def arabaSur(x: Int): Unit = println(x + " araba vınn")

  def dobloSur(x: Int): Unit = println(x + " doblo vınn")

  def sur(surFunc: Int => Unit)(x: Int): Unit = surFunc(x)

  def main(args: Array[String]): Unit = {
    val surFunc = sur(arabaSur) _
    val surFunc2 = sur(dobloSur) _

    surFunc(2)
    surFunc2(3)
  }
}
~~~

İki farklı yaklaşımın aslında nasıl da aynı kapıya çıktığını yukarıdaki örneklerden görebiliriz. Burada tabii Scala hem functional hem de object-oriented bir dil olduğu için *traits* denen inheritance öğelerini de kullanabilirdik ama functional konseptine uymazdı. 

Fonksiyonel programlama dillerinde ise bu abstaction'ı bize basit matematiksel fonksiyonlar kullanarak yapabilmemize olanak veriyor. Çoğu fonksiyonel dil, bir çok yararlı data tiplerini de bütünleşik olarak kullanıma sunuyor. (List, Set, Hash gibi yapılar). Bu yapılar aynı kurallara ve aynı araçlarla kullanıma izin verdiğinden, hem bu sadece bu bütünleşik yapıları kullanarak basit ve güçlü programlar yazabiliyorsunuz hem de benzer yapılar geliştirerek çok daha başka özellikleri kolayca programınıza entegre edebiliyorsunuz.


İşte burada tanım yaparak anlayabileceğimiz en uç yere geldik. Çünkü pratik örneklerle görmezsek kavramlar da çok soyut kalmaya başlıyor. Artık kod görerek kavramları yerine oturtmamız lazım.



# Functional Programming in Javascript

Composition of small and simple things forms bigger and more complex things. Complexity on the universe is composed forms of much smaller and simpler components.

And we see that, not only structural but also behavioural differences occurs of composition, like Hydrogen and Oxygen both flammable but water (H20) is extinguisher (at least not flammable).

I don't want to continue on this example, but we have to consider how complexity could be occurred on nature. Composing simple components over time (iteration, evolution).

> *Computer programs are the most intricate, delicately balanced and finely interwoven of all the products of human industry to date. They are machines with far more moving parts than any engine: the parts don't wear out, but they interact and rub up against one another in ways the programmers themselves cannot predict.* - Fred Brooks

So why our programs, which are the most complex systems ever created by humans, can't be constructed by this approach? Mostly because of the heritage of the engineering with too little resources (like 100Hz processor 120Kb of RAM or whatever), all of the structure of our programs must be carefully designed to be performant and economic. And by that time we don't expect much, we don't have search engines and social media.

After the Web all of a sudden, we all entered an era of online communication and business. Now, Huston we have a problem. We can't handle this much demand. So this is called the Software Crisis.

The answer to Software Crisis was Object Oriented Programming, Design Patterns and the tools. Now we can type A and IDE we work on completes it with 

![](/assets/images/no_idea_why.jpg)

https://www.quora.com/What-are-the-key-advantages-of-pure-functional-languages-avoiding-side-effects-in-function-calls-or-other-statements-How-does-it-help-in-programming

https://www.youtube.com/watch?v=ZhuHCtR3xq8

* find quotes about functional programming told by great people on software (states etc.)

## CSP

* RxJS
* <https://www.youtube.com/watch?v=W2DgDNQZOwo>

## Functional programming definition

* Order of execution: <http://stackoverflow.com/questions/31408817/order-of-execution-of-functions-in-functional-programming>

## What side effect is

## Immutablity

Immutable.js

## ES6

* const

## Category

~~~
Quote
You need a composition and identity to form a category

Identity is a function that just returns input unchanged ??

Laws of category:
left identity: when you compose a function with identity and compose identity with a function that would be the same

associativity: c(c(f, g), h) == c(f, c(g, h)) 
End Quote
~~~

## Functor 

~~~
Quote
Any object or data structure you can map over it is a functor
End Quote
~~~

* Maybe Functor

## referential transparency

## memoization vs caching

## side-effects

## curry

Composition can only be done with one arity functions, because a function can only return one result, and that result will be the next input of another. So a function should take one parameter to be composed. 

Currying make functions other than one arity possible to be composed. Other than that it is such a simple and effective tool for reuse.

~~~js
function curry(split(seperator, str) {
	return str.split(seperator);
});
~~~   

## Ramda library

> this example is not good enough

So what the difference is on this library, apart from the classical native functions in javascript for instance, you've got this style of programming:

~~~js
function add2(list) {
	return list.map(function(x) { return x + 2; });
}

function double(list) {
	return list.map(function(x) { return x * 2; });
}

console.log(double(add2([1, 2, 3])));
~~~

Or we could just have written this:

~~~js
function add2(x) {
	return x + 2;
}

function double(x) {
	return x * 2;
}

console.log([1, 2, 3].map(function(x) { return double(add2(x)); });
~~~

So this is some functional programming, no global state or mutations in place, but composition of functions isn't the most efficiant one. You can easily see we are iterating the list twice.

But the main advantage of functional programming is composition of functions itself but native implementation of these functions in javascript don't let you that way. Lets see how you can establish this with Ramda:

~~~js
var _ = require('ramda');

var add2 = _.add(2);
var double = _.multiple(2);

console.log(_.map( _.compose(double, add2), [1, 2, 3] ));
~~~

We simple applied this law to our code.

~~~js
// map's composition law
var law = compose(map(f), map(g)) == map(compose(f, g));
~~~

Beside the already available functions, you can extend and combine them easily because function parameter signatures are always functions first, data last. You can **curry** (built-in curring support) and generate new functions from the original one, to use it again whenever you want, and combine with others.

<http://ramdajs.com/0.19.0/index.html>
<http://fr.umio.us/why-ramda/>
<https://cwmyers.github.io/monet.js>

## Maybe functor

Schrodingers cat

## Either functor

## Monads

<https://youtu.be/ZhuHCtR3xq8?t=59m49s>

* g: a -> Mb
* f: b -> Mc

To compose these guys, we need a function that called bind operator is just `Mb -> (b -> Mc) -> Mc`

## Signatures

### Identity Monad Examples

**Notation:**

For clarity, I'll use Haskell type notation on top of functions with comments. It is simple and precise. Lets see some examples:

* `a -> b` in this function, it takes an input of type `a` and outputs a result of type `b`. You can think of *a* and *b* as *Int* and *String*.
* `a -> b -> c` this one takes input parameters of the `a` and `b`, and outputs a result of type `c`. Note that most of the functions I'll use will be curried, which means you can give parameters one by one until it gets all the necessary inputs. Before that you'll get a new function which expects missing parameters. see the `curry` function for implementation. For example you only give the first parameter `a` then its notation would be like this: `a -> (b -> c)` and can be interpreted like "this function expect a parameter of type `a` and returns a new function which expects a parameter of type `b` and outputs a result of type `c`"
* `(a -> b) -> c` this one is not curried because it is simply a function with one *arity* (number of parameters) and currying only occurs for the last part. So I can interpret it like this: it takes an input of a function which accepts a parameter of type `a` and outputs result of type `b`, and finally returns a result of type `c`.
* `E<a> -> E<b> -> E<(a->b)>` I'll use `E<>` for *elevated* types which are container types. If you know already what a monad is, I whould use `M<>` instead. These are same as above, just take notice to the `E<(a->b)` part that it is an *elevated* type of a function which takes `a` and outputs `b`
.

> As you see, you can express much with this simple notation

Lets start with the `Identity` *monad*. As you still don't know what a *monad* is, you can think of it as a container type. On this Identity case it is indeed a container, just a container. I chose Identity because I can examine all monadic properties because it is simple to use and write. Then we will examine other monads too.

~~~js
class Identity {
  constructor(value) {
    this.value = value;
  }
  
  toString() {
    return `Identity(${this.value.toString()})`;
  }
}
~~~

> `value` could be either a type or a function

**Utility functions:**

<http://jsbin.com/patayorihu>

To use monads more efficient, we need these two helper functions `
curry` and `compose`. I won't go into detail of these functions here but they are the foundations of all the Functional Programming and we'll use them on all our code. So give them some attention, respect.

 1. **curry**

    > If you are here just willing to learn skip this part: For clarity I'll not use `partial function application` not because I don't care, because it just doesn't matter. See this example
    
    > `var f1 = curry((x, y, z) => x + y + z)`
    
    > you can use `f1` however you like:
    
    > 
    ~~~
    f1(1, 2, 3) // 6
    f1(1)(2, 3) // still 6
    f1(1)(2)(3) // still 6
    ~~~

   *currying* is a powerful tool if you know how to use it properly. And to do that you have to know what it is for. First of all with currying you'll get reusable functions from existing ones out of the box. 
   
   Functions that return functions are a strong concept. 
   
   ~~~js
    function add(x, y) {
      return x + y,
    }
   ~~~
   
   Given a simple function of *add*, we can transform it like this:
   
   ~~~js
    function addTo(x) {
      return function (y) {
        return x + y;
      };
    }
    
    const add2 = addTo(2);
    add2(3) // 5
   ~~~
   
   With the help of *closures*, as you saw, we can fix or bind some of the parameters of a simple function like add, and get a brand new function just waiting for the second parameter to be passed in. Now we have a `add2` function which adds 2 to any value given to it. 
   
   Frankly we don't need this manual work of tranformation and we can use `curry` function to transform any regular function automatically.
   
   ~~~js
   const add = curry(function(x, y) {
     return x + y,
   });
   
   const add2 = add(2);
   add2(3) // 5
   ~~~
   
   Here is the implementation of *curry*:
	
	~~~js
	function curry(fx) {
	  var arity = fx.length;
	
	  return function f1() {
	    var args = Array.prototype.slice.call(arguments, 0);
	    if (args.length >= arity) {
	      return fx.apply(null, args);
	    }
	    else {
	      return function f2() {
	        var args2 = Array.prototype.slice.call(arguments, 0);
	        return f1.apply(null, args.concat(args2)); 
	      };
	    }
	  };
	}
	~~~
	
1. **compose**

    We'll use `compose` function to create composible functions, apparently. `compose` function takes any number of functions, and evaluates them _from left to right_ with the given parameter, which takes the parameter to function and passes its result to the next one's input. As you'll see it is easy for one parameter functions to compose. 
    
    Here is the implementation:
    
    ~~~js
    function compose() {
      var funcs = arguments;
      return function() {
        var args = arguments;
        for (var i = funcs.length; i --> 0;) {
          args = [funcs[i].apply(this, args)];
        }
        return args[0];
      };
    }
    ~~~
    
    And you can use like this:
    
    ~~~js
    compose(x => x + 1, y => y * 2)(3) // 7
    ~~~

1. **unit (return)** 

	We'll use a static method `of` for wrapping values in Identity. 
	
	~~~js
    const of = curry(function (m, value){
      return m.of(value);
    });
	
	class Identity {
	  ...
	  static of(value){
	    return new Identity(value);
	  }
	}
	~~~	
	~~~js
	Identity.of(5).toString()
	~~~
	~~~
	Identity(5)
	~~~
	
	With the help of the `of` function, we can even shorten:

    ~~~js
    const iof = of(Identity);
    iof(5) // Identity(5)
    ~~~

1. **map**

	* `(a->b) -> E<a> -> E<b>` or
	* `E<a> -> (a->b) -> E<b>`
	
	~~~js
	const map = curry(function(fn, m) {
	  return m.map(fn);
	});
		
	class Identity {
	  constructor(value) {
	    this.value = value;
	  }
	  
	  toString() {
	    console.log(`Identity(${this.value})`); 
	    return this;
	  }
	  
	  // (a->b) -> E<a> -> E<b>
	  map(fn) {
	    return Identity.of(fn(this.value));
	  }
	  
	  static of(value){
	    return new Identity(value);
	  }
	}
	~~~
	~~~js
	map(x => x + 1, Identity.of(5)).toString()
	~~~
	~~~
	Identity(6)
	~~~
	
	--
	
	**functor laws**
	
	1. map(id) = id
	2. compose(map(g), map(f)) = map(compose(g, f))
	
	The first law means that your map function mustn't change any value, just apply the function given.
	
	Second law means your map function must be composable.
	
	~~~js
    function id(x) {
      return x
    }
    
    Identity.of(4).map(id).toString();
	~~~
	~~~
	Identity(4)
	~~~
	
	~~~js
	var f1 = compose(map(x => x + 1), map(x => x * 2));
	var f2 = map(compose(x => x + 1, x => x * 2);
	
	f1(Identity.of(1)); // Identity(3)
	f2(Identity.of(1)); // Identity(3)
	~~~

1. **apply**
	
    ~~~js
    const apply = function(fn, ...args) {
      for (var i = 0; i < args.length; i ++) {
        fn = fn.apply(args[i])
      }
      
      return fn;
    };
    
    class Identity {
      // E<a> E<(a->b)> -> E<b>
      // E<(a->b)> -> E<a> -> E<b>
      apply(arg) {
        arg = arg.value;

        if (typeof arg === 'function')
          return Identity.of(curry(arg)(this.value));
        else
          return Identity.of(this.value(arg));
      }
    }
	~~~
	~~~js
   Identity.of(5)
     .apply(Identity.of((x, y) => x + y + 1))
     .apply(Identity.of(2)).toString()
	~~~
	~~~
	Identity(8)
	~~~
	~~~js
	Identity.of((x, y) => x + y + 1)
     .apply(Identity.of(5))
     .apply(Identity.of(2)).toString()
	~~~
	~~~
	Identity(8)
	~~~
	
    > the `apply` function of Identity class, either takes a funtion of Identity and later its arguments, or takes a value then later related function. Both ways function will be curried so same `apply` function could be used for "applying" rest of the arguments.

	~~~js
	apply(
	  Identity.of((x,y,z) => x + y + z + 1), 
	  Identity.of(1),
	  Identity.of(2),
	  Identity.of(3)
	).toString()
	~~~
	~~~
	Identity(7)
	~~~
	~~~js
	apply(
	  Identity.of((x,y,z) => x + y + z + 1), 
	  Identity.of(1)
	).apply(Identity.of(2))
	 .apply(Identity.of(3)).toString()
	~~~
	~~~
	Identity(7)
	~~~

    > Apart from the class one, `apply` standalone function can take multiple arguments, once it runs it either returns the result or curried Identity function value. After that it should be used as class `apply` function (arguments one by one).

1. **bind**

    What if we have this function:
    
    ~~~js
    map(i => map(j => i + j, Identity.of(2)), Identity.of(3))
    // or
    // Identity.of(3).map(i => Identity.of(2).map(j => i + j))
    ~~~
    
    What we'll get is this:
    
    ~~~
    Identity(Identity(5))
    ~~~
    
    And this is the same as above:
    
    ~~~js
    map(i => Identity.of(i), Identity.of(3)) // Identity(Identity(3))
    ~~~
    
    Or simply:
    
    ~~~js
    map(Identity.of, Identity.of(3)) // Identity(Identity(3))
    ~~~

    > So sometimes, we need to flatten these nested structures and therefore we need the `bind` function
	
	* `(a->E<b>) -> E<a> -> E<b>`

    ~~~js
    const bind = curry(function(fn, m) {
      return m.bind(fn);
    });
	
	class Identity {
	  ...
	  // E<a> -> (a->E<b>) ->  E<b>
	  bind(fn) {
	    return fn(this.value);
	  }
	}
	~~~
	
	`map(i => map(j => i + j, Identity.of(2)), Identity.of(3))` can be run as:
		
	~~~js
	map(i => bind(j => i + j, Identity.of(2)), Identity.of(3))
	
	// or
	
	bind(i => map(j => i + j, Identity.of(2)), Identity.of(3))
	~~~
	~~~
	Identity(6)
	~~~
	
	And now if we apply the `id` function which we saw on functor laws before, to the `bind` function we have an extract method like this:
	
	~~~js
	Identity.of(3).bind(x => x) // 3
	~~~ 
	
	Interestingly we can rewrite **map** function with **unit** and **bind**:
	
	~~~js
	...
    map(fn) {
      //return Identity.of(fn(this.value));
      return Identity.of(this.bind(fn));
    }
	...
	~~~
	
	Apparently, **map** is a subset of **bind**, and this is the reason why Monads should implement at least these two functions: **unit** and **bind**.


## IO

## EventStream

RxJS, Bacon

## Future

lazy promise?

## Monad

<https://groups.google.com/forum/#!forum/fpinjs>
