---
layout: post
title: "Yazılım Geliştirme Modelleri"
description: ""
toc: true
category: ["software"]
tags: ["software-models", "waterfall", "spiral", "agile", "xp"]
excerpt: "Her yazılımcının bilmesi gereken yazılım geliştirme süreçlerine değineceğiz. Yazılım geliştirme modellerinin en çok kullanılanlarının avantaj ve dezavantajlarını görüp XP ve agile prensiplerine değineceğiz."
series: "Teori Önemlidir"
series_no: 1
---
{% include JB/setup %}

{% include series.html %}

> NOT: Bu metotlar tek başlarına iyi, kötü, çöp şeklinde sınıflandırılmamalıdır. Burada yazılmayan daha birçok model vardır. Seçilecek model, projenin tipine, boyutuna vs. bağlı olarak değişebilir, ya da hibrit çözümlere gidilebilir. Dezavantajlı kısımlar farkında olunduğunda üstesinden gelinebilir.

# Geleneksel (waterfall) model

![](/assets/images/waterfall.png)

* İhtiyaçların belirlenmesi (Requirements analysis) => Ürün gereksinmeleri
* Analiz => Modeller, iş kuralları
* Tasarım => Genel mimari
* Kodlama => Geliştirme
* Testing => Doğrulama
* Bakım => Kurulum, destek vs.

Dökümantasyon ağırlıklı, kolay kontrol edilebilir, yönetilebilir süreç gibi artıları vardır. Büyük karmaşık problemlerde, gerekliliklerin önceden belli olduğu ve değişimin çok az olacağı projelerde kullanılır.

Ama günümüz projelerinin çoğu daha farklı ihtiyaçlara sahip olduğundan olsa gerek sonuç şunun gibi olabiliyor:

![](/assets/images/itproject.png)

Peki neden böyle oluyor diye kendilerine sorduklarında şu problemleri buldular:

* Projenin başında tüm gereksinimlerin ve analizin yapılmaya çalışılması (Over-analysing)
* Yazılım süreçlerinde müşteri ile iletişim son aşamalarda gerçekleşiyor ve bu yüzden istekler geç anlaşılıyor: *"Ama ben böyle istememiştim (ABBİ)" Sendromu*
* İlk aşamalarda yapılan eksik ve hataların son aşamalara kadar fark edilememesi.
* Projelerde gereksinimler sık sık değişikliğe uğruyor. Bu da önceden yapılan çalışmaların boşa gitmesine neden olabiliyor (Değişim)

# V-Shaped Model

![](/assets/images/v-model.png)

> A functional specification (or sometimes functional specifications) is a formal document used to describe in detail for software developers a product's intended capabilities, appearance, and interactions with users.

V şeklindeki bu modelimizde, sürecin her aşamasına karşılık bir doğrulama (verification) adımı yer almakta. Ortasında da bizim bu şemada göremediğimiz planlama aşamaları yer almaktadır. Sıralama şu şekilde diyebiliriz:

1. Requirements => System Test Planning
1. High Level Design => Integration Test Planning
1. Low Level Design => Unit Test Planning
1. Implementation
1. Unit Testing
1. Integration Testing
1. System Testing

Test odaklı bir süreç. Waterfall modeline göre test daha erken safhalarda başlıyor, bu da son süreçlerde keşfedilen eksik ve hataları daha erken bulmaya neden oluyor. Ama waterfall gibi bu model de yeterince esnek olmayabiliyor.

Testing'le ilgiliyseniz sizi şu güzel yazımıza alalım => [Software Testing](/software/2015/11/15/software-testing/)

# Prototyping Model

> “I can’t tell you what I want, but **I**’ll **k**now **i**t
**w**hen **I** **s**ee **i**t.”

> IKIWISI sendromu: İstediğim şeyi ancak görünce söyleyebilirim

Bitilmemiş yazılımların üretilerek, ön çalışma yapılması olayıdır. Böylece müşterinin ihtiyaçlarıyla karşılaştırılması mümkün olmaktadır. Aynı zamanda ihtiyaç analizlerinin doğrulamasını da sağlar.

Dezavantajları:

