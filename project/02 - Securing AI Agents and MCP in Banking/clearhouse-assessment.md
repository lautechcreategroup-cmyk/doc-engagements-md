# Securing AI Agents and MCP in Banking — ClearHouse Reference Assessment

What the two ClearHouse papers in [`reference/`](reference/) say, how they relate to our
[solution blueprint](solution-blueprint.md), and what we should take into the product build (Offer B, the Agent
Security Gateway, in [development-strategy.md](development-strategy.md)). Written 2026-11-17. See the
[project tracker](README.md).

## 1. The two papers

| | [ClearHouse white paper v0.2](reference/clearhouse-v0.2-revised.pdf) | [Governing Agentic Finance v3.5](reference/governing-agentic-finance-v3.5.pdf) |
| --- | --- | --- |
| What it is | Engineering white paper for a *governed execution kernel* for autonomous agents that change shared state (ledgers, journals, regulatory logs). Rust; TLA+ models. | Research paper for a *SAFR-aligned payment gateway* built on that kernel: shared limits across agentic payment protocols (AP2, x402, MPP, ACP). |
| Author / source | The ClearHouse Project; repo `github.com/GFTN-Services/ClearHouse` | Stanley Yong, ClearHouse / Tokenized Markets Lab; repo `github.com/GFTN-Services/clearhouse-safr-gateway` |
| Date and status | 13 Nov 2026, v0.2.0-beta, "not a financial-grade guarantee" | Nov 2026, revision 3.5, "draft for institutional review" |
| Core idea | Sandboxes and identity cover *where the agent runs* and *who it is*. Neither stops two correctly authorised agents from making individually valid changes that are jointly wrong, or acting on stale state. Put a fail-closed *commit gate* outside the agent. | Authorisation (a valid mandate) is not the same as *capacity* (is there still budget, is the state still the same, did the payment actually happen). Add a *commitment boundary* beneath SAFR governance. |
| Evidence level | Strong at the formal-model level (TLC, Apalache, TLAPS). Partial for implementation and OS enforcement. No production soak. | Tested internally; two read-only external checks. No funded settlement, no independent review. |
| Honest finding | A competent conventional stack (DB transactions + outbox) matches it on every single-database concern. | Same: within one database, serializable Postgres + outbox passed every scenario at lower latency (p95 2.1 ms vs 3.6 ms). The cross-system advantage is unmeasured. |

Both papers say that AI tools were used heavily to write the code, specs and text, and that no outside party has
reviewed them. Treat their results as the authors' own claims. Neither paper has been checked against MAS's own
SAFR publication; we need to read SAFR v1.1 from mas.gov.sg ourselves before quoting it to a bank.

### 1.1 Mechanisms worth knowing

| Mechanism | What it does | Paper |
| --- | --- | --- |
| **Staged effects (overlay)** | An agent's changes are journaled as intents in a private copy, not applied. Abort leaves real state byte-identical. | White paper §II |
| **Commit gate with read-footprint validation** | At commit, reject if anything the agent *read* or *wrote* was changed by a later commit. Checking writes alone admits write skew (machine-found counterexample). | White paper §VI |
| **Intent-bound approval** | Approver signs `hash(class ‖ intent_hash ‖ work_unit ‖ expiry ‖ policy_version)`. Changing amount, destination or policy version invalidates the approval. | White paper §V; GAF ch. 5 |
| **Commit-time revalidation** | Authority is checked when the effect is staged *and again just before commit*, so a revoked envelope, removed approver or expired approval blocks it (closes time-of-check / time-of-use). | White paper §V; GAF ch. 5 |
| **Shared-limit reservation** | Reserve against a shared allowance under a per-mandate lock; reservation expires if unused; consume at commit. Ten racing requests on a $2,000 budget → exactly five commit. | GAF ch. 5–6 |
| **Durable obligation (outbox) + recovery** | Record the payment you are committed to *before* sending it. After a crash or timeout, resolve from external evidence; resubmit only with rail idempotency or proof of non-execution; otherwise hold for manual investigation. | White paper §V; GAF ch. 5–6 |
| **Read Gate (provenance taint)** | Each agent context carries the highest sensitivity label it has read; egress to a lower-clearance sink needs an explicit, logged declassification. A clean DLP scan is *not* a declassification. | White paper §VII |
| **Credential custody** | Agents hold an identity token only. Execution credentials stay behind the gateway (HSM / KMS / custodian). Drills test that no other path to a payment system exists (11/11 passing). | White paper §II; GAF ch. 9 |
| **Signed evidence bundle** | Ed25519-signed, hash-linked decision chain, verified offline. Proves integrity and order — not completeness, correctness, or that the payment happened. | White paper §II; GAF ch. 9 |
| **SAFR four dispositions** | Every proposed action gets Deny / Escalate / Auto-Execute / Observe from versioned controls. | GAF ch. 4 |

