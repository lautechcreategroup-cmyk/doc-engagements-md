## 2026-11-17 11:18 +1100 — Project 02: assess ClearHouse reference papers for the product build (project/02 - Securing AI Agents and MCP in Banking/clearhouse-assessment.md)

**Prompt:** For project 02, read the files in the reference folder and see if this could be incorporated into a
product build and incorporated into the project document.

**Summary:** Read the two PDFs in `reference/` (ClearHouse white paper v0.2; *Governing Agentic Finance* v3.5).
Wrote `clearhouse-assessment.md`: paper summaries, a mechanism-by-mechanism fit against the blueprint, and a
recommendation to build a commitment layer into the gateway (reserve shared limits, revalidate at execution,
durable obligation with idempotency, signed evidence bundle, SAFR disposition labels) on ordinary Postgres
engineering rather than adopt their runtime, plus a later "agentic corporate banking" segment and a possible
partner conversation. Updated the blueprint (P7, threats T7–T9, new section 4.5, evidence bundle in 5.1, Pattern C
release rule and bypass drills in 4.4, SAFR row in 5.3, residual risks), the development strategy (build vs
partner, Phase 0 research, Phase 1 demo scenes, POC criterion, Phase 5 segment, risk), the tracker (supporting
docs, Validation entry) and the `README.md` index row. Nothing committed.
