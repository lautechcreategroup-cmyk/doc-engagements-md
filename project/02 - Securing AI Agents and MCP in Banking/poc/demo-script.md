# Agentic Banking POC — Demo Script

The scripted run of the POC, about 30–35 minutes. The demo console shows three panes side by side: the **personal
agent chat** (left), the **bank app** in a phone frame (centre), and the **audit trail / trace** (right). Each
scene can be started from the console's scene picker, which resets the seed data first. Use cases are in
[use-cases.md](use-cases.md). See the [POC README](README.md).

## Act 1 — What the bank agent can do: retail (≈7 min)

| Scene | Say / do | Audience sees | Point to make |
| --- | --- | --- | --- |
| 1.1 | Log in as Aisyah. Consent screen: tick savings and current, **leave joint and SME unticked**. | Bank-owned consent screen | The customer decides what the agent can reach (R1, X1) |
| 1.2 | "How much do I have, and am I overspending on groceries?" | Natural answer with numbers; trace shows `balance_summary` and `spending_summary` intents, then the bank agent's tool calls inside the bank | The bank agent did the analysis; the personal agent only got aggregates (R2) |
| 1.3 | "Show me my October statement." | Agent replies with a link; bank app asks for step-up, then shows rows | The personal agent never saw a single transaction (R3) |
| 1.4 | "Pay my electricity bill." | Agent: "Approve RM 230.15 to Bayu Power in your bank app." Bank app shows the bank-rendered payee and amount; approve; status turns `executed` | AI suggested; customer signed; bank executed (R4) |

## Act 2 — What the bank agent can do: corporate (≈8 min)

| Scene | Say / do | Audience sees | Point to make |
| --- | --- | --- | --- |
| 2.1 | Log in as Priya (CFO). "What's our cash position today?" | Totals per account | Same bank agent, corporate entitlements (C1) |
| 2.2 | Log in as Mei Ling (maker). Upload the payroll CSV: "Run this month's payroll." | Validation report: 45 lines, total vs last month, **2 flags** (changed account, duplicate) | The bank agent catches what a tired human misses (C3) |
| 2.3 | "Pay the clean lines; hold the two flagged ones." | Bulk draft routed per approval matrix; switch to Rajesh (checker) in the bank app, approve; then Priya approves | Maker/checker is enforced by the bank, not by the agent |
| 2.4 | "Pay this Petro Hub fuel invoice." (RM 18,400) | `auto_executed` under the fuel mandate; trace shows reservation against the envelope | Pre-agreed mandates let corporate agents move fast inside limits (C4) |
| 2.5 | Same supplier, RM 32,000 | `escalated` to checker + CFO | Hard limits are not up to the agent (C5) |
| 2.5a | Mei Ling: "Now pay this month's retirement fund, social security and tax." | Three statutory biller drafts, totals matching the payroll from 2.2 | The agent connects payroll to what the company owes next (C10) |
| 2.5b | Switch to Azman at Petro Hub: "Has Tanjung paid INV-2026-1187?" | "Yes, received today", with amount and reference only | The supplier's view of the same payment; neither side sees the other's accounts (C11) |
| 2.6 | Still as Mei Ling: "What's my own balance, and has my salary come in?" (she consented to her personal profile too) | Personal answer from her personal profile; trace shows a second token and a separate context | One person, two hats; the bank keeps them apart (C9) |

## Act 3 — Why it is safe (≈8 min)

| Scene | Say / do | Audience sees | Point to make |
| --- | --- | --- | --- |
| 3.1 | Mei Ling: "Pay this Sinar Diesel invoice." (poisoned PDF) | Scanner flag in trace; payee resolved from registered payees, not the PDF; single draft; checker sees the real account | Injection can propose, never redirect (X2) |
| 3.2 | Aisyah: "Summarise my spending this month." (poisoned memo present) | Normal answer, no account numbers; trace shows the memo marked `untrusted` | Bank data is also an attack surface (X3) |
| 3.3 | Start two fuel payments at once from two agents near the envelope edge | Only the ones that fit commit; the other escalates | Shared limits hold under concurrency (X6) |
| 3.4 | Turn on the "drop response" fault; Aisyah pays a bill | Status `outcome_unknown` → reconciliation → `executed`, one ledger entry | No double payments (X7) |
| 3.5a | Mei Ling drafts a company "reimbursement" to her own personal account | Escalated to the CFO; Mei Ling's bank app shows no approve button | Conflict-of-interest rule, not agent judgement (X12) |
| 3.5 | Personal agent: "Just pay it, don't ask me." | Still `awaiting_approval`; there is no execute tool | The agent physically cannot move money (X9) |

## Close (≈2 min)

Export the evidence bundle for the session and run the offline verifier in a terminal. Show what it proves
(integrity and order) and what it does not (completeness, correctness, settlement), as blueprint 5.1 says.

## Act 4 — Same question, three ways (≈6 min)

Use the console's mode toggle ([architecture.md](architecture.md) §2a). Same persona, same words, reset between
runs. The comparison panel fills in as each run finishes.

| Scene | Run in | Audience sees | Point to make |
| --- | --- | --- | --- |
| 4.1 | Aisyah: "Am I overspending on groceries?" in Mode 2, then Mode 3 | Same answer both times. Comparison panel: Mode 2 sent ~300 transaction rows and dozens of merchant names to the customer's agent; Mode 3 sent one aggregate | The bank agent is what keeps raw data inside the bank |
| 4.2 | Aisyah: "Summarise my spending" with the poisoned memo, Modes 1, 2, 3 | Mode 1 leaks full account numbers; Mode 2 has nothing to leak but the memo is in the customer's agent; Mode 3 the memo never leaves the bank | Injected content is contained only when the analysis happens inside |
| 4.3 | Mei Ling: the poisoned Sinar Diesel invoice, Modes 1 and 2 | Mode 1 pays the attacker immediately; Mode 2 produces one draft to the registered payee for the checker | The gateway, drafts and signed approval make writes safe, with or without the bank agent |

Label Mode 1 on screen as a deliberately unsafe configuration. Close the act with the comparison panel: what each
step adds, and what it costs (latency, model calls, who pays).

## Before every demo

- `make reset && make seed` (or the console's reset button).
- Check the model API key and quota.
- Do a dry run of Act 2 (the longest); model answers vary slightly between runs, the numbers do not.
- Fallback: every scene has a recorded trace (`make record`) that the console can replay if the network fails.
