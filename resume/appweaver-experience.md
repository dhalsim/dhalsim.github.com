# AppWeaver CV Experience: Engineering & Product

This document breaks down your work on **AppWeaver** (`/Users/baris/Projects/nostr/dm-bot-main`) into two distinct pillars: **Engineering & Architecture** and **Product Craftsmanship & Growth**.

Rather than designing an abstract framework in a vacuum, you built a foundational local-first architecture and iteratively expanded it across **14 repositories** (core + 13 independent plugin apps) by developing real-world, daily-driver applications and monetization/growth engines on top of it.

---

## 1. Executive Framing for Employers

Highlighting both **Engineering** and **Product** demonstrates rare end-to-end ownership:

```
┌─────────────────────────────────────────────────────────┐
│                      BARIŞ AYDEK                        │
│        Lead Systems Architect & Product Builder         │
└────────────────────────────┬────────────────────────────┘
                             │
              ┌──────────────┴──────────────┐
              ▼                             ▼
┌───────────────────────────────┐ ┌───────────────────────────────┐
│     ENGINEERING & SYSTEMS     │ │       PRODUCT & GROWTH        │
├───────────────────────────────┤ ├───────────────────────────────┤
│ • Decoupled Capability Bus    │ │ • Built-in Marketplace &      │
│   (Service Contracts)         │ │   Bitcoin Lightning Licensing │
│ • Command-Based Architecture  │ │ • AI Draft Pattern            │
│   (Locality of Behavior)      │ │   (Propose/Revise/Accept)     │
│ • Universal Search & Resource │ │ • Second Brain (Memory)       │
│   Views across Apps           │ │   Code AST & Markdown Graph   │
│ • Omnichannel Bot Access      │ │ • Browser Actions: Dual-Model │
│   (Encrypted DMs, CLI, Web)   │ │   System One + LLM Automation │
│ • Job Scheduler: Recurring &  │ │ • PayPerQ (PPQ): Tinfoil/Nitro│
│   Sticky Session Execution    │ │   TEE Enclave Privacy Routing │
│ • WebNode JSON UI Framework   │ │ • Todo: Priority Duels &      │
│   (Keyed Reconciliation)      │ │   Champions Filter            │
│ • Real-Time AI Tool           │ │ • Nostr Radar: Time-Slot      │
│   Intervention Engine         │ │   Reader & Signal Review      │
│ • Cooperative AI Prompt Queue │ │ • Multi-Mode Story System:    │
│   (Pause / Resume / Edit)     │ │   Walkthroughs, Demos &       │
│ • Shared OpenAI-Compatible    │ │   EffectCraft 60fps Videos    │
│   Inference Bridge            │ │ • Content Locality in the     │
│ • Bun, Solid.js, SQLite, FTS5 │ │   Age of AI                   │
└───────────────────────────────┘ └───────────────────────────────┘
```

---

## 2. Master Experience Inventory for `cv-en.md` (Pick & Choose)

### Option 1: Comprehensive Master List (Pick & Select for Your Real CV)

