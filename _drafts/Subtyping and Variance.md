# Subtyping and Variance

> *Barbara Liskov*'s Substitution prinsiple (LSP): Given A <: B, anything one can to do with a value of B, one should also be able to do with a value of type A.

This subject is heavily related to these and their combined usages:

* Subtyping
* Generics

Basic definitions on scala:

`S <: IntSet` means *S* is any subtype of (including) *IntSet*
`S >: T` means *S* is a super type of (including) *T*

```scala
def assertAllPos[S <: IntSet](r: S): S = ...
```

In this code the function takes a parameter *r* whose type is a subtype of *IntSet* and returns a subtype of *IntSet* again.

We could say

```scala
[S >: NonEmpty]
```

or even

```scala
[S >: NonEmpty <: IntSet]
```

So the hard question would be, given `NonEmpty <: IntSet` is also `List[NonEmpty] <: List[IntSet]`?

## Variance

### Covariant

When we think about it the above statement will be true and called **covariant** because the relationship varies with the type parameter.

In c# (or java) one could have done

```c#
NonEmpty[] a = new NonEmpty[] { new NonEmpty() };
IntSet[] b = a;
b[0] = new Empty();
NonEmpty s = a[0];
```

But all we could have this runtime error:

```
System.ArrayTypeMismatchException: Attempted to access an element as a type incompatible with the array. (line 4)
```

Because c# arrays are **covariant** and **mutable** we got this error. Fortunately generic collections in c# are **invariant** so you'll have a compile check. Also scala's mutable arrays are not covariant unlike java and c# arrays.

> http://stackoverflow.com/a/2033921/2049893

### Variance (cont.)

Knowing the above, now we can go further: `C[T]` is a parameterised type and A, B are types such that `A <: B`

* Covariant if `C[A] <: C[B]`
* Contravariant if `C[A] >: C[B]`
* Invariant if neither `C[A]` nor `C[B]` is a subtype of the other

Scala lets you define variance like:

```scala
class C[+A] { ... } // C is covariant
class C[-A] { ... } // C is contravariant
class C[A] { ... }  // C is nonvariant
```

If we have two function types (`NonEmpty <: IntSet` and `Empty <: IntSet`):

```scala
type A = IntSet => NonEmpty
type B = NonEmpty => IntSet

A -> NonEmpty,Empty => NonEmpty
B -> NonEmpty       => NonEmpty,Empty
```
If one pass *NonEmpty* to the function *A*, it returns *NonEmpty* and it is still an *IntSet*. But you can't do the same to the function *B* as you can't pass *Empty* to function *B* and it can return *Empty*. So `A <: B`.

To generalize, given `A2 <: A1` and `B1 <: B2` then:

```
A1 => B1 <: A2 => B2
```

So functions are **contravariant** in their argument types, and **covariant** in their result type.

```scala
trait Function1[-T, +U] {
    def apply(x: T): U
}
```

So the rules are:

* **covariant** type parameters can only appear in method results.
* **contravariant** type parameters can only appear in method parameters.
* **invariant** type parameters can appear anywhere.

On why `Nil < List[T]`:

> *Nothing* is a subtype of every other type (including *Null*); there exist no instances of this type. Although type Nothing is uninhabited, it is nevertheless useful in several ways. For instance, the Scala library defines a value *scala.collection.immutable.Nil* of type *List[Nothing]*. Because lists are **covariant** in Scala, this makes *scala.collection.immutable.Nil* an instance of *List[T]*, for any element of type *T*.

### Example

Lets see the List example here:

```scala
// made List covariant
trait List[T] {
  def isEmpty: Boolean
  def head: T
  def tail: List[T]
}

class Cons[T](val head: T, val tail: List[T]) extends List[T] {
  override def isEmpty: Boolean = false
}

class Nil[T] extends List[T] {
  override def isEmpty: Boolean = true

  override def head: Nothing = throw new NoSuchElementException("Nil.head")

  override def tail: Nothing = throw new NoSuchElementException("Nil.tail")
}
```

And these additional types:

```scala
abstract class IntSet {
  def incl(x: Int): IntSet
}

object Empty extends IntSet {
  override def incl(x: Int): IntSet = new NonEmpty(x, Empty, Empty)
}

class NonEmpty(elem: Int, left: IntSet, right: IntSet) extends IntSet {
  override def incl(x: Int): IntSet = {
    if(x < elem)
      new NonEmpty(elem, left.incl(x), right)
    else if(x > elem)
      new NonEmpty(elem, left, right.incl(x))
    else
      this
  }
}
```

First of all, I want to change type `Nil` from *class* to *object* because we don't need to instantiate it. But then we lose generic parameter so we need to change `List[T]` to `List[Nothing]` because it is subtype of every other types.

Now in this line `new Cons[T](elem, **Nil**)` we get an error:

```
Error:(28, 57) type mismatch;
 found   : A$A0.this.Nil.type
 required: A$A0.this.List[T]
Note: Nothing <: T (and A$A0.this.Nil.type <: A$A0.this.List[Nothing]), but trait List is invariant in type T.
You may wish to define T as +T instead. (SLS 4.5)
def singleton[T](elem: T): List[T] = new Cons[T](elem, Nil)

```

As the error message explains: the type `T` in `List` we defined is *invariant* and that means `List[Nothing]` is not a subtype of `List[T]`, so let's change definition of List to `List[+T]` *covariant*. Now everything compiles as expected.

### Bounds

We can define type bounds in our generic types or functions. But why do we need them? Let's see an example: Adding a **prepend** method to the `List` type.

```scala
def prepend(elem: T): List[T] = new Cons(elem, this)
```

Because we can use both Empty and NonEmpty as type T, this will violate LSP, will give a compile-time error:

```
Error:(8, 16) covariant type T occurs in contravariant position in type T of value elem
  def prepend(elem: T): List[T] = new Cons(elem, this)
              ^
```

If we have defined our type as covariant, we also need to use parameters as contravariant. This means we need a type that have lower bound of `T`. We need to change our function like this:

```scala
def prepend[U >: T](elem: U): List[U] = new Cons(elem, this)

def f(xs: List[NonEmpty], x: Empty) = xs.prepend(x)
```

Function `f`'s return type will be inferred as `List[IntSet]` automatically On our function, `U` will be an `Empty`, `T` will be `NonEmpty` and they are also `IntSet`s.
