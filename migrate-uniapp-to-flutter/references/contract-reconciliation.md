# Contract Reconciliation

Read this reference when the current UniApp code, an API/host contract, and the Flutter implementation disagree, or when the user asks whether a mismatch came from migration or later contract drift.

## Separate the two decisions

Decide these independently:

1. **Target behavior now:** which artifact the target must follow.
2. **Origin attribution:** when and where the divergence entered the chain.

An attribution theory does not choose the target contract. Follow the authority the user named. If the user asks for code-based judgment, use current code and Git evidence rather than document-history inference. When no authority is named and the conflict changes production behavior, expose the conflict before changing the contract.

## Three-way trace

Trace the complete call chain in each available artifact:

| Contract surface | UniApp/source | Current API or host contract | Flutter target |
|---|---|---|---|
| Base URL, path, and method | | | |
| Request fields and defaults | | | |
| Response DTO and nullability | | | |
| Business status/error mapping | | | |
| Visibility/disabled/offline controls | | | |
| Polling, retry, pagination, or expiry timing | | | |
| Auth and required headers | | | |
| Navigation/platform directive | | | |

Follow callers, parsers, repositories, state transitions, and widgets. A field that is parsed but never affects its promised behavior is still a mismatch.

## Attribute with evidence

Use one of these labels only when its evidence is available:

- `migration omission`: behavior or contract existed in the selected source at migration time but did not reach Flutter;
- `inherited source behavior`: Flutter accurately carried behavior already present in the selected source revision, including a prior source removal;
- `contract drift`: an authoritative external contract changed after the selected source/target implementation;
- `platform adaptation`: Flutter/host intentionally differs because the source platform capability has no equivalent;
- `unresolved`: available code, revision, or contract evidence cannot establish origin.

For code-based attribution, inspect the relevant source and target Git history around introduction, removal, and migration commits. Current absence alone does not prove that migration omitted a behavior.

## Repair at the boundary

Implement the selected current behavior with the smallest boundary change:

- keep endpoint and DTO compatibility in the API/repository/model layer;
- propagate backend-controlled fields into controller/state before widgets;
- use server-provided timing, retry, pagination, and action controls when the selected contract owns them;
- add a focused regression for every reconciled mismatch;
- report the fix and its attribution separately.

**Complete when:** every conflicting surface has a selected authority, target disposition, focused regression, and evidence-backed attribution or an explicit `unresolved` label.
