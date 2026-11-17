# Securing AI Agents and MCP in Banking — Project Tracker

Status: Idea
Owner: TBC
Client / stakeholder: TBC (banks and financial institutions exploring MCP / agentic AI)
Started: 2026-11-06
Time tracking: n/a yet

## Idea
Banks want to use the Model Context Protocol (MCP) and agentic AI workflows. Doing so puts business efficiency in
direct tension with high-stakes security risk. Agents reason probabilistically and can be steered by prompt
injection. Loose tool scopes let them pull more data than the task needs. Transaction data is a behavioural profile
of the customer, so any leak is a serious privacy and regulatory failure (GDPR, PDPA). Rate limiting, the usual
API control, only stops volume abuse. It does nothing against one well-crafted, authorised-looking request.

The opportunity is a reference security architecture, and possibly a product or service, that lets a bank expose
banking capabilities to AI agents without giving them "god mode". It combines four layers:

- input and context scanning;
- blind-token (zero-knowledge) data handling;
- a dual-agent split between a semi-trusted client agent and a sandboxed bank enterprise agent;
- cryptographic human-in-the-loop approval for every state-changing action.

Source: internal idea, from an exploratory conversation with Gemini (summary pasted on 2026-11-06). Why now:
MCP is becoming the default way to connect agents to enterprise systems, and banks are being asked to support it
before the security patterns have settled.

Caveat to carry into Validation: the material so far is an LLM-generated summary. Nothing in it has been checked
against real bank architectures, regulator guidance (e.g. BNM RMiT, MAS TRM), or existing scanning / AI-firewall
products. Treat the scenarios and mitigations as hypotheses.

Supporting docs in this folder:
- [problem-and-risks.md](problem-and-risks.md): the four core problems: rate limiting falls short, god-mode and
  scope bleed, non-deterministic behaviour and prompt injection, and how sensitive transaction data is.
- [threat-scenarios.md](threat-scenarios.md): three ways agentic failures happen: cross-account scope bleed, an
  indirect prompt injection hidden in a PDF, and a persistent memory / RAG leak.
- [architectural-mitigations.md](architectural-mitigations.md): the four defence-in-depth patterns, a matrix of
  which mitigation covers which scenario, and open questions for validation.
- [solution-blueprint.md](solution-blueprint.md): the proposed approach and solution. *Secure Agentic AI & MCP
  Integration Blueprint (v1.0 draft)*, written for a CISO, an enterprise-architecture head and compliance. Covers
  the trust zones, a threat catalogue (T1–T9), Patterns A–D with workflows, OAuth 2.1 / DPoP binding,
  least-privilege tools, the policy gateway, a commitment boundary (4.5), the audit trail and anomaly response,
  and a regulatory mapping.
- [development-strategy.md](development-strategy.md): what we would sell (advisory, an Agent Security Gateway,
  integration accelerators), build vs partner, and the phased plan with gates: validate, reference demo, find a
  design-partner bank, POC, production pilot, scale. Includes where to find partners and the POC success criteria.
- [blueprint-prompt.md](blueprint-prompt.md): the prompt the blueprint structure came from, saved word for word.
- [clearhouse-assessment.md](clearhouse-assessment.md): assessment of the two ClearHouse papers in
  [`reference/`](reference/) (the ClearHouse governed-execution white paper v0.2, and *Governing Agentic Finance*
  v3.5 on SAFR-aligned payment controls). Maps their mechanisms to our blueprint and recommends building a
  commitment layer into the gateway: reserve shared limits, revalidate at execution, durable obligation and
  reconciliation, signed evidence bundle. Adds threats T7–T9 and a later "agentic corporate banking" segment.
- [bank-rollout-proposal.md](bank-rollout-proposal.md): the bank-facing proposal. Value proposition by
  executive, and a six-phase rollout where each phase is approved on its own and pays back before the next:
  0 readiness assessment, 1 payment integrity controls on existing automation, 2 governed staff assistant,
  3 customer insights (read-only), 4 customer actions with device approval, 5 third-party agent channel,
  6 agentic corporate banking (hypothesis). Includes commercial model, governance and honest limits.
- [`reference/`](reference/): source PDFs from outside OrangePay (self-published, AI-assisted, not independently
  reviewed).
- [presentation/board-deck.html](presentation/board-deck.html) ([PDF](presentation/board-deck.pdf)): a 20-slide
  board briefing. Covers the AI landscape, the MCP marketplace, the problem statement, and three product options:
  A, an MCP product to onboard a company; B, MCP with web scraping; C, an agent-to-agent gateway that stops
  third-party agents reaching tools and data directly. Slides 15–17 are three Option C scenarios: protecting
  the customer, containing an out-of-control agent, and guarding against prompt injection. Ends with a comparison, a proposed path and the decisions
  asked of the board. Re-export the PDF with [presentation/export-pdf.sh](presentation/export-pdf.sh).

## Validation
- 2026-11-17: reviewed two external ClearHouse papers ([assessment](clearhouse-assessment.md)). They confirm a gap
  our blueprint missed: an approved action must be re-checked at the moment it executes, shared limits must be
  reserved, and uncertain payment outcomes must be tracked (T7–T9). Their own tests show a conventional
  Postgres-plus-outbox stack does this as well within one bank, so we build it into the gateway rather than adopt
  their runtime. Blueprint (P7, 4.5) and strategy (Phase 0–1, POC criteria) updated. Discovery conversations not
  yet started.

## Decision
[Build / Park / Drop — one line on why, and who made the call]

## Build
[How we intend to build it — approach, key technical decisions, what shipped and when, and any notes worth
remembering for whoever picks this up or extends it later]

## Go to Market / Delivery
[How it reaches the people it's for — pricing, positioning, client handover, who sells or delivers it and how,
which customers/segments first]

## Cost (only if worth tracking)
[Non-engineering spend worth noting — infra, tooling, contractor costs, etc. Skip entirely for small projects.
Engineer hours live in the time-tracking tool (link above), not here — don't duplicate them.]

## Outcome
[After it's been live a while: did it work? Key numbers if we have them. What we'd do differently next time.
This is the input to the next idea, so be honest here even if it flopped.]
