title: Software Testing
author:
  name: Barış Aydek
  url: http://dhalsim.github.io
output: basic.html

--

# Tanım

> **Yazılım testi:** Yazılım ürününün *production*'a geçmeden önce, yazılımın doğruluğunun ve kalitesinin kontrol edilmesi, varsa hataların bulunup tespit edilmesi işlemidir.

*Bu sunum Yazılım testi nedir sorusunu cevaplayıp, Unit Testing'e yoğunlaşacaktır.*

--

# Yazılım kazaları

--

## **Savaş**

* 1980, Amerika Hava Savunma Komutanlığı, iletişim cihazındaki hata bir nükleer saldırının yaşandığını yayıyor.
* 1983, Sovyet uydusu, Amerikan füzesi saldırısı raporu veriyor.

--

## **Hastalık**

* 1985-87 arası radyasyon tedavi aracındaki hata, en az 3 kişinin ölüme, çoğu hastanın da 100 kat fazla radyasyon almasına yol açıyor.

--

## **Para kaybı**

* 1996, uzaya uydu gönderilmesinde roket yazılımdaki hata yörüngede sapmaya neden olup roketin kendini patlatmasına neden oluyor. Hatanın maliyeti 370 milyon dolar.
* 1999, yine uydu fırlatmasındaki hata 1.2 milyar dolara maloluyor.
* 1996, banka yazılım hatası 832 müşterinin 920 milyon dolar borçlandırıyor.

--

## **Kaza**

* 1994, sistem hatası bir helikopterin düşmesine ve 29 kişinin ölmesine neden oluyor.
* 1993, uçak sistemindeki bir hata şuna yol açıyor: <https://www.youtube.com/watch?v=4iToQ2FykoI>
* 1994, Çin'de yazılım hatası uçak kazasına yol açıyor: 264 ölü.

--

## **Vakit kaybı**

* 2015, Türkiye'de herhangi bir devlet dairesindeki memur: Sistemler çalışmıyor!

--

# Yanlış vs Doğru

--

* **Bilinen:** Yazılımın testi, yazılım *production*'a geçmeden hemen önce yapılmalıdır.

--

* **Doğrusu:** Yazılım testi yapılabildiği en erken zamanda yapılmaya başlanmalı, mümkünse her değişiklikte güncellenmeli ve tekrarlanmalıdır.

--

* **Bilinen:** Tüm kodlama bittikten sonra testing başlar

--

* **Doğrusu:** Development modeline göre değişir, *Agile* gibi metodolojilerde *testing*, gereksinim analiziyle başlar.

--

* **Bilinen:** Unit testing iyidir ama bunun için yeterli vaktimiz ve kaynağımız yok.

--

# :/

--

# Testing Teorisi

--

Yazılım modellerinde gördüğümüz çoğu modern sistem, **iterasyon** temelinde olmaktadır. Bunun yanında testing, günümüzde çok popülerleşen **çevik süreçler**de de olduğu gibi **sık ve erken sürüm** ihtiyacıyla beraber tüm bu yöntemlerin mümkün olmasını sağlar. Bu yüzden de ayrı bir önemi vardır.

--

# Testing Çeşitleri

--

Çok çeşitli testing yöntemleri vardır. Burada en temel testing yöntemlerini listeliyoruz:

* **Manuel testing:** (Henüz) otomatize edilmediği durumda uygulanması gerekir. Sürekli tekrar edilmesi sıkıcıdır ve işgücü gerektirir.
* **Otomatize testing:** Yazılımsal araçlar yardımıyla gerçekleşir, test sonucu karşılaştırmalı yöntem kullanılarak rapor olarak sunulur.

--

* **Unit testing:** Yazılımın en küçük modüllerinin test edilmesidir. Kodlama becerileri gerektirdiğinden genellikle yazılım geliştiricileri tarafından yapılır. **White-box** testing yöntemidir.
* **Black-box testing:** Yazılımın iç işleyişi bilinmeden, sadece girdi ve çıktılarına bakarak yapılan testtir.

--

