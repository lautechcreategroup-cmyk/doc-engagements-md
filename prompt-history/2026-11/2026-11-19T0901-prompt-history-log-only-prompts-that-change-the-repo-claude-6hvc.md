## 2026-11-19 09:01 +0800 — Prompt history: log only prompts that change the repo (CLAUDE.md, README.md, prompt-history/add.sh)

**Prompt:** Update the prompt history such that the agent should only add an entry if there are any changes to the source. If the prompt is just an enquiry, it can ignore the prompt and not add to the history.

**Summary:** CLAUDE.md (= AGENTS.md / AGENT.md) Prompt history section now says to log a prompt only if it changed the repo (file created, edited, moved or deleted, or a commit/push). Questions, retrieval, reviews and discarded drafts get no entry, and the history entry itself doesn't count as a change. Matching wording in the README.md index line for prompt history and in the prompt-history/add.sh header comment. Done on branch project-02-poc (from origin/main). Not committed.
