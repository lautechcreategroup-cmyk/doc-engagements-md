---
pdf_options:
  format: A4
  margin: 18mm 16mm 20mm 16mm
  displayHeaderFooter: true
  headerTemplate: '<div></div>'
  footerTemplate: '<div style="width:100%;font-size:8px;padding:0 16mm;color:#999;display:flex;justify-content:space-between;"><span>Johor Digital Government — Business Case (Conservative Assessment) · OrangePay · 17 October 2026</span><span>Page <span class="pageNumber"></span> of <span class="totalPages"></span></span></div>'
stylesheet: business-case.css
---

# Johor Digital Government: The Business Case

### A conservative read: what to bid now, what to gate, and what to walk away from

*Prepared by OrangePay · 17 October 2026 · Idea stage, for client validation*

<div class="callout">

**The one-paragraph version.** Johor is building a state data lake, and the question is what to build on top of
it. Benchmarking against Chinese cities and provinces — the only governments that have run this playbook at
scale — supports starting small, not committing to a programme. We recommend bidding only **three cheap,
low-risk items now** (a "one visit" baseline at two volunteering councils, complaints analytics for three
councils, an investor-facing approval tracker) plus **one institutional workstream**: the state data-sharing
directive, which is the critical path and is mostly lawyers, not vendors. Everything else is **gated** on
answering four questions that kill Malaysian state IT programmes regardless of technology: who funds it
(including years 2–5), which procurement route, who is the single accountable owner, and what survives the
state election due by 2027. One flagship idea — a state-wide city-operations platform — we recommend walking
away from outright. Two adversarial expert reviews (Malaysian and Chinese government IT delivery) stress-tested
this package; this document adopts the most conservative posture both reviews support.

</div>

## 1. The recommendation in one table

| Verdict | Items | Conditions |
| --- | --- | --- |
| **Bid now** | A1 "one visit" baseline, top-20 services — MBJB and MBIP only | No published ranking of councils in year one |
| **Bid now** | A4 complaints analytics — **3 councils only**, aduan data quality is poor and unstandardised across all 16 | Anonymisation first |
| **Bid now** | A3 investor-facing approval tracker (OSC 3.0 Plus, councils, utilities, IMFC-J) | OSC 3.0 Plus is a federal (KPKT) system — federal integration consent required. Frame as investor transparency, **not** an expose of which agency delays |
| **Start now, institutional** | B1 data-sharing framework — **rescoped**: MMKN directive + data catalogue + 3 pilot MoUs + a PDPA-gap memo | Not a state enactment (multi-year). 12–18 months, mostly lawyers and the State Secretary's office, thin vendor content. Critical path |
| **Candidate, open tender** | B5 shared payments — the real gap is reconciliation and unified e-receipts, not payment rails (DuitNow/FPX already exist) | Open procurement; OrangePay declares a commercial interest (§6) |
| **Gated sequence** | B3 master reference data → B2 e-licences → B4 integration layer; then C1 auto-approval **renewals-only, realistically 2028+**; C2 life-event bundles **state services only** | Each gate below. C1 needs legal equivalence for e-certificates and a judicial-review-safe fallback design |
| **Park** | C5 data-centre resource monitoring (fold into A3/B4); C6 open data / data products (**park to ~2030**) | No enforcement teeth, no demand side, no safe legal basis yet |
| **Walk away** | C4 state-wide city-operations platform; C3 SME credit-from-data **in its current form** | C4: the only Malaysian precedent (KL City Brain, 2018) has no published outcome. C3: credit-grade data is federal (CCRIS, LHDN, EPF); BNM-regulated banks will not lend on state-attested licences; "consent" has no statutory meaning for state-held data while PDPA exempts the state entirely |

This deliberately under-bids relative to the seventeen-item longlist: the Malaysian reviewer's advice was to
bid 3–4, park 3, kill 3–4 — and we adopt the stricter reading.

## 2. Why this matters now — with the caveats attached

- **The data-centre boom is real but is not a citizen-services mandate.** 42 approved projects worth
  RM164.45 billion (Q2 2025, state figures), ~78.6% of Malaysia's operational IT capacity. Its bankable
  government-facing impact is land premiums, water-and-power politics and investor facilitation pressure —
  which A3 serves. It does **not** create citizen-service demand, and data-centre operators compete with the
  state for the same scarce engineers.
