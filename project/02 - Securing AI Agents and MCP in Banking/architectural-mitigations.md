# Securing AI Agents and MCP in Banking — Architectural Mitigations

Source: summary of an exploratory conversation with Gemini, 2026-11-06. The coverage matrix and open questions
below are our own additions. Not yet validated. See the [project tracker](README.md).

Four defence-in-depth patterns for closing the gap between AI usefulness and banking security. They are layers,
not alternatives: each one covers a different part of the problems in [problem-and-risks.md](problem-and-risks.md)
and the scenarios in [threat-scenarios.md](threat-scenarios.md).

## 1. Strict input / context scanning and firewalls

**Role:** front-line armour. Scanning products intercept, sanitise and block malicious prompts and indirect
injections before they reach the LLM's context window. That covers user input, and also uploaded documents, web
content and tool results.

**Limit:** detection is probabilistic too. It lowers the injection rate but cannot guarantee zero, so it has to sit
in front of the structural controls below, not replace them.

## 2. Blind-token execution (zero-knowledge data handling)

**Role:** the agent never sees raw transaction data or PII. Bank systems process the query and return a
**cryptographic reference token** to the agent. The agent passes that token back to the native bank app. There,
the human user decrypts and views the data behind traditional multi-factor authentication (MFA).

**Effect:** even a fully compromised agent has nothing sensitive to leak, because it only ever holds opaque tokens.

**Trade-off:** the agent cannot reason over data it cannot see. This fits "fetch and show me" requests, but not
"analyse my spending" requests (see pattern 3).

## 3. Dual-agent / delegated enterprise architecture

**Role:** splits the system into two halves.

1. **Client agent (semi-trusted, external):** talks to the user, handles natural language, and passes on
   **structured intent**, not free text.
2. **Bank's enterprise agent (trusted, sandboxed):** runs entirely inside the bank's secure, air-gapped
   infrastructure. It reads internal records, runs the analysis inside its sandbox, and sends back only
   **synthesised, non-sensitive answers** to the client agent.

**Effect:** the analysis happens where the data lives. The structured-intent boundary stops free-text injection
from crossing into the trusted side.

## 4. Cryptographic human-in-the-loop (HITL)

**Role:** for every state-changing action (moving money, updating beneficiaries), the AI is barred from acting on
its own. It drafts the payload, but execution needs an external **cryptographic approval challenge**, completed
through secure native banking channels.

**Effect:** an injected or confused agent can at worst propose a bad transaction. It cannot carry one out without a
human signing it in a channel the agent does not control.

## Coverage: which mitigation addresses which scenario

● primary control · ○ partial / supporting · blank = not addressed

| Mitigation | S1 Scope bleed | S2 Trojan-horse PDF | S3 Memory / RAG trap |
| --- | --- | --- | --- |
| Input / context scanning | | ● | ○ (scan what gets written to memory) |
| Blind-token execution | ● (agent never sees other accounts' raw data) | ● (nothing raw to exfiltrate) | ● (nothing sensitive to persist) |
| Dual-agent split | ● (scoping enforced on the trusted side) | ○ (structured intent narrows injection) | ● (sensitive context stays in the bank sandbox) |
| Cryptographic HITL | | ● for write actions (exfiltration through reads is not covered) | |

Gaps the summary does not address directly, worth adding to any reference architecture:
- **Least-privilege, per-task MCP tool scopes**, enforced in the MCP server or gateway rather than in the prompt
  (the direct fix for S1).
- **Egress control:** the agent runtime cannot reach arbitrary external endpoints (closes S2's exfiltration path).
- **Tenant-isolated memory with retention limits** and PII redaction in logs and analytics (the direct fix for S3).

## Open questions for validation

- Do the target banks' regulators (e.g. BNM RMiT in Malaysia, MAS TRM in Singapore) already set requirements for AI
  agents or third-party tool access that this has to map to?
- Which scanning / AI-firewall products exist today, and how do they perform on indirect injection through
  documents?
- Blind-token flow: what does the token carry, who issues and expires it, and does it fit existing mobile banking
  app deep-link and MFA flows?
- Dual-agent split: what is the structured-intent schema, and who owns and versions it?
- Is the product here a reference architecture (advisory), an MCP gateway (software), or both? Proposed answer:
  both, led by advisory, with the gateway as the product. See [development-strategy.md](development-strategy.md).
  The full design is in [solution-blueprint.md](solution-blueprint.md).
