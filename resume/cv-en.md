---
layout: cv
title: Barış Aydek CV
---
# Barış Aydek
Computer Engineer

<div id="webaddress">
<a href="mailto:baris.aydek@gmail.com">baris.aydek@gmail.com</a>
|
<a href="https://dhalsim.github.io/en">My Blog (EN)</a>
|
<a href="https://dhalsim.github.io">My Blog (TR)</a>
|
<i class="fa fa-github"></i> <a href="http://github.com/dhalsim">dhalsim</a>
|
<i class="fa fa-linkedin"></i> <a href="https://www.linkedin.com/in/baris-aydek-39352325">Barış Aydek</a>
</div>

## Work expreriences

`2017-2023`
**Senior Software Developer, Comtravo (Acquired by Navan, Formerly TripActions)**

I started my journey at Comtravo as a Junior Software Engineer despite having six years of prior experience in C# development. My motivation was to transition Node.js due to my fascination with its ecosystem. Comtravo offered me the opportunity to join as a junior developer, and I embraced the challenge of proving my expertise in a new tech stack. Within a year, I had promoted to middle, and senior software engineering positions as my responsibilities grew. 

During my initial adaptation phase in the backend team, my primary focus was on reporting. The first thing I did was refactoring the code to make it easier to maintain reports as I fixed its bugs. 

I participated in various data integrations for our B2B travel search and booking engine. Search engine was responsible for fetching data from multiple sources, merging the results into a common data type, and show the best results for the user, which will be used to finilize the booking flow asyncroniously. We used SNS/SQS events to create messages for offers and bookings. Then the messages are picked by AWS Step Functions and do async fulfillment on those bookings. 

Integrations I worked on the product: 

* Hotel integrations with booking.com and hrs
* Flight integrations with Sabre, Hitchhiker
* Train integrations with DB and Amadeus
* Use of SNS/SQS events and AWS Step Functions for async fulfillment

I worked some parts of our CRM service such as invoice management within the same company. After this project, I played a key role in designing and implementing the Aggregated Invoices project, allowing customers to manage their accounting more efficiently. We utilized AWS Step Functions, triggered by custom AWS cron jobs, to generate invoices in batches during low DB usage periods. This approach offered flexibility and resilience, as we could re-run the step functions in case of any issues.

On the backend, we needed to introduce company roles (traveler, booker and admin) for the users. I created a security check mechanism for our backend API endpoints using JWT tokens. I desinged a library that can be used to validate our API requests against the rules defined in the services.

Travel policies was the most wanted feature among our customers, and I was responsible for designing MongoDB schemas, models, and a library for the actual policy validations which is called from various backend services and frontend applications. The requirements was the company admins or travel agents could set rules like budgeting or allowed cabin types, and system should signal the user about any violations of that policies. 

As my experience grew in the company, I became the most knowledgeable person in the department, serving as the primary point of escalation, consultation and mentorship. Additionally, I was entrusted with technical reviews, PR reviews, and making architectural updates to the system as needed. 

I took on the challenge of integrating the British Airways NDC (a new standard in flights industry) API. We integrated a new Node.js service into an existing Java stack. We created an adaptor in between the Java services and Node.js service using REST and Kafka queues.

Furthermore, I joined the core team to help integrating Auth0 into our authentication system. With the integration we aimed increased security, scalibility and compliance. Navan already had Single Sign-on (SSO) features using SAML and OIDC, and it was decided to create some adapters for existing users, while giving an option to migrate to Auth0 in time. I was in charge of the part of creating an SSO service to be used by the customers that wants to create and edit their SSO connections using Auth0 API. Users could upload their XMLs or define their connection configurations. This time I had the chance to work with Java Spring Framework to create our service. I was also mainly writing Terraform definitions to create the infrastructure layer in our AWS infra using Auth0 terraform provider. After the acquisation, we had to go through rebranding of TripActions to Navan, and we supported this change as a team.

