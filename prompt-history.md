# Prompt History

Log of prompts given to AI agents in this repo. Append new entries at the bottom, in the format below. Times are
local (UTC+8). The convention follows `orangepayorg/template-dict-rte-v1`.

---

## 2026-10-17 13:05 — New project: Johor digital government next steps, China benchmark (project/01 - Johor Digital Government Next Steps (China Benchmark)/)

**Prompt:** I have a need to create a project to investigate the digital journey for a municipal in China. The Johor
government is starting a Data lake and would like to know what's next. So picking China and referencing their
journey could give us some hint as to what sort of project we could launch next. There might be: low hanging fruit
project; strategic long term project; infrastructure type of project, which could enable other forms of automation
or services. One idea could be to: cut down on paper work; improve processing time; build totally new services that
could bring in more investment or make life better for the local business and citizens. This is the research from
another agent: *[pasted Johor municipal governance baseline profile, stored as `johor-baseline-profile.md`]*. Please
reach out to the internet if possible for your research and document all these as a project.

**Summary:** Ran `/new-project` and created `project/01 - Johor Digital Government Next Steps (China Benchmark)/`:
- **`README.md`:** the tracker. Status: Idea, client: Johor State Government. Only the Idea section is filled in,
  with the three project buckets and the caveat that Johor should copy China's sequence, not its top-down
  enforcement.
- **`johor-baseline-profile.md`:** the pasted research, cleaned up and marked unverified. Added a web-sourced
  section covering data-centre approvals (42 projects, RM164.45 bn), the Johor Digital Plan, JS-SEZ / IMFC-J, the
  Data Sharing Act 2025 (federal-only, which leaves state agencies uncovered), OSC 3.0 Plus, and the fact that no
  public information exists on the data lake itself.
- **`china-municipal-digital-journey.md`:** a seven-stage reference journey with sources. Stages: Zhejiang "At Most
  One Visit", Zheliban / Shanghai 一网通办, e-certificates, Shenzhen 秒批, 高效办成一件事, City Brain / 一网统管 /
  Beijing 12345, Suzhou 信易贷 / Shanghai Data Exchange. Ends with what transfers to Johor, what needs adapting and
  what to leave out.
- **`opportunity-longlist.md`:** 17 candidate projects across three buckets: low-hanging fruit (A1–A5),
  infrastructure/enablers (B1–B6) and strategic (C1–C6). Each is tagged by goal and mapped to its China precedent.
  Includes a draft sequence and open questions for the client.

Added the project row to `README.md`. Nothing committed.

---

## 2026-10-17 13:15 — Adopt prompt-history convention (CLAUDE.md, prompt-history.md)

**Prompt:** look at the AGENTS.md in this repo https://github.com/orangepayorg/portal-process-designer-node-v3
there is a prompt-history.md which will store the prompt history. Incorporate this into the AGENTS.md in this repo
and create the first prompt history.

**Summary:** The portal repo's `main` has no `prompt-history.md`. The convention lives in its sibling worker repo
(`orangepayorg/app-process-designer-worker-go-v1`), which the portal's `feature/remote-worker-console` branch
references. Copied that "Prompt history" section into `CLAUDE.md` (= `AGENTS.md` / `AGENT.md` via symlinks),
adapted it to this repo (paths name documents or project folders, and long pastes are summarised), and created this
file with the two prompts from this session. Indexed `prompt-history.md` in `README.md`. Nothing committed.
(Superseded by the next entry.)

---

## 2026-10-17 13:20 — Switch prompt-history reference to template-dict-rte-v1 (CLAUDE.md, prompt-history.md)

**Prompt:** refer to this project instead https://github.com/orangepayorg/template-dict-rte-v1 there's a
prompt-history there and the AGENTS.md has instruction on how to create the prompt history

**Summary:** Replaced the "Prompt history" section in `CLAUDE.md` with template-dict-rte-v1's wording: append to
`prompt-history.md` with a clear title, the file path or feature in the title, a task description and the time
added. Adapted it to this repo by naming the project folder or document in the title and summarising long pastes.
Kept the existing entry format (`## <date time> — <title>`, then **Prompt:** and **Summary:**), which matches that
repo, and pointed this file's header at it. Nothing committed.

---

## 2026-10-17 13:26 — China delivery models and success/failure case studies (project/01 - Johor Digital Government Next Steps (China Benchmark)/china-delivery-models-and-case-studies.md)

**Prompt:** also maybe detail how these services are created in china, do they award it to a contractor or they
build in house. Detail the journey. If it's mix then show what works and what did not work. Take some usecase of
projects that was highly successful and projects that failed for each category. If there's a number then list them
down too so we could launch additional reserach later.