* **Integration testing:** Unit testi yapılsa dahi bu modüllerin birbirleriyle entegrasyonunda hatalar meydana gelebilir. Çeşitli modüllerin grup halinde ve dış kaynaklarla (donanım, veritabanı vb.) beraber test edilmesidir.
* **User acceptance testing (UAT):** Müşteri ya da kullanıcı tarafından yazılım ihtiyaç analizi dökümanınındaki **functional** ihtiyaçları karşılayıp karşılamadığına bakılır.

--

* **System testing:** Sistemin bütünü üzerinde yapılan testing'dir.
	* **Functional testing:** UAT ile benzerdir. Regression testleri örnektir.
	* **Non-functional testing:** Yazılımın fonksiyonel olmayan yönlerinin test edilmesidir. Load testing, performance testing, security testing gibi.

--

# Test Driven Development (TDD)

--

Yazılım geliştirirken **önce** testinin yazılması, daha sonra da kodun kendisinin yazılmasıdır.

> Agile ve XP'de TDD'yi sıkça görürüz. 

--

> Peki neden TDD? **Çünkü lanet olası testleri sonradan yazması ya çok zordur ya da artık imkansız hale gelmiştir.** Bu özellikle **Unit Testing** için geçerlidir.

--

**Amaçlar:**

* Yazılmış kodun testinin yazılması zordur, bu yüzden önce test sonra kod
* Zaman içindeki değişikliklerin önceden çalışan kodu bozup bozmadığının **anlık** kontrolü (lanetli hataların oluşmasının önlenmesi: biribirini bozan hata düzeltmeleri)
* Değişime açık olmak

**Hataların anlık farkedilmesi:**

Diyelim bir yazılımınızda bir hata meydana geldi. Bu müşteriden de gelebilir, siz de farketmiş olabilirsiniz. _TDD kullanılmayan_ bir projede tipik olarak şunlar yaşanır.

![](/assets/images/ffffuuu.png)

* Aslen hatayı oluşturan kodun yazılması (kimin yazdığı, zamanı belli değil)
* Hata ile ilgili kaydın oluşturulması
* Hatayı çözmek için bir geliştiricinin üzerine alması veya ona atanması
* Geliştirici genelde hata ile ilgili kaydı yaratan **tester** ile ve/veya müşteri ile iletişime geçer, senaryoyu tam olarak anlar.
* Geliştirici tarafından hatanın yaratılması. İki aşamadır: ilki hatanın production ortamında anlaşılması için yaratılması gerekmektedir. Bu olmuyorsa loglardan bakılarak bulunması gerekir. Her zaman yapılması zordur. İkinci aşama ise bu hatanın aynısının geliştiricinin kendi ortamında da yaratabilmesidir. İlk aşama gerçekleşse bile ortam farklarından (kod farkı, kullanıcı farklı, DB farkı...) dolayı bunu gerçekleştirmek yine zordur.
* Geliştirici hatayı anladıktan sonra hatanın nedenini kod üzerinde tespit etmelidir. Bu işlem genelde **debugging** dediğimiz yöntemle yapılır. Çoğu zaman bu yöntem, kodun büyük bir kısmına hakim olmayı gerektirir. İyi düzenlenmemiş kod üzerinde saatlerce debugging yapıldığı az görünen bir şey değildir.
* Sorunlu kod tespit edildikten sonra değiştirmek için ne gerektiği analiz edilir. Kişinin kendi yazdığı bir kod dahi olsa eski kodu anlamak zordur. **Single Responsibility** prensibine uyulmayan kodlarda değişiklik yapmak başka bir çok kısmı etkiler. Bu durumda yapılan değişikliğin nereleri etkileyeceği hakkında başka geliştiriciler hatta yazılım mimarları ile görüş alışverişi yapmak gerekecektir. Ender durumlarda da olsa bu bağımlılık yüzünden hatanın düzeltilmesi ertelenebilir ve hatta iptal edilebilir.
* Düzeltme işleminden sonra kod tekrar test edilmelidir. Bizim durumumuzda bu test otomatize edilmediğinden test süreci bir haftayı bulabilir.
* Test süreci sonrasında şanslıysak bir problem çıkmaz ve kodun tekrar canlıya atılması için örneğin 1 hafta daha gerekmektedir.
* Şanslı değilsek ki çoğu zaman değiliz, bu hata ya hiç düzelmemiş ya da daha kötüsü başka hata(lar)a sebep olmuş olabilir. Bu durumda bu döngünün başına dönmemiz gerekiyor.