```markdown
`2026-Present, Remote`

**Creator & Lead Architect, AppWeaver (Open Source)**

* Founded and architected AppWeaver, an extensible local-first application platform and agentic AI workspace built with Bun, TypeScript, Solid.js, SQLite, and Nostr (a decentralized, event-based communication protocol for social networks); designed for omnichannel operation across encrypted Nostr DMs (accessible via any mobile/desktop Nostr client), interactive CLI, and local web interfaces.
* Designed a decoupled Plugin Capability Architecture across 14 repositories where AppWeaver core defines versioned service contracts (e.g. job scheduling, universal search, resource views, AI model sources, fast decision classifiers, and workspace file views) that apps provide or consume without cross-dependencies.
* Engineered a Command-Based Architecture where commands encapsulate input validation schemas, execution logic, and UI renderers in a single module (Locality of Behavior) dispatched through a decoupled router.
* Built a concurrent Universal Search coordinator (`search:v1` and `resource-view:v1`) where apps independently handle queries and decide what resources to return under strict deadline isolation (supported across Bookmarks, Todo, File Manager, Job Scheduler, and Memory).
* Engineered a background Job Scheduler (`jobs`) supporting natural language AI prompts or direct command execution for one-time and recurring cron jobs, with model selection, capability-based registration for third-party apps, and opt-in sticky sessions to maintain agent conversational context across recurring runs.
* Engineered the WebNode server-driven JSON UI framework in Solid.js for coherent UI and behaviors across all apps, featuring keyed state reconciliation and optimistic UI updates without executing untrusted plugin code in the browser.
* Built a real-time AI Tool Intervention Engine over WebSockets that intercepts agent tool calls before execution for human-in-the-loop approvals and remembered permission rules.
* Engineered a cooperative AI Prompt Queue that lets users submit, reorder, and edit follow-up prompts while an agent is busy, pausing the AI safely between model turns without aborting running tools or streams.
* Created an interactive Skill Learning workflow (`/skills learn`) that analyzes active troubleshooting or coding sessions to automatically extract and synthesize reusable workspace AI skills.
* Implemented a shared OpenAI-compatible HTTP Inference Bridge, allowing external developer tools, editors, and scripts to use AppWeaver's configured AI runtimes with standard base URLs and API keys.
* Built a managed OpenCode runtime controller supporting concurrent AI model sources and workspaces simultaneously without restart delays.
* Built a decentralized plugin marketplace with one-time Bitcoin Lightning payments and cryptographically verifiable user ownership—allowing users to buy an app once, unlock lifetime updates, and recover purchases across different machines without a central billing server.
* Pioneered the "AI Draft Pattern" (propose, revise, accept/decline) across local database apps, ensuring AI agents propose structured drafts for human review rather than mutating user data directly.
* Designed and built a suite of AI-native applications on top of the platform:
  * **Second Brain (`memory`):** A deterministic code and documentation intelligence engine that indexes Git-committed snapshots using the TypeScript Compiler AST to extract symbol declarations and 1–3 hop relationship graphs (`calls`, `references`, `imports`, `extends`, `implements`), alongside CommonMark/GFM Markdown heading hierarchies, block-level chunks, YAML frontmatter, and backlinks—ranked jointly via weighted SQLite FTS5 and Reciprocal Rank Fusion (RRF) to cut LLM context payload sizes by 71%.
  * **Browser Actions (`browser`):** Resumable Playwright browser automation using a Dual-Model architecture: pairs a fast, low-cost System One decision model (`system-one:v1`) to evaluate live DOM snapshots and select click/scroll operations with a secondary text LLM for form input and summaries, alongside human-in-the-loop login checkpoints.
  * **PayPerQ (`ppq`):** Privacy-first AI model provider that routes prompts through attested **Tinfoil and AWS Nitro TEE enclaves** so user code and prompts stay encrypted in transit and during inference, featuring Bitcoin Lightning micro-top-ups and automatic session resumption when credits run out.
  * **Todo App (`todo`):** A hierarchical task engine featuring tournament-style pairwise prioritization "duels" to establish ranking champions, ancestor-preserving champion filters, nested subtasks, and schema-validated AI task breakdown into drafts.
  * **Nostr Radar (`nr`):** An intentional, time-slot based social reader that evaluates posts in batches using dual-mode AI classification (fast System One classifier vs. deep LLM summaries), granular author/topic Signal Review for transparent user-controlled ranking, and Web of Trust (WoT) filtering.
  * **Bookmarks Manager (`bm`):** AI-assisted link capture with automatic summarization, tagging, and decentralized discovery filtered by Web of Trust (WoT) reputation scores.
  * **File Manager (`file`):** Integrated workspace tree explorer, in-app file editing, visual git diff inspection, and commits.
* Established a Content Locality architecture where features, documentation, and media assets are co-located within app boundaries (enabling AI agents to reason about and modify features in a single context window); built a static documentation site generator and a multi-mode Story system featuring in-app interactive walkthroughs, zero-backend browser demo simulations, and an automated **Story -> EffectCraft 60fps WebM** pipeline recording headless Playwright runs into cinematic showcase videos.
```