Known gaps the authors name themselves: compliance-hold *content* is not evaluated at commit (only its version);
a mandate tightened mid-flight passes with the old limits; reservation consume and obligation write are separate
writes; escalated approvals cannot yet be resumed end to end; object-level dependencies miss predicate
"phantoms"; no cross-system (federated) capacity yet.

## 2. How it relates to our blueprint

Our blueprint is about **a bank exposing its services to customer-facing agents** over MCP: keep data out of the
model (Patterns B and C), stop injection (Pattern A), and make every write a draft the customer signs (Pattern D).
ClearHouse is about **what happens at the instant an approved action changes real state**. The two are
complementary layers, and ClearHouse fills gaps our blueprint does not cover:

| Blueprint area | What we have | What ClearHouse adds | Fit |
| --- | --- | --- | --- |
| Pattern D (HITL) | Customer signs `hash(canonical payload)` on device; TAS verifies then executes | Bind the **policy version** into the signed hash; **re-validate at execute time** (consent revoked, beneficiary frozen, limit changed, account hold, session severed) | **Strong — adopt** |
| 4.3 policy gateway | Per-transaction and daily caps, velocity | Caps checked at draft time are race-prone across parallel sessions or agents. **Reserve at draft, consume at execute**, expire unused reservations | **Strong — adopt** |
| Execution / core submission | Not covered | **Durable obligation before submission**, idempotency key per draft, explicit "outcome unknown" state, no blind retries | **Strong — adopt** |
| 5.1 audit trail | Hash-chained, WORM | Per-event **signatures**, exportable **evidence bundle**, **offline verifier**, and the honest "four questions" framing | **Medium — adopt** |
| Pattern C output policy | "Output policy / DLP" leaves Z3 | **Provenance taint**: the enterprise agent that read raw transactions is high-taint; release to Z1 only through an explicit declassifier (aggregate templates), never "DLP looked clean" | **Medium — adopt the model**, not the code |
| 4.4 runtime | No egress from Z3; no secrets in context | Credential custody + **bypass drills** run by the bank against its own deployment | **Medium — add to red-team pack** |
| 5.3 regulatory mapping | GDPR / PDPA, RMiT / TRM, FEAT | **MAS SAFR** vocabulary (four dispositions, governance envelope, controls repository) | **Medium — add as alignment, after reading SAFR ourselves** |
| 5.2 anomaly response | Tiered severing | Hard constraints never overridable by a risk score; only discretionary escalation adapts (approval-fatigue control) | Small — adopt the rule |
| Commit gate / OCC, TLA+ proofs, overlay file system | — | Kernel-level machinery for agents editing shared files/ledgers | **Low for us now** — useful only if we later govern bank-internal agents writing to shared records |
| Cross-protocol budgets (AP2, x402, MPP, ACP) | — | One budget across agentic payment rails | **Later segment** (see 3.3) |

New threats this gives our catalogue (added to the blueprint as T7–T9):

- **T7 Stale authorisation (time-of-check / time-of-use):** the customer approves; before execution the consent
  is revoked, the payee is flagged, or a hold is placed — and the payment still runs on the earlier check.
- **T8 Shared-limit race:** two sessions or agents (the bank assistant plus a third-party agent, or several SME
  staff agents) each pass the daily-cap check and together exceed it.
- **T9 Duplicate or lost execution:** a timeout after core banking accepted the instruction; the agent or gateway
  retries and pays twice, or wrongly assumes failure.

