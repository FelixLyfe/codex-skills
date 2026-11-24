# Verification

Use the exact pre-edit baseline, including user changes that existed before this task. The Git base alone is insufficient when the starting worktree was dirty. In an approved Apply run, keep a recoverable copy or patch for the scoped files outside the proposed loading paths.

## Account for Disappeared Lines

Inspect the full owned diff, including deleted and new files. For each removed line or contiguous block, record one of:

- approved deletion: ledger ID and the accepted reason;
- move: ledger ID, destination, and an exact-text match;
- rewrite: ledger ID, replacement location, and the retained conditions and meaning.

A move is not a semantic deletion. A shorter replacement is not proof that the old rule survived. Check subjects, negation, qualifiers, ordering, exceptions, and authorization limits explicitly. Restore any unexplained removal verbatim before claiming completion.

Search for old filenames and update live pointers. Distinguish intentional historical mentions from broken links. Validate new links and match each conditional glob against real intended files using the target tool's matching semantics, including exclusions and path roots. A pattern with no current match is a gap to resolve or explicitly retain for an evidenced future scope; do not silently broaden it.

## Independent Retention Review

When an independent agent is available and delegation is permitted, give it only the removed original text, source locations, access to the resulting repository, and this neutral task:

```text
Check whether the meaning of each removed passage survives in the current
repository. Search key concepts and synonyms, not only exact sentences.
For each passage, return the evidence location and any lost condition,
exception, negation, or ordering. Report absent or ambiguous meanings.
Do not edit files.
```

Do not supply the author's conclusions or deletion rationale. Exclude the review packet, baseline copies, audit logs, and the change ledger as proof of retention: operational meaning must be reachable by the agent when it needs it. If approved destinations are outside the repository, grant read access only to those destinations needed for the check.

After the review, reconcile missing meanings with the approved ledger. Intentional approved deletions are expected; missing moved or rewritten meanings and unexplained removals must be restored verbatim or repaired through a newly reviewed change. Avoid overwriting concurrent user edits while restoring.

If independent review is unavailable, say so. The author's reread can still find mistakes but is not an independent check.

## Verify Actual Loading

Static pointers and matching globs prove wiring, not runtime loading. For a changed conditional loading route:

1. Use an isolated copy of the approved configuration with matching relative paths and tool settings. Insert a unique harmless marker into the destination rule or reference only. Never insert secrets or leave markers in production instructions.
2. Start a fresh target-tool session that has not seen the marker, relocated text, or prior conversation. Have it read an ordinary file or perform a task that should trigger the rule. Ask for the loaded marker without supplying its value or directly naming the rule file. Capture available load evidence.
3. Run the negative case in a separate fresh session with a nonmatching file or task. Reusing the positive session would retain the marker and invalidate the comparison. Avoid explicitly invoking the skill if automatic selection is what is being tested.
4. Check that the positive case loads the expected material and the negative case does not. Investigate unexpected loading, another path to the same material, or a missing trigger. A marker response alone is weak evidence; inspect loading records when available and exercise a representative rule to check behavior.
5. Remove only the test artifacts created for this check. Confirm that no marker remains in the deliverable and that the actual configuration matches the tested copy except for the marker.

Do not build a new agent runner, create a user-owned chat, or alter global configuration merely to obtain this evidence without the required authorization. If a fresh-session facility is unavailable, report the route as statically checked and runtime-unverified, with the exact positive and negative cases still required.

## Delivery Evidence

Report before/after sizes by loading tier using the same counting method. Include the ledger, removed-line reconciliation, independent-review status, glob/link checks, and fresh-session results or gaps. Do not call a reduction in total file size a reduction in always-loaded context unless the loading evidence supports it.

For a later model-upgrade review, reuse the inventory method and representative cases while checking current configuration and behavior again. Historical approval applies to its recorded change set, not to newly proposed deletions.
