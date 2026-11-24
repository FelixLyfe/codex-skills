# Operation and Triggers

Read this for external effects, recovery, recurring runs, or operational failures. Apply only the controls relevant to the workflow.

## External Actions and Recovery

For each consequential action, identify the destination, minimum required access, stable item identity, completion evidence, and recovery owner. Reuse authorized access; request a new connection only when the workflow needs it and follow the integration's authorization process.

Record enough progress to distinguish `not started`, `in progress`, `confirmed complete`, `failed`, and `outcome unknown`. Minimize sensitive information in logs.

- Deduplicate repeated inputs. Use a supported idempotency key or verify existing destination state before creating another effect.
- Retry a confirmed transient failure only within a bounded attempt or time budget. Do not keep retrying a permission error or an unresolved business decision.
- After a timeout or ambiguous response to a write, reconcile destination state first. If the result cannot be determined, stop that item for human resolution.
- Resume partial work from confirmed progress. Do not replay completed actions or invent a rollback for an irreversible operation.
- Define when a person must take over and what evidence they need. Keep unvalidated high-impact branches under review.

## Choose a Trigger Only When Requested

First demonstrate the controlled workflow against its acceptance criteria. Select the simplest mechanism whose semantics match the requirement:

| Requirement | Candidate mechanism | Evidence needed |
| --- | --- | --- |
| Run at a fixed time or interval | Supported scheduler | Timezone, cadence, overlap policy |
| React to a specific event | Supported event subscription or native automation | Event source, filter, delivery and duplicate behavior |
| Act when a condition becomes true | Native condition trigger, or bounded polling if necessary | Explicit condition, polling cost, acceptable delay |

Inspect the current environment's automation instructions and tool schemas before choosing or configuring a mechanism. Use an available first-party automation action when the host requires it. Do not invent event types, filters, schedule fields, or dependencies on skills that are unavailable.

Reuse settled choices. Resolve only missing material details: timezone, frequency or event scope, action, notification, failure handling, pause control, and any limits on cost or data access. Unattended runs must have a defined fallback for unresolved input; they cannot rely on an interactive answer arriving during the run.

## Acceptance and Handoff

Inspect the saved configuration, enabled state, and next-run information when available. Check execution evidence separately through an authorized controlled invocation or an observed scheduled run. Do not execute an extra live action solely to manufacture proof. If the first run is in the future, report it as configured with runtime verification pending.

Record how to pause the workflow, where failures appear, and how an operator can reconcile or resume an item. For changes to a running workflow, retain the prior configuration or a practical rollback path and replay the affected cases before expanding its scope.
