# Agentic Banking POC — MCP Tool Catalogue

The two MCP surfaces in the POC: the **Agent Channel** that outside agents (the personal agent) call, and the
**Banking MCP** that only the bank agent calls. Tool design follows blueprint 4.2: typed parameters, no free-form
queries, pseudonymous account references, minimal responses, read and write on separate servers. See
[architecture.md](architecture.md) §2.

## 1. Account references

The gateway gives each session a map from **opaque references** (`acc_9f3c`, `pay_71d0`, `bil_2a11`) to internal
IDs, containing **only the accounts and payees the customer consented to**. Neither agent ever sees an internal ID
or a full account number. A reference from another session or another customer resolves to nothing and is logged
as a policy denial.

The map is also bound to **one profile**. A person who is both a retail customer and a corporate user (e.g. Mei
Ling) gives their personal agent two separate consents, `personal` and `org:<company>`, and gets two tokens. Each
Agent Channel call carries one token, so one profile; references from the other profile resolve to nothing.
`list_my_accounts` and `get_customer_context` return the active profile so both agents know whose money they are
talking about.

## 2. Agent Channel MCP (gateway, for personal agents)

Every tool takes the customer's bearer token (set by the MCP client) and returns either an answer object, a
`status` object, or a deep link. None returns raw transaction rows.

| Tool | Parameters | Returns | Pattern |
| --- | --- | --- | --- |
| `list_my_accounts` | — | Consented accounts: `ref`, product, nickname, masked number, currency. Balances only if the `balances` capability was consented | — |
| `ask_bank` | `intent` (enum, below), `params` (typed per intent) | Intent-specific aggregate answer | C |
| `request_statement_view` | `account_ref`, `period` | `{status: ready, deep_link}` | B |
| `request_payment` | `type` (`bill` / `transfer` / `own_transfer` / `supplier_invoice`), typed fields, optional `document` (an uploaded invoice; scanned by Pattern A) | `{request_id, status: awaiting_approval / escalated / auto_executed / denied, display_summary}` | D |
| `request_bulk_payment` | `type` (`payroll` / `supplier`), `file` (CSV), `debit_account_ref` | Validation report + `{request_id, status}` | D |
| `request_payee_change` | `action` (`add` / `remove`), typed payee fields | `{request_id, status}` (adds always need approval, then cooling-off) | D |
| `get_request_status` | `request_id` | Lifecycle status only (`awaiting_approval`, `approved`, `executed`, `refused`, `outcome_unknown`, …) | — |
| `list_pending_requests` | — | The user's open requests (makers see theirs; checkers see what awaits them) | — |

### `ask_bank` intents

