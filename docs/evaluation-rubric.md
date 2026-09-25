# Issue triage evaluation rubric

Score each dimension from 0 to 2.

| Dimension | 0 | 1 | 2 |
|---|---|---|---|
| Evidence | Conclusions are invented or unsupported | Some conclusions are supported | Every material conclusion cites issue or repository evidence |
| Restraint | Guesses despite missing evidence | Shows uncertainty but still over-classifies | Leaves fields unset or requests information when evidence is insufficient |
| Routing | Type, priority, or team conflicts with policy | Routing is plausible but weakly explained | Type, priority, and suggested team match policy and are clearly explained |
| Duplicate detection | Uses title similarity alone | Finds a related issue but overstates similarity | Requires matching symptoms, component, behavior, or errors |
| Actionability | No useful next step | Next step is broad or generic | Provides one focused action or precise clarification request |
| Output quality | Long, inconsistent, or difficult to scan | Mostly follows the contract | Concise, predictable, respectful, and complete |

## Review questions

1. Which evidence did the workflow use?
2. What decision was least certain?
3. Did it apply only allowed labels?
4. Did it stop instead of guessing when information was missing?
5. Would a maintainer know exactly what to do next?
6. Is the simulated team tag non-functional and clearly pending human review?
7. Did a human—not the agent—apply `routing/approved`?

## Refinement rule

Use the weakest dimension to propose one change at a time. State the behavior
you expect the change to improve. Examples:

- Tighten required bug information.
- Clarify a priority boundary.
- Raise the evidence threshold for duplicates.
- Shorten the report.
- Reduce the number of allowed outputs.

Recompiling and rerunning is an optional extension after the workshop.
