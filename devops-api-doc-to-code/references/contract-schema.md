# Contract Schema

Read this reference when normalizing a non-trivial or ambiguous API contract.

## Facts, Gaps, and Conflicts

- **Fact:** directly documented protocol or behavior that can drive implementation.
- **Gap:** required meaning the authority does not state.
- **Conflict:** current code, runtime evidence, and the authoritative document disagree.

Only facts become types, mappings, or UI rules. Report gaps as questions or caveats. Resolve conflicts against the selected authority and name any runtime evidence that justifies preserving current behavior.

## Normalized Record

```text
API:
  method:
  path:
  service/prefix ownership:
  replaces/shared semantics:
Request:
  body/query:
  fields and required flags:
  enums:
  units/bounds/index base/order:
  defaults/null/presence behavior:
Response:
  data shape:
  absent vs false/zero/empty/null:
  pagination/counts:
  added/removed/stale fields:
Errors and behavior:
  validation/business errors:
  idempotency/partial failure:
  backend-controlled actions/timing:
Examples:
  request:
  response:
Audit, when applicable:
  data provenance and freshness:
  shared builders/callers:
  affected layers:
  classification:
```

Use examples to confirm exact casing and nesting. Use the normative schema/table for types when an example conflicts with it, and record the conflict.

## Audit Classification

Finish with exactly one classification:

- `change required`: at least one documented fact is not implemented;
- `already compliant`: every compared surface matches and the Audit worktree is unchanged;
- `blocked by a named gap`: a missing contract fact prevents a safe conclusion or implementation.
