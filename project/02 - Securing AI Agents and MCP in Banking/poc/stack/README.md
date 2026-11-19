# Agentic Banking POC — Stack

Code for the POC. **Empty until the build starts.** The build prompt is [../poc-build-prompt.md](../poc-build-prompt.md);
the spec is the rest of [../](../README.md). Each folder's README says what belongs in it.

```
stack/
├── services/                 Z4 · mock banking system (one FastAPI app + Postgres schema each)
│   ├── core-banking/         accounts, ledger, balances, holds, limits
│   ├── customer-profile/     parties, users, relationships, corporate roles, approval matrix, devices
│   ├── statements/           transactions, statements, blind-token view vault
│   └── payments/             payees, billers, rails, payment orders, bulk batches, standing instructions
├── banking-mcp/              Z4 · MCP servers the bank agent uses
│   ├── read-server/          read-only tools
│   └── draft-server/         draft_* tools (create TAS drafts only)
├── bank-agent/               Z3 · the bank's enterprise agent (sandboxed, no memory across requests)
├── bank-edge/                Z2 · the bank's edge
│   ├── auth/                 mock auth server + consent screen
│   ├── gateway/              Agent Channel MCP server (the only bank entry point for outside agents)
│   ├── policy/               versioned policy-as-code
│   ├── scanner/              Pattern A scanner interface + heuristic scanner
│   ├── tas/                  transaction authorisation service + commitment lifecycle
│   └── audit/                append-only signed audit store, evidence export, offline verifier
├── open-mcp/                 Mode 1 only · deliberately unsafe open banking MCP (comparison baseline)
├── personal-agent/           Z1 · the customer's own agent (same code in all three channel modes)
├── bank-app/                 Z0 · mock bank app (approvals, statement views, maker/checker)
├── demo-console/             three-pane demo UI + scene picker
├── seed-data/                synthetic personas, transactions, customer files (incl. poisoned docs)
└── tests/                    cross-component scene tests
```

To be added by the build: `docker-compose.yml`, `Makefile`, `.env.example`, `pyproject.toml`, `NOTES.md` (build
log: what was built, simplifications, open issues).

## Deliberate simplifications (keep this list current)

See [../architecture.md](../architecture.md) §5. Nothing here is a production design: mock auth instead of FAPI,
local key files instead of an HSM, a browser page instead of a mobile app, a Python policy module instead of
OPA / Cedar, a heuristic scanner instead of a vendor product, mock rails.
