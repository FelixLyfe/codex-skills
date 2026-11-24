# Workflow Blueprint

Use this reference to turn an informal process description into a concrete design. Include only fields that affect the requested outcome; a small workflow does not need a filled-out questionnaire.

## Recover the Human Decisions

Ask the user to narrate an actual example when the existing materials do not explain the process. Capture what they inspect, why they choose a branch, what causes an exception, and how they recognize completion or failure.

For each consequential decision, establish:

- required evidence, its freshness, and which source wins a conflict;
- thresholds, priorities, exceptions, and who owns an unresolved judgment;
- record identity across systems, including collisions and duplicates;
- continuation, stopping, escalation, and recovery conditions;
- relevant data access, retention, and output restrictions.

A stable identifier is evidence of record identity; a similar-looking name alone may not be. Treat unspecified business rules as gaps rather than convenient defaults.

## Review Template

```text
Goal and observable success:
Scope and exclusions:
Entry condition and input sources:
Steps, handoffs, and outputs:
Decision rules and source precedence:
Exceptions and human takeover:
Tools, accounts, access, and external effects:
Acceptance cases and evidence:
Failure recovery and duplicate prevention:
Trigger and timezone, if requested:
Assumptions and unresolved decisions:
Current status and next authorized action:
```

Mark facts, assumptions, and gaps next to the affected item. If approval is missing, identify the exact action it blocks and present the completed design or artifact for review. Do not reclassify an already authorized action as unapproved merely because a new blueprint was written.

## Case Record

| Input and starting state | Expected decision and result | Stop or handoff condition | Observed result and evidence |
| --- | --- | --- | --- |
| An ordinary eligible item | Follow the defined path and satisfy the goal | Required evidence is unavailable | Record the walkthrough or controlled run |
| The same item arrives again, if repeats are possible | Reuse the existing outcome or apply the defined update rule | Prior external write outcome is uncertain | Check identity and persisted state |

Choose further cases from the workflow's actual branches. A tabletop walkthrough establishes design plausibility; it does not prove that an integration works or that users accept its results.