- **The Johor–Singapore SEZ (signed January 2025)** and the IMFC-J one-stop centre (1,000 enquiries, RM73
  billion potential investment self-reported by March 2026) put a price on approval speed. SEZ investors will
  compare Johor with Singapore.
- **A federal target without a state scoreboard.** Building-permit approvals are targeted to fall from 42 to
  21 days; no Johor-specific published actuals exist. A3 is the scoreboard.
- **A governance vacuum.** Digital Johor Sdn Bhd (2017) is widely seen as having failed; the Digital Master
  Plan 2030's current status is unclear. Keeping that failure in view is the package's best instinct: it is
  the client's own precedent for a vehicle without a mandate or a budget.

## 3. The evidence — presented with its warts

Chinese provinces and cities (Zhejiang, Shanghai, Shenzhen, Suzhou, Beijing, Guizhou, Guangdong) ran this
journey over a decade. As pedagogy, the sequence holds: paperwork and visits first, data sharing and
e-certificates second, automation third, city-ops platforms fourth, data markets last. One reviewer's caution,
which we adopt: the sequence was **messier in practice** — Shanghai built its front door and ops platform in
parallel; Zhejiang shared data concurrently with its process reform. Treat the order as a default, not a law.

**What worked (directionally, mostly self-reported):** Zhejiang's "one visit" reform cut a Ningbo
manufacturer's permit processing from 3–4 months to under one month, and was codified into provincial
regulation in 2018 so it outlived its founders. Shanghai aggregated 678 certificate types (~200 million
certificates, 2.14 billion retrieval calls — each call is one photocopy nobody had to bring). Shenzhen
automates roughly 200 low-risk, data-verifiable items with automatic fallback to a human. Suzhou's
credit-from-data scheme produced thousands of first-ever bank loans for small firms. Note the fine print our
own first draft got wrong: "100% online" in Zhejiang meant **item coverage**, not end-to-end completion, and
Beijing's celebrated 97% hotline resolution rate is a self-defined metric with documented gaming.

**What failed — these, not the wins, are the load-bearing lessons:**

- **Vendors who were never paid.** A Guizhou county bought a 120-million-yuan smart-city package (audited at
  ~80 million yuan): six of seven subsystems idle, the vendor suing. One obscure source — but it is one
  instance of a **systemic 2022–24 pattern** of Chinese governments not paying smart-city vendors, with
  integrators going under. For any plan involving an operator and council-subscribed services, "who pays, and
  will they keep paying" is China's number-one failure lesson. Malaysia's Auditor-General reports are the
  domestic version of the same story.
- **Dashboards that impress delegations and change nothing.** China's own phrase for it is "big-screen
  formalism". It is the exact failure mode awaiting councils like Mersing and Kota Tinggi, whose binding
  constraint is assessment collection, not visualisation. This is why C5 is folded away and why the pilot set
  is urban.
- **The imported platform with nothing behind it.** KL deployed Alibaba's City Brain in 2018; a 2020 ITU
  article was still speaking in "expected outcomes"; no evaluation or expansion was ever published. Any C4-type
  proposal is gated on someone answering what actually happened.
- **Trust destroyed by misuse.** Henan, 2022: red health codes given to 1,317 bank depositors to stop them
  protesting; five officials disciplined. Shared data without access controls, purpose limits and audit logs
  kills the whole programme. Hangzhou's proposed permanent health score drew 86% public opposition — even in
  China.
- **Operator models drift.** Digital Guangdong — the celebrated government–enterprise JV — saw Tencent diluted
  from 49% to ~16.7% when a central SOE took 62.84% at a modest valuation. China itself is mid-restructure on
  the data-bureau/数据集团 model. We therefore do **not** sell "the settled Chinese operating model"; we
  propose the *principles* (state owns data and policy; one accountable operator; competitive term with exit
  clauses; fund operations, not just the build) and expect the Johor version to look different.

## 4. The four killers — and what the plan does about each

Both expert reviews converge here: Malaysian state IT programmes are killed by these four, not by technology.

