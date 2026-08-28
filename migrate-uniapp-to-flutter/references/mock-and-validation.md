# Mock and Validation

Read this reference when adding/changing Mock support, designing deterministic scenarios, or recording layered acceptance.

## Mock Boundary

Place mode selection at the repository/data-source injection boundary using the repository's existing flavor, environment, or dependency-injection mechanism. When none exists and Mock is justified, use feature-scoped compile-time settings such as:

- `<FEATURE>_USE_MOCK` for Real versus Mock;
- `<FEATURE>_MOCK_SCENARIO` for scenario selection.

Formal production builds default to Real and fail closed if Mock is selected. A demo may default to Mock only when offline acceptance is its declared purpose and an explicit Real command remains available.

The switch selects an implementation, not a second page. Both implementations return the same domain models and typed failures to the same controller/state and widgets.

## Scenario Matrix

Use the smallest set that covers materially different in-scope behavior:

| Scenario | Data-source behavior | State/UI exercised |
|---|---|---|
| normal | representative complete response | primary content and actions |
| empty | valid empty/absent business data | empty or fallback rendering |
| loading | deterministic delayed completion | loading and interaction gating |
| error | typed network/business failure | error copy, retry, retained state |
| long-content | long labels, descriptions, or lists | wrapping, scroll, overflow, fixed controls |
| business states | one fixture per distinct transition | action-specific behavior |
| server-control | varying flags, timing, cursors, or directives | visibility, disabled/offline state, polling/retry, pagination |

Mock mutations update subsequent reads and visible state consistently. Seed deterministic data and reproduce the Real contract's transitions and typed errors.

Document copyable commands for the exact target, adapted to its version manager and entrypoint:

```bash
flutter run --dart-define=<FEATURE>_USE_MOCK=true --dart-define=<FEATURE>_MOCK_SCENARIO=normal
flutter run --dart-define=<FEATURE>_USE_MOCK=false
```

For Add-to-App, state both the module build command and the native host launch procedure.

## Validation Ladder

Record each rung as `PASS`, `FAIL`, `SKIP`, or `BLOCKED`, with its command/path and evidence:

- `SKIP`: the rung is not applicable or was not available in this run; state why and never count it as passing.
- `BLOCKED`: the rung applies but a named dependency prevents execution.

| Rung | Applies when | Minimum evidence |
|---|---|---|
| Format | source changed | repository formatter completed without unintended churn |
| Static analysis | source changed | analyzer completed with no introduced issue |
| Unit/widget | behavior or contract changed | fields, statuses, requests, controls, errors, transitions, key states |
| Flutter build | app/module is buildable in scope | relevant target compiled |
| Native host build | Add-to-App host is in scope | Android/iOS host target compiled |
| Mock runtime | Mock branch is in scope | named scenario and critical interactions observed |
| App/host runtime | runtime acceptance is in scope | actual app/native entry path observed |
| Live runtime | live acceptance is authorized and available | authenticated contract behavior observed |

Use repository-prescribed commands and pinned tooling. Common Flutter checks are illustrative only:

```bash
dart format .
flutter analyze
flutter test
git diff --check
```

## Runtime Record

For each applicable critical path, record:

- simulator/device and OS;
- app/host target and build mode;
- Mock/Real mode and scenario when applicable;
- route and launch input;
- actions performed and visible result;
- screenshot or non-secret log when it materially proves the claim;
- unresolved difference and next exact action.

Exercise only the states and effects inside the selected mode's scope. When initialization triggers overlays, delayed work, polling, or animation, ensure Overlay/Navigator/context is ready; tests settle or cancel timers, animations, subscriptions, and pollers before teardown.

Classify failure at its first boundary: code, toolchain/cache permission, app/host contract, credentials, network, or backend state. A hot reload or Mock run remains evidence for that path only.
