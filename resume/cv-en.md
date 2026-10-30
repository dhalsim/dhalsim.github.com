---
layout: cv
title: Barış Aydek CV
---

<div class="height-1in"></div>

# Barış Aydek

<div id="webaddress">
  <a href="mailto:nostrize@proton.me">nostrize@proton.me</a>
  |
  <a href="https://getappweaver.com">getappweaver.com</a>
  |
  <i class="fa fa-github"></i> <a href="https://github.com/dhalsim">Dhalsim</a>
  |
  <i class="fa fa-github"></i> <a href="https://github.com/nostrize">Nostrize</a>
  |
  <i class="fa fa-linkedin"></i> <a href="https://www.linkedin.com/in/baris-aydek-39352325">LinkedIn</a>
  <span class="printer-hide">
    |
    <a href="https://dhalsim.github.io/assets/resume/cv-en.pdf">PDF</a>
  </span>
</div>
</div>

<div class="height-0-6in"></div>

## Professional Summary

**Lead AI Systems & Product Architect** with 15+ years of experience designing distributed cloud backends, modular application platforms, and AI-native products from zero to one. Creator & Lead Architect of **[AppWeaver](https://getappweaver.com)**, a daily-driver open-source agentic AI workspace and 14-repository plugin ecosystem. Deep expertise in TypeScript, Bun/Node.js, reactive and server-driven UIs (Solid.js, React), SQLite/FTS5, deterministic context engineering, and decentralized protocols (Nostr, Bitcoin Lightning). Proven track record of bridging enterprise backend reliability (event-driven microservices, async fulfillment workflows, B2B invoicing engines) with end-to-end AI product execution.

<div class="print-cv-t-skills"></div>

## Technical Skills

- **Languages & Runtimes:** TypeScript, JavaScript, Bun, Node.js, SQL, C#, Java
- **AI & Agentic Engineering:** Agent Harness & Runtime Orchestration, Deterministic Context Engineering (AST & Graph Indexing), Cooperative Prompt Queues, Real-Time Tool Intervention (HITL), Dual-Model Routing (Fast Classifiers + Deep LLMs), Confidential Compute / TEE Enclave Proxies (AWS Nitro, Tinfoil), OpenAI-Compatible Inference Bridges
- **System & Product Architecture:** Decoupled Plugin & Capability Contracts, Command-Driven Omnichannel Architecture (Zod Schemas & Locality of Behavior), Event-Driven Architecture, SOA, REST & WebSocket APIs
- **Databases & Search:** SQLite (WAL, Recursive CTEs), FTS5 Full-Text Search, Reciprocal Rank Fusion (RRF), Deadline-Isolated Federated Search, MongoDB, MySQL
- **Frontend & UI Systems:** Solid.js, React, Server-Driven JSON UI (WebNode Schema, Keyed State Reconciliation & Optimistic Updates), Vite, Tailwind CSS, PWA / Web Push
- **Decentralized Protocols & Payments:** Nostr (NIP-04/NIP-44 Encrypted DMs, Web of Trust Filtering), Bitcoin Lightning (LNURL, NWC), Cashu eCash, Serverless Cryptographic Licensing
- **Automation, Cloud & DevOps:** Playwright (Resumable Browser Automation & Headless 60fps Video Capture), AWS (SNS/SQS, Step Functions, Lambda), Apache Kafka, Docker, Terraform, Git, CI/CD
- **Spoken Languages:** English (Full Professional Proficiency), Turkish (Native)

<div class="page-break"></div>
<div class="height-1in"></div>

## Work Experiences

`2026–Present, Remote`

**Creator & Lead Product Architect, [AppWeaver](https://getappweaver.com) (Open Source)**

- **Command-Driven Omnichannel Platform (Web, Mobile PWA & Nostr):** Envisioned, architected, and shipped a daily-driver local-first application platform and agentic AI workspace across 14 repositories using Bun, TypeScript, Solid.js, SQLite, and Nostr—delivering a rich desktop and responsive mobile PWA alongside NIP-04/NIP-44 encrypted Nostr DMs and CLI, where Zod-validated commands (`/app command --flag`) dynamically dual-render as interactive WebSocket UI components or structured text.
- **Decoupled Capability Contracts & App Template SDK:** Designed a zero-cross-dependency plugin architecture governed by versioned service contracts (`search:v1`, `resource-view:v1`, `system-one:v1`, job scheduling, and model routing) alongside a standardized app template—enabling both humans and coding agents to scaffold, customize, and maintain isolated DB apps within a single bounded context (Locality of Behavior).
- **WebNode Server-Driven UI Framework:** Engineered a declarative JSON UI schema and renderer in Solid.js featuring keyed state reconciliation and optimistic UI updates, delivering cohesive multi-app web interfaces without executing untrusted plugin code in the browser.
- **Cooperative AI Runtime & Safe DB Mutation Governance:** Built a multi-workspace AI runtime controller featuring a cooperative Prompt Queue (allowing users to insert, reorder, and edit follow-up prompts mid-run, safely pausing between LLM turns without aborting active streams), a WebSocket Tool Intervention Engine for real-time human-in-the-loop approvals, and the "AI Draft Pattern" (propose/revise/accept) so agents safely propose database changes without mutating user state directly.
- **Federated Search, Sticky Cron Jobs & Inference Bridge:** Built a deadline-isolated Universal Search coordinator across 5 core apps; a background Job Scheduler supporting natural-language cron tasks with opt-in sticky conversational sessions; an interactive Skill Learning workflow (`/skills learn`) that synthesizes troubleshooting sessions into reusable workspace skills; and a shared OpenAI-compatible HTTP Inference Bridge for external developer tooling.
- **Serverless Lightning Marketplace & Automated Media Pipeline:** Built a decentralized plugin marketplace using Bitcoin Lightning and cryptographic ownership proofs for serverless, cross-machine license recovery; established a Content Locality architecture with a zero-backend browser simulation mode and an automated Playwright-to-60fps WebM video showcase pipeline powering [Todo App Landing Page](https://getappweaver.com/apps/todo).

<div class="page-break"></div>
<div class="height-1in"></div>

**Flagship AI-Native Applications Architected on [AppWeaver](https://getappweaver.com):**

- **Second Brain (Deterministic Context & Code Intelligence):** Built a hybrid indexing engine over Git snapshots using the TypeScript Compiler AST API (symbol declarations and 1–3 hop call/reference/inheritance graphs) and CommonMark AST chunks—ranked via weighted SQLite FTS5 and Reciprocal Rank Fusion (RRF) with a two-tiered retrieval format that cuts LLM context payload sizes by **71%** (1,178 B vs. 4,130 B on benchmark symbol queries) while deferring deep AST inspection to targeted tool calls.
- **Browser Actions (Dual-Model DOM Agent):** Engineered resumable Playwright automation pairing a fast System One classifier (`system-one:v1` via Jev API) to evaluate indexed viewport controls via typed choice/confidence contracts (automatically tripping a human-in-the-loop checkpoint on low confidence or login/CAPTCHA screens), delegating to a generative LLM only when free-form text synthesis is required.
- **PayPerQ (Confidential Compute AI Proxy):** Built a privacy-first inference provider routing prompts through attested **Tinfoil and AWS Nitro TEE enclaves** for end-to-end encryption in transit and during inference, integrated with Bitcoin Lightning micro-top-ups and automatic session resumption.
- **Daily-Driver Productivity Suite (Todo, Nostr Radar, Bookmarks, Files):** Built a cohesive suite featuring tournament-style pairwise task prioritization ("duels") with schema-validated AI task breakdown, high-throughput batch social feed classification (scoring up to 200 topics/64 moods per round-trip via `system-one:v1` + Web of Trust filtering), and an integrated workspace Git diff/file explorer.

`2023–2025, Remote`

**Independent Product Engineer & Open Source Creator**

- **AI Media & Automated Content Pipelines:** Created [Bitcoin Son Dakika](https://bitcoin-son-dakika.vercel.app/) ([GitHub](https://github.com/dhalsim/bitcoin-son-dakika)), an automated Nostr-based news outlet featuring programmatic content curation and AI-generated audio podcasts.
- **Decentralized Browser Extensions & Publishing Tooling:** Architected and shipped multiple open-source Nostr and Bitcoin Lightning (LNURL/NWC) products, including [Nostrize](https://nostrize.me) (a browser extension enabling zero-fee P2P Bitcoin payments and crowdfunding across GitHub, YouTube, and X), [Nostr Static](https://blog.nostrize.me) (decentralized static site generator with RSS/Atom discovery), [Bettr Quest](https://bettr.quest/) (social quest platform prototype), and contributed to [Lantern](https://chromewebstore.google.com/detail/lantern/jjoijlenmgefkaeiomoaelcljfibpcgh) (web annotations and bookmarking browser extension).
- **Full-Stack E-Commerce & Web Publishing:** Engineered custom full-stack e-commerce applications using React, Node.js, and TypeScript, and built [En Basit Bitcoin Kitabı](https://enbasitbitcoinkitabi.site), converting and translating an open-source Bitcoin book into an interactive Turkish web publication.

<div class="page-break"></div>
<div class="height-1in"></div>

`2017–2023, Berlin`

**Senior Software Developer, Comtravo (Acquired by Navan)**

- **Co-Led British Airways NDC & Global Provider Integrations:** Co-led the 6-month British Airways NDC integration and architected distributed travel booking backends connecting global GDS/OTA providers (Booking.com, Sabre, Amadeus) using AWS event-driven services (SNS/SQS, Step Functions, Lambda).
- **Asynchronous Offer Fulfillment Engine:** Engineered resilient async fulfillment workflows that automated ticket and reservation issuance from customer offers, with intelligent fallback routing that converted external provider failures into structured Operations tickets for manual recovery.
- **Multi-Entity Corporate Invoicing & Bug Remediation:** Led the refactoring of mission-critical B2B invoicing and payment pipelines in close collaboration with Product and Finance teams, eliminating legacy bugs and enabling automated monthly/semi-monthly consolidated billing per company or corporate address.
- **Polyglot Microservices & Event-Driven Kafka Adapters:** Integrated high-throughput Node.js microservices into the core enterprise Java stack by developing robust queue adapters over Apache Kafka.
- **Security, SSO & Infrastructure as Code:** Designed and implemented JWT-based API authorization, integrated Auth0 Cloud Authentication with custom SSO modules, modeled scalable MongoDB schemas, and provisioned cloud infrastructure using Terraform IaC in AWS environments.
- **Cross-Functional Delivery & Mentorship:** Partnered closely with QA and Infrastructure teams to streamline CI/CD delivery pipelines, while mentoring junior engineers and driving team-wide code quality and testing standards.

`2013–2016, Istanbul`

**Software Developer, Amadeus R&D Istanbul**

- Engineered core booking and ticketing features for the Amadeus e-Power online booking engine, powering 1,000+ commercial travel portals globally.
- Developed resilient SOAP/REST web service modules and secure payment integrations across flight and hotel reservation pipelines.
- Modernized deployment velocity by implementing automated CI/CD pipelines in Jenkins and establishing secure coding standards.

`2012–2013, Istanbul`

**Software Development Specialist, Gezisitesi.com**

- Developed and maintained high-traffic online travel agency applications using Service-Oriented Architecture (SOA) principles and web services.

`2010–2012, Istanbul`

**Software Development Specialist, Cronom**

- Engineered core components of OttO, an XML-based ASP.NET rapid application framework powering dynamic data management and enterprise workflows.
- Delivered technical consulting and custom integration solutions for major enterprise clients (Coca-Cola İçecek, Turkcell Global Bilgi, Abdi İbrahim) leveraging .NET, WCF, and SOA patterns.

## Education

`2005–2009`
**B.Sc. in Computer Engineering**, Pamukkale University (3.04 / 4.00 GPA)

## Certificates & Professional Training

- [Functional Programming Principles in Scala — Coursera (Grade: 96.0%)](https://www.coursera.org/account/accomplishments/records/TNQK6WGCUZET)
- [Learning How to Learn — Coursera (Grade: 92.4%)](https://www.coursera.org/account/accomplishments/records/4FKFYFV5643W)
- Fundamentals of Application Security — Team Mentor (Score: 92/100)
- **Enterprise & Cloud Architecture Seminars (BTAkademi & Microsoft, 184 hrs total):** OOP & Design Patterns (32h), Enterprise Design Patterns (32h), Advanced C# (50h), Windows Azure (24h), WCF (18h), ASP.NET MVC Framework (18h), Enterprise Library 5.0 (10h)