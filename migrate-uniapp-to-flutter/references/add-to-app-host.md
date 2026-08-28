# Add-to-App Host Integration

Read this reference when the target contains a Flutter module plus Android/iOS hosts, launches a Flutter route from native UI, or must replace a `uni.*`/mini-program capability.

## Inspect before extending

Find the existing engine owner, route launch code, channel registry, authentication/context provider, navigation bridge, analytics bridge, and lifecycle policy. Extend the established bridge when its ownership matches the page. Add one feature-scoped bridge when no suitable contract exists.

Keep the page boundary visible:

- route: page identity and the stable business identifier needed to address it;
- host context: tokens and refresh semantics, device identity/required headers, user/session context, environment, and backend-controlled launch data;
- host actions: analytics, cross-business navigation, subscription, external links, permissions, and other native effects.

Credentials stay out of route strings and ordinary page arguments. Reuse the target's auth refresh path rather than adding page-local token refresh.

## Debug experiments

Use a temporary auth or route bypass only to isolate a named boundary. Record the production baseline first, keep credentials out of source and captured logs, and confine fixed identifiers to an explicit debug entry.

Before a commit, push, or production handoff:

1. restore host token/context retrieval and empty global credential defaults;
2. remove temporary headers, disabled host calls, and production-reachable fixed identifiers;
3. inspect the owned diff for tokens, credentials, and bypass flags;
4. rerun the affected auth, network, route, and build checks.

A successful API call under a bypass is live-backend evidence for that request, not host-auth evidence.

## Engine and channel lifecycle

For a host-created engine, use this default order:

1. create or obtain the intended engine;
2. call `run()` with the intended entrypoint/initial route;
3. create and register channels on that engine's messenger;
4. present the Flutter view/controller/activity using the same engine;
5. detach or reuse handlers according to the host's existing lifecycle.

This order prevents the observed class of startup crash caused by registering a channel against an engine that has not started. If the target already has a proven centralized engine/channel registry with a different lifecycle, preserve it and verify the actual native entry instead of duplicating registration.

Registration must be idempotent for repeated page opens or cached engines. Verify that result callbacks complete exactly once and on the expected thread.

## Contract ledger

Record both Dart and native definitions:

| Method | Direction | Required payload | Success result | Typed failures | Native owner | Flutter caller |
|---|---|---|---|---|---|---|
| Launch context | host -> Flutter | | | missing/expired context | | |
| Access token/refresh | host -> Flutter | | | expired/unavailable | | |
| Device identity/required headers | host -> Flutter | | | missing/invalid | | |
| Analytics/business event | Flutter -> host | | | rejected/unavailable | | |
| Cross-business navigation | Flutter -> host | | | unsupported/invalid target | | |
| Subscription/platform action | Flutter -> host | | | unsupported/denied | | |
| External link | Flutter -> host | | | invalid/unavailable | | |

Use explicit `unsupported` or typed errors when a WeChat/UniApp capability has no equivalent. A synthetic success corrupts the Flutter state machine and acceptance evidence.

## Native acceptance path

Build the host, then validate through the actual native entry:

- open the page with a valid and missing identifier;
- confirm the intended engine and route receive the request;
- exercise loading, error/retry, critical business actions, and cross-business navigation;
- verify back/close behavior and repeated open/close cycles;
- verify safe areas, keyboard, scroll/fixed controls, and tappable geometry on the selected simulator/device;
- exercise missing/expired context and token refresh when the environment allows;
- verify contract-defined auth-expiry retry and required device headers with non-secret request evidence;
- confirm unsupported platform behavior is visible and truthful.

A standalone `flutter run`, widget test, or successful module build does not prove this path. Record host/device model, OS, build mode, data mode, route input, and observed result.

When native implementation is owned elsewhere, leave a feature-specific integration record containing the route, context method, bridge contract, code examples only where useful, and the exact host acceptance steps. Report the host level as pending until observed.
