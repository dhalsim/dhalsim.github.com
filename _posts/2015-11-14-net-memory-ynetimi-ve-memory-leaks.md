---
layout: post
title: ".Net Memory Yönetimi ve Memory Leaks"
description: ""
toc: true
category: [".net", "memory"]
tags: [".net", "memory"]
excerpt: "Bu yazıda .NET memory yönetimi nasıl çalışır onu öğreneceğiz böylece uygulamarımızı hafıza açısından daha bilinçli geliştirebileceğiz.s"
---
{% include JB/setup %}

# Genel Terimler

## Heap

* Code Heap
* Small Object Heap
* Large Object Heap
* Process Heap

## Stack

Metot çağrımları sırasında o metot için geçerli verilerin tutulması, ve gerektiğinde hatırlanması amacıyla kullanılan memory'dir.

En son çağrılan, en üstteki memory frame olduğundan stack yapısındadır.

## Value Types

* Byte
* Int32
* UInt32
* Double
* Decimal
* **Structs**
* SByte
* Int64
* UInt64
* Boolean
* IntPtr
* Int16
* UInt16
* Single
* Char
* UIntPtr

## Reference Types

* classes
* interfaces
* delegates
* strings
* instances of “object”

### Örnek

~~~csharp
 void Method1()
 {
       MyClass myObj = new MyClass();
       Console.WriteLine(myObj.Text);
 }
~~~