| Killer | Reality | Conservative answer |
| --- | --- | --- |
| **Funding model** | Johor's entire 2026 state budget is ~RM2.546 bn. A serious data-lake programme is RM50–150 m build plus double-digit-millions annual ops — unaffordable from the state development budget alone. Nobody has asked who funds year 3. | No item with an operating cost proceeds without a named payer for years 2–5: RMK13 (2026–2030) federal money, a GLC vehicle (JCorp, KPRJ), or council subscriptions. Fund operations, not just the build |
| **Procurement route** | 16 PBTs procure independently; a state framework agreement needs legal opinion and KPKT's blessing; incumbents will fight it. E-perolehan routes and MOF registration are unaddressed in most strategies | Procurement route is designed *before* scope is promised. Bids now on the table are consulting-sized and need no framework agreement |
| **Accountable owner** | The lake "just started" — someone is already being paid to build it. That incumbent will bid for everything downstream; the longlist is implicitly a vendor strategy that never names the incumbent | Name the incumbent and the incumbent's systems in validation, before any bid. One named state owner (a small state data authority) over policy, catalogue and KPIs |
| **Electoral clock** | PRN Johor due by 2027. Every 18-month-plus item crosses into campaign season; the Menteri Besar's personal sponsorship is a single point of failure; the palace can elevate or orphan a project | Visible wins inside 12 months (A1/A4 are cheap and legible); codify via MMKN circular so the reform outlives its sponsor, as Zhejiang did |

**Johor's substitute for Beijing's mandates** — the reviews' best shared insight. China enforced compliance
top-down; Johor cannot. But Johor appoints council presidents and controls their grants: that leverage is the
functional Malaysian equivalent of Chinese cadre assessment, and it should be used **explicitly**, not left
implicit. Two further constraints the conservative plan respects: PBTs are federally regulated (KPKT), which
is both a risk and a route to federal co-funding; and federal bodies (JDN, MyDigital ID, MyGOV, KPKT's OSC)
already occupy much of China's stages 1–3 — a **federal-overlap map** (what Putrajaya provides vs. what Johor
must build) gates the entire shortlist, or the state will pay twice for the same plumbing.

**Security and audit.** A state lake aggregating identity, land and licence data is a national-grade
honeypot, under NACSA/CSM directives and a well-known national leak history, with the Auditor-General
watching. The trust layer (consent where it has meaning, access logs, purpose limits, a public transparency
report) is a **mandatory workstream inside every project**, not a standalone slide.

## 5. What makes this hard

1. **The legal hole is bigger than the DSA.** The Data Sharing Act 2025 covers federal bodies only. Worse:
   PDPA section 3(1) exempts **both** federal and state governments — no general personal-data statute binds
   Johor at all, so "consent-based" initiatives have no statutory meaning for state-held data. This single
   fact is why B1 (rescoped to directive, catalogue, pilot MoUs, PDPA-gap memo) is the critical path and why
   C3 is declined in its current form.
2. **Two-speed citizens.** Older and rural constituents rely on physical counters; closing them shuts out
   voters. Hybrid by design: assisted-digital counters file on the same digital workflow (A5, folded into
   A1/A4 delivery), so paper disappears behind the counter, not the counter itself.
3. **Talent.** Johor competes with data-centre operators and Singapore for engineers. Thin council IT teams
   should consume shared services, not build them — and district councils should never buy turnkey packages
   (the Guizhou lesson).
4. **The lake itself is unknown.** No public information on scope, owner, datasets or platform. It is the
   first validation question; conveniently, the bid-now items do not depend on the answer.

## 6. Where OrangePay fits — declared, and narrowed

The conservative posture is to shrink the declared interest, not broaden it:

- **B5 — shared payments (candidate, open tender).** The genuine gap is reconciliation across 16 councils and
  a single digital receipt per payment — cash at counters stays. OrangePay is interested and competent here,
  and says so plainly: **any advice we give on B5 must be followed by an open procurement in which we bid like
  anyone else**. A vendor that advises while pre-assigned the build becomes the next vendor-lock story.
- **C3 — SME credit-from-data: withdrawn.** Our first draft kept C3 as a later OrangePay opportunity. The
  reviewers are right that it does not survive contact with Malaysian reality: the credit-grade data is
  federal, BNM-regulated banks will not lend on state-attested licences alone, private bureaux (CTOS,
  Experian) already compete, and consent is legally empty while the state sits outside PDPA. At most, a
  narrow data-verification service might one day run under a BNM/SME Corp federal umbrella. OrangePay does not
  build its case on it.

