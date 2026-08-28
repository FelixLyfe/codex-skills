---
name: migrate-uniapp-to-flutter
description: Migrate or repair UniApp/Vue pages in Flutter with behavior parity. Use for full page migrations, scoped parity repairs, or source/API/host contract-drift audits.
---

# Migrate UniApp to Flutter

Treat the work as a **parity migration**: the selected UniApp runtime/code defines product behavior, the current authoritative API and host contracts define external protocol, and the target Flutter repository defines implementation shape. The boundary is the selected page plus the dependency closure required to preserve its behavior.

## Select One Mode

- **Full migration:** move a page and its required dependency closure into Flutter; maintain a complete parity ledger.
- **Parity repair:** correct an existing Flutter migration; trace and update only the affected behavior and dependency closure.
- **Contract-drift audit:** compare source, current API/host contract, and Flutter to determine the target behavior and likely origin of a mismatch; keep the worktree unchanged unless the user also requests a repair.

A request to fix an audited mismatch selects Parity repair. Stay inside the selected page boundary; represent cross-business navigation through an existing route or minimal host interface.

## Evidence Levels

Report each level independently:

- **code:** formatting, analysis, and tests;
- **build:** the relevant Flutter app/module or native host compiled;
- **host:** the page was opened and exercised through the actual app/native entry;
- **live:** authenticated APIs and backend-controlled behavior were observed.

Passing one level does not imply the next.

## Load Only Relevant References

- Read [references/parity-ledger.md](references/parity-ledger.md) after selecting the mode; use the full ledger for Full migration and only affected sections for Parity repair or Contract-drift audit.
- Read [references/contract-reconciliation.md](references/contract-reconciliation.md) when source, current contract, and Flutter disagree or origin attribution is requested.
- Read [references/mock-and-validation.md](references/mock-and-validation.md) when adding/changing Mock support, planning deterministic runtime scenarios, or recording the validation ladder.
- Read [references/add-to-app-host.md](references/add-to-app-host.md) when the target is Add-to-App, launches Flutter from native UI, or replaces a mini-program capability with a host contract.

## Steps

### 1. Establish ground truth

Read the request, repository instructions, selected source page, and target repository. Record:

- source revision, route, required launch input, runnable behavior, and bootstrap blockers;
- target topology, pinned toolchain, current entry, applicable hosts, and validation commands;
- selected API/host authority and supplied visual evidence;
- baseline worktree, task-owned paths, page boundary, and available evidence levels.

Use observed source behavior when available. Label code-derived conclusions when source runtime is blocked, and name the prerequisite when runtime comparison is required.

**Complete when:** route input, source/target revisions and entries, contract authority, owned paths, scope, and evidence are recorded without treating an unknown as verified.

### 2. Close the mode-scoped dependency graph

Trace behavior reached through child components, lifecycle hooks, stores/composables, APIs, types, utilities, assets, navigation, storage, permissions, dialogs, polling, pagination, refresh, validation, retry, errors, and platform capabilities. Include response fields that control visibility, enabled state, labels, timing, pagination, retry, or navigation.

- Full migration accounts for the complete page dependency closure and every ledger section.
- Parity repair accounts for the affected rows, their callers/consumers, and the smallest closure needed to prevent regressions.
- Contract-drift audit traces only the disputed contract surfaces and their behavioral consumers.

Map each in-scope dependency to current Flutter routes, state/model/repository boundaries, networking/authentication, dependency injection, theme/widgets, assets, persistence, platform bridge, and tests.

**Complete when:** every in-scope state, action, transformation, external effect, platform capability, and page-owned contract field has a target disposition or labeled gap.

### 3. Audit or implement the target-native slice

In Contract-drift audit mode, complete the three-way trace, select the current authority, classify the origin with available evidence, report findings, and stop without editing.

For Full migration or Parity repair:

1. register or preserve the route and parse only stable launch input;
2. model current-contract fields, nullability, enums/statuses, and response-control semantics;
3. connect the authoritative endpoint through existing transport, auth, retry, repository, and injection boundaries;
4. implement the affected state machine, errors, actions, dialogs, validation, navigation, and platform effects;
5. build the UI with current theme/widgets and only required source assets;
6. keep compatibility logic at transport/model boundaries and platform substitutions behind typed host interfaces.

Re-express source behavior in Flutter patterns rather than translating line by line. Add a page-local seam only when the target lacks an appropriate abstraction.

**Complete when:** the production repository/data-source path follows the selected authority, every in-scope ledger row and contract field has a disposition, reconciled mismatches have focused tests, and the owned diff contains no speculative infrastructure.

### 4. Add Mock acceptance only when it earns the branch

Add or change Mock support when at least one condition applies:

- the user requests offline or reproducible acceptance;
- source/live runtime is unavailable and deterministic UI/state evidence is needed;
- the target already has a Mock/Real seam that should cover the migrated feature;
- backend-controlled states or timing need deterministic regression coverage.

Place Mock and Real behind the same repository/data-source contract so they share models, state transitions, controllers, widgets, and typed failures. Production defaults to Real and cannot silently select Mock. Leave Mock wiring unchanged when none of the branch conditions apply.

**Complete when applicable:** mode/scenario selection is centralized, documented scenarios cover the required behavior, production fails closed against Mock, and one copyable command opens the intended scenario.

### 5. Integrate the applicable app or host entry

For Add-to-App or platform-dependent behavior, keep route arguments focused on page identity and stable business identifiers. Obtain credentials, device/session context, analytics, cross-business navigation, subscriptions, external links, permissions, and other native effects through existing host contracts or one feature-scoped bridge.

Define matching method, payload, result, and typed-error semantics on Dart and native sides. Unsupported platform capabilities return an explicit unsupported result.

**Complete when applicable:** Dart/native contracts and lifecycle match, the actual host entry can supply the page context, and unsupported behavior is truthful; otherwise report the exact pending host acceptance action.

### 6. Prove behavior in applicable layers

Use the repository's pinned toolchain and prescribed format, analysis, focused tests, relevant regression tests, build, and diff checks. Cover field parsing/disposition, statuses, requests, server controls, errors, transitions, timing/retry/pagination, key widget states, and host serialization where applicable.

Exercise the page through the applicable standalone app or native host entry. Compare against observed source runtime or supplied visual evidence. Run deterministic Mock scenarios only when that branch is in scope, and live APIs only when credentials, backend state, authorization, and safe test data are available.

Treat temporary tokens, fixed identifiers, disabled host calls, and hardcoded headers as experiments. Before commit, push, or production handoff, restore the production path, confine retained fixtures to explicit debug wiring, scan the owned diff for credentials, and rerun affected checks.

**Complete when:** every attempted command and runtime path has a result; app/host entry, device, build mode, data mode, and route input are named; skipped or blocked levels have reasons; and code, environment, host, and backend failures are classified separately.

### 7. Close the scoped ledger

Re-read the selected source and current contract, then audit every mode-scoped ledger row against the final result. Repair in-scope gaps before reporting them. Persist only unresolved cross-owner/session acceptance items, each with owner, evidence level, expected behavior, and exact acceptance action.

Report completed behavior, key files, reused target capabilities, validation and observed runtime path, known source/Flutter differences, requested drift attribution, and pending items. Include Mock commands only when Mock was in scope.

**Complete when:** no scoped ledger row is silently open and every completion claim is supported by its stated evidence level.