![sekil1](https://www.safaribooksonline.com/library/view/under-the-hood/9781906434755/images/20.jpg)

When Method1 completes, the stack frame is removed (along with the object reference), leaving the object without a reference.

# İşleyiş

## Passing parameters

* Value Type parametre olarak geçilirken kopyalanır
* Reference Type parametre olarak geçilirken referans üzerinden geçer

> struct'lar value type olduğundan ve programcı tarafından tanımlandığından boyut olarak büyük olabilir. Bu da bazı performans sorunlarına yol açabilir

## Ref kullanımı

### Örnek 2

Aşağıdaki örneğe dikkat edilirse

~~~csharp
 void Method1()
 {
    int v1=22;
    Method2(v1);
    Console.WriteLine(“Method1 = ” + v1.ToString());
 }

 void Method2(int v2)
 {
    v2=12;
    Console.WriteLine(“Method2 = ” + v2.ToString());
 }
~~~

Sonuç:

~~~
 Method 2 = 12
 Method 1 = 22
~~~

Parametreleri ref keyword'ü ile geçirdiğimizde

~~~csharp
 void Method1()
 {
    int v1=22;
    Method2(ref v1);
    Console.WriteLine(“Method1 = ” + v1.ToString());
 }

 void Method2(ref int v2)
 {
    v2=12;
    Console.WriteLine(“Method2 = ” + v2.ToString());
 }
~~~

Sonuç şu şekilde olacaktır:

~~~
 Method 2 = 12
 Method 1 = 12
~~~

## Boxing Unboxing

~~~csharp
  // integer Stack'te yaratıldı
  int stackVariable=12;
  // integer Heap'te yaratıldı = Boxing
  object boxedObject= stackVariable
  // Unboxing
  int unBoxed=(int)boxedObject;
~~~

> object tipinde parametre alan bir metoda geçilen değer otomatik boxing işlemine uğrar ve bu işlem bilinçsiz olarak loop içinde yapılıyorsa performans problemine yol açabilir

~~~csharp
  int i=12;
  ArrayList lst=new ArrayList();
  // ArrayList Add metodunun imzası
  // int Add(object value)			
  lst.Add(i); // otomatik Boxing
  int p=(int)lst[0]; // Unboxing
~~~

# Garbage collection

Heap üzerinde objelerin referans edilip edilmediğine bakıp heap'i temizler. Baktığı yerler:

* global/static object references
* CPU registers
* object finalization references
* Interop references (COM/API çağrımlarına geçen .NET objeleri)
* stack references

## Yöntemler

* SOH Cleanup (heap compaction)
* LOH Sweeping (free space tracking)

Small Object Heap'te nesneler memory'de ardışık olarak tutulur ve GC bu alanı temizlik sırasında ardışık tutar. Taşıma işlemleri sayesinde boş kısımlar minimumdadır ancak bu işlem CPU zamanı kullandığı için performansı etkileyebilir.

Large Object Heap'te taşıma işlemi uzun süreceğinden ardışıl değildir. Boş ve kullanılan kısımlar takip edilir. Memory'nin bir bölümü boş olarak işaretlendiğinde yerine en uygun nesnenin tahsil edilmesi gerekir. Bu yüzden memory alanı verimsiz kullanılabilir.

* Statik Objeler

Bir class member static olarak tanımlıysa, bu onu instance bazında değil class bazında bir obje haline getirir. Genellikle global değişken tanımlamak amacıyla kullanılır. Bir appdomain içindeki tüm threadler tarafından erişilebilirler. Appdomain'in yaşam zamanı boyunca memory'de tutulurlar.

> *[ThreadStatic]* attribute'u ile tanımlı member'lar thread başına bir instance olarak tutulurlar.

~~~
 [ThreadStatic]
 public static int NumberofThreadHits=0;
~~~

### Örnek

* Önce

![](https://www.safaribooksonline.com/library/view/under-the-hood/9781906434755/images/41-1.jpg)

* Sonra

![](https://www.safaribooksonline.com/library/view/under-the-hood/9781906434755/images/42-1.jpg)

## GC Ne zaman Çalışır?

Belli memory koşulları oluştuğunda veya uygulama hafıza sıkıntısı çekmeye başladığında ayrı bir thread'de çalışır. Ancak GC bir nesnenin yaşamasına izin vermesi için en az bir root referansa ihtiyacı vardır.

Developer GC'yi şu yöntemle çalışmaya zorlayabilir:

~~~
GC.Collect();
~~~

Ancak bu kullanım performans ve scalibility sorunlarına yol açabilir. Kullanılması tavsiye edilmiyor.

## Objelerin sınıflandırılması

GC yöntemlerine bakıldığında -özellikle büyük nesnelerde- kullanım listeleri tutma ve hafızayı compact tutma işlemlerinin problemli olduğu görülür. Büyük obje graflarında gezmek, ölü nesnelerin üzerine kullanımdakileri kopyalamak önemli işlemci zamanı gerektirektirir. Bu yüzden tüm bu işlemlerin optimize olması gerekmektedir.

Bu yüzden GC'yi tasarlayanlari tüm objeleri 3 gruba sınıflandırdılar: kısa süre içinde allocate olup silinen **short-lived** objeler, öte taraftan erken allocate olup süresiz kullanılan **long-lived** objeler ve ikisinin ortasındali **medium-lived** objeler.

Genel allocation biçimleri incelendiğinde short-lived objelerin long-lived objelere göre daha sık kullanıldığını keşfettiler. Ayrıca GC tarafından sık toplanan objelerin de yakın zamanda allocate edilen objeler olduğunu gördüler. Çoğu obje bir metot içinde kullanılıp kapsam dışına çıktığından kısa sürelidirler. Bu yüzden kısa zaman içinde allocate olmuş nesneler GC tarafından daha sık kontrol edilir.

Bu tipler şu şekilde adlandırılmışlardır.

* Gen 0 (short-lived)
* Gen 1 (medium-lived)
* Gen 2 (long-lived)

### Örnek

Aşağıdaki şekilde SOH üzerinde her objeyi ve ait oldukları generation'ı görebilirsiniz. Obje W en az 2 GC kontrolünden geçmiş, oysaki Z ve Y ilk defa bakılacak. Obje X bir GC kontrolünden hayatta kalmış geçmiş.

![](https://www.safaribooksonline.com/library/view/under-the-hood/9781906434755/images/45-1.jpg)

## GC Ne zaman Çalışır? (2)

Generation'a özel boyutlar aşıldığında otomatik olarak çalışır

* Gen 0 ~256 K
* Gen 1 ~ 2 MB (bu durumda GC Gen 1 ve Gen 0'ı toplar)
* Gen 2 ~10 MB (bu durumda GC Gen 2, 1 ve 0'ı toplar)

Ayrıca

* kod tarafında GC.Collect() çağrıldığında
* işletim sistemi düşük hafıza bildirimi gönderdiğinde

> bu değerler uygulamaya ve çalıştığı makineye göre değişiklik gösterebilir

> genel çalışma prensibi olarak Gen 0 toplama Gen 1'e göre ve Gen 1 toplama da Gen 2'ye göre 10 kat daha sık çalışır.

### Gen 0 collection

* Eğer root'u varsa Gen 1'e taşı
* Yoksa öldür ve sıkıştır

Bu durumda Gen 0 toplama sonunda Gen 0 boş olacaktır.

### Gen 1 collection

* Gen 1 ve 0 için işlem yapılır. Sonucunda nesne ya gen 0'a taşınır ya da gen 2'ye yükseltilir.

### Gen 2 collection

* Tüm generation'lar denetlendiği için en uzun sürenidir.

### Sonuç

İdeal olarak objelerin çoğu Gen 0'da belki Gen 1'de ölecektir.

Gen 2'ye gelen objeler belli nedenlerle orada olmalı; sürekli yaratılıp kullanmaktansa saklanması ve böylece tekrar kullanımı söz konusu olabilir.

Gen 2'ye gelip root referansı kalmayan objeler hafızada bir süre gereksiz yer tutacaklardır. Root referansı devam eden ve sık çalışan Gen 2 kodu, Gen 2 toplamasının da sık çalışmasına neden olur.

> Bir objenin gereksiz yere referansının olması o objeyi çok kolay Gen 2'ye terfi ettirebilir, bu da memory'nin verimsiz kullanılmasını yol açabilir.

# Finalization

.NET tarafından kullanılan unmanaged (.NET olmayan) herhangi bir kod GC tarafından toplanamaz. Bu yüzden .NET tarafında bu kaynakların manuel free edilmesi gerekmektedir.

Bu yüzden .NET tarafındaki finalizer yapısı kullanılır. Ancak bu yapıyı kullanmanın bir yan etkisi olarak bu nesnelerinizin yaşam ömrünü uzatacaktır.

Nesnenizin yok edilmeden hemen önce .NET tarafından çağrılacak aşağıdaki yapılardan herhangi birini kullanabilirsiniz.

~~~csharp
class TestClass
{
      ~TestClass()
      {
      }
}

class TestClass2
{
      void Finalize()
      {
      }
}
~~~

Ancak bu kaynakları free etme işlemi GC'nin işleyişini yavaşlatacağından, asenkron olarak belli bir thread üzerinden bu yapıların queue mantığıyla çağrılması söz konusudur.

![](https://www.safaribooksonline.com/library/view/under-the-hood/9781906434755/images/51-1.jpg)

Şekilde görüldüğü gibi Z nesnesinin finalizer metodu var. Bu da finalization queue (finalize edilecek nesnelerin listesi) denilen bir yapıya referansının eklenmesine yol açar.

Z nesnesi root referansını kaybettiğinde collection işlemi için aday olacakken, finalization queue'da referansı olduğundan Gen 1 de olduğunu farzedersek Gen 2'ye terfi edecektir.

Aynı zamanda fReachable denen artık finalizer'ın çağrılması gereken objelerin tutulduğu queue'ya aktarılır. Ancak bundan sonra başka bir thread bu queue'yu okuyup nesnelerin Finalize metodunu ya da destructor'ını çağırır.

![](https://www.safaribooksonline.com/library/view/under-the-hood/9781906434755/images/52-1.jpg)

### Sonuç

Bu yapıda Finalize'ın işleyişi verimsiz gibi görünmekte ancak GC bize bu implemantasyonu, eksik yapılan bir temizlik yüzünden veya process'in durması durumunda son çare olarak yapmamız için izin veriyor.

## Disose Finalize Pattern Örnek

[Disose Finalize Pattern Örnek](https://dotnetfiddle.net/JQV78j)

<iframe width="100%" height=3150" src="https://dotnetfiddle.net/Widget/JQV78j" frameborder="0"></iframe>

Yukarıdaki örnekte görüldüğü gibi GC'nin bu asenkron yapısına uyacak aynı zamanda kendi isteğimizle de çalıştırabileceğimiz bir Finalize Dispose Pattern görebilirsiniz.

Bu patternde **protected virtual void Dispose(Boolean)** metodu iki farklı senaryo için uygulanmaktadır:

* disposing = true => metot kullanıcı kodundan çağrıldı, managed ve unmanaged kaynaklar dispose edilebilir.
* disposing = false => methot runtime tarafından finalizer ile çağrıldı, sadece unmanaged kaynaklar dispose edilebilir.

*Base* class'ta *IDisposable*'dan gelen **public void Dispose()** metodunu, **protected virtual void Dispose(Boolean)** metodunu ve **~Base()** Finalize metodunu görebilirsiniz.

.NET'te bu işlemin Base class'larda da handle edilmesi gerektiğinden kodda böyle bir hiyerarşi kuruldu.

*IDisposable* implementasyonunu kendi isteğimizle ,**mesela using statement kullanarak** çağırıyoruz. Ama bu çağrımı yapmayıp işi GC'ye havale edeceksek bunu da Finalize (destructor) metodu üzerinden çalışmasını sağlıyoruz.

Her ikisinin de farklı threadlerde çalışmasından ve kestirilemez olmasından ötürü kodu **protected virtual void Dispose(Boolean)** metodu içinden ortaklaştırıyoruz.

> Eğer thread-safe olması gereken bir kaynak varsa bunu lock mekanizmalarıyla thread-safe hale getirmeliyiz.

*Derived* class'ta ise eğer sadece o instance için handle edilmesi gereken unmanaged bir kaynak varsa dispose patternini uygulamamız gerekiyor. bunu da **protected virtual void Dispose(Boolean)** metodunu **override** ederek yapıyoruz.

> Dikkat etmemiz gereken nokta bu override edilmiş metotda base'in Dispose(Boolean) metodunu en sonda çağırmaktır, böylece üst sınıfların da kendi dispose mekanizlarının çalışması için zinciri devam ettirmiş oluyoruz.

İlginç olan bir başka kısım Base class'ta tanımlı şurasıdır:

~~~
 public void Dispose()
 {
     Dispose(true);
     GC.SuppressFinalize(this);
 }
~~~

Bu kodda Dispose metodu işini bitirdikten sonra managed ve unmanaged tüm kaynakları dispose etti, ve artık GC'nin Finalize metoduna gerek kalmadı.

Böylece Dispose pattern'i eğer doğru kullanılırsa ilk baştan doğan Finalization'dan kaynaklanan yaşam süresinin uzaması problemini de aşmış oluyoruz.

> Sonuç olarak eğer yapılabiliyorsa *IDisposable* nesnelerimizi aşağıdaki using statement'ı ile birlilkte kullanmamız performans ve güvenlik açısından doğru olmaktadır:

~~~csharp
 using (Derived d1 = new Derived("d1", tracking))
 {
    //d1 işlemleri
    //implicit disposing
 }
~~~

[Konu ile ilgili daha ayrıntılı anlatılan bir örnek](http://www.codeproject.com/Articles/15360/Implementing-IDisposable-and-the-Dispose-Pattern-P)

# GC Options

## Modlar

Sadece 2 GC Modu vardır.

Tek işlemcili bilgisayarlarda default **workstation** modu en hızlı olan seçenek olacaktır.

2 işlemcili bilgisayarlarda **workstation** ya da **server** modu kullanılabilir.

**Server** GC modu 2'den fazla işlemcili bilgisayarlarda en hızlı olacaktır.

Kodun hangi modda çalıştığını öğrenmek için şu komut kullanılabilir:

~~~
bool isServerGC = GCSettings.IsServerGC();
~~~

Server gc maximum işlem hacmi için optimize edilmiştir. Bu her processor için bir GC thread'inin paralel olarak çalışacağı anlamına gelmektedir.

Workstation gc hızı (responsiveness) ön plana çıkarır: belli bir zamanda az iş yapılır ancak uygulama belli hareketlere daha hızlı cevap verir.

Bu nedenle bir bilgisayarda birden fazla uygulama çalışıyorsa server gc yerine workstation gc'yi tercih edebilirsiniz.

Config üzerinden **server** moduna ayarlamak için:

~~~xml
<configuration>
   <runtime>
      <gcServer enabled="true"/>
   </runtime>
</configuration>
~~~

## Concurrency

.NET Framework 4.0 ile beraber workstation concurrent gc, background gc ile değiştirildi ve .NET Framework 4.5 ile beraber de server gc için  kullanılabilir hale geldi.

<gcConcurrent> elementi ile bu davranışı kontrol edebiliriz.

~~~xml
<configuration>
   <runtime>
   		<gcConcurrent enabled=“true | false”/>
   </runtime>
</configuration>
~~~

Concurrent gc, gc işlemi esnasında ekran takılmalarını minimize etmek için tasarlanmıştır. Bu yüzden etkileşimli UI uygulamaları için uygundur. Server ile ilgili işlemler yapmadıkça bu modu aktif olarak tutmak isteyeceksinizdir.

## Runtime GC Latency Control

.NET GC latency modunu programatik olarak değiştirmenize izin verir.

3 mod vardır:

* **GCLatencyMode.Batch** – UI etkileşimi önemli olmayan yerlerde maximum işlem ve performans verir.
* **GCLatencyMode.LowLatency** – UI etkileşiminin önemli olduğu yerlerde GC'nin etkisini minimuma indirir. ör: animasyon
* **GCLatencyMode.Interactive** – Concurrency açık Workstation gc modu, GC verimliliği ve uygulama etkileşimi arasında dengeli.

Maximum UI ya da işlem gerektiren kritik yerlerde **LatencyMode**'u değiştirmek anlamlı olacaktır. Daha sonra eski haline geri döndürmek gereklidir:

~~~csharp
using System.Runtime;
…
// Store current latency mode
GCLatencyMode mode = GCSettings.LatencyMode;
// Set low latency mode
GCSettings.LatencyMode = GCLatencyMode.LowLatency;
try
{
   // Do some critical animation work
}
finally
{
   // Restore latency mode
   GCSettings.LatencyMode = mode;
}
~~~

# Weak References

Weak referanslar objeleri tutmanızı sağlarken aynı zamanda GC tarafından toplanmasına da izin verir. Büyük objelerde bazen kod içinde tekrar kullanılıp kullanılmayacağı belli olmayan durumlarda kullanmak isteyebilirsiniz.

Büyük bir objeyi instantiate etmek CPU zamanı gerektirir aynı zamanda onu yüklü tutmak da memory gerektirir.

Uygulamanız kullanıcının büyük veri yapılarında gezmesini sağlıyorken, bu verilerin bazılarına tekrar ulaşmak isteyecek bazılarına ise ulaşmayacaktır. Bu durumda bu yapıları weak referanslara çevirip GC'nin ihtiyaç duyduğunda collect etmesini sağlayabilirsiniz.

~~~csharp
// Load a complex data structure
Complex3dDataStructure floor23=new Complex3dDataStructure();
floor23.Load(“floor23.data”);

… // Do some work then
// Get a weak reference to it
WeakReference weakRef=new WeakReference(floor23, false);

// Destroy the strong reference, keeping the weak reference
floor23=null;
…
// Some time later try and get a strong reference back
floor23=(Complex3dDataStructure)weakRef.Target;
// recreate if weak ref was reclaimed
if (floor23==null)
{
   floor23=new Complex3dDataStructure();
   floor23.Load(“floor23.data”);
}
~~~

## Short weak references

Eğer objeniz finalizable değilse WeakReference constructor'ına **false** geçilir.

~~~
WeakReference wr=WeakReference(floor23, false);
~~~

GC'nin "kullanılan objeler" listesinde değilse silinir.

## Long weak references

Bunun yanında finalizable nesnemiz varsa constructor'a **true** geçilir.

~~~
WeakReference wr=WeakReference(floor23, true);
~~~

Eğer obje “kullanılan objeler” listesinde ya da finalization queue'da değilse silinebilir.