---

### Option 2: Deep Systems, AI Runtime & Architecture Focus

```markdown
`2026-Present, Remote`

**Lead Systems & Full-Stack Architect, AppWeaver**

* Architected an open-source, local-first developer platform combining desktop/browser automation, multi-source AI runtimes, and decentralized event-based protocols (Bun, TypeScript, Solid.js, SQLite, Nostr).
* Designed an inter-plugin capability bus across 14 standalone repositories where core defines strict Zod-validated service contracts that plugins provide or consume without cross-plugin dependencies.
* Engineered a Command-Based Architecture with decoupled dispatch, colocating input validation, logic, and UI renderers according to Locality of Behavior.
* Engineered the WebNode server-driven JSON UI framework in Solid.js, featuring keyed state reconciliation and optimistic UI updates across all apps.
* Built a concurrent Universal Search coordinator (`search:v1` & `resource-view:v1`) executing deadline-isolated queries across plugins with cursor pagination and canonical deep linking.
* Created a deterministic code & documentation graph engine (`plugins/memory`) using the TypeScript Compiler API and CommonMark ASTs over Git blob snapshots to index code call graphs (`calls`, `references`, `imports`, `extends`, `implements`) and Markdown hierarchies into SQLite FTS5 with Reciprocal Rank Fusion—cutting LLM context output size by 71%.
* Engineered a cooperative AI Prompt Queue and managed OpenCode runtime controller supporting concurrent model-source servers, mid-run pause gates, real-time WebSocket tool intervention, and `/skills learn` to synthesize reusable workspace skills from chat sessions.
* Implemented a shared OpenAI-compatible HTTP inference bridge and a background Job Scheduler with cron execution, sticky sessions, and cross-plugin scheduling capabilities.
* Built a serverless app licensing and payment verification system using Bitcoin Lightning zaps, encrypted secret storage, and single-use cryptographic challenge-response signatures for cross-instance purchase recovery.
```

---

### Option 3: Product-Minded Full-Stack & AI Engineer Focus

```markdown
`2026-Present, Remote`

**Product Engineer & Lead Developer, AppWeaver**

* Built an open-source local-first AI productivity ecosystem from concept to a multi-app platform, co-evolving the core architecture alongside real-world user workflows.
* Engineered an omnichannel workspace accessible via encrypted Nostr DMs from any mobile client, a local CLI, or a responsive web dashboard.
* Pioneered human-centric AI design patterns: the **AI Draft Pattern** (propose, revise, accept/decline before database mutation), **Cooperative Prompt Queuing** (queue, edit, or pause busy AI runs without losing context), and **Skill Learning** (`/skills learn` to turn solved problems into permanent agent skills).
* Designed and launched flagship AI applications:
  * **Second Brain (Memory) & Universal Search:** Instant cross-app search over codebase AST graphs, Markdown docs (headings, frontmatter, backlinks), todos, and bookmarks from a unified header dialog.
  * **Browser Actions:** Prompt-driven Playwright automation pairing a fast System One decision model for step-by-step DOM element selection with a text LLM for content generation and human-in-the-loop login checkpoints.
  * **PayPerQ:** Confidential AI inference routed through attested **Tinfoil and AWS Nitro TEE enclaves**, with seamless Lightning balance top-ups and auto-resuming tasks.
  * **Todo App:** Hierarchical task engine with pairwise tournament duels (`duel`) to crown priority champions, ancestor-preserving champion filters, and AI-assisted task breakdown.
  * **Nostr Radar:** Intentional time-slot social reader replacing infinite scroll with batch evaluation, dual-mode AI classification, and granular **Signal Review** for user-controlled algorithmic ranking.
  * **Job Scheduler:** Natural language job creation, cron automation, and sticky session tracking across recurring AI tasks.
* Built a decentralized marketplace allowing open-source authors to sell apps via one-time Bitcoin Lightning payments with early-adopter lifetime update guarantees.
* Engineered the complete product growth & media stack: a plugin-owned content locality architecture, an interactive browser demo simulator, and an automated **Story -> EffectCraft** pipeline that compiles interactive app walkthroughs into 60fps 1080p WebM showcase videos.
```