## 3. Product build recommendation

### 3.1 Build it into the gateway — a "commitment layer" in Offer B

The papers' own comparison is the key fact: *within one database, a serializable Postgres transaction plus a
transactional outbox does everything their gateway does, faster.* For a single bank, the commitment layer is a
**feature of our Agent Security Gateway, built on ordinary engineering**, not a separate product we need to buy or
licence. Scope for the build:

1. **Draft → reserve → approve → revalidate → commit → obligation → reconcile** lifecycle in the Pattern D TAS.
   Every state change is a row in Postgres; transitions are serializable.
2. **Intent hash** over the canonical payload *plus* `policy_version` and `consent_version`; what the customer
   signs and what TAS executes are the same hash.
3. **Commit-time revalidation inside the commit transaction:** consent, beneficiary status, account holds,
   limits and session state are re-evaluated by *content*, not just version — this avoids the gap ClearHouse
   still has.
4. **Reservation against shared limits** (per customer, per account, per corporate mandate) with expiry.
5. **Durable obligation + idempotency key** for every core-banking submission; an `outcome_unknown` state that
   holds capacity and goes to an operations queue rather than retrying.
6. **Signed evidence bundle + offline verifier** as an export from the audit store — a strong sales artefact for
   CISOs and auditors.
7. **SAFR disposition labels** on every policy decision (Deny / Escalate / Auto-Execute / Observe), so a
   Singapore bank can map our output onto SAFR without translation.

Estimated effect on Phase 1: roughly 2 extra engineer-weeks on the gateway and TAS. Adds three demo scenes (T7–T9)
that are easy to show live and that rate limiting and AI firewalls visibly do not stop.

### 3.2 What not to take

- The Rust kernel, file-system overlay, OS sandboxing (Seatbelt / Landlock) and TLA+ proofs. They solve agents
  editing shared files and ledgers, which is not our v1 scope, and they are beta, single-team and unreviewed.
- Their codebase as a dependency, until we have checked the repository licence and maturity, and until someone
  outside the author's team has reviewed it.

### 3.3 Where it opens a bigger market (later, hypothesis)

Our blueprint assumes **the customer signs every write** (retail). That does not scale to SME and corporate
customers whose own agents pay suppliers, sweep cash or settle invoices through the bank's MCP server. There, the
bank needs **mandates with spending envelopes** (Auto-Execute within limits, Escalate above), shared budgets across
several agents and channels, and evidence a corporate auditor can verify. This is the ClearHouse model applied to
our gateway, and it is a natural Phase 5 extension: *"agentic corporate banking"*. Cross-rail budgets (AP2, x402
and similar) only matter if a bank or its customers actually pay through those rails — not a v1 concern for
Malaysian or Singapore banks.

### 3.4 Partner option

The ClearHouse / Tokenized Markets Lab team is working on the same problem from the financial-execution side and
is SAFR-focused (Singapore). Worth one Phase 0 conversation: compare notes, ask about licence and reviewers, and
explore whether they would act as a technical partner for corporate and treasury use cases (3.3) while we own the
customer-channel MCP security layer. Decide after Gate 0.

## 4. Changes made to the project documents

- [solution-blueprint.md](solution-blueprint.md): design principle P7; threats T7–T9; new section 4.5 (commitment
  boundary); signed evidence bundle in 5.1; SAFR row in 5.3; scenario and residual-risk updates.
- [development-strategy.md](development-strategy.md): build-vs-partner row, Phase 0 research items, Phase 1 demo
  scope and red-team scenes, POC success criteria, Phase 5 corporate extension, strategy risk.
- [README.md](README.md) (tracker): reference papers and this assessment listed; input to Validation.

## 5. Open questions

1. Does SAFR v1.1 say what the paper says it says? Read the MAS source.
2. Is SAFR relevant to BNM-regulated banks, or only to MAS? Is there a BNM equivalent in progress?
3. What licence is the ClearHouse code under, and is anyone outside the author's team reviewing it?
4. Do our target banks' core systems support idempotent payment submission? This decides how much of the
   obligation / reconciliation work we need.
5. Does any design-partner candidate have SME or corporate customers asking for agent-initiated payments (3.3)?