## 7. The ask — a four-week validation sprint, then a gate decision

**Evidence to gather (one State Secretary's office meeting answers most of it):**

1. The data-lake contract: vendor, stack, owner, budget line, steering committee — name the incumbent.
2. Who can sign a state data-sharing directive (MMKN standing authority, state digital officer) and the
   relationship to KPKT and JDN.
3. Funding: state development budget vs. RMK13 grant vs. GLC vehicle — and whether any **operations budget
   exists for years 2–5**.
4. Incumbent PBT system vendors and any existing state framework agreement.
5. IMFC-J: is investor tracking manual? (Decides A3's scope.)
6. What happened to KL City Brain after 2018, and a Digital Johor Sdn Bhd post-mortem — the client's own
   failure cases, which will land harder than Chinese ones.
7. OSC 3.0 Plus Johor actual approval times.

**Gates the sprint must close before anything beyond the bid-now items proceeds:**

- **G1 — Federal-overlap map:** what JDN/MyDigital ID/KPKT already provide vs. what Johor must build.
- **G2 — Named payer for years 2–5** for every item with an operating cost.
- **G3 — KL City Brain answer**, before any city-operations conversation reopens.
- **G4 — B1 instrument confirmed** (MMKN directive route) and three pilot MoUs drafted.

**Proposed pilot:** A4 complaints analytics for three councils plus the A1 baseline at MBJB and MBIP — cheap,
legible, using data that already exists, no procurement drama, survivable across elections.

**Decision point:** build / park / drop, with costed next phases only for what survives G1–G4.

<div class="callout">

**Bottom line.** The case for *doing something* is strong: the window, the federal 21-day target, and the
state's own failed-vehicle history all argue for it. The case for *committing to a programme now* is not:
funding, procurement, ownership and the electoral clock are unanswered, and the legal basis for sharing state
data does not exist yet. The conservative play is three small bids, one institutional directive, one honest
tender conversation — and gates on everything else.

</div>

## Appendix — method, sources, confidence

- **Research basis.** Public web sources researched 17 October 2026: official Chinese government releases,
  China Daily, The Paper, Caixin, SCMP, Sixth Tone, Yicai; Malaysian press and official sources (Malay Mail,
  The Sun, The Edge, The Vibes, Astro Awani, Bernama, MIDA, KPKT, JDN); legal analyses (Allen & Gledhill,
  Hogan Lovells, Azmi & Associates, DFDL); World Bank; academic studies. Full source links live in the project
  knowledge base, `project/01 - Johor Digital Government Next Steps (China Benchmark)/`.
- **Stress-testing.** Two adversarial expert reviews — one briefed as a Malaysian government IT delivery
  expert (20+ years, e-perolehan/SUK Johor realities), one as a Chinese government IT delivery expert —
  reviewed the full package. Malaysian claims in the reviews were web-verified (DSA 2025 scope, PDPA s.3(1)
  exemption, 16 PBTs, KPKT funding); selected Chinese claims were verified against Chinese-language sources
  (Digital Guangdong shareholding, Beijing Data Group capitalisation, Shanghai Data Exchange volumes).
- **Corrections adopted in this document.** "Menteri Besar", not Chief Minister. Zhejiang "100% online"
  reframed as item coverage. Contested Suzhou lending figures and the muddled Beijing Data Group capital
  figures removed. Shanghai Data Exchange treated as a second slow-start case alongside Guiyang, not a
  counter-example. Digital Guangdong's Tencent stake dilution (49% → ~16.7%, 2021) cited as the cautionary
  operator lesson. The five-year operator term limit corrected to public-data authorised-operation practice,
  not platform-JV practice. Guizhou failure framed as one instance of a systemic vendor-receivables pattern.
  Beijing 12345's 97% resolution rate flagged as self-defined.
- **Confidence.** Chinese quantitative results are mostly government or vendor self-reporting (2017–2023),
  treated as directional throughout. Unverified reviewer judgement is labelled as professional opinion in the
  review documents themselves.
- **Open evidence gaps.** KL City Brain outcome; independent evaluation of any City Brain deployment;
  the Johor data lake's scope, owner and datasets; OSC 3.0 Plus Johor actuals.
