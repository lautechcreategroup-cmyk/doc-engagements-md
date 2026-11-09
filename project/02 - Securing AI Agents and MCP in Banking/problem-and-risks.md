# Securing AI Agents and MCP in Banking — Core Problems and Risks

Source: summary of an exploratory conversation with Gemini, 2026-11-06. Not yet validated. See the
[project tracker](README.md).

## Context

Financial institutions are exploring the Model Context Protocol (MCP) and agentic AI workflows. This puts business
efficiency (agents that can act on banking data and services) in tension with high-stakes cybersecurity risk.
This doc sets out why the usual controls are not enough. The failure modes are in
[threat-scenarios.md](threat-scenarios.md) and the proposed defences in
[architectural-mitigations.md](architectural-mitigations.md).

## 1. Rate limiting is not enough

Traditional rate limiters only stop **volume** abuse: denial of service and brute force. They cannot stop a single,
well-crafted, authorised-looking prompt injection. That one request can run an unauthorised financial operation or
exfiltrate data while staying well within any rate limit.

**Implication:** controls must act on the *content and intent* of each request and on what the agent can reach,
not just on how often it calls.

## 2. The "god-mode" and scope-bleed problem

AI agents reason probabilistically. Without rigid constraints, an agent built for one narrow task (e.g. checking
grocery spend) can pull in broader context. That can expose data from other accounts (joint, business) or
sensitive corporate records.

**Implication:** an agent's tool access must be scoped to the minimum the task needs, and that scope has to be
enforced outside the model. Asking the model to stay in scope is not a control.

## 3. Non-deterministic behaviour makes agents vulnerable

Traditional code is deterministic: the same input gives the same, reviewable behaviour. LLMs are not, and they are
open to prompt injection. Anything the agent reads can carry weaponised instructions, including content it did not
receive from the user directly, such as hidden text in PDFs or web pages.

**Implication:** every piece of content entering the agent's context is untrusted input, and the model cannot be
the last line of defence.

## 4. Transaction data is highly sensitive

Transaction histories are treated as critically sensitive because they work as **behavioural and psychological
profiles**: where someone goes, what they buy, who they pay, and when. A leak risks:

- severe privacy violations for individual customers;
- corporate espionage, for business accounts;
- regulatory penalties under data-protection regimes (GDPR, PDPA, etc.).

**Implication:** the safest design is one where the agent never holds raw transaction data or PII at all (see
blind-token execution and the dual-agent split in [architectural-mitigations.md](architectural-mitigations.md)).
