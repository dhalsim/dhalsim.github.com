# Monads

Data structures that:

* They have some algebraic laws
* They implement flatMap (bind) and unit functions

## Functions

### Bind

The signature of a bind function:

`M[T].flatMap[U](f: T => M[U]): M[U]`

Bind, or flatMap as called in Scala, is a special form of the `map` function which it wraps the result with the Monadic form.

### Unit

def unit[T](x: T): M[T]

for List: unit will be-> unit(x) = List(x)

### Map

map could be defined as a combination of flatMap and unit:

m.map(f) == m.flatMap(x => unit(f(x))) or
         == m.flatMap(f andThen unit)
 
> Bind or FlatMap or SelectMany or Chain

## Laws

These are the monadic laws that if a structure obeys these rules we call it a monad. List in Scala is a monad so I'll give from *List*s.

### Associativity

> In programming languages, the associativity (or fixity) of an operator is a property that determines how operators of the same precedence are grouped in the absence of parentheses.        

It means these two statements should evaluate the same results:

~~~scala
	def mul2(x: Int): List[Int] = List(x * 2) 
	def incr(x: Int): List[Int] = List(x + 1) 

	val m = List(1, 2)                        
	
	m.flatMap(mul2).flatMap(incr)             //> res0: List[Int] = List(3, 5)
	m.flatMap(x => mul2(x).flatMap(incr))     //> res1: List[Int] = List(3, 5)
~~~

> A subset of Monads is Monoids that the structures are at least provides the associativity law

	
### Left Unit

The **left unit** law is:

`unit(x).flatMap(f) == f(x)`

For example:

~~~scala
	def mul2(x: Int): List[Int] = List(x * 2) 
	
	List(1).flatMap(mul2)                     //> res2: List[Int] = List(2)
	mul2(1)                                   //> res3: List[Int] = List(2)
~~~

### Right Unit

The **right unit** law is the opposite of the *left unit law*:

`m.flatMap(unit) == m`

Now lets change our code a little bit and see the variations:

~~~scala
	def unit(x: Int): List[Int] = List(x)     
	val mul2: Int => Int = 2 *                
	val incr: Int => Int = 1 +                
	
	val m_mul2: Int => List[Int] = mul2 andThen unit
	val m_incr: Int => List[Int] = incr andThen unit
	
	// left unit	                          
	unit(1).map(mul2)                         //> res0: List[Int] = List(2)
	unit(1).flatMap(m_mul2)                   //> res1: List[Int] = List(2)
	m_mul2(1)                                 //> res2: List[Int] = List(2)
	
	// right unit
	unit(1).flatMap(unit)                     //> res3: List[Int] = List(1)
	List(1).flatMap(unit)                     //> res4: List[Int] = List(1)
~~~

See how I defined anonymous functions `mul2` and `incr` without specifying parameters. I also used function composition to create monadic functions of them with `andThen`. I simply wrap the functions. Left unit is the same except I'm using the right (official) naming for unit instead of List. And one more thing to explain: you can also see the relation between `map` and `flatMap`

## Option Monad

> Represents optional values. Instances of Option are either an instance of *scala.Some* or the object *None*.

In Scala the main reason to use monadic structures is to use them in context of 
[for(sequence)-comprehension](http://docs.scala-lang.org/tutorials/tour/sequence-comprehensions.html)

To understand what is monad and its laws, also with for-comprehensions in Scala I'll make an Option type myself and use this example:

~~~scala
def getParameter(p: String) = if (p == "name") Some(" baris ") else None

val upper = for {
  name <- request getParameter "name"
  trimmed <- Some(name.trim)
  upper <- Some(trimmed.toUpperCase) if trimmed.length != 0
} yield upper

println(upper getOrElse "")
~~~