---

### Option 4: Compact / Print-Friendly (Strict 2-Page CV Fit)

```markdown
`2026-Present, Remote`

**Creator & Lead Architect, AppWeaver (Open Source)**

* Architected an open-source local-first application platform and agentic AI workspace built with Bun, TypeScript, Solid.js, SQLite, and Nostr; operable interchangeably via encrypted Nostr DMs, CLI, or web.
* Designed a decoupled Plugin Capability Architecture where core defines versioned service contracts that 13 standalone plugins provide or consume without cross-dependencies.
* Engineered the WebNode server-driven JSON UI framework in Solid.js, featuring keyed state reconciliation and optimistic UI updates.
* Built an AI runtime featuring real-time WebSocket tool intervention, a cooperative prompt queue with mid-run pause, `/skills learn` skill generation, a shared OpenAI-compatible HTTP inference bridge, and **Tinfoil/Nitro TEE enclave** privacy routing (**PayPerQ**).
* Built a concurrent Universal Search coordinator and a background Job Scheduler with cron triggers and sticky session context preservation.
* Pioneered the "AI Draft Pattern" (propose/revise/accept) across local apps: **Second Brain** (TS Compiler AST code graphs & Markdown FTS5 with Reciprocal Rank Fusion), **Browser Actions** (Playwright dual-model DOM automation), **Todo** (tournament priority duels), and **Nostr Radar** (time-slot batch reader with Signal Review).
* Built a serverless app marketplace with Bitcoin Lightning licensing, a zero-backend interactive web demo, and an automated Playwright-to-EffectCraft 60fps WebM showcase video pipeline.
```

---

## 3. Deep Dive: Key Engineering & Product Stories (Interview Prep)

### 1. Code Intelligence in `memory`: Git Blobs vs Hooks, AST Edges, and Reciprocal Rank Fusion (RRF)
> **Technical Q&A / Architecture Breakdown:**
> - **Git-Committed Snapshots vs. Git Hooks:**
>   - *How the Indexer Reads Code:* `plugins/memory/code/snapshot.ts` implements a virtual TypeScript `CompilerHost` that runs `git ls-tree -rz <revision>` and retrieves file contents directly from Git blob objects using `git cat-file blob <oid>`. It does **not** read dirty working directory files from disk for project code. This guarantees that uncommitted syntax errors, unfinished edits, or scratch files never corrupt the symbol graph or cause compiler crashes.
>   - *Where Git Hooks Fit In:* Local Git hooks (`post-commit`, `post-checkout`, `post-merge`) are installed to trigger incremental index refreshes in the background whenever the Git HEAD moves, keeping the index completely up to date without manual user intervention.
> - **Exact AST Relationships Extracted:**
>   - Using `ts.Program` and the TypeScript type checker, `memory` traverses the syntax tree and type references to extract exact 1–3 hop graph edges across symbols: `calls`, `references`, `imports`, `extends`, and `implements`.
> - **What is Reciprocal Rank Fusion (RRF)?**
>   - In information retrieval, combining rankings from different search mechanisms (e.g. Code Symbol Search vs Markdown Document Search) by comparing raw scores is notoriously fragile because BM25/FTS5 scores have completely different scales and distributions across schemas.
>   - **Reciprocal Rank Fusion (RRF)** is an industry-standard rank aggregation algorithm (Cormack, Clarke, and Buettcher) that calculates an item's combined score based purely on its rank position across result lists:
>     $$\text{RRF Score}(d) = \sum_{m \in M} \frac{1}{k + r_m(d)}$$
>     In `plugins/memory/discovery.ts`, $k$ is set to the canonical constant `60`:
>     `score = 1 / (60 + rank)`
>   - This allows code symbols and markdown sections to be interleaved fairly into a single, cohesive search result list without score distortion.
> - **Why AST + FTS5 + RRF Beats Naive Vector RAG for Code:**
>   - Naive vector embeddings hallucinate relationship edges, fail to trace exact call graphs, blur casing/identifiers, and require costly embedding model inference.
>   - AppWeaver's approach provides exact symbol resolution, zero embedding latency, and cuts CLI/agent context payload sizes by **71%**.

