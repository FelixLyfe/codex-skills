---
name: devops-api-doc-to-code
description: Extract, audit, or implement DevOps API contracts from authenticated documentation or supplied text. Use for contract normalization, code audits, or request-to-UI integration.
---

# DevOps API Doc To Code

Turn current API documentation into a contract-first result. The document supplies protocol facts, the repository supplies implementation shape, and the selected mode controls whether the work stops at documentation, remains read-only, or changes code.

## Select One Mode

Choose the lowest-mutation mode that satisfies the request and stay within it:

- **Extract:** normalize the document into a usable contract. Use for `整理接口文档`, schema extraction, or endpoint summaries. Stop after the contract and gaps are reported.
- **Audit:** compare the contract with current code and classify the integration as `change required`, `already compliant`, or `blocked by a named gap`. Keep the worktree unchanged.
- **Implement:** audit first, then make only the required integration changes and verify them.

When the requested outcome is ambiguous, infer the mode from the requested deliverable. A request to inspect or assess selects Audit; a request to connect, migrate, replace, or fix an API selects Implement.

## Contract Bar

- Treat the current authenticated document or supplied contract as authority for paths, fields, enums, required flags, nullability, units, ordering, examples, and documented behavior.
- Reduce evidence to `facts / gaps / conflicts`. Only facts become types, mappings, requests, or UI behavior.
- Keep undocumented counts, filters, idempotency, partial failures, defaults, and fallback semantics as named gaps.
- Follow the document when code conflicts with it unless the user designates another authority or current runtime evidence explicitly preserves existing behavior.
- Report documentation, code, build, and live-API evidence separately. Static success does not prove real API behavior.

## Load Only Relevant References

- Read [references/browser-extraction.md](references/browser-extraction.md) when the contract is inside an authenticated browser session, schema nodes are collapsed, or ordinary fetch cannot reach the page.
- Read [references/contract-schema.md](references/contract-schema.md) for a non-trivial contract, ambiguous presence/null semantics, shared endpoint remarks, or a multi-endpoint change.
- Read [references/integration-patterns.md](references/integration-patterns.md) for Audit or Implement work spanning dependency wiring, shared builders, batch calls, backend-controlled actions, presence-sensitive state, or freshness/race behavior.

## Steps

### 1. Acquire current evidence

Identify the selected mode and contract authority. Reuse an authenticated, already-open documentation tab when available; otherwise use supplied contract text or the best local evidence. Keep browser access read-only and request only the exact documentation origin when approval is needed.

Capture the repository baseline only for Audit or Implement mode. Preserve unrelated changes.

**Complete when:** the mode, authoritative contract source, revision/freshness evidence, and any access blocker are explicit.

### 2. Normalize the contract

Capture method, path, prefix/service ownership, request body or query, field types, required flags, enums, nullability and presence semantics, units/bounds/index bases, ordering, response shape, examples, remarks, errors, pagination/count behavior, idempotency, partial failures, and changed or removed fields.

Expand nested schema nodes before treating their children as absent. Verify shared-endpoint or action-specific behavior from remarks and API comments rather than inferring it from call sites.

Classify every relevant statement as a fact, gap, or conflict.

**Complete when:** every required contract surface is either a fact or a named gap, and no implementation decision depends on an unexpanded or guessed schema.

### 3. Finish Extract or trace Audit/Implement

In Extract mode, produce the normalized contract, examples needed for use, and named gaps, then stop.

In Audit or Implement mode, trace the affected chain from final request construction through transport, schema/model, domain/state, and presentation. Enumerate every caller of a changed shared builder. Record each field's provenance and freshness, and inspect environment or Mock gates when the runtime-selected endpoint matters.

For every affected layer, mark `compliant`, `change required`, `unaffected`, or `blocked`. A verified no-op is a complete Audit result.

**Complete when:** Extract has a usable contract with gaps, or Audit/Implement has accounted for every affected layer, caller, data source, and stale field/path.

### 4. Implement only in Implement mode

Match repository naming, prefix, error, dependency-injection, and state-management conventions. Model documented optionality and enums precisely, keep compatibility at transport/model boundaries, and propagate backend control fields into state and presentation.

Preserve explicit `false`, `0`, empty string, and `null` when the contract distinguishes them. Apply fallback only when the documented presence rule permits it. Keep display ownership separate from mutation ownership.

For batch replacements, preserve public caller contracts where required, normalize input once, issue the documented request shape, and update state once after the defined success result. For list/filter/count APIs, keep backend-owned filtering and counts authoritative. Guard rapid reloads or tab changes against stale responses.

**Complete when:** every `change required` item is implemented or explicitly blocked, every changed contract field reaches its final consumer, and the owned diff contains no unrelated behavior.

### 5. Verify and report by mode

- **Extract:** report the source, normalized contract, examples used, and gaps; no code validation is implied.
- **Audit:** report compared layers and classification; confirm whether the worktree remained unchanged.
- **Implement:** run repository-prescribed focused tests and static checks, then build or inspect runtime endpoint selection when the change affects generated/runtime behavior. Perform live API verification only when authorized credentials and safe test data are available.

Trace request-builder changes to the final HTTP wrapper in tests or observable runtime evidence. Report real API status explicitly as observed, not run, or blocked, with the first failing boundary.

**Complete when:** the final response names the mode, contract source, result, validation appropriate to that mode, live-API status, changed files if any, and every remaining gap.
