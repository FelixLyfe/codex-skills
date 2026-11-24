---
name: workflow-anything
description: Design, validate, or implement repeatable workflows from user goals. Use for process redesign, agents, integrations, or recurring and event-driven automation; not one-off task execution without a workflow request.
---

# Workflow Anything

Turn an outcome into a workflow whose decisions, effects, and success can be checked. Separate the user's goal from the steps they happen to use today.

## Select the Deliverable

- **Design:** deliver a reviewable blueprint and case walkthroughs. Stop at the design when implementation was not requested.
- **Implement:** build and validate the requested workflow within the user's existing authorization. Reuse a previously accepted blueprint rather than asking for the same approval again.
- **Refine:** use observed failures or feedback to change an existing workflow, then replay the affected cases against its acceptance criteria.

Scheduling is an optional implementation branch. A request to design a process does not imply a request to enable unattended execution. A one-off task stays a one-off task unless the user asks for a repeatable workflow.

## Authorization and Evidence

Read relevant authorized sources and prepare concrete, reversible artifacts before requesting any missing approval. Existing authorization for the same scope remains valid. Before enabling an integration or performing external writes, sends, publication, payments, or unattended runs, make the target, access, effects, and recovery behavior reviewable and resolve any missing authorization. Material changes to scope, permissions, costs, or effects need a new decision.

Use safe local simulations or supported dry-runs before live side effects. Do not send real messages, make bookings, or write test data into shared systems merely to test a design. An uncertain write outcome requires checking current state before any retry.

Keep `proposed`, `simulated`, `implemented`, `configured`, and `observed in operation` distinct. A saved schedule or successful tool call does not by itself prove that the user's goal was met.

## Load Only Relevant References

- Read [references/blueprint.md](references/blueprint.md) when the goal, current process, source authority, or human decision rules are unclear, or when presenting a blueprint for review.
- Read [references/operation-and-triggers.md](references/operation-and-triggers.md) when implementing external actions, retries, recovery, or unattended triggers, or investigating a running workflow's failures.

## Steps

### 1. Define the outcome and reconstruct the current process

Identify who benefits, the observable success criteria, the scope, and exclusions. Distinguish the intended result from intermediate actions such as filling a form or sending a message. Let the user choose an unresolved business goal instead of selecting one on their behalf.

Use available materials first. Ask only questions that change the outcome, source access, decision rules, effects, or acceptance evidence. Label low-risk defaults; use one question at a time for a complex interview and group independent short questions when useful.

Capture the trigger, inputs, steps, handoffs, outputs, checks, and recovery practices. Separate facts, assumptions, and gaps. Suggest a simpler route explicitly when current habits are unnecessary to the goal.

**Complete when:** the target result is observable and every material unknown is either answered, a labeled assumption, or a named decision requiring human input.

### 2. Make the workflow reviewable

Describe the entry and exit, each step's inputs and outputs, authoritative sources, branches, tools, access, effects, and acceptance evidence. Translate tacit judgment into conditions for continuing, stopping, and handing off to a person.

Include missing, stale, ambiguous, and conflicting inputs where relevant. Define how records are matched across tools, what counts as a duplicate, and how partial completion is recognized. Leave unsupported high-impact decisions with a human; do not invent thresholds or source priorities.

**Complete when:** each consequential branch has an evidence-based rule or an explicit human handoff, and the blueprint explains both the intended outcome and its operational limits.

### 3. Exercise cases and resolve the remaining decisions

Use supplied examples, de-identified examples when needed, or safe synthetic data. Cover a normal case and the relevant ambiguity, conflict, missing-input, duplicate, timeout, or partial-success cases. Record each input, expected path, expected outcome, stop condition, and actual simulated result. Fix mismatches and replay the affected cases.

Present the concrete blueprint and evidence. In Design mode, deliver them and stop. In Implement or Refine mode, resolve only decisions or authorization still missing; proceed with work already authorized. Keep an unvalidated high-impact branch behind human review.

**Complete when:** representative cases support the design, remaining limitations are explicit, and the next implementation action is within the agreed scope and permissions.

### 4. Implement and verify the requested scope

Choose the simplest supported mechanism. Implement the smallest useful slice, run it under controlled conditions, and compare the outcome with the acceptance criteria. Record sufficient state to diagnose failures and recover without retaining unnecessary sensitive data.

Enable future triggers only when requested and after the controlled workflow meets its criteria. Inspect the current environment's automation routing and tool schema; use supported scheduling or event capabilities. Verify configuration separately from actual execution. Stop expanding a run when it deviates from the design.

**Complete when:** the requested artifacts or workflow exist, each acceptance claim has appropriate evidence, and any operational or permission blocker has a precise remaining action.

### 5. Deliver or refine using observed results

Report what was designed or changed, what was exercised, and what remains unobserved. For a running workflow, include its owner, trigger, failure notification, pause path, and recovery limits when applicable.

In Refine mode, distinguish observations, suspected causes, and proposed changes. Replay relevant cases, retain the accepted criteria and rollback path, and keep a concise change record. A single ambiguous report is not authority to expand permissions or silently change a high-impact rule.

**Complete when:** the user can tell whether the result is a design, a tested implementation, a configured trigger, or an observed run, and knows any required next action.
