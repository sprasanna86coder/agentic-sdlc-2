# Scenario B: incomplete bug

## Representative safe outputs

- Add label: `bug`
- Add label: `needs-info`
- Add label: `suggested-team/support-triage`
- Add one triage comment
- Leave priority unset

## Representative maintainer comment

### Summary

The issue says that the triage workflow stopped working, but it does not
describe the failing behavior or provide enough evidence to reproduce it.

### Classification

- **Type:** Possible bug; the report is not yet verifiable.
- **Priority:** Unset because impact and scope are not documented.
- **Suggested team:** `suggested-team/support-triage`
- **Simulated tag:** `@example/support-triage`
- **Approval:** Pending maintainer review

### Information needed

1. What action or event was expected to trigger the workflow?
2. What happened instead, including the workflow run URL and relevant error?
3. Which gh-aw version and repository configuration are affected?
4. When did the workflow last run successfully, and what changed afterward?

### Next step

Provide the failing run and reproduction details so the behavior can be
investigated without guessing.

## Evaluation observations

- Restraint is the primary success criterion.
- Urgent wording alone does not justify a priority label.
- Focused questions are more useful than a speculative diagnosis.
- Support triage is appropriate until enough evidence exists for product-team routing.