**Summary:** Ran further web research and added `china-delivery-models-and-case-studies.md`:
- **How delivery changed over time:** from departmental IT centres, to the PPP smart-city boom, to data bureaus and
  operator companies, to COVID health codes, to state-owned data groups and the crackdown on government apps.
- **Five delivery models compared:**
  1. In-house bureau (Shanghai Big Data Center, Shenzhen).
  2. Joint-venture operator under "管运分离" (Digital Guangdong: Tencent plus the three telcos).
  3. Co-development with a tech giant (Zhejiang with Alibaba).
  4. State-owned operating company or data group (Hangzhou City Brain Co., Shanghai and Beijing data groups).
  5. Turnkey PPP (a Guizhou county).
- **Success and failure cases for each bucket:**
  - Low-hanging fruit: "At Most One Visit" and Beijing 12345 worked; app sprawl ("fingertip formalism") failed.
  - Infrastructure: Digital Guangdong and the e-certificate libraries worked; the Guizhou PPP and the Henan
    red-code misuse failed.
  - Strategic: Shenzhen 秒批, Suzhou 信易贷 and City Brain (claimed) worked; the Hangzhou permanent health code,
    the slow start of the Guiyang data exchange and KL City Brain (2018, no published outcome) fell short.
- **Also in the doc:** a worked / didn't-work table, a draft owner/operator model for Johor, a 42-row numbers
  register with confidence levels and follow-up questions, and the evidence gaps.

Linked it from the tracker and `README.md`. Nothing committed.

---

## 2026-10-17 13:32 — Commit and push session changes to main

**Prompt:** commit these changes and push directly to main

**Summary:** Committed the Johor project folder (`project/01 - Johor Digital Government Next Steps (China Benchmark)/`),
the `CLAUDE.md` prompt-history section, `prompt-history.md` and the `README.md` index updates as `b198b50`, and
pushed it to `origin/main`. This entry was committed separately afterwards.

---

## 2026-10-22 — Project 01: findings presentation for MDEC / Johor state IT (`project/01 - …/presentation/`)

**Prompt:** For project 01, build a presentation of the findings for a Malaysian government business-IT contact
(at MDEC and involved with Johor state IT), who will present it to their own board (Johor state leadership). Share
only headlines. Also show where we can help shape and develop the opportunity, and position the Hyalo designer
(`portal-process-designer-node-v3/slides/1-DesignerValueProposition`) as our strategic delivery tool: the client
focuses on defining the project, and a change of direction isn't prohibitive. Validate the statement and ask
questions first. Then: state the deck structure first (Deck A and Deck B), build the decks, store them locally, and
save the outline.

**Summary:** Validated the Hyalo claim against the government deck brief and the project research. The core claim
holds; it was reframed as "you focus on the definition and the governance; the build won't be the bottleneck".
Hyalo doesn't make governance agile. In-progress capabilities are badged, and no Malaysian project is named. The
board's sovereignty and lock-in questions are answered with "Proposed" positions.

Agreed two decks:
- **Deck A:** findings for Johor state leadership, 13 slides.
- **Deck B:** how we help, plus Hyalo, 11 slides.

Built both as HTML in the Hyalo government-deck style, with PDFs, `export-pdf.sh` and `deck-outline.md`, in
`project/01 - …/presentation/`. Defaults taken: a placeholder for the first step, no
payments content. Updated `README.md` and the project tracker. Nothing committed.

---

## 2026-10-22 — Project 01: remove "Prepared by OrangePay" from Deck A (`project/01 - …/presentation/`)

**Prompt:** Commit and push the presentation to a branch and raise a PR. Then: make sure "Prepared by OrangePay" is
removed, commit the change, and add a PR comment explaining why.

**Summary:** Committed and pushed to branch `johor-findings-presentation`. Removed "Prepared by OrangePay" from
Deck A's title and closing slides so it is unbranded for the contact's board, re-exported the PDF and updated
`deck-outline.md`. The PR text and the comment explaining the change are ready.

---

## 2026-11-06 15:05 — New project: Securing AI Agents and MCP in Banking (project/02 - Securing AI Agents and MCP in Banking/)

