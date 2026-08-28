# Layout and Routing

Read this reference for platform layout, shared component boundaries, new pages, or route failures.

## Repository Shape

- Find repository instructions, route helpers, page generators, accepted page directory shape, layout utilities, and existing components before adding structure.
- Treat generated route tables and typings as build outputs unless the repository explicitly owns them as source.
- Prefer project route keys/helpers over bare navigation strings when available.
- Preserve unrelated worktree edits and generated files outside the task-owned route change.

## Mini-Program Layout

- Reserve the WeChat native capsule area through the project's navigation component or current capsule metrics.
- Derive custom-navigation and sticky offsets from status-bar/layout utilities. Keep runtime pixel math separate from visual rpx sizing.
- Give overflowing tab rows stable item geometry and implement click-to-center when the contract shows it.
- Clamp draggable controls to safe-area bounds in runtime pixels and snap them after touch end.
- Verify parent dimensions for absolutely positioned controls and confirm their rendered hit targets.
- Emit explicit component events from the rendered element when native event passthrough is not reliable.

## Component Boundary

- Page: route params, data loading, authorization gates, operation dispatch, refresh, and pagination.
- Visual component: reusable layout and presentation with explicit events and opt-in behavior.
- Composable: genuinely repeated stateful interaction such as pagination, drag math, or request-race protection.

Add a shared component only when multiple real consumers need it or it isolates a platform invariant. Keep page-specific layout local.

## New Page Gate

Before claiming a new page works:

1. Register its route through the repository's source configuration.
2. Add the accepted page metadata, including navigation and authentication conventions when applicable.
3. Run the repository's generator or mini-program build.
4. Verify the exact base path exists in the generated page table, route typings, or compiled page configuration.
5. Exercise navigation in DevTools or record that runtime routing remains unverified.

Type checking alone does not prove page registration.

## Common Runtime Boundaries

- Rounded dashed outlines may require `border` rather than `outline`.
- Clickable controls nested in clickable cards need propagation ownership.
- Scrollbar and enhanced-scroll props require compiled WXML and runtime verification.
- Native SVG/image rendering, tabbar lifecycle, share controls, flicker, and touch hot zones are runtime claims.
- Visible copy assembly includes formatter output plus prefixes, suffixes, punctuation, and empty-state suppression.
