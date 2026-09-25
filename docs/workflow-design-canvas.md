# Agentic workflow design canvas

Use this canvas after completing the issue-triage exercise. Select one
contextual task from your own software delivery lifecycle and define a small,
testable first version.

| Decision | Your design |
|---|---|
| SDLC task | What recurring contextual task should the workflow address? |
| Trigger | Issue, pull request, failed workflow, schedule, release, or command? |
| Context | Which files, logs, issues, pull requests, or documentation must it read? |
| Agent decision | What judgment should the agent make? |
| Safe output | Recommendation, comment, label, issue, or pull request? |
| Human gate | What consequence requires review or explicit approval? |
| Evaluation cases | Which complete, incomplete, ambiguous, and adversarial cases will you test? |

## Candidate check

Before implementing the workflow, confirm:

- Inputs vary enough that fixed rules are insufficient.
- The task requires interpretation or synthesis.
- The output can be evaluated against observable criteria.
- Repository writes can be bounded or made reviewable.
- An incorrect result is reversible or reviewed before application.

If the correct behavior is already known and deterministic, use a traditional
GitHub Actions step instead.
