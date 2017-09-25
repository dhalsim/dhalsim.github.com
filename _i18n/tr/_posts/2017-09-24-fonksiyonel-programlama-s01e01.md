---
layout: post
title: "Fonksiyonel Programlama - S01E01"
description: "Fonksiyonel Programlama - S01E01: Fonksiyonel Programla hakkında yazmak, okuyucuyu neler bekliyor"
image: "/assets/images/icon-fp.svg"
toc: true
category: ["fonksiyonel-programlama"]
tags: ["fonksiyonel-programlama", "functional-programming", "OOP", "software"]
series: "Fonksiyonel Programlama"
series_category: "fonksiyonel-programlama"
series_no: 1
excerpt: "Fonksiyonel programlama üzerine yeni bir seri. Bu serinin ilk yazısında önsöz olarak kendi tecrübelerimi ve beni yazmaya iten sebepleri yazdım. İlk bölüm olarak yazılımın çıkmazlarında OOP'nin yetersiz kaldığı durumlara değinip FP'nin tanımını yaptık."
---

# Önsöz: Fonksiyonel Programlama hakkında yazmak

> Yıllardır fonksiyonel programlamayı araştırıyorum, öğrenmeye çalışıyorum, notlar tutuyorum, hakkında vidyolar izliyorum, bloglar makaleler okuyorum ve bir noktaya kadar gelip tıkanıyorum.

İş hayatında **FP** (fonksiyonel programlama) tekniklerini uygulayacak fırsatı bulamamam, çevremde böyle bir farkındalığın olmaması daha da önemlisi iş hayatına verdiğim bir seneye yaklaşan ara, önceliklerimin değişkenliği nedeniyle bu konuya daha önceden istediğim gibi eğilemedim.

Birçok kere sayfalarca İngilizce ve Türkçe taslak yazılar, küçük programlar yazdım. Sonunda anladım ki FP bir derya ve tamamını öğreneyim de sonra yazayım yöntemi bende işe yaramayacak.

Bu yaşadığım problemi aşmak için bir strateji geliştirdim: *Her hafta en az 2 veya 3 blog makalesi ile kısa kısa, pratiğe dayalı yazılar yazmak.*

> *"çok acil olarak değil ama çabuk çabuk yapılması gerekiyor."* 
> 
> Necati Şaşmaz

Bir Türk olarak tabii ki **kervan yolda düzülür** diyorum ve taslaklarımdan da yardım alarak bu girizgahla başlıyorum.  

## Bu seri kimlere hitap eder?

* Herhangi bir programlama dilinin basit syntax'ını bilen veya biraz bakıp anlayabilen
* Yazılım ve **OOP** temel problemleriyle ilgili farkındalık sahibi olan
* İngilizce terim gördüğünde bilmiyorsa sözlüğe bakabilen
* Büyük bir yazılım projesini *fail* etmiş olan
* Yazılımı daha iyi nasıl yaparım derdi olan
* Önceden öğrendiklerini unutup yepyeni fikirlere açık olabilen

dimağlara hitap etmektedir.

## İçerik nasıl olacak?

İçerik tamamen s.kimin keyfine göre olacak. 

* Kendimi belli bir programlama diliyle, spesifik teknolojiyle kısıtlamayacağım. 
* Daha önce de uyguladığım gibi tek proje üzerinden evrile evrile de gidebilirim, hap şeklinde küçük örneklerle de. 
* İlk yazılarımdaki gibi şekiller çizerek anlatımı güçlendirme yöntemine başvurabilirim ya da sıkılırsam anlamazlarsa anlamasınlar amk diyebilirim.
* Espirili bir dil de kullanabilirim, kasmayıp MEB kitapları formatında da yazabilirim

## Nasıl başlamalı?

1. Kendim bu yazıya nasıl başlayacağım

    Birşey hakkında ilk yazarken bence en sıkıcı olan giriş ve tanımdır. Sonuçta bilmediğin bir konu, oradan buradan duyduğun yarım yamalak, yalan yanlış bilgiler var. Giriş bölümünü okuyunca insanda devamı ile ilgili bir fikriyat oluşmalı. 
    
    Ama seçtiğim format buna çok uygun değil. Belki ilk başta anlatmam gerekenleri ortalarda söylerim. Ama yazarken FP'yi  hiç bilmeyenlere göre yazacağım, o yüzden bana güvenin ve okumaya devam edin.

1. Siz nasıl başlayasınız?

    Bence okumaya devam edin. Bildiğiniz kısımlar olursa bir sonrakine geçin. Ama tekrar etmekte fayda var. Sıkılırsanız başka kaynaklara bakın ve geri dönün. Olmadı baştan tekrar okuyun. Örnekleri çalıştırmayı deneyin. Kurcalayın, bol bol hata yapın. Ne bileyim uğraşın biraz işte. Çok sıkıştığınızda yorum yazın veya mail atın.

# S01E01: Niye?

İş yerinde çalışırken farkettim ki: 

* kodu yazarken **X zaman** harcıyorsam
* kodu test etmem yine en az X zaman
* kodu doğru çalışabilir hale getirmem 3X zaman
* bozduğum diğer yerleri bulup düzeltmem 5X zaman

