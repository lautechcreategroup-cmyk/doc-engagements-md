## 2026-10-17 16:15 +0800 — Roll out token-cheap prompt history to portal-process-designer-node-v3 and doc-engineering-v1

**Prompt:** now look at https://github.com/orangepayorg/portal-process-designer-node-v3 and add the prompt history
into the agent, and using the same scheme where it adds it using the cheapest method and then raise a PR for this
change. (Follow-up mid-task: "do the same for https://github.com/orangepayorg/doc-engineering-v1 as well".)

**Summary:** Applied this repo's scheme (monthly `prompt-history/YYYY-MM.md`, the `prompt-history/add.sh` appender,
and an inline template with a never-read rule) to both repos, each on an `add-prompt-history` branch, and logged the
first entry with the script:
- **portal-process-designer-node-v3:** section added to `AGENTS.md` (`CLAUDE.md` links to it):
  https://github.com/orangepayorg/portal-process-designer-node-v3/pull/66
- **doc-engineering-v1:** section added to `CLAUDE.md` (`AGENT.md` links to it), plus `README.md` index section 11:
  https://github.com/orangepayorg/doc-engineering-v1/pull/36