### 2. Locality of Behavior (LoB) & Command-Based Architecture in the Age of AI
> **Why Locality Matters for AI-Assisted Engineering:**
> - **The Problem with Traditional Layering in AI Workflows:** Traditional MVC and split-layer architectures scatter a single feature across distant directories (`controllers/`, `views/`, `models/`, `routes/`, `tests/`). When an AI coding agent attempts to modify or reason about a feature, it must search across the entire project tree, consuming massive context tokens and frequently making incomplete edits.
> - **The Solution (Locality of Behavior):** Each AppWeaver plugin command (e.g. `plugins/todo/commands/add/`) co-locates everything needed for that feature in a single self-contained directory:
>   - `definition.ts`: CLI/web parameter schemas (Zod).
>   - `handler.ts`: Core business execution logic.
>   - `adapter.ts`: UI rendering definitions for the WebNode engine.
>   - `db.ts`: Local SQLite queries and migrations.
>   - `stories.ts`: Interactive UI walkthroughs and test scenarios.
> - In the age of AI, an agent can open a single command directory, understand its end-to-end behavior, and implement fixes or enhancements with zero context fragmentation.

### 3. Dual-Model Browser Automation (`plugins/browser` + `plugins/systemone`)
- **The Problem:** Running full conversational LLMs on every step of browser automation is slow, expensive, and prone to context bloat from huge DOM trees.
- **The Solution (System One + System Two):**
  - Playwright captures the live page and indexes up to 120 visible, non-occluded interactive controls in the viewport.
  - Instead of asking a heavy LLM what to do, Browser invokes the **System One capability (`system-one:v1`)**—a fast, low-cost structured decision classifier (`jev-latest`)—passing the task state and indexed DOM candidates as typed `choice` and `score` questions.
  - System One rapidly selects the operation (`CLICK`, `SCROLL`, `WAIT`, `COMPLETE`) and target element with confidence scoring (automatically pausing at a human checkpoint if confidence drops below `0.20` or if a manual login is required).
  - A separately configured lightweight text model (`completeText`) is only called when actual text generation is needed (initial URL bootstrap, `TYPE_TEXT` form values, and final observation summaries).

### 4. Background Job Scheduler: Sticky Sessions & Capability Bus (`plugins/job`)
- **Cron Automation & Sticky Sessions:** Jobs support one-time execution and recurring cron schedules. By default, jobs run in clean, independent sessions. With `--sticky-session true`, the scheduler preserves conversational and runtime context across recurring executions on the same model source and workspace target, enabling continuous monitoring agents that remember earlier runs.
- **Capability Registration:** The Job Scheduler exposes versioned capabilities (`scheduler:v1` through `scheduler:v4`) so other plugins (such as Todo or Nostr Radar) can programmatically schedule recurring tasks or trigger direct plugin-tool executions without user intervention.

### 5. The AI Draft Pattern
- **The Philosophy:** Giving an AI agent direct write permissions to a personal database leads to hallucinations, accidental overwrites, and loss of trust.
- **The Solution:** When an agent runs a task in **Todo**, **Bookmarks**, or **Job Scheduler**, it outputs a schema-validated draft. The user inspects the draft in the UI with explicit actions: **Accept**, **Decline**, or **Revise** (re-prompting the agent with feedback). Data is only committed to SQLite after explicit user approval.

