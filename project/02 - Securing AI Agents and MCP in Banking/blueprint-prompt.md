# Blueprint Generation Prompt

The prompt the user gave Gemini to produce the solution blueprint, saved word for word for reuse. The blueprint
we wrote from this structure is [solution-blueprint.md](solution-blueprint.md). See the
[project tracker](README.md).

---

```
You are a Principal Enterprise Security Architect and Systems Engineer specializing in Fintech and Secure AI Infrastructure. Your task is to write a formal, comprehensive **Enterprise Architecture Blueprint Document** for a Tier-1 financial institution.

The document must outline a secure, defense-in-depth architecture for integrating Model Context Protocol (MCP) servers and LLM-driven agentic workflows into core banking systems.

Please structure the blueprint using professional engineering documentation standards (IEEE/TOGAF style), incorporating clear headings, technical detail, security considerations, and architectural workflows.

---

# DOCUMENT TITLE: Secure Agentic AI & MCP Integration Blueprint (v1.0)
## Target Audience: Chief Information Security Officer (CISO), Head of Enterprise Architecture, and Regulatory Compliance Officers.

---

### 1. Executive Summary & Objective
- Define the strategic vision of agentic banking vs. the inherent risk profile of Model Context Protocol (MCP).
- State the core architectural goal: Enabling agentic efficiency while maintaining strict zero-trust data boundaries, regulatory compliance (e.g., GDPR, PDPA, MAS/BNM guidelines), and deterministic control over state changes.

### 2. Threat Modeling & Attack Surface Analysis
Detail the specific security vectors unique to LLM and MCP integration in banking:
- **Excessive Agency & Scope Bleed:** How probabilistic reasoning leads to unintended cross-account or corporate data access.
- **Indirect Prompt Injection:** Vectors via untrusted external inputs (PDF statements, invoices, merchant URLs) weaponizing tool execution.
- **Data Exfiltration via Context Pollution:** Risks of raw PII and transactional behavior profiles landing in LLM context windows or vector databases (RAG).

### 3. Core Architectural Patterns & Defense-in-Depth
Define the technical mechanics of the proposed multi-layered security framework:

#### Pattern A: Input/Context Scanning & Semantic Firewalls (The Perimeter)
- Real-time sanitization of prompts and structured inputs.
- Stripping hidden system-prompt manipulation (zero-font text, markdown injection) before payloads hit LLM context boundaries.

#### Pattern B: Blind-Token Execution / Zero-Knowledge Data Handling (Data Minimization)
- Explain the cryptographic tokenization scheme where raw transactions/PII are never exposed to the agent.
- Workflow: Agent requests query -> Bank core returns a blind reference token -> Token is passed back to the native bank app -> User decrypts and views data behind traditional MFA boundaries.

#### Pattern C: Dual-Agent / Delegated Enterprise Architecture (Air-Gapped Trust Boundary)
- **Client Agent (Semi-trusted/External):** Handles natural language user interaction and intent formatting.
- **Bank's Enterprise Agent (Trusted/Sandboxed):** Resides inside the bank's secure perimeter, executes data access and analysis locally within a strict sandbox, and returns only synthesized, non-sensitive insights back to the client agent.

#### Pattern D: Cryptographic Human-in-the-Loop (HITL) for State Changes
- Strict separation between read operations and state-changing operations (money movement, beneficiary updates).
- Mandatory out-of-band cryptographic approval challenges executed via native banking apps, bypassing AI context entirely.

### 4. Implementation Protocol & API Governance
- OAuth 2.1 Enforcement with cryptographic session binding.
- Tool-specific least privilege (hyper-specific tools like `get_account_balance` instead of generic database access).
- Deterministic policy enforcement gateways intercepting every MCP tool call to cross-reference hardcoded business logic limits.

### 5. Compliance, Auditability & Immutable Logging
- Append-only audit trails mapping every tool call, payload, and user intent.
- Behavioral anomaly detection to automatically sever compromised sessions.
```
