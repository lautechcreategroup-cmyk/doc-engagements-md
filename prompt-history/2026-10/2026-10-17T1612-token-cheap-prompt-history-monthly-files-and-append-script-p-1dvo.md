## 2026-10-17 16:12 +0800 — Token-cheap prompt history: monthly files and append script (prompt-history/, CLAUDE.md)

**Prompt:** yes plase...make it so that the adding the prompt history will consume the least amount of tokens now and
even in the future. Can send this to the same branch for now.

**Summary:** Moved `prompt-history.md` to `prompt-history/2026-10.md` (one file per month, so no file grows without
limit). Added `prompt-history/add.sh "<title>"`, which reads the body from a quoted heredoc and appends the
separator, timestamp, heading and body to the current month's file, creating it if needed. It never reads the
file. Rewrote the "Prompt history" section of `CLAUDE.md`:
- the entry template is inline, so no agent needs to open a history file to copy the format;
- agents must use the script, and not an editor tool, which reads the whole file;
- a no-shell fallback, and grep/tail for lookups.

Updated the `README.md` index entry. Pushed to `project-01-expert-reviews` (PR #1).