### 6. PayPerQ (`plugins/ppq`) — Private AI via Tinfoil & Nitro TEE Enclaves
- **How It Works Simply:** Users want access to frontier AI models without exposing their private workspace code or personal identity to AI providers. PayPerQ routes requests through a local proxy that verifies and encrypts traffic directly into **Tinfoil and AWS Nitro Trusted Execution Environments (TEE enclaves)** so prompts remain private. Users fund their balance on-demand with Bitcoin Lightning (no subscriptions or credit cards), and if a long coding task runs out of credit mid-run, AppWeaver pauses the session, sends a notification to top up, and resumes the exact session where it left off.

### 7. Serverless App Marketplace & Bitcoin Lightning Licensing
- **How It Works Simply:** Open-source developers can charge for their AppWeaver plugins without running a payment server or adding DRM. Authors publish a signed price offer, and buyers pay via Bitcoin Lightning. AppWeaver cryptographically verifies the payment receipt to unlock installation and lifetime updates ("Early-Adopter Pricing"). Because ownership is tied to the buyer's cryptographic identity rather than a single computer, users can restore their purchased apps on any new machine by signing a one-time verification challenge.

---

## 4. Supporting CV Section Updates for `cv-en.md`

### Updated Professional Summary

> **Lead Full-Stack & Systems Architect** with 15+ years of experience designing distributed systems, modular architectures, and cloud solutions. Creator of **AppWeaver**, an open-source local-first AI application platform and 13-plugin ecosystem. Expert in TypeScript, Bun/Node.js, reactive frontends (Solid.js, React), SQLite/FTS5, compiler AST analysis, and decentralized event-based protocols (Nostr, Bitcoin Lightning). Proven track record of bridging deep systems engineering (decoupled capability contracts, command-based architecture, cooperative AI runtime control, TEE enclave privacy routing) with end-to-end product craftsmanship (omnichannel bot interfaces, daily-driver AI apps, serverless app licensing, and automated 60fps showcase media pipelines).

### Modernized Technical Skills Section

```markdown
## Technical skills

* **Languages & Runtimes:** TypeScript, JavaScript, Bun, Node.js, C#, Java, SQL
* **Frontend & UI Systems:** Solid.js, React, Server-Driven JSON UI (WebNodes), Vite, Tailwind CSS, PWA / Web Push
* **Architecture & Compilers:** Decoupled Plugin Capability Systems, Command-Based Architecture (Locality of Behavior), TypeScript Compiler API (AST Static Analysis & Code Graphs), CommonMark AST Parsing, Event-Driven Architecture, SOA, REST & WebSocket APIs
* **AI & Agentic Engineering:** OpenCode Runtime Orchestration, Cooperative Prompt Queues, Real-Time Tool Intervention, Dual-Model Routing (System One Classifiers + LLM), TEE Enclave Proxies (Tinfoil/Nitro), Dynamic Skill Synthesis (`/skills learn`), AI Draft Workflows
* **Databases & Search:** SQLite (WAL, Foreign Keys, Recursive CTEs), FTS5 Full-Text Search, Reciprocal Rank Fusion (RRF), Universal Multi-Source Search Coordination, MongoDB, MySQL
* **Decentralized & Omnichannel:** Nostr (Decentralized Event-Based Protocol, NIP-04/NIP-44 Encrypted DMs), Bitcoin Lightning (LNURL, NWC), Cashu eCash, Cryptographic Challenge-Response Licensing
* **Automation, Media & DevOps:** Playwright (Browser Automation & Headless Capture), EffectCraft / ExtendScript Video Pipelines, Docker (Alpine), Git, AWS (SNS/SQS, Step Functions, Lambda), Terraform, CI/CD
```
