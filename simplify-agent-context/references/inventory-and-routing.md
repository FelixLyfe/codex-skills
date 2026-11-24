# Inventory and Routing

## Establish the Loading Model

Inventory only the requested project and relevant user-level configuration. Resolve symlinks and shared locations before proposing a write: a project-visible skill may actually live in a global directory or a managed plugin cache.

Use the target tool's current instructions, supported configuration, or observable loading evidence. Do not assume that every tool reads the same global rules, that `AGENTS.md` and `CLAUDE.md` have a universal precedence, or that all `paths:` patterns use the same matching rules.

Do not create a root `CLAUDE.md` merely to reorganize content. If an existing agent requires a compatibility entry point, first establish its loading behavior and preserve reachability from the tools the user actually uses. Treat managed or generated sources according to their owner; prefer a supported configuration or source change over editing a generated cache.

Use an inventory such as:

| Source and tool | Loading condition | Characters | Evidence | Coverage or uncertainty |
| --- | --- | ---: | --- | --- |
| Root project instructions | Project entry, if supported | Measured | Tool configuration or observed session | State the actual root |
| Global rules | Tool-specific | Measured | Configured location | Which tools consume them |
| Rule files | Unconditional or matching paths | Measured | Declared condition and tool semantics | Unverified matches |
| Skill descriptions | Discovery, if included by the host | Measured separately | Active skill catalog | Installed versus discoverable |
| Skill bodies and references | Invocation or explicit pointer | Measured separately | Trigger and link | Unreachable resources |

Count Unicode characters including whitespace consistently. Avoid adding mutually exclusive branches into a claim about per-turn load. Use actual loaded payloads when available; otherwise describe sizes as source inventory, not measured runtime context.

## Choose the Destination

| Content | Preferred home | Reachability requirement |
| --- | --- | --- |
| Constraints relevant at any conversational moment, such as sending a reply, committing, publishing, or deleting | Appropriate root/global entry point | Preserve essential limits immediately; link optional procedures |
| Cross-project constraints | Global rules | Verify every relevant tool consumes them before removing project copies |
| Project commands, deployment procedures, and local conventions | Project guide | Leave a root pointer stating when to read the guide |
| Task-specific judgment | Skill body | Description names the actual task and trigger |
| Guidance for only one skill branch | `references/` | Parent names the branch that requires the reference |
| Deterministic checks or transformations | Script or supported hook | Defined trigger, inputs, failure behavior, and executable evidence |

A "read X before Y" instruction can become a hook only if the tool supports the required event and context injection. Verify the hook before removing the old pointer; otherwise retain the pointer. A hook or script must not silently extend permission to mutate data.

## Review Ledger

| ID | Source and passage | Action | Proposed content or destination | Load condition | Reason and evidence | Approval |
| --- | --- | --- | --- | --- | --- | --- |

Define actions consistently:

- **Fix:** correct an evidenced error, stale statement, or broken pointer; retain relevant historical context.
- **Delete:** remove a meaning shown to be unnecessary, with explicit approval. Missing usage records are insufficient evidence of disuse.
- **Move:** relocate the original text intact and name its entry point.
- **Rewrite:** change expression while retaining the contract; show the proposed wording for review.
- **Keep:** retain useful, protected, or uncertain content and explain why.

For example, replace a vague style slogan with a concrete contrast only when it expresses the user's actual preference:

```text
Prefer direct status reports.
NO: A comprehensive validation exercise has been undertaken.
OK: The three affected checks passed; device testing remains unverified.
```

Do not replace permission, evidence, or sequencing requirements with a style label. The approval entry should be specific enough that later deleted lines can be reconciled without guessing what the user accepted.
