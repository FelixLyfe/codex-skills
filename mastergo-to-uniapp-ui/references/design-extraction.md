# Design Extraction

Read this reference when extracting a MasterGo layer or reconciling design sources.

## Authority Matrix

Assign one authority per surface instead of imposing one total order on every artifact:

| Surface | Candidate authority | Selected evidence | Conflict/gap |
|---|---|---|---|
| Geometry and typography | MasterGo layer, screenshot, design note | | |
| Copy | product/localization spec, design text map, current runtime | | |
| Assets | current manifest, design export, repository asset | | |
| Interaction and state | observed runtime, current business code, interaction note | | |
| Implementation shape | repository conventions | | |

The latest explicit user correction replaces the selected authority only for the surface it addresses. Record unresolved conflicts before editing.

## MasterGo Extraction

Follow the currently installed MasterGo integration instructions. When it exposes the section-based workflow:

1. Parse `fileId` and `layerId` from the supplied link.
2. Call `mcp__getDesignSections` once without `sectionIndex` for the overview.
3. Fetch every returned section index in bounded batches.
4. After all sections are available, call `mcp__getDesignSvgs` and `mcp__getDesignTexts` when those tools exist.
5. Use the returned text map and exported assets as evidence; record any section or asset the integration could not retrieve.

When the integration is unavailable, use supplied screenshots, local design notes/manifests, and current runtime evidence. Name the fallback and the claims it cannot establish.

## Extraction Checklist

Capture only surfaces relevant to the task:

- frame and viewport dimensions;
- root background, navigation, status-bar and safe-area assumptions;
- positions, dimensions, spacing, radii, separators, typography, and state colors;
- final rendered copy, including prefixes, suffixes, punctuation, and empty-value suppression;
- asset source and rendered dimensions;
- loading, empty, error, selected, disabled, and business states shown by the evidence;
- scrolling, sticky, drag, swipe, overflow, keyboard, and overlay behavior;
- hit targets and action ownership.

## Units and Assets

Derive the design-to-runtime scale from the target project's conventions. A `375px` frame converts with `px * 2 = rpx` only when the project uses a `750rpx` design basis. Keep values returned by runtime layout APIs in runtime pixels when used in JavaScript calculations.

Read the complete referenced asset manifest. Build a coverage list for the task surface and map every required asset to its current source; a changed filename or CDN path supersedes prior-turn memory.
