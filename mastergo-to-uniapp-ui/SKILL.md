---
name: mastergo-to-uniapp-ui
description: Implement MasterGo designs in UniApp mini-programs with visual and interaction parity. Use for page/component design-to-code work or runtime mismatch repair.
---

# MasterGo To UniApp UI

Turn design evidence into maintainable UniApp code. Treat design parity as a surface-by-surface contract: evidence owns the intended result, the current application owns business behavior, and the target repository owns implementation shape.

## Contract

Build an authority matrix before editing. The latest explicit user correction overrides the affected surface. Otherwise use the user-designated authority, or these defaults:

- geometry and typography: the referenced MasterGo layer or supplied screenshot;
- copy: the supplied product/localization specification;
- assets: the current manifest or design export;
- interactions and data behavior: observed runtime and current business code;
- implementation structure: current repository conventions.

When sources disagree without a designated authority, record the conflict and select the most current direct evidence for that surface. Preserve business logic, data contracts, display-versus-mutation ownership, generated-file ownership, and user-owned changes unless the contract explicitly changes them.

Keep three evidence levels separate:

- source: the edited Vue/TypeScript/styles and route metadata;
- generated: compiled route tables or WXML/WXSS/JS prove propagation;
- runtime: DevTools or real-device behavior proves rendering and interaction.

## Load Only Relevant References

- Read [references/design-extraction.md](references/design-extraction.md) when a MasterGo link/layer is supplied, design evidence conflicts, or exact copy/assets/measurements must be extracted.
- Read [references/layout-and-routing.md](references/layout-and-routing.md) for custom navigation, safe areas, sticky/scrolling regions, floating controls, shared component boundaries, new pages, or route failures.
- Read [references/selection-and-forms.md](references/selection-and-forms.md) for selectable items, custom entries, max-count rules, form state, or return-to-source behavior.
- Read [references/keyboard-and-overlays.md](references/keyboard-and-overlays.md) for popups, focus, keyboard containment, pickers, native overlays, or chained prompt sequencing.
- Read [references/validation.md](references/validation.md) before running project checks, generators, watch builds, generated-output inspection, or runtime acceptance.

## Steps

### 1. Establish the baseline

Read repository instructions and nearby design manifests. Inspect the worktree, route/page mechanism, reusable components, layout utilities, package-manager declaration, and validation scripts. Preserve unrelated changes.

When the page is runnable or screenshot evidence exists, capture the current screen at the target viewport and use that same viewport for the after comparison. Record unavailable baseline evidence explicitly.

**Complete when:** contract sources, target viewport, route mechanism, relevant project primitives, validation commands, and unrelated dirty files are known.

### 2. Extract the contract

Create the authority matrix, then capture frame geometry, colors, typography, final rendered copy, asset sources, visible states, interactions, overlay ownership, and responsive/safe-area behavior. Re-read a referenced manifest immediately before editing when the user says its links or notes changed, and account for every asset on the task surface.

For multi-state screens, record a state matrix covering the states the evidence or current behavior actually contains. Keep visual unit conversion separate from runtime pixel calculations.

**Complete when:** every visible region, state, interaction, and asset has an authoritative source or a named evidence gap.

### 3. Implement in the repository's shape

Write a compact implementation spec naming what changes, what remains stable, and how each affected state is represented. Reuse current components and composables when their ownership fits; add a shared abstraction only when it has more than one real consumer or isolates a platform invariant.

Implement the smallest owned diff. Register routes and page metadata through the repository's accepted mechanism. Keep shared behavior opt-in unless the contract establishes it as universal. For platform-dependent lifecycle or event behavior, implement the explicit state transition rather than relying on timing delays.

**Complete when:** every edited file maps to the contract, each affected state and action has an implementation path, route metadata is registered when applicable, and the diff contains no unrelated redesign or generated churn.

### 4. Verify the contract

Run the repository's narrow static checks, then the relevant mini-program build when routes, generated configuration, or runtime behavior changed. Inspect generated output only as propagation evidence. Exercise visual and interaction claims in DevTools or on a device when available, using the baseline viewport and every user-named mismatch.

Review generated-file drift and stop any watch process started for validation. Classify unperformed runtime checks as gaps with an exact handoff sequence.

**Complete when:** each changed surface has source evidence, applicable generated evidence, and either observed runtime evidence or a precise outstanding runtime check.
