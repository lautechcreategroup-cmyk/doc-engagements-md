# Securing AI Agents and MCP in Banking — Agentic Banking POC

A working proof of concept with three parts: a **personal agent** (the customer's own AI agent), a **bank agent**
(the bank's enterprise agent), and a **mocked banking system** that the bank agent reaches only through MCP. It is
the Phase 1 "reference demo" in [development-strategy.md](../development-strategy.md), aimed at showing **what the
bank agent can do**, for both retail and corporate customers, while the controls in the
[solution blueprint](../solution-blueprint.md) stay in place. See the [project tracker](../README.md).

Status: **draft for review, nothing built yet.** Created 2026-11-19.

## The idea in one picture

```mermaid
flowchart LR
    subgraph Z1["Z1 · Customer side (semi-trusted)"]
        PA["Personal agent<br/>(customer's own AI)"]
        DOCS[["Customer files<br/>invoices · payroll CSV"]]
    end
    subgraph Z2["Z2 · Bank edge"]
        GW["Agent Channel gateway<br/>(MCP server for outside agents)<br/>auth · consent · policy · audit"]
        TAS["Transaction authorisation<br/>reserve · approve · revalidate · commit"]
    end
    subgraph Z3["Z3 · Bank agent sandbox (no egress)"]
        BA["Bank agent<br/>(bank-hosted LLM loop)"]
    end
    subgraph Z4["Z4 · Mock banking system"]
        MCPR["Banking MCP<br/>read server"]
        MCPD["Banking MCP<br/>draft server"]
        CORE[("Core banking")]
        CIF[("Customer profile")]
        STMT[("Statements")]
        PAY[("Payments")]
    end
    APP["Bank app (mock)<br/>approve with device key"]

    PA --> DOCS
    PA -- "structured intents (MCP)" --> GW
    GW --> BA
    BA --> MCPR --> CORE & CIF & STMT
    BA --> MCPD --> TAS
    TAS --> PAY --> CORE
    TAS -. push .-> APP
    APP -. signed approval .-> TAS
```

- The **personal agent never touches banking tools.** It speaks to the bank through one MCP server at the bank's
  edge, the *Agent Channel*, using typed intents ("spending summary", "pay this invoice").
- The **bank agent** does the work inside the bank. It is the only agent that uses the **Banking MCP** servers,
  which wrap the mock core banking, customer profile, statements and payments services.
- **Nothing moves money without a signed approval** in the mock bank app, except corporate payments that fall
  inside a mandate the company set up beforehand (SAFR "Auto-Execute"), which is a corporate-only scene.

## Files in this folder

| File | What it is |
| --- | --- |
| [poc-build-prompt.md](poc-build-prompt.md) | **The prompt.** Hand it to a coding agent to build the stack, milestone by milestone. |
| [architecture.md](architecture.md) | Components, trust zones, request flows, tech stack and what the POC simplifies on purpose. |
| [mock-banking-system.md](mock-banking-system.md) | The four mock services: data model, internal APIs, business rules, seed data. |
| [mcp-tool-catalogue.md](mcp-tool-catalogue.md) | The Banking MCP tools (for the bank agent) and the Agent Channel intents (for personal agents). |
| [use-cases.md](use-cases.md) | Retail (R1–R8) and corporate (C1–C8) use cases, plus the security scenes they exercise. |
| [demo-script.md](demo-script.md) | The scripted demo: scenes, what the audience sees, what to show in the audit trail. |
| [stack/](stack/) | The empty project structure the build fills in. Each folder has a README saying what goes there. |

## Decisions for review before building

These are the recommendations the prompt currently assumes. Change them here and in the prompt together.

| # | Decision | Recommendation | Why | Alternative |
| --- | --- | --- | --- | --- |
| D1 | Language | **Python 3.12** for everything except the browser UI | One language across services, MCP servers and agents; mature MCP and Anthropic SDKs | TypeScript throughout |
| D2 | Where the code lives | `stack/` in this folder for now | You asked for it here; easy to review next to the spec | A separate code repo once the build starts (recommended before it gets large) |
| D3 | How the personal agent talks to the bank | **MCP** (the Agent Channel is an MCP server exposing intent tools) | Same protocol on both sides; any MCP-capable agent can connect | Google A2A protocol between the two agents |
| D4 | Agent loops | **Self-hosted Messages API loop** (Anthropic SDK tool runner) for both agents | The bank agent must run inside the bank's zone with no egress; hosting it ourselves is the point | Anthropic Managed Agents for the personal agent only |
| D5 | Model | `claude-opus-5-5` for both agents, set in config | Current default; cheaper models can be tried per agent once the demo works | `claude-sonnet-5-5` for the personal agent |
| D6 | Policy engine | **Policy-as-code in a versioned Python module** | Fast to build and test; the policy *version* still goes into signatures and audit | OPA / Cedar (blueprint 4.3); swap in for the partner POC |
| D7 | Auth | **Simplified OAuth**: mock auth server, consent screen, short-lived JWT with account and capability scopes | Shows consent scoping (the S1 fix) without a full FAPI build | Full OAuth 2.1 + PKCE + DPoP (blueprint 4.1) as a stretch milestone |
| D8 | Data store | One **Postgres 16**, one schema per mock service, plus one for TAS and audit | Serializable transactions for the commitment layer (blueprint 4.5) | SQLite (cannot show the concurrency scenes honestly) |
| D9 | Pattern A scanning | A **pluggable scanner interface** with a simple built-in heuristic scanner | Proves placement; vendor choice comes later | Integrate one vendor scanner now |
| D10 | UI | One **demo console** web page: personal-agent chat, phone-frame bank app, live audit trail | The audience sees all three at once | Separate apps |

## Open questions

1. Who is the audience for the first demo: internal, a bank prospect, or the board? It changes how much polish
   [demo-script.md](demo-script.md) needs.
2. Should the corporate scenes use Malaysian rails names (DuitNow, IBG, JomPAY) as the spec does, or stay generic?
3. Is an Anthropic API key with enough budget available for repeated demo runs? (Each full run of the demo script
   is a few dozen model calls.)
4. Is the "naive stack" comparison (attacks succeed without the controls, fail with them) in scope for the first
   build, or a later milestone? The prompt puts it last (M7).
