# Transaction authorisation service (TAS)

Owns every write: Drafted → Reserved → Approved → Committed → Submitted → Executed / OutcomeUnknown → resolved.
Canonical payloads, device-key signature verification, commit-time revalidation, reservations against shared
limits and mandate envelopes, durable obligations, reconciliation. Blueprint [3.4 and 4.5](../../../../solution-blueprint.md).
