---
name: simplify-agent-context
description: Audit and simplify agent instructions and installed skills without losing constraints. Use for context-load reduction or model-upgrade reviews; not general prose shortening. Inventory is read-only until the change ledger is approved.
---

# Simplify Agent Context

Reduce instruction load while preserving the decisions and constraints that change agent behavior. Place content at the right loading level before shortening it.

## Modes and Approval

- **Audit:** inventory the requested project instructions, global rules, and installed skills; propose a change ledger. Make no file changes, including saved reports, before approval unless the user explicitly requests a report file.
- **Apply:** execute an approved ledger, then verify meaning and loading. Reuse existing approval for the same entries; present newly discovered deletions or material scope changes separately.

Default to Audit when no ledger has been approved. A request to simplify context does not itself authorize removing installed skills or editing all global configuration. Stay within the named project, tools, and skill locations.

## Preserve These Meanings

Do not discard the following as obvious, verbose, unused, or duplicated:

- user preferences, rejected approaches and their reasons, and machine-specific facts;
- silent failure modes and surprising behavior that is actually normal;
- restrictive clauses such as "never writes" or "does not upload," including clauses embedded in descriptions;
- rules for data deletion, spending, publishing, privilege escalation, and rewriting pushed history;
- dated decisions and their historical context.

When relocating irreversible-action rules, move the entire block verbatim. Preserve conditions, exceptions, negation, and order in every other protected rule. Keep historical decisions identifiable as history; a later correction does not erase the earlier record.

## Load Only Relevant References

- Read [references/inventory-and-routing.md](references/inventory-and-routing.md) during inventory and destination selection, especially when several agent tools or conditional rules share the project.
- Read [references/verification.md](references/verification.md) before applying a ledger. It defines removed-line accounting, independent review, and fresh-session loading checks.

## Steps

### 1. Inventory the actual context sources

Identify the active agent tools and requested roots. Capture the current file contents, existing changes, and loading entry points without modifying files. Inspect likely always-loaded sources first: root instructions, global rules, unconditional rule files, and discovered skill descriptions. Then inspect conditional rules, skill bodies, and references.

Measure each source with a stated unit and separate always-loaded content from conditional content. Count mixed-language text in characters; report tokens only with a named tokenizer or a clearly labeled estimate. Loading behavior is tool-specific: distinguish observed behavior from an unverified assumption.

Use actual invocation records, if available and authorized, to assess skill use. Record the observation period and coverage. Name searches establish references, not usage; absent or incomplete telemetry means usage is unknown.

**Complete when:** the scoped sources, sizes, load conditions, evidence, and coverage gaps are listed, including always-loaded descriptions separately from skill bodies.

### 2. Propose a change ledger

Give each relevant passage a stable ID and one disposition: **fix / delete / move / rewrite / keep** (`修 / 删 / 挪 / 改写 / 保留`). Include its source location, proposed content or exact destination, loading route, and a one-sentence reason.

Judge sentences by their effect on behavior. Generic reminders may be deletion candidates; uncertain value is a reason to keep and investigate. Prefer outcomes, completion criteria, and required evidence over a prescribed route when another route would satisfy the same contract. Preserve ordering when the sequence itself matters, such as validation before publication or authorization before deletion.

Consolidate true repetition into a familiar term only if the term retains the same meaning. For a subjective writing preference, a short NO / OK pair can clarify the target better than a slogan. Keep distinct requirements explicit; a word such as "tight" alone does not preserve measurable cost or timing limits.

**Complete when:** every proposed change has a reviewable entry, every move has a reachable destination, protected content is accounted for, and the user has the ledger to approve. In Audit mode, stop here with files unchanged.

### 3. Apply approved moves, then simplify

Preserve the pre-edit baseline independently of unrelated user changes. Move approved blocks intact and establish their loading pointers first; shorten or rewrite only as a separate approved operation. If a passage needs both, link the move and rewrite entries so their effects can be distinguished.

Choose destinations by scope and invocation: judgment in skills, deterministic enforcement in a script or hook when supported, project operations in project guidance, and genuinely cross-project constraints in global rules. Preserve immediate access to rules needed at arbitrary conversational moments.

Keep skill descriptions focused on capability, triggering conditions, and meaningful exclusions. Put extra examples in the body and branch-specific detail in references. Use only metadata supported by the target skill format; do not invent a `when_to_use` field. Whole-skill removal needs an explicitly approved ledger entry and a check of its callers and resources.

**Complete when:** the owned diff implements only approved entries and each moved meaning has both a destination and a supported path for loading it.

### 4. Verify retention and loading

Follow the verification reference. Account for every disappeared line as an approved deletion, a verbatim move, or an approved rewrite with its preserved meaning located. Check links, old filenames, and conditional globs using the target tool's semantics.

Use an independent reviewer, when available and permitted, to search for lost meanings without seeing the author's conclusions. Restore unexplained missing content verbatim. Verify conditional loading with fresh positive and negative sessions in an isolated copy; do not confuse file existence or direct reading with automatic discovery.

**Complete when:** the final diff has no unexplained removals, applicable loading checks have evidence, and any unavailable independent review or runtime check is explicitly marked unverified.

### 5. Report the result and preserve the rerun method

Report the approved changes, size changes by loading tier, retained constraints, review findings, and actual loading evidence. Distinguish static validation from fresh-session results. State the exact remaining check if a capability was unavailable.

For an approved reusable record, retain the ledger, tool/model versions where available, counting method, representative cases, and a concise rerun procedure in the project-designated location. Re-evaluate behavior after a model upgrade; the new model may change which reminders are redundant, but it does not invalidate user decisions or constraints.

**Complete when:** the user can inspect what changed, what was preserved, what was verified, and how to repeat the review without making all the detailed material always-loaded again.
