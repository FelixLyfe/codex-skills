# Contract Integration Patterns

Read this reference for multi-layer Audit or Implement work.

## Integration Map

Trace the complete affected chain:

- final request builder and transport wrapper;
- request/response schema and domain/view models;
- dependency registration or service interface when the repository uses injection;
- domain/state action, mapper, pagination, cache, and request-race handling;
- presentation states, including loading, empty, error, refresh, and load-more.

Completion means every layer is compliant, changed, unaffected with a reason, or blocked by a named gap.

## Shared Builders and Batch Replacement

For a documented batch endpoint replacing repeated single-item calls:

1. add the exact request/response schema and transport call;
2. update dependency wiring used by the current architecture;
3. normalize and deduplicate input once, issue one request, and update local state once;
4. preserve the public action contract and single-item path while verified callers still require them;
5. test the batch caller and every shared builder or preserved endpoint family.

Apply documented filtering before ordering or indexing. Construct the final transmitted array with the required index base after invalid/filtered entries are removed.

## Backend-Controlled Actions

- Treat the response action collection as the membership source when the contract assigns it that role.
- Trace action identifier, placement, order, label ownership, disabled state/reason, and eligibility freshness.
- Diagnose a missing action from actual payload membership and state before adding status-derived UI rules.
- Fetch authoritative detail at the action boundary when a list contract does not carry fields required for mutation eligibility.
- Test absent, unknown, disabled, alternate placement, and ordering states that the contract supports.

## Presence, Amounts, and Freshness

- Preserve distinctions among field absence, `false`, `0`, empty string, and `null` when documented.
- Apply documented precedence before compatibility fallback; fallback activates only for the allowed presence state.
- Treat backend-calculated values as authoritative, including documented zeroes.
- Guard late responses with the current request, filter, or session identity so stale data cannot overwrite a newer state.
- Use backend-owned filtering, pagination, and counts rather than deriving global results from a partial local page.

## Verification

Use repository-prescribed commands and pinned tooling. Add focused tests for final request shape, presence semantics, every changed shared caller, server-controlled state, and response races.

When runtime endpoint selection or a Mock/Real gate changed, build the relevant target and inspect generated output or runtime evidence for the selected endpoint and environment branch. Static types alone do not prove the bundled path.

If the declared package manager cannot run without rewriting dependency state, use the repository's version manager or existing local binaries and report the tooling limitation separately.
