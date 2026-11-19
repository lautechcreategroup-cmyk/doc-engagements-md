# Open banking MCP (Mode 1, deliberately unsafe)

The comparison baseline: broad tools straight over the mock services, full account numbers, a `transfer` that
executes, a static API key and no consent. Spec: [mcp-tool-catalogue.md §3b](../../mcp-tool-catalogue.md). Runs only
in the `open` compose profile, never by default, and is labelled unsafe in the console and logs. Never reuse its
code in the governed modes.