sürüyordu. Mesaimin yarısını da başkalarının hatalarını bulup düzeltmeye ayırıyordum. Verilen estimation'lar tutmuyor ve bu durum düzelecekmiş gibi de görünmüyordu.

Bu problemlerle ilgili elimizdeki alet kutusu şuydu:

OOP, SOLID, design patterns, refactoring, DRY, unit testing, code reviewing, CI, pair programming, QA

Bunların hepsini tabii ki uygulamıyorduk. Uygulasak da yarım yamalak, çoğunluğunda ortamlarda SOLID uyguluyoruz demek içindi (kim bilecek). Ama sonuç olarak elimizdeki aletler sorunu tamamen çözmemize yetmiyordu hatta belki de engel oluyordu. Kimse bu yöntemleri nasıl en doğru şekilde uygulanması gerektiğini bilmiyordu. 

* OOP ve design patterns uygulayayım derken kod gereksizce şişip karmaşıklaşıyordu. 
* Class isimleri arttıkça isimlendirme problemleri yaşıyordum: XManager, XProvider, XBuilder gibi. Doğru ismi bulmak çok zaman alıyordu
* Refactoring yaparken başka yerler bozuluyordu.
* Kimse test yazmak istemiyor, yazılan testler de çoğu zaman işe yaramıyordu
* Code review bazen işe yarasa da yaramadığı çok oluyordu
* QA'den dönen bir bug'ın çözümü günler sürebiliyordu

Mimari açıdan problemler kadar kodun kendisi de zamanla çok problemli hale geliyordu. En basitinden business içeren, asıl işi yapan bir kodu incelediğimde karşıma: 

* yüzlerce satırlık metotlar
* oradan buradan kopyalanmış parça kodlar
* yama yapıla yapıla kodun bütünlüğü ve amacı kaybolmuş
* okunabilirliği çok az
* debug yapmadan nasıl çalışacağı tahmin edilemeyen
* başka yerleri bozmadan değiştirmesi imkansız

kaynak kodları ortaya çıkıyordu. Yazılımcılar kendi aralarında design pattern'lar hakkında konuşup masturbasyon yapadursunlar, mikroskopla en derine indiğinde bile **problemsiz kod bulamıyorsun**.

> Ben de hatasız kul olmaz ama hatasız kod olur mu diye inceden araştırmaya başladım. İşte o sırada **fonksiyonel programlama**yla ilk tanışmamı gerçekleştirdim.

## Karmaşıklığın çözümü nedir?

Eğer büyük bir yazılım projesinde çalışıyorsan seni en fazla sıkıştıracak problem karmaşıklık problemidir.

<blockquote class="twitter-tweet" data-lang="en"><p lang="en" dir="ltr">OO makes code understandable by encapsulating moving parts.  FP makes code understandable by minimizing moving parts.</p>&mdash; Michael Feathers (@mfeathers) <a href="https://twitter.com/mfeathers/status/29581296216">November 3, 2010</a></blockquote>
<script async src="//platform.twitter.com/widgets.js" charset="utf-8"></script>

<br />

OOP'de ne yapıyoruz? Değişen kısımları **abstraction**'a alıp, kalan kısımları ortaklaştırmaya çalışıyoruz. OOP'un bize sunduğu en büyük araç da **inheritance**.

Tabii OOP guruları, inheritance'ın problemlerini görüp: **Composition over inheritance** prensibini tavsiye etmişler.

> Çevremize ve hatta evrene baktığımızda da karmaşık görünen sistemlerin aslında birbirine çok benzer parçaların farklı birleşimlerinden, kombinasyonlarından oluştuğunu görüyoruz.

FP de tam olarak bu composition üzerine gidiyor. Composition'ı sağlayabilmemiz için uymamız gereken kuralları gösteriyor.

**Bu kuralları öğrenmeden önce FP neymiş bakalım:**

## Tanım

**FP, matematikteki fonksiyon tanımındaki fonksiyonları kullanılarak yapılan programlamadır.**

Bu kadar basit aslında. Lise matematiğinden hatırladığımız fonksiyonlar. Evet hakikaten de *"Hocam gerçek hayatta bu bizim ne işimize yarayacak?"* diye sorduğumuz konular işimize yarayacakmış. Keşke zamanında iyi dinleseymişim.

Peki **matematikteki fonksiyon** neydi? Hatırlayalım:

Dokuzuncu sınıf matematikte yaptığı tanımı aynen alıyorum:

A ve B boş olmayan iki küme olsun. A’nın her elemanını B’nin yalnız bir elemanına eşleyen A’dan B’ye bir f bağıntısına, A’dan B’ye bir fonksiyon denir.

![](/assets/images/mathematical-function.png)

Fonksiyon olması için;

1. A’nın her elamanı B’ye gidecek.
1. A kümesinde açıkta eleman kalmayacak.
1. A’nın herhangi bir elamanı B’ye iki defa gitmeyecek.

> İyi de ne var bunda zaten yazdığımız fonksiyonlar böyle değil mi?

Tam olarak değil. Cevabını bir sonraki bölümde örnek üzerinden göreceğiz.