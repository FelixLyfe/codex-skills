# UniApp Validation

Read this reference before running checks, generators, watch builds, generated-output inspection, or runtime acceptance.

## Choose Repository Commands

Use the package manager, version, and scripts declared by the repository. Run the narrowest relevant checks first:

1. type checking;
2. linting;
3. style linting when styles changed;
4. the target mini-program build when routes, generated configuration, or runtime behavior changed.

If a global package manager would purge or reinstall dependencies, use the repository-pinned version through its version manager or existing local binaries. Preserve dependency state while validating the change.

## Generated Evidence

For a new or changed route, search the generated page table, route typings, or compiled output for the exact base path. For platform props or selectors, inspect generated WXML/WXSS/JS to confirm source propagation.

Generated output proves compilation, not runtime behavior. Use a placeholder in targeted searches rather than preserving a project-specific path:

```bash
rg "<page-path-or-selector>" <generated-route-files> <compiled-output>
git diff --check
```

## Runtime Evidence

Use the same viewport as the baseline. Re-check every named mismatch: position, baseline, spacing, clipping, wrapping, hit target, scroll behavior, keyboard shift, overlay order, and interaction timing.

When DevTools or device validation belongs to another owner, finish source and build evidence and provide the exact route, state, actions, and expected result they should exercise.

## Cleanup

Stop watch-mode builds after the first required successful compile and confirm the process ended. Review generator-touched files: preserve intentional route registration and user-owned changes, and exclude generator-only churn from the task diff.

**Complete when:** each attempted check has a result, generated evidence is labeled as generated, runtime claims are observed or explicitly pending, and the final diff contains only task-owned changes.
