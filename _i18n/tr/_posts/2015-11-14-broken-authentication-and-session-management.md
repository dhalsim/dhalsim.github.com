---
layout: post
title: "Broken Authentication and Session Management"
description: "OWASP Top 10 Risks listesinde 2. sırada olan Broken Authentication and Session Management konusuyla ilgili notları okuyabilirsiniz."
toc: true
category: ["dotnet", "security"]
tags: ["dotnet", "security", "session management"]
excerpt: "ASP.NET uygulamalarında session management ile ilgili öneriler."
image: "/assets/images/cyber-security.jpg"
---
{% include JB/setup %}

## Genel bilgiler

* OWASP Top 10 Risks listesinde 2. sırada
* Genel itibariyle autorized kullanıcının session'ınını çalmak üzerine bir açık
* HTTP sessionless bir protokol ama session ihtiyaçları nedeniyle framework'ler ve browser'lar cookie denen bilgileri tutuyor. cookie bilgisi üzerinden web server kullanıcıyı tanıyor.
* Biz ASP.NET_SessionId cookie'sini kullanıyoruz. Cookie'ler session yönetimi açısından daha güvenli olduğu söyleniyor. Mesela Cookieless mod'un request URL üzerinden gitmesi [Session Fixation](https://www.owasp.org/index.php/Session_fixation) denilen atağa karşı daha açık olması anlamına geliyor.

##  Koruma yöntemleri

* Cookieless session'ın kapanması
* Authentication'ın bilinen, güvenilir yöntemlerle yapılması
* IP check
* Password recovery, sign up işlemlerinin güvenliğinin artırılması
* SSL kullanımı
* Session expire
* Cookie secure, httpOnly

## Şifre işlemleri güvenliği

* Şifre oluşturmada email confirmation/activation kullanılması, değiştirme işlemlerinde eski şifrenin de sorulması
* Secret question değiştirme işleminde şifre sorulması
* Bu bilgilerin loglanması

## SSL kullanımı

* tüm sitede SSL'in aktif olması
* http -> https redirection

## Session Expire

* Mümkün olduğunca session expire süresinin kısa olması sağlanmalı

## Cookie secure, httpOnly

* Site içinde SSL kullanılsa bile bazı resourse'larda kullanılması unutulmuş olabilir

~~~
<img src="http://mysite.com/images/icon.png" />
~~~

* Bu gibi durumlarda desteklenen browser'ların cookie'leri sadece secure transferlerde göndermesi için header'a **secure** flag'i eklenir
* Javascript ataklarından (mesela XSS) korunmak veya bilginin 3. parti yerlere sızmasını önlemek adına, cookielerin client tarafında çalıştırılması yine **httpOnly** flag'i sağlanır.
* Her cookie için ayrı ayrı setlenebilir veya web.config üzerinden genel bir ayar yapılabilir

~~~csharp
HttpCookie myCookie = new HttpCookie("myCookie");
myCookie.HttpOnly = true;
Response.AppendCookie(myCookie);
~~~

~~~xml
<httpCookies httpOnlyCookies="true" …>
~~~

* Setlendiği zaman artık bu cookie'nin client side tarafından çalıştırılamayacağını bilmemiz gerekir.
* Aynı şekilde **secure** flag'i de şifresiz HTTP üzerinden gerçekleşen bağlantılarda cookie'yi göndermeyecektir.  

~~~csharp
HttpCookie myCookie = new HttpCookie("myCookie");
myCookie.Secure = true;
Response.AppendCookie(myCookie);
~~~

~~~xml
<httpCookies requireSSL="true" />
~~~

## Kaynaklar

* <http://lockmedown.com/broken-authentication-and-session-management>

* <http://www.slideshare.net/RapPayne/18-a3-broken-authentication-and-session-managementpptx>

* <http://www.troyhunt.com/2013/03/c-is-for-cookie-h-is-for-hacker.html>

* <https://asafaweb.com>
