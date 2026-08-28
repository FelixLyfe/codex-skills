# Parity Ledger

Use this as working state, not as a mandatory repository artifact.

- Full migration uses every relevant section for the complete page dependency closure.
- Parity repair records only affected rows and the dependency closure needed to verify them.
- Contract-drift audit records only disputed contract surfaces, consumers, and attribution evidence.

Persist only unresolved cross-owner/session items in a feature-scoped tracker.

Allowed row states:

- `mapped`: target owner is known;
- `implemented`: code exists but runtime evidence is pending;
- `verified-mock`: observed through Mock data;
- `verified-host`: observed through the applicable app/native entry;
- `verified-live`: observed through the real authenticated contract;
- `pending-external`: blocked on host, credentials, backend state, or another named dependency;
- `excluded`: outside the agreed page boundary, with the preserving interface named.

Every mode-scoped row needs one state before final reporting.

## Entry and Environment

| Item | Source | Target | Evidence/state |
|---|---|---|---|
| Project, page, and selected revision | | | |
| Bootstrap/build status | | | |
| Registered route and business identifier | | | |
| Additional launch context | | | |
| Current API/host contract and authority | | | |
| SDK/version manager and topology | | | |
| Applicable app/native entry | | | |
| Source runtime/design evidence | | | |
| Target validation commands | | | |
| Baseline worktree and owned paths | | | |

## Source Dependency Closure

Create rows for transitive dependencies that change in-scope behavior.

| Area | Source symbol/file | Observable behavior | Target owner | State/evidence |
|---|---|---|---|---|
| Child component | | | | |
| Store/composable | | | | |
| API, polling, or pagination | | | | |
| Response-control field | | | | |
| Type/model or transformation | | | | |
| Utility/constant | | | | |
| Asset/font/icon | | | | |
| Route/navigation | | | | |
| Storage/permission/platform capability | | | | |

Follow lifecycle hooks, event handlers, computed/watch effects, dialogs, validation, refresh, retry, and error branches; imports are only the starting point.

## State and Action Parity

| Trigger | Preconditions | State transition | Service/host effect | Visible result | Error/alternate result | State/evidence |
|---|---|---|---|---|---|---|
| Page launch | | | | | | |
| Retry/refresh | | | | | | |
| Primary action | | | | | | |
| Dialog confirm/cancel | | | | | | |
| Form/validation | | | | | | |
| Cross-business navigation | | | | | | |
| Back/close | | | | | | |

Include in-scope loading, content, empty, error, disabled, selected, mutation-in-flight, success, and business statuses. Record contract-controlled visibility, labels, timing, cursors, terminal states, and deduplication.

## API and Data Contract

| Operation | Authority/revision | URL/path/method | Request fields | Response/control semantics | Auth/retry | Flutter owner | Evidence |
|---|---|---|---|---|---|---|---|
| Initial data | | | | | | | |
| Supporting data | | | | | | | |
| Mutation | | | | | | | |

Trace each operation from caller to transport. Compare names, types, optionality, defaults, nesting, business errors, timing values, and conversions.

Give every in-scope page-owned current-contract field a disposition:

| Field/control | Source consumer | Current meaning | Flutter disposition | Test/evidence |
|---|---|---|---|---|
| Content value | | | consumed / preserved / intentionally ignored | |
| Action visibility/disabled state | | | | |
| Offline/terminal state | | | | |
| Poll/retry interval | | | | |
| Cursor/page/next token | | | | |
| Navigation/host directive | | | | |

An intentionally ignored field needs a reason and downstream owner when applicable. Parsing alone is incomplete until the field's control effect reaches state and UI.

## UI Parity

| Region/state | Structure | Visual contract | Layout behavior | Interaction/hit target | Asset | Evidence |
|---|---|---|---|---|---|---|
| Navigation/header | | | | | | |
| Content sections | | | | | | |
| Bottom/fixed controls | | | | | | |
| Dialog/sheet/toast | | | | | | |
| Loading/empty/error | | | | | | |
| Long text/keyboard | | | | | | |

Use source runtime, screenshots, or design nodes as visual evidence. Mark code-derived measurements until runtime comparison exists.

## Closure Questions

- Does every in-scope visible state have a renderer and transition path?
- Does every in-scope action preserve validation, service, navigation, dialog, and error behavior?
- Does every current contract field have a disposition and do backend controls reach behavior?
- Were source/contract conflicts resolved against the selected authority?
- Are cross-business effects contained behind a route or host contract?
- When Mock is in scope, do Mock and Real share models, state transitions, and widgets?
- Are platform substitutions explicit rather than reported as success?
- Does the diff stay inside the selected dependency closure?
- Are code, build, host, and live evidence reported separately?

## Open Acceptance Handoff

Use this table only when work must continue after delivery.

| Priority | Unresolved behavior | Current evidence | Owner/dependency | Exact acceptance action | Status |
|---|---|---|---|---|---|
| | | code / build / host / live | | | open / blocked |