![](/assets/images/happygoat.jpg)

En basit bir hatanın çözümü için hatanın kaynağından itibaren günler, haftalar, aylar hatta yıllar geçmiş olabilir. Karmaşık yazılım sistemlerinde buna ratslamak çok zor değildir. Peki _TDD kullanılan_ bir projede durum nasıl olurdu? İki türlü olabilirdi. İlki:

* Geliştirici istenen özelliği sağlayacak kod değişikliğini yapmak için test yazar
* Test fail olur. Testi geçirecek minimum kodu yazar.
* Başka testler fail olur. Bu durumda neden fail oldukları, yapılan son değişiklikle alakalıdır yani nedeni bellidir.
* Ya eski kodlar tekrar düzenlenmelidir ya da yeni yazılan kod düzenlenir.
* Düzenleme yapılır ve hiçbir testin başarız olmadığı görülür.

İkinci türlü şöyle olabilirdi:

* Müşteriden veya sizden bir hata kaydı gelir.
* Gerekli iletişim ve analiz yapılır (TDD kullanılmayan projeyle aynı şekilde)
* Hata tekrar edilmesi yapılır (TDD kullanılmayan projeyle aynı şekilde)
* Hata tespiti yine **debugging** yöntemiyle tespit edilir. TDD kullanılan projelerde **refactoring** yapıldığı için bu işlem görece daha kolaydır.
* Geliştirici bu hatayı lokal ortamında bir test yazarak gerçekleştirir.
* Bu testi geçirecek minimum kodu yazar.
* Diğer unit testlerin başarısız olmadığını görür.
* **QA** takımı kodun son halinin **regression test**lerini çalıştırır.

Her iki durumda da TDD'nin ve **test automation**'ın bize zaman ve emek kazandırdığını görüyoruz. Kodumuzun kalitesini kod ve hatalar açısından artırıyor. Daha da iyisi kodumuz artık değişime daha açık.

> Eğer TDD güzel bir şey ama zamanımız yok diyen birisini görürseniz bu senaryoyu anlatın. Asıl TDD kullanmamak zaman kaybıdır.

## Unit Testing

Yazılımın en küçük birimlerinin (ben bu yazıda buna **fonksiyon** diyeceğim) test edilmesidir. Bu kodun önceklikle **test edilebilir** olmasını gerektirir. Test edilebilir kodu yazmanın en doğru yolu TDD ve türevleridir.

**Test edilebilir fonksiyon:**

* Bir fonksiyon sadece bir iş yapmalıdır ya da değişmek için tek bir nedeni olmalıdır. Birden fazla iş yapıyorsa bölünmelidir (Single responsibility)
* Nesne yönelimli dillerde olan **constructor** yapısının sadece **field** ataması için kullanılmalıdır.
* Fonksiyona bağımlılıkların dışarıdan enjekte edilmesi. (Dependency Injection - Inversion of Control)
* fonksiyonlara geçirilen parametreler olabildiğince basit objeler olmalıdır

Şimdi sizden yazdığınız son kodlara bir bakmanızı istiyorum. Yukarıdaki prensiplere uyuyor mu? Eğer TDD ile yazılmadıysa çok zor.

Peki test edilebilir kodu öğrendik ama test edilebilir kodun özelliklerini farkedebildik mi?

> Test edilen fonksiyon sadece o fonksiyonla ilgili işleri yapmalıdır

Her şey bunun için. Neden bu kadar önemli? Diyelim ki bir fonksiyonu test eden kodu yazdık ve çalıştırdık. Bu test **fail** oldu. bu durumda fonksiyon beklenen sonuçları üretmemiş demektir. Peki hatayı düzeltmemiz gerektiğinde nereyi düzelteceğiz. Hata fonksiyonun kendisinde mi yoksa fonksiyonun kullandığı dış kaynaklardan mı meydana geldi? Eğer fonksiyonumuz test edilebilir prensiplere uymuyorsa bunu anlamanın kolay bir yolu yoktur.

