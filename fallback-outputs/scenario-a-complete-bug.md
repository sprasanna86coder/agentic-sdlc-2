# Scenario A: complete bug

## Representative safe outputs

- Add label: `bug`
- Add label: `priority/p1`
- Add label: `suggested-team/workflows`
- Add one triage comment

## Representative maintainer comment

### Summary

The issue reports a regression in `gh aw compile` after upgrading to version
0.88.7. It includes reproduction steps, expected and actual behavior, the
environment, and the compiler error.

### Classification

- **Type:** Bug. Compilation of a previously valid issue trigger now fails.
- **Priority:** `priority/p1`. The compiler is blocked for the reported workflow,
  but the issue does not establish a broad service outage or data-loss risk.
- **Suggested team:** `suggested-team/workflows`
- **Simulated tag:** `@example/workflows`
- **Approval:** Pending maintainer review

### Similar issues

No sufficiently similar issue was identified.

### Next step

Reproduce the schema validation failure with gh-aw 0.88.7 and determine whether
the issue trigger schema or migration handling changed.

## Evaluation observations

- The classification cites details present in the issue.
- The priority avoids escalating the issue to p0 without outage evidence.
- The next step is specific enough for an engineer to begin investigation.
- The simulated team tag is visible but creates no real mention or notification.
- A live result may choose to leave priority unset; evaluate its reasoning
  rather than expecting this exact wording.
