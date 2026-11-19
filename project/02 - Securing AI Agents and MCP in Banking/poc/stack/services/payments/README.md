# Mock payments

Payees (with cooling-off), billers, intrabank / mock DuitNow / mock IBG rails, payment orders, bulk batches,
standing instructions, reconciliation evidence. Spec: [mock-banking-system.md §4](../../../mock-banking-system.md).
Accepts payment submissions **from TAS only**, idempotent on `draft_id`. Fault injection for the lost-response
scene (X7).
