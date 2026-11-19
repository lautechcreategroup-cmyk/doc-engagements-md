# Mock fraud intelligence

Stand-in for the bank's fraud engine, national mule databases and payee-name services: mock interbank directory,
mule list, payee-name check, destination account age, customer baselines, scam typology warnings and a fraud-ops
case queue. Spec: [mock-banking-system.md §6](../../../mock-banking-system.md); how it is used:
[bank-agent-design.md §5](../../../bank-agent-design.md). Called by the policy engine for fixed rules on every
payment, and readable by the bank agent through the Banking MCP.