* Doğası gereği kullanıcı etkileşimi az olan, hesaplama yoğun işlerde faydası azdır.
* Mühendislik açısından bakımı zor, doğru analiz edilmemiş yazılımların üretilmesine sebep olabilir. Projenin bütünü açısından bakıldığında prototip aşamasında öngörülemeyen eksikliklere (güvenlik, performans vs) açıktır.

# İteratif modeller

![](/assets/images/iterative.png)

Basitçe, yazılım sürecini daha küçük parçalara (phases) ayırıp, her parça için küçük birer waterfall metodu uygulamak gibi anlatılabilir. Burada amaç kodlama zamanı sürecini erkene alıp çıkan sonucu erken görebilmektir.

Projedeki işleri daha küçük modüllere veya özelliklere ayırıp, birikmeli (incremental) şekilde yapılmasıdır. Bu parçaların her birinin sonucu bir sonraki parçanın analizinde bir girdi olmakta ve bu projenin daha hızlı geliştirilmesini sağlamaktadır.

# Spiral Model

![](/assets/images/spiral_new.png)

[1] <a name="ConOps"></a> [Concept of Operations](https://en.wikipedia.org/wiki/Concept_of_operations)

Spiral model, **risk tabanlı** bir **süreç modeli** oluşturucusudur. Birden çok tarafın, eşzamanlı bir şekilde, yazılım yoğun sistemlerin mühendisliğine yönlendirilmesine yarar. İki ana ayırt edici unsuru vardır.

İlki, bir sistemin tanımlanması ve gerçekleştirilmesi seviyesinin artırılması, aynı zamanda risk seviyesinin azaltılması için **döngüsel** bir yöntem olması. İkincisi, tüm tarafların onaylayacağı hem uygulanabilir hem de tatmin edici sistem çözümleri sağlamak amacıyla birkaç tane **anchor point milestone** (LCO, LCA, IOC) belirtilmesidir.

Şimdi yukarıdaki tanımdaki geçen kavramları açıklamaya çalışalım

**Süreç (process) modeli** iki ana soruyu cevaplar:

 * Şimdi sıradaki yapılacak iş ne?
 * Ne kadar süreyle yapılmaya devam etmeli?

**Risk tabanlı**'daki bahsedilen riskler, proje amaçlarına doğru giderken, onu başarısızlığa uğratacak olası olaylar ve durumlardır. Etkisi önemsizden ölümcüle ve olasılığı mümkünden kesine doğru olabilir. Modelin devamı bu risklerin belirlenmesine bağlıdır ve en önemli adımdır.

**Döngüsel:** Tüm işlerin bir kerede yapılması yerine, kalan önemli risklerin azaltılması şeklinde adım adım gerçekleşir.

**Model oluşturucu:** Spiral model aslında risk yönelimli bir süreç modeli oluşturucudur. Farklı risk biçimleri *incremental*, *waterfall*, *evolutionary prototyping* ya da başka süreç modellerinin seçilmesini sağlar.

Spiral modelin 6 kuralı ve esneklikleri:

1. Anahtar ürünlerin eşzamanlı olarak kararlaştırılması ([Concept Of Operations](#ConOps), ihtiyaçlar, planlar, tasarım, kod)
	* Bunun ardışık olarak yapılması projenin kısıtlanmasına veya doğru bir ürün ortaya çıkarılamamasına yol açabilir.
	* **Esneklik:** Anahtar ürünlerin yoğunlukları
	* **Esneklik:** Spiralde olabilecek mini spirallerin sayısı.
	* **Örnek:** İhtiyaçlar maliyet ile birlikte düşünüldüğünde, bazı kısıtların esnetilmesi
2. Her döngüde bu dört adım uygulanması
	*  Tüm tarafların (stakeholders) amaçlarının ve kısıtlarının **(kazanma şartı)** dikkate alınması
	*  Kazanma şartlarını sağlayacak alternatif çözümlerin ve risklerin belirlenmesi, değerlendirilmesi
	*  Bu belirlenen risklerin giderilmesi, çözümün uygulanması
	*  Tüm önemli taraflarca onay alınması ve sonraki döngüye devam taahhütü
	*  **Örnek:** Kritik tarafların sistemin belirlenmesi ve geliştirilmesi aşamalarında yer almaması daha sonraki üretilen ürünün kabul edilmemesine yol açabilir, riski arttırır.
	*  **Örnek:** Sadece Windows kullanan kullanıcıları katarak düşünülen bir sistem, satın alınması veya geliştirilmesi sonucu Windows kullanmayan kullanıcılar açısından kabul edilemez.
3. Harcanacak eforun risk tarafından belirlenmesi
	* Yapılacak aktivitelerin ne kadar süreyle yapılacağının
	* Toplam riskin minimuma indirilerek belirlenmesi
	* **Örnek:** Testing'in ne kadar süreceği, bitirilmemiş ürün sunumu veya markete geç girme risklerinin toplamının minimumu şeklinde belirlenmesi
	* **Esneklik:** Aktivitelerin yöntemleri, modeller
	* **Esneklik:** Risk değerlendirilmesi ve yönetimindeki çeşitli yöntemler
4. Detayın seviyesi risk tarafından belirlenir
	* Bir aktivitenin çok detaylandırılması veya
	* Bir aktivitenin az detaylandırılması riski artırıp artırmamasına göre yapılır
	* **Örnek:** Grafik arabiriminde kısıtlamalar koymak (detay) ileriki aşamalarda riskin artmasına neden olabilir. Ya da hiç kısıtlama koymamak ileride kullan kolaylığı açısından riskli ürün çıkması neden olabilir.
5. Anchor point milestones kullanımı:
	*  **Life Cycle Objectives - LCO:** Tüm tarafların (stakeholders) amaç ve kısıtlarını (win conditions) tatmin edecek yeterli teknik ve yönetimsel yaklaşım tanımı var mı?
	*  **Life Cycle Architecture - LCA:** Tüm tarafların amaç ve kısıtlarını sağlayan öncelikli bir yöntemin, yeterli bir tanımı var mı? Tüm önemli riskler çözülmüş veya azaltılmış mı?
	*  Bu iki **milestone**'da eğer cevap evet ise bu milestone'lar aşılmıştır, aksi durumda proje iptal edilebilir veya taraflar bir döngü daha evet cevabına ulaşmaya çalışabilir.
	*  **Initial Operational Capability - IOC:** Yazılım, site, kullanıcılar, yöneticiler ve destek ekibi, sistemin canlıya çıkışına yeterince hazır mı?
	*  Cevap evet ise sistem canlıya çıkabilir, aksi durumda proje iptal edilebilir veya taraflar bir döngü daha evet cevabına ulaşmaya çalışabilir.
6. Sistemin ve yaşam döngüsünün bütününe önem verilmesi:
	* Sistemin bütünü ve tüm yaşam döngüsünü kapsayan uzun dönemli kaygıların öneminin önplana çıkarılmasıdır. İlk geliştirilmesi esnasındaki aşırı odaklanmayı dışlar.
	* **Örnek:** Yazılımdaki diğer süreçlerin arkaplana atılarak sadece teknik konuların düşünülmesinin önüne geçilmesi

## En çok yapılan yanılgılar!: (hazardous spiral look-alikes!)

* Spiral, sadece sıralı waterfall adımlarından oluşur; projedeki her şey tek bir spiral sırasını izler.
* Diagramdaki tüm öğelerin belirtilen sırada takip edilir
* Önceki kararları gözden geçirme, geri alma yolu yoktur

## Kaynaklar:

* <http://sunset.usc.edu/publications/TECHRPTS/2001/usccse2001-501/usccse2001-501.pdf>
* <http://www.sei.cmu.edu/reports/00sr008.pdf>
* <https://en.wikipedia.org/wiki/Spiral_model>

# Agile Model

2001 yılında *Agile Manifesto* ismiyle duyurulan bir modeldir. Türkçe'ye *çevik prensipler* olarak çevriliyor. Manifesto bir grup yazılım geliştirme yönteminden bahsediyor:

1. "Erken müşteri memnuniyeti ve kullanılabilir yazılımın sürekli teslimi (continuous delivery)". Yazılımın müşterilerle ve diğer taraflarla erken ve hızlı paylaşılması.
2. "Sonraki geliştirme aşamalarında bile ihtiyaçların değişmesine açık olmak". Bunun kaçınılmaz olarak geleceğini bilmeliyiz. Bu duruma kendimizi ve süreçlerimizi adapte etmeliyiz.
3. "Çalışan yazılımın aylar yerine haftalar içerisinde teslimi".
4. "İş insanları ve yazılım geliştiricileri arasında yakın ve günlük işbirliği".
5. "Projeler motive olmuş güvenilir kişiler tarafından yapılmalı". Buna kim karşı çıkabilir?
6. "Yüz yüze iletişim en iyi iletişim şeklidir". Aynı yerde bulunmayı gerektirir.
7. "Çalışan yazılım ilerlemenin ana ölçüsüdür". Çalışan yazılım oluşturulan dökümanlardan daha önemlidir deniyor.
8. "Sürdürülebilir geliştirme sürekliliği ve hızı korunmalıdır".
9. "İyi tasarım ve teknik mükemmellik sürekli gözetilmelidir".
10. "Basitlik -yapılmayan işlerin artırılma sanatı- temeldir". Yazar burada gereksiz işlerin yapılmaması gerektiğinden bahsediyor, neyin gerekli neyin gereksiz olduğunu bulmak ve buna göre davranmak zor bir iştir.
11. "Kendi kendine organize olabilen takımlar". Bu durumda insanlar istedikleri işi yapacakları için takımlar daha verimli olacaktır
12. "Belli zaman aralıklarında takımın daha verimli olmanın yollarını bulur ve buna göre hareketlerini düzenler".

Bir de dört ana prensipten bahsedilir:

* "Kişiler ve iletişim, süreç ve araçlardan üstündür". Önemli olan kişilerdir ve gereksiz süreçler araya mesafe kolay, iletişimi olumsuz etkiler.
* "Çalışan yazılım, kapsamlı dökümantasyondan üstündür". Çalışan yazılım ortaya çıkmadan yapılan kapsamlı dökümantasyonların ilerleyen süreçlerde tamamen değişmesi bile mümkün olmaktadır. Dökümantasyon yazılımla beraber yürümelidir.
* "Müşteri işbirliği, sözleşmelerden üstündür". Müşteri ilk başta yapılan sözleşmelerde ne istediğinin tam olarak belirtmesi çok zordur. İstekler zaman içinde değişebilir. Bu durumlarda müşterinin istekleri sözleşmelerle çelişebilir veya yeterli gelmeyebilir.
* "Değişime cevap verebilme, belli bir planı uygulamaktan üstündür". Planlarımızın da değişime cevap verebilmesi gereklidir.

Burada yaptığım çeviride **üstündür** kelimesini bilerek seçtim. Burada anlatmak istenilen cümlelerin solundakiler, cümlenin sağındakilere göre daha önemlidir ama bu sağındakileri hiç uygulamamak anlamına gelmemeli. Sadece aslında neyin önemli olduğunu, ve kimlerle alakalı olduğunu unutmamak gerekiyor.

## Kaynaklar

* Agile: <https://scrumalliance.org/community/articles/2012/september/what-agile-is-%E2%80%94-and-what-it-isn%E2%80%99t>

# Extreme Programming (XP) Modeli

![](/assets/images/dilbert-xp02.gif)

Extreme programming modelini, çevik prensiplerin uygulama geliştirmeye olan cevabı olarak görebiliriz.

Yıllardan beri kullanılagelen doğru yazılım geliştirme yöntemlerinin (best practices), _aşırı_ bir şekilde kullanılmasıdır:

Mesela yazılımın test edilmesi iyi birşeydir. O halde yazılım sürekli test edilebilir olmalıdır. Müşteri geliştirici arasındaki iletişimin iyi olması önemlidir. O halde müşteri takımın bir parçası olmalıdır. Esnek olabilmek iyidir. O halde planlama esnekliği sağlayacak şekilde olmalıdır. Yazılımda kalite iyi birşeydir. O halde kaliteyi artırabilmek için sürekli değişiklik yapılması gerekir, geliştiriciler birlikte çalıştığında daha verimlidirler, o halde **pair** olarak çalışmaları gerekir gibi...


Aynı zamanda çevik prensiplerden birçoğunu barındırır: **basitlik, iletişimin önemi, karşılıklı güven, esnek planlama, motivasyon** vb.

![](/assets/images/xp_project.png)

## Müşterinin önemi

XP takım odaklı bir modeldir ve takım içinde **müşteriyi** de koyar. Planlamalarda müşteri de bulunur çünkü toplantılardan dışlanılmayacak kadar önemlidir. Ancak müşteri XP'nin gerekliliklerini yerine getirebilecek yetkinlikte olmalıdır. Konusuna hakim, sorumluluk sahibi, teknik ekibe güvenen (özellikle zaman tahminlerinde ve bunlar tahmin olduğunun bilinciyle), karar verici, önceliklendirme yapabilen, testlerde yer alan vb.

## User stories

Müşterinin bir diğer görevi de **user story**'leri oluşturmaktır. User story'ler, teknik konulara girmeden kullanıcı bakış açısıyla anlaşılabilir, basit, test edilebilir bir şekilde birkaç cümle halinde yazılır. Yapılma süreleri birkaç günden birkaç haftaya kadar olmalıdır. Süre tahminleri geliştiriciler tarafından yapılır, müşteri tarafından da **önceliklendirir**. Geliştirici bunların zaman tahminlerini yapar, bunu yaparken müşteriyle iletişim halindedir. Bir sürümde hangi user story'lerin yapılacağının belirlenmesine **sürüm planlaması** denir.

> User story'ye örnek olarak; `Başlık: <kullanıcı tipi> olarak, <nedeni> ile, <amaç> olmasını istiyorum` kalıbı kullanılabilir:
>
> * "Yorumların imla kontolü: Müşteri olarak yorum alanına yazılan kelimelerin imlasının kontrol edilmesini istiyorum".
> * "Favoriler: Kullanıcı olarak sevdiğim filmleri favori listesine alabilmeyi istiyorum".
> * "Sistem performansı: CTO olarak sistemin 1000 eşzamanlı kullanıcıyı kaldırabilmesini istiyorum".

## Sürüm Planlaması

User story zaman tahminleri yapılırken eğer önceden benzer işler yapılmışsa ondan yararlanılabilir. Aynı zamanda tüm geliştiriciler fikirlerini söyler ve belli bir zamanda anlaşmaya çalışırlar. Bu yöntem gözden kaçan riskleri ortaya çıkarır ve konunun anlaşılmasına yardım eder. Ancak her durumda bunun tahmin olduğu, yanılabileceği gözönüne alınmalıdır. Zaman içerisinde tahminlerde gerçeğe yakın sonuçlar almak kolaylaşır.

## İterasyon Planlaması

**Küçük sürümler** -birkaç aylık sürelerde önerilir- de XP'nin önemli özelliklerindendir. Sürümler de **iterasyonlarla** yaklaşık 2 haftalık zaman dilimlerine bölünür. Bir iterasyonda takımın kapasitesine ve önceki deneyimlerden alınan bilgilerle (**project velocity**), user story'lerin ne kadarı yapılacağı planlanır. Buna **iterasyon planı** denir.

Her iterasyon **otomatize testlerden** geçmeli ve müşterinin onayını almalıdır. Müşteri testlerin sonuçlarına göre **geri bildirimlerde** bulunur. Bu bildirimler sonraki iterasyon planlarında değerlendirilir. Gerektiği durumlarda -mesela müşteri fikir değiştirdiğinde veya geliştirici birşey farkettiğinde- sürüm planı da tekrar yapılmalıdır. Sürüme ulaşana kadar bu iterasyonlar -isminden de analışılacağı üzre- tekrarlanır. Bu iterasyonlarda müşteri **önceliklendirme** yapmaya devam eder.

Önceliklendirme yapılırken müşterinin fikirlerine öncelik vermeniz projenin başarısı açısından önemlidir. Ancak bazı özelliklerin birbirlerine bağımlılıkları vardır ve bir özellik yapılmadan diğer özellikler yapılamaz gibi görünür. Mesela bir banka yazılımda havale yapabilmek için önce hesap açma, para yatırma işlemlerinin yapılabilmesi gerekmektedir. Ancak XP programlamada yazılımların baştan **test edilebilir** olması sayesinde, sıralamada zorunluluğu ortadan kaldırır. Sadece kullanıcı açısından test edilemez ancak müşteriye testi mümkündür veya paylaşılabilir.

Sürüm planlamasında hangi user story'lerin hangi iterasyonlarda yapılacağı kararlaştırılmıştı. **Iteration planning**'te ise bu user story'ler **task**'lara bölünür. **Iteration planning** toplantısına müşteri dahil tüm ekip katılır. Yapılması gereken teknik task'lar da bu toplantıda çıkarılır. Geliştiriciler istedikleri task'ları seçer ve süre tahminini kendilerine göre yaparlar.  İterasyon zamanını aşan durumlarda müşteriden bazı story'lerin ertelenmesi veya tersi durumda müşteriden başka story eklemesi istenir. Toplantı esnasında müşteri story'ler ile ilgili gerekli detayları anlatabilir veya bunlarla ilgili dökümanlar istenebilir. Story'nin **kullanıcı kabul testleri** de bu aşamada hazırlanabilir.

Taskların kişilere atanması ve tahminlenmesi esnasında atanan kişi, kendi önceki yaptığı işlerdeki performansına (**project velocity**) göre bir tahminde bulunur. Bu tahminde geliştiricilere güvenmek gerekir çünkü herkes aynı hızda çalışmaz ve bu tahminler konusunda baskı yapmak doğru tahmin üretimi konusunda da problemlere yol açabilir. Bu yüzden en doğru yol kişinin daha önceki iterasyonlarda yaptığı iş hızının ve önceki benzer işlerdeki sürelerin ölçülmesi olabilir. Bu hesaplanan hıza göre kişiler kendilerine yetecek kadar task'a atanmış olmalıdır.

XP'de bir task'ın veya story'nin bitmesi demek kodlamasının bitmesi demek değildir. Tüm testlerin yazılmış olması ve hepsinin geçiyor olması gerekmektedir. Bu yüzden tahminlerde test için gerekiyorsa ekstra süre ayrılmalıdır.

## Motivasyon

XP'ye göre geliştiriciler geliştirmeleri **eşli** (pair programming) olarak yapmalıdır. Eşler birbirlerini taskların ihtiyaçlarına göre kendileri seçmelidir. Bu hem belli taskların yapılması süresini kısaltır hem de yazılan kodun en azından bir kişi tarafından gözden geçirilmesini sağlar. Takım içindeki iletişimi kuvvetlendirir. Geliştiriciler çalışmak için istedikleri taskları seçebilirler. Bu onları **motive** edecektir.

Story'nin bitmesine yakın veya ortasında müşteri tarafından kontrol edilmesi durumunda müşterinin istediği değişiklikler gördüğü eksiklikler önceden belli olacağı için bir story'nin tamamlanması daha kolay olacaktır. Son anda ortaya çıkan değişiklik istekleri geliştiricilerin motivasyonunu kötü etkilerken bu yöntem geliştiricilere bir taskın veya story'nin bitirilmesinde güven verecektir.

İterasyon sonunda geliştiricilerin yapılan işlerin üzerinden geçmesi (demo) de motivasyonu artıran şeylerden biridir.

## Takip

![](/assets/images/dilbertstandup.png)

İterasyon süresinde yapılması gerekenlerden biri de yapılan işlerin durumunun takip edilmesidir. XP'de bu işi yapmaya gönüllü **tracker** adında bir rol vardır ve bu kişi haftada bir iki kere tüm geliştiricileri sırayla ziyaret eder. Onlardan yaptıkları işlerin ve yapacakları işlerin listesini alır. Ne kadarlık daha yapacak işleri olduğunu öğrenir.

Bu şekilde tasklarla ilgili geliştiricilerin bir problemi varsa önceden tespit edilmiş olur. Gerekirse müşteri ile bir toplantı ayarlanıp konu hakkındaki soru işaretleri giderilebilir. Ya da daha tecrübeli kişilerden yardım alınabilir. Her durumda bir sorun olduğunda bunun erken anlaşılması daha iyidir.

Ayrıca günlük 15'er dakikalık **stand-up meeting**ler düzenlemek de takım içinde yapılan ve yapılmayan işlerin öğrenilmesini sağlar. Duyuruların veya yaşanan problemlerin aktarılma yeridir. Ancak problemlere ilişkin çözümler konuşulmaz, gerek duyulursa ilgili kişiler ayrı bir toplantı düzenleyebilirler.

## Pratikler

XP'nin bir diğer güçlü tarafı da pratiklerdir. Teknoloji ve ihtiyaçlar doğrultusunda her gün bu pratikler biraz daha gelişiyor ve çoğalıyor. Bunlardan bazılarını yüzeysel olarak inceleyeceğiz:

* Continuous process (süreklilik): Geliştirme sonucunda ara ara yapılan işlemlerin daha sık yapılmasını sağlayan genellikle otomatize edilmiş süreçlerdir.
	* Continuous integration (sürekli entegrasyon): QA süreçlerinin olmazsa olmazlarındandır. Yazılım süreçlerinde entegrasyon işlemleri her zaman en çok sorun çıkaran kısımlardan olmuştur. Bunu aşmak için daha sık ve daha erken entegrasyon önerilir. Bu entegrasyon işlemleri mesela her **commit** sonrası çalışan testler şeklinde olabilir. **Build server** gibi sistemler kullanılabilir
	* Refactoring (Tasarım iyileştirmeleri): Birçok şirkette yazılımın kalitesini ölçen özel yazılımlar kullanılmaktadır. Bu ölçümler yazılımın karmaşıklığını, modüller arasındaki bağımlılığı, kod tekrarı gibi değişik şeyler olabilir. Bu ölçümlerle beraber sürekli ve erken tasarımın iyileştirilmesi daha sonra çıkacak zor mimari ve tasarımsal problemleri engelleyebilir.
	* Küçük sürümler: Çalışan kodun sık aralıklarla güncel olarak *deploy* edilmesi işlemidir. Bu versiyonlar müşteriye açıktır ve bu işlemin sık yapılması müşterinin takibi ve yönetimi açısından önemlidir. Bazı problemlerin veya eksikliklerin erken tespiti ve erken düzeltilmesi daha sonra düzeltilmesinden daha kolay olur.
* Kod standartları: Tüm ekibin uymak zorunda olduğu kodlama standartlarıdır. Bu standartlar kaçınılması veya uygulanması gereken kodlama yöntemleri olabilir. Genellikle dile göre değişir ve dil topluluklarında belli standartlar zaten vardır, ancak takımlar değişiklik yapabilirler. Bu kodun herkes için daha anlaşılabilir olmasını sağlar.
* Pair programming (eşli programlama): Tek makinede aynı iş için iki programcının çalışması şeklindedir.
* Mesai: Fazla mesai XP topluluklarında kaçınılması gereken bir şeydir. Çünkü bu moral ve verimlilik açısından orta ve uzun vadede sorunlara yol açar
* Test-driven Development (test yönelimli geliştirme): Buradaki çoğu pratiğin hayata geçirilebilmesi için olmazsa olmaz yöntemdir. Çeşitleri vardır ve ayrı bir yazıyı haketmektedir: <<<!!! BURAYA TESTİNG YAZISI LİNKİ GELECEK !!!>>>
* Collective Code Ownership (Kodun müşterek sahiplenilmesi): Yazılan bir kodu isteyen herkes inceleyip değiştirebilir. Bu bugları azaltıp kodu iyileştiren bir sistemdir. Otomatize testler ve pair programming bunun için önşarttır.
* System Metaphor: Yazılımın tüm takım (geliştiriciler, müşteri, yöneticiler) tarafından anlaşılabilir bir tanımıdır. Tüm sistemin olduğu gibi daha küçük modüllerin ve sınıfların da isimlendirmesinde anlaşılır olması ve kendi kendini anlatması beklenir. Tabii bu konu kod standartlarında da ele alınabilir.

Kaynaklar:

* Planning Extreme Programming. ISBN: 9780201710915
* <http://www.extremeprogramming.org/>
* <http://c2.com/cgi/wiki?PlanningGame>
* <https://en.wikipedia.org/wiki/Extreme_programming_practices>
* <http://ronjeffries.com/xprog/what-is-extreme-programming>
