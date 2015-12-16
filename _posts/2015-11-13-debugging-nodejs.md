---
layout: post
title: "Debugging Node.js"
toc: true
description: "Bu makalede node.js uygulamalarının lokalde ve remote üzerinden nasıl debug edilebileceğini okuyabilirsiniz."
category: ["node.js", "kontrol-bende"]
tags: ["node.js", "debugging"]
series: "Kontrol Bende"
series_no: 1
image: "https://nodejs.org/static/images/logos/nodejs.png"
---
{% include JB/setup %}

{% include series.html %}
<br />

Şimdi elimizde bir node.js uygulaması var. Kodları var, çözemediğimiz çalıştırabiliyoruz ama bazı problemler/hatalar meydana geliyor. Onları incelememiz lazım. Burada noluyor? debugging devreye giriyor.

<!--more-->

![](/assets/images/kitten.png)

Genelde gariban yazılımcı debugger'ıyla birlikte doğmuştur. Bir program yazarken yaptığı her satır değişiklikte en az bir seans debug etmezse o program çalışmaz. Eğer çalışırsa bu mucizedir.

Bu ciddi şekilde verimsiz bir yöntemdir. Ve en çok ihtiyacımız olan beyin hücrelerimize zararlıdır.

Ancak genelde başka bir yöntem bilmediğimizde veya **gerçekten ihtiyaç olduğunda** kullanmak kaçınılmazdır.

Ama sizi mağdur yazılımcı rolünü oynamaktan men ediyorum ve muhteşem makaleme davet ediyorum efendim. (bkz: [Unit Testing]())

## Local Debugging

Ve işte zorunlu olarak debug etmemiz gereken bölgedeyiz. Artık bizi bu beladan ancak bir debugger kurtarabilir.

Şimdi burada debugging mevzusunu da 2'ye ayırdım ister istemez. **Local** ve **remote** olmak üzere:

Local demek, kendi bilgisayarımız üstündeki uygulamamız anlamında. Başka bir bilgisayar üzerindeki uygulamayı kendi bilgisayarımızda debug etmeye ise **remote debugging** deniyor. Ona sonra geleceğim.

Bu yazıda node.js uygulamaları nasıl debug edilir bunu göreceğiz. Bu yazıda [node-inspector](https://github.com/node-inspector/node-inspector) kullanacağız.

İndirgeç:

~~~
npm install -g node-inspector
node-debug app.js
~~~

şeklinde debug edebiliyoruz.

> Not: node-inspector sadece Chrome ve Opera tarayıcılarını destekliyor.

Node-debug açıldığında otomatik olarak <http://127.0.0.1:8080/debug?port=5858> sayfasını varsayılan tarayıcınızda açacaktır.

Şimdi *node-debug* da ne ola ki derseniz aslında bu **local** üzerinde debugging işlemini kolaylaştıran bir araçlar silsilesi.

1. node'u --debug-brk parametresiyle çalıştırıyor (ilk satırda durması, 5858 portunu dinlemesi)
1. node-inspector'u 8080 portu üzerinden çalıştırıyor
1. Varsayılan tarayıcıda debug'ı başlatıyor

Ayrıca yüzbinlerce özellik daha: <https://github.com/node-inspector/node-inspector#features>

## Remote debugging

Şimdi başka bilgisayardaki bir uygulamayı kendi bilgisayarımızda nasıl debug ederiz onu görelim. Niye böyle bir şey yapayım beni deli mi öptü demeyin. Mesela production bir ortamda, mesela grafik arayüzü olmayan bir Linux sistemininde uygulamanız çalışıyor. Ha, o zaman tamam.

Size bunun demonstreşınını vagrant üzerinden yapacağım ki bir zamanlar **vagrant** üzerinden nasıl proje çalıştırılır onu da yazmıştım lanet olsun.  (bkz: [Vagrant? Buyur?]())

Şimdi vagrant üzerinden, o yazıdaki projeyi nasıl debug ediyoruz, görelim:

~~~
vagrant up
vagrant ssh
# --> ilgili projenin klasörüne gidin (chatcat?)
grunt dev
~~~

ile açtığımız VM'in ilgili klasörüne gidip uygulamamızı buluyoruz. Uygulamayı *debug* modunda başlatmamız gerekiyor. Ama biliyorsunuz ki biz bunu nasıl **grunt**'ta başlatacağızı da öğrenmiştik allah belamızı vermesin.

Önceki [Multiroom Chat]() uygulamamamızda **nodemon** kullanmıştık. Grunt içindeki ayarların şu şekilde olduğuna emin olun:

~~~js
nodemon: {
  dev: {
    script: 'app.js',
    options: {
      nodeArgs: ['--debug-brk'],
      watch: [
        'app.js',
        'Gruntfile.js',
        'src/**/*.js'
      ]
    }
  }
}
~~~

İkinci olarak yine başka bir terminalde `vagrant ssh` ile bağlantı daha kuracağız ve onda da `node-inspector`'ı çalıştıracağız.

Farkedersiniz ki bize utanmadan `Visit http://127.0.0.1:8080/?ws=127.0.0.1:8080&port=5858 to start debugging.` gibi tavsiyelerde bulunuyor bu ukala program!

Ama bilmiyor ki biz bir VM üzerindeyiz de görsel bir browser'ımız yok. Nasıl açıp da bakalım?

Ama zaten konumuz **remote debugging** olduğundan debug olayını kendi bilgisayarımızda yapacağız. O yüzden link'te verdiği **8080** ve **5858**
portları bizim için önemli.

Neden önemli, çünkü **port forwarding** (port yönlendirme - verdiğim linkte yazdım bu ne deme şimdi) yapacağız:

**VagrantFile:**

~~~
...
config.vm.network "forwarded_port", guest: 3000, host: 3000
config.vm.network "forwarded_port", guest: 8080, host: 8080
config.vm.network "forwarded_port", guest: 5858, host: 5858
...
~~~

Gerekli tüm portları kendimize yönlendirdik. Bu portlar kendi bilgisayarımızda VM'in kullandığı portlara yönlenecek. Şimdi ayarları girdik ama VM'i tekrar başlatıp komutları tekrarlamamız lazım. İyi oldu hem pekişmiş olur konu:

* `CTRL+C` ile uygulamadan çıkın.
* `exit` ile *ssh* bağlantısından çıkın.
* `vagrant reload` ile VM baştan başlasın ki port ayarları yüklensin
* `vagrant ssh` ile tekrar bağlanın
* ilgili klasörde `grunt dev` diyin ki *nodemon* --debug-brk ile çalışsın
* başka bir *shh* bağlantısında `node-inspector` açın ki debug bilgilerini göndersin
* kendi bilgisayarınızda size söylediği linki açın (hiçbir ayar değiştirmediyseniz <http://127.0.0.1:8080/debug?port=5858> olacaktır)

## Bonus

Anlamadım bıbıcım diyenler ve benim muhteşem debug yeteneklerimi (alet işler el övünür) görmek isteyenler sizi youtube'a alalım: <!!BURAYA LINK GELECEK!!>

<br />
{% include series.html %}
<br />