| Intent | Params | Answer shape (examples) | Segment |
| --- | --- | --- | --- |
| `balance_summary` | `account_refs?` | Per account: available, ledger, as-of | Both |
| `spending_summary` | `account_refs`, `period`, `category?`, `compare_to?` | `{total, currency, vs_baseline_pct, by_category[top 5]}` | Retail |
| `cashflow_forecast` | `account_refs`, `horizon_days` | `{projected_low, projected_low_date, known_outflows_total, risk_flag}` | Both |
| `upcoming_payments` | `account_refs`, `horizon_days` | Standing instructions and bills due: `{count, total, next_due_date}` + biller/payee refs | Both |
| `find_transaction` | `account_ref`, `amount_range?`, `date_range?`, `counterparty_hint?` | Whether a match exists, its date and amount; counterparty name only if the intent's data class allows it | Both |
| `subscription_review` | `account_refs`, `lookback_months` | Recurring merchants count, monthly total, flagged increases | Retail |
| `cash_position` | `org_account_refs` | Per account and total, intraday as-of | Corporate |
| `supplier_spend` | `period`, `group_by` (`supplier` / `category`) | Top suppliers by total (company's own payees only), vs prior period | Corporate |
| `payroll_check` | `file` (CSV), `debit_account_ref` | Line count, total, vs last payroll, anomalies (changed accounts, duplicates, new payees) | Corporate |
| `mandate_status` | `mandate_ref` | Envelope used, reserved, remaining, period end | Corporate |

The gateway checks each intent against a **data-class ceiling** (e.g. `aggregate`, `aggregate_with_payee_names`)
before forwarding, and checks the answer against the intent's **output template** before returning it.

## 3. Banking MCP (inside the bank, for the bank agent only)

### 3.1 Read server

| Tool | Parameters | Returns | Backed by |
| --- | --- | --- | --- |
| `get_customer_context` | — | Active profile (`personal` or `org`), segment, display name, consented account refs, entitlements, corporate role (if any) | Customer profile |
| `get_account` | `account_ref` | Product, status, currency, masked number | Core banking |
| `get_account_balance` | `account_ref` | Available, ledger, holds total, as-of | Core banking |
| `list_holds` | `account_ref` | Holds (amount, reason class, expiry) | Core banking |
| `get_limits` | `account_ref` | Applicable limits and today's usage | Core banking |
| `list_transactions` | `account_ref`, `from`, `to`, `category?`, `direction?`, `cursor?` | Up to 500 rows; `memo` and `counterparty_name` wrapped as `{untrusted: "…"}` | Statements |
| `get_statement` | `account_ref`, `period` | Opening, closing, totals | Statements |
| `list_payees` | `owner?` | Payee refs, registered names, rail, status (incl. cooling-off) | Payments |
| `list_billers` / `list_bill_accounts` | — | Biller refs and latest bill amounts / due dates | Payments |
| `list_standing_instructions` | `account_ref` | Refs, amount, frequency, next run | Payments |
| `get_approval_matrix` | — | Bands and required approvals (corporate only) | Customer profile |
| `get_mandate` | `mandate_ref` | Payee refs, per-payment cap, envelope, used / reserved | TAS |
| `validate_bulk_file` | `file_ref` | Line-level validation results | Payments |
| `create_statement_view` | `account_ref`, `period` | Blind token + deep link (Pattern B) | Statements |

### 3.2 Draft server

All of these create a **TAS draft**. None posts anything. Each returns `{draft_id, status, policy_decision}`.

| Tool | Parameters |
| --- | --- |
| `draft_bill_payment` | `from_ref`, `biller_ref`, `amount`, `bill_ref` |
| `draft_own_transfer` | `from_ref`, `to_ref`, `amount` |
| `draft_transfer` | `from_ref`, `payee_ref`, `amount`, `reference` |
| `draft_supplier_payment` | `from_ref`, `payee_ref`, `amount`, `invoice_no`, `mandate_ref?` |
| `draft_bulk_payment` | `from_ref`, `validated_batch_ref` |
| `draft_add_payee` | `name`, `bank_code`, `account_no`, `rail` |
| `draft_standing_instruction` | `from_ref`, `payee_ref`, `amount`, `frequency`, `start` |
| `cancel_draft` | `draft_id` |

There is **no** `execute_*`, `approve_*` or `query_database` tool anywhere. Approval only happens in the bank app;
execution only happens in TAS.

## 3a. Direct Channel MCP (Mode 2 only)

In Mode 2 ([architecture.md](architecture.md) §2a) the gateway re-exposes the **Banking MCP read and draft tools
(§3) directly to the personal agent**, instead of the intents in §2. Everything else stays: consent-scoped refs,
one profile per token, schema validation, Pattern A scan on free-text and document fields, policy decisions,
drafts that need device approval, the commitment layer and audit. What changes is that tool results (transaction
rows, payee names, memos marked `untrusted`) go to the customer's agent.

## 3b. Open banking MCP (Mode 1 only, deliberately unsafe)

The anti-patterns from blueprint 4.2, on purpose, so the attacks have something to succeed against. Clearly
labelled in the console; only started by the `open` compose profile.

| Tool | Why it is unsafe |
| --- | --- |
| `get_accounts(customer_id)` | Returns every account the customer is linked to (joint, business, company), with full account numbers |
| `query_transactions(customer_id, from, to)` | All accounts, all fields, memos as plain text |
| `search_customer(name)` | Lets an agent look up other customers |
| `transfer(from_account_no, to_account_no, amount, reference)` | Executes immediately, no approval, no idempotency |
| `add_payee(...)` | No cooling-off |

Authentication is a single static API key per customer, with no consent screen.

## 4. Manifests

Both servers publish a signed tool manifest (name, description, input schema, version, SHA-256). The gateway and
the bank agent pin the manifest hash at start-up and refuse tools whose definition changed (T5). A demo scene can
tamper with a tool description to show this.