**Prompt:** This is a summary of my interaction with Gemini, create a new project to document these points. There
could be more than 1 document. (Pasted: a Gemini executive summary on securing AI agents and MCP in banking,
covering core problems and risks, three threat scenarios, and four architectural mitigations. Stored across the
project's supporting docs.)

**Summary:** Created `project/02 - Securing AI Agents and MCP in Banking/`. The tracker `README.md` has Status: Idea,
with only the Idea section filled in. Owner and client are TBC, and the source is recorded as an internal idea from
the Gemini conversation. Split the summary into three supporting docs:
- `problem-and-risks.md`
- `threat-scenarios.md`
- `architectural-mitigations.md`, which adds our own scenario coverage matrix, gaps (least-privilege MCP scopes,
  egress control, tenant-isolated memory) and open questions for validation.

Added row 02 to the `README.md` Projects table. Nothing committed.

---

## 2026-11-06 15:13 — Project 02: solution blueprint and development strategy (project/02 - Securing AI Agents and MCP in Banking/)

**Prompt:** This was my prompt to generate the blueprint / solutions. Incorporate it as an approach and solution.
Then see what the development strategy would be if we want to develop such a thing, including the points where we
could find a partner / bank, deploy the solution for a POC, and then move on to bigger goals. (Pasted: the Gemini
prompt for a "Secure Agentic AI & MCP Integration Blueprint (v1.0)", in five sections. Saved word for word as
`blueprint-prompt.md`.)

**Summary:** Added three docs to project 02:
- `blueprint-prompt.md`: the prompt, saved word for word.
- `solution-blueprint.md`: the full blueprint, written to the prompt's structure. Covers trust zones Z0–Z4, threat
  catalogue T1–T6, Patterns A–D with mermaid workflows, OAuth 2.1 + DPoP / RFC 8707 / FAPI 2.0, least-privilege
  tool design, the policy-as-code gateway, the audit-record schema, tiered anomaly response, a regulatory mapping
  marked as still to be confirmed, and residual risks.
- `development-strategy.md`: offers A/B/C, with the recommendation to lead with advisory and build the Agent
  Security Gateway. Covers build vs partner, phases 0–5 with gates, partner channels and touchpoints, POC scope
  and success criteria, team, risks and next steps.

Updated the tracker's supporting-docs list (Status stays Idea), answered the open question in
`architectural-mitigations.md`, and expanded the project 02 row in `README.md`. Nothing committed.

---

## 2026-11-09 11:06 — Commit and push project 02 to main

**Prompt:** Push the changes directly to main.

**Summary:** Committed the project 02 folder (tracker, problem/risks, threat scenarios, mitigations, solution
blueprint, development strategy, blueprint prompt), the `README.md` index row and the `prompt-history.md` entries
in one commit on `main`, then pushed it to `origin/main`.

---

## 2026-11-13 16:23 — Project 02: board deck (project/02 - Securing AI Agents and MCP in Banking/presentation/board-deck.html)

**Prompt:** For project 02, Securing AI Agents and MCP in Banking, produce a set of slides to be presented to a
company board about the landscape of the AI solution, the MCP marketplace, then the problem statement and finally
the possible solutions. We can have: an MCP product to onboard a company; MCP with web scraping; agent-to-agent
that will stop third-party agents' direct access. Follow-up: the slides can be in HTML, but in slide form so that
we can print them to PDF.

**Summary:** Added `presentation/` to project 02 with `board-deck.html` (17 slides, 1920×1080, arrow-key
navigation, prints one slide per page), the exported `board-deck.pdf`, and `export-pdf.sh` (copied from project
01). Sections: AI landscape (assistants, copilots, agents; MCP and A2A), the MCP marketplace (four kinds of
player; how publishing and listing work), the problem (four reasons controls fall short, scenarios S1–S3, three
public MCP incidents from 2025, four guarantees a bank needs), and solutions (options A, B and C, a comparison
table, a proposed path, and the decisions asked of the board). Assumptions taken: "onboard a company" read as
getting a company onto MCP; the budget is a `[RM__]` placeholder; the incident and protocol dates are from memory
and need checking before external use. Updated the tracker's supporting-docs list and the project 02 row in
`README.md`. Nothing committed.

---

## 2026-11-13 16:44 — Project 02: Option C scenario slides (project/02 - Securing AI Agents and MCP in Banking/presentation/board-deck.html)

**Prompt:** For Option C, in the deck give some scenarios where agent-to-agent can protect the customer, mitigate
an out-of-control agent and guard against prompt injection. Maybe add a few slides after slide 14.

**Summary:** Added three scenario slides after slide 14 (now slides 15–17; the deck is 20 slides). Each one sets
"with direct access" against "with agent-to-agent": a grocery-spend question where the history stays in the bank;
a faulty or compromised assistant that is limited to a short list of requests, cannot pay without the customer's
signature and can be suspended; and a hidden instruction in an invoice that cannot cross the fixed-form request
boundary. The third slide states the limit: the outside assistant can still be fooled. Re-exported
`board-deck.pdf` and updated the slide count in the tracker and `README.md`. Nothing committed.

---

## 2026-11-13 16:51 — Commit and push project 02 board deck to main

**Prompt:** Please commit these changes and push directly to main.

**Summary:** Committed the project 02 `presentation/` folder (board deck HTML, PDF and `export-pdf.sh`), the
tracker update, the `README.md` index row and the `prompt-history.md` entries in one commit on `main`, then pushed
it to `origin/main`.
