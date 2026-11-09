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
  the trust zones, a threat catalogue (T1–T6), Patterns A–D with workflows, OAuth 2.1 / DPoP binding,
  least-privilege tools, the policy gateway, the audit trail and anomaly response, and a regulatory mapping.
- [development-strategy.md](development-strategy.md): what we would sell (advisory, an Agent Security Gateway,
  integration accelerators), build vs partner, and the phased plan with gates: validate, reference demo, find a
  design-partner bank, POC, production pilot, scale. Includes where to find partners and the POC success criteria.
- [blueprint-prompt.md](blueprint-prompt.md): the prompt the blueprint structure came from, saved word for word.

## Validation
[What we tried to de-risk it before committing real time — a prototype, a client conversation, a spike.
What we learned. Rough cost/time spent so far.]

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
