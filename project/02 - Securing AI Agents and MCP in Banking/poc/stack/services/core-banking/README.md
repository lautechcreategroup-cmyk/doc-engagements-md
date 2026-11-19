# Mock core banking

Accounts, ledger, balances, holds and limits. Spec: [mock-banking-system.md §2](../../../mock-banking-system.md).
Only the payments service may post entries. Posting is idempotent on `posting_ref`; available = ledger − holds;
frozen accounts accept no debits. Includes `/admin/faults`.