Fonksiyonun dış kaynaklardan bağımsız olarak test edilebilmesi için kullanılan tüm bu dış kaynakların izole edilmesi gerekir. Bu işleme **mocking** diyoruz. Bu iş için kullanılabilecek `Dummy, Fake, Stubs, Mocks` gibi seçenekler mevcuttur ama ben bu yazıda kolay olması açısından `Mock objeleri` seçtim.

> **Mock obje:** Bir obje düşünün ki siz bu objeyinin fonksiyonlarını, property'lerini istediğiniz çıktıları versin, istediğiniz davranışları uygulasın. Bu objeleri **run-time**'da yaratıp, mock edilen obje yerine kullanabilirsiniz.

Neler mock edilebilir? Fonksiyonun kullandığı tüm dış kaynaklar: HTTP request objesi, veritabanı objesi, test edilen fonksiyonun kullandığı herhangibir fonksiyon. [Demo](#Demo)'da tüm bunları daha rahat anlayacaksınız.

**İyi unit testin özellikleri:**

* (Çok) hızlı çalışması, çünkü bir kodun sonucunu ne kadar erken görebilirseniz o kadar iyidir.
* İzole: Test edilmek istenen fonksiyonalize diğer kodlardan izole olmalıdır.
* Tekrarlanabilir: Test her çalışmasında aynı sonucu vermelidir
* Bağımsız: Diğer testlerin çalışmasından bağımsız olmalıdır.
* Anlaşılabilir
* Dökümante eder: Yazılan test aynı zamanda çok güncel bir dökümantasyondur (BDD)

**Yazma Yöntemleri (TDD):**

1.	Red: İstenen test yazılır. Bu test çalıştırılır ve başarısız olur.
1.	Green: Testi geçirecek minimum kod yazılır. Dış kaynaklar, bağımlılıklar mock ile soyutlanabilir.
1.	Refactor: Düzenleme işlemidir. Artık teste dayanan bir kodumuz olduğundan testin fail olmamasına dikkat ederek içimiz rahat kodumuzu düzenleyebiliriz.
1.	Tekrar

Bu yöntemler takip edildiği takdirde, iyi bir unit test yazmış oluruz. Peki bu yöntem (TDD) aynı zamanda bize geliştirme esnasında nasıl yardımcı olur ona bakalım.

**Sernaryo:** Bir ERP yazılımı yapıyorsunuz ve sizden istenen şey: siparişi görüp iptal etmek veya bir notla beraber ilgili departmana iletmek olsun.

_TDD kullanılmayan_ örneğimizde geliştirme yöntemi genelde şu şekilde olacaktır.

1. İstenen işlemleri yapacak kod yazılır.
1. Daha sonra yazılım derlenir ve local ortamda çalıştırılır. Bu iş çeşitli gereksinimler gerektirebilir: DB, network bağlantısı gibi.
1. Müşteri rolünde bir kullanıcıyla sisteme giriş yapılır.
1. Sipariş oluşturmak için gerekli ekranlarda veriler girilir
1. Sistemden çıkılıp siparişleri görebilen bir kullanıcıyla tekrar girilir.
1. Sistemden sipariş görülür ve kodlanan özelliğin doğru çalışıp çalışmadığına bakılır.

Eğer şanslıysanız ki çoğu zaman değilsiniz, bu işlemi 2-3 kere tekrar ederek istenen kodu yazabilirsiniz ama biz biliyoruz ki yazılan kodu test edebilmek için bu doğrudan alakası olmayan işleri çok kereler tekrarlamanız gerekecek. Üstelik bu işin müşteriden, QA'den dönme durumunda yine aynı adımları izlemeniz gerekecek.

_TDD kullanılan_ örneğimizde belki işimiz çok kolay olmayacak ama bize şu basit faydaları sağlayacaktır:

* Test yazmak basit ve etkili bir analiz ve tasarım sağlar
* Geliştirme esnasında kodun ne yapıp yapamadığının anlık sonucunu görmek konsantrasyonun dağılmadan geliştirebilmeyi sağlar
* Değiştirilen kodun başka yerleri bozup bozmadığının farkında olabilmek daha radikal (ve doğru) değişiklikleri mümkün kılar
* Yazılan testler geliştiriciler için en güncel dökümantasyonu sağlar
* Testlerin izole yazılması sayesinde yazılımın diğer kısımlarından bağımsız geliştirilmesi sağlanabilir.
* Kodun bambaşka bir yerindeki bug artık sizin geliştirmenizi engellemez

## Integration Testing

Karmaşık bir yazılım birçok alt yazılımların birleşimiyle meydana gelir.  geliştirilen bu modüller birbirleriyle belirli arayüzlerle etkileşerek çalışırlar. Görülmüştür ki bu modüllerin entegrasyonu yazılım geliştirmesindeki en zorlu süreçlerden biridir.

Bunu çözebilmek için çevik prensiplerden de yararlanarak integration testing ortaya çıkarılmıştır. Farklı stratejiler mevcuttur:

* Big Bang Yöntemi: Geliştirilen tüm modüller tek bir kerede birleştirilir ve test edilir. Tüm modüllerin bitmesini gerektirir ve çıkan hataların ana kaynağını tespit etmek zordur.
* Incremental (Birikmeli) Yöntem: *Buttom Up* (alttan üste), *Top Down* (üstten alta) ve ikisinin birleşimi *Sandwich* yöntemleri kullanılabilir. Seçilen yönteme göre **stub** ve **driver** yazılması gerekebilir. [^stubdriver]

![](/assets/images/topbottom.png)

## System Testing

Ürünün canlıya çıkmadan önce yapılan yazılım sisteminin bütününün test edilmesidir. Yazılımın aynı zamanda donanım ve diğer dış kaynaklarla beraber denenmesidir. 50'den fazla çeşidi bununmaktadır. Kullanılabilirlik (usablity), regression [^regression], functional, performans en çok kullanılan system testing çeşitlerindendir.

Çoğu zaman Functional Requirement Specification (FRS) [^frs], System Requirement Specification (SRS) [^srs] gibi üst seviye dökümantasyonlardan yararlanılır.

# Code Coverage (Test Coverage)

Yazılan testlerin, yazılımı gerçekte ne kadarını kapsadığının hesaplandığı yöntemdir. Teorik olarak code coverage %100 olan yazılımlar hatasızdır denebilir ancak pratikte birçok yönden çok fazla sayıda test yazılmasını gerektireceği için çok zordur. Ancak oran ne kadar yüksekse hata oluşma olasılığı düşer.

**TDD** kullanımı code coverage'ın yüksek tutulması için bir yöntem olarak düşünülebilir çünkü TDD ile testi olmayan kod yazılmaması amaçlanır.

Çok kullanılan code coverage ölçüm yöntemleri:

* Statement Coverage: Kaynak kodunun satır bazında ne kadarının çalıştığına bakar
* Decision Coverage: `if`, `while` gibi karar elemanlarında `boolean` değerinin tümüne bakar. bir kere `true` bir kere de `false` seçilebilmesi yeterlidir.
* Condition Coverage: Yine decision coverage gibi ama bu sefer karar statement'larınındaki tüm değişkenler test edilmeli.

# Continuous integration



# Continuous Delivery

# Demo

# Kaynaklar

* <http://www.turkishtestingboard.org/files/ISTQB-Yazilim-Testi-Terimler-Sozlugu.pdf>
* <http://www.guru99.com/software-testing-life-cycle.html>
* <http://istqbexamcertification.com/what-is-integration-testing>
* <http://googletesting.blogspot.co.uk/2015/04/just-say-no-to-more-end-to-end-tests.html>
* <http://www.artima.com/weblogs/viewpost.jsp?thread=203994>
* <http://www.developertesting.com/archives/month200705/20070504-000425.html>
* <http://www.bullseye.com/coverage.html>

<br />
{% include series.html %}
<br />

**Dipnotlar:**

[^stubdriver]: <http://testingbasicinterviewquestions.blogspot.com.tr/2012/01/why-we-use-stubs-and-drivers.html>
[^regression]: <https://en.wikipedia.org/wiki/Regression_testing>
[^frs]: <https://en.wikipedia.org/wiki/Functional_requirement>
[^srs]: <https://en.wikipedia.org/wiki/Requirements_analysis>