`2013-2016`
**Software Developer, Amadeus R&D Istanbul**

Amadeus e-Power is a fully customizable, high performance, easy-to-use online booking engine (flight, hotel, car, train) by the time was used by about worldwide 1000+ booking portals. It can be served to B2B (agencies) or B2C customers, either using extensible e-Power UI engine or using e-Power web services.  

Responsibilities:

* Application configuration management for deploying on different farm machines. 
* Unit test initial setup, Test and Code Coverage Reports integration for Jenkins
* Application code security 
* Various Flight, Hotel, Payment, Webservice module features

`2012-2013`
**Software Development Specialist, Gezisitesi.com**

I was responsible of developing an online hotel and tour selling platform.

*Technologies used: ASP.NET MVC 4, WCF, NHibernate.*

`2010-2012`
**Software Development Specialist, Cronom**

I was responsible of developing of an XML based ASP.NET framework. Using the framework customers are able to create their web screens and forms, manage data, create different workflows by triggering actions on the screen, all by defining XML declarations and simple scripts. Product can be used with optional UI tool (Windows Forms) providing customers to generate screens, workflows, and data integrations using drag and drop UI or wizards to generate necessary XML definitions.

In my first year, I worked on supporting this product with fixing bugs and developing new features. 

That year I learned basic ASP.NET web development skills, and mostly back-end programming skills like maintaining and developing our in-house ORM framework, generating ASP.NET pages (including generating necessary Javascript code) and business workflows from XMLs defined.

Also worked on in-house solutions in Coca Cola İçecek, GlobalBilgi (Turkcell), Abdi İbrahim and Ulaşım A.Ş by helping customers to solve their enterprise requirements.

In my second year, I worked in support and development team on a rolling basis. In that period I worked with all parts of the product, including product design tool using Windows Forms and DexExpress libraries. During that time, my knowledge on the code base and architecture also increased and was able to work on more technical problems including concurrency issues.

On the last 4 months I did a project with the product to work with
cloud platforms and started to build a web platform for managing this cloud product. This let me to
develop my SOA knowledge using WCF technologies, and deployment libraries found on .net platform. In this development cycle I studied Test Driven Development heavily and practiced it using NUnit framework

## Education

`2005-2009`
**Computer Engineering**, Pamukkale University 

`1997-2005`
İzmir Milli Piyango Anatolian High School (English)

## Technical skills

* Javascript / Typescript / Node.js / Java Spring
* OOP / FP
* TDD / BDD / DDD
* MongoDB / Mysql
* Docker, Jenkins, Terraform, AWS

## Projects

### open source

* Check out my [nostr](https://nostr.com/) application to fetch nostr events and transform them into markdown lists to be published again as long formatted notes using Nostr Web : [Github link](https://github.com/btcpayserver/BTCPayServer.Lightning/pull/151)
* BTCPay Server: Blink API integration PR: [Github link](https://github.com/btcpayserver/BTCPayServer.Lightning/pull/151)

### blog

I write mostly about javascript on my [blog](https://dhalsim.github.io/en) which is in Turkish and English.

## Courses and Seminars

1. OOP & Design Patterns / BTAkademi, 32 hours
1. Advanced C# / BTAkademi, 50 hours
1. Enterprise Design Patterns / BTAkademi, 32 hours
1. Enterprice Library 5.0 / BTAkademi, 10 hours
1. WCF / BTAkademi, 18 hours
1. ASP.NET MVC Framework / BTAkademi, 18 hours
1. Windows Azure/ Microsoft, 24 hours

## Certificates

1. Fundamentals of Application Security / Team Mentor (Score: 92/100)
1. [Learning how to learn / Coursera (Grade Achieved: 92.4%)](https://www.coursera.org/account/accomplishments/records/4FKFYFV5643W)
1. [Functional Programming Principles in Scala / Coursera (Grade Achieved: 96.0%)](https://www.coursera.org/account/accomplishments/records/TNQK6WGCUZET)
