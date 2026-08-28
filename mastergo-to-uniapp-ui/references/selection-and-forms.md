# Selection and Forms

Read this reference when the design includes selectable items, custom entries, count limits, or form return behavior.

## State Matrix

Record the states the current surface supports:

| Concern | States or decisions |
|---|---|
| Selection | unselected, selected, recommended, disabled |
| Custom entry | closed, editing, invalid, duplicate, confirmed |
| Limits | below maximum, at maximum, attempted overflow |
| Data | loading, empty, error, populated |
| Completion | confirm, cancel, return payload, source highlight |

## Ownership Rules

- Keep one source of truth for selected identifiers and derive visual state from it.
- Keep special actions such as custom entry outside sortable data, or append them after sorting/filtering when the contract places them last.
- Enforce limits at the earliest visible entry point for every add path.
- Preserve the current return payload, event, or targeted store-update mechanism when it satisfies the contract.
- Separate display ownership from mutation ownership; render delete/edit controls only on surfaces assigned that behavior.
- Preserve existing items through add-only flows unless the contract explicitly changes edit semantics.

## Input and Validation

Cover empty and whitespace-only values, duplicates, maximum counts, cancel/confirm, and server-side failure. Normalize at the business boundary while preserving the designated display copy.

Keyboard type is an input affordance, not validation. Filter or validate pasted/programmatic values when the contract restricts character classes.

**Complete when:** every supported state has one owner, every add/remove path enforces the same constraints, and the source page receives the intended result without an unnecessary full reload.
