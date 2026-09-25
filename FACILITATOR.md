# Facilitator guide

## Recommended delivery model

- Publish this folder as a GitHub template repository before the event.
- Send `PREWORK.md` at least one week before the workshop.
- Ask attendees to create their own repository from the template and launch its
  Codespace before the event.
- Require attendees to complete the pre-work verification.
- Keep one facilitator-owned fallback repository available for demonstration.
- Encourage pairs or tables to use one working environment when setup fails.
- Treat Copilot Free and other Auto-only plans as evaluation-only participants;
  pair them with a compatible Copilot Pro+ or organization-seat environment.

## Before publishing

1. Follow `PUBLISHING.md` with a separate personal GitHub.com account.
2. Create a repository from the template and launch a new Codespace.
3. Authenticate GitHub CLI as the intended user:

   ```shell
   unset GH_TOKEN GITHUB_TOKEN
   gh auth login --hostname github.com --git-protocol https \
     --web --scopes repo,workflow,read:org
   gh auth setup-git --hostname github.com
   gh auth status --active --hostname github.com
   ```

4. Run `./scripts/workshop-readiness.sh`.
5. Confirm the workflow uses `model: auto`.
6. Confirm the fixture issue is skipped and scenario A proceeds past
   pre-activation. The root-level `if:` checks the triggering issue's labels;
   `skip-if-match` must not be used because it searches the repository.
7. Confirm `on.roles: all`, the `WORKSHOP_OPERATOR` variable, and the operator
   condition are present. Test personal and organization-owned copies. In a
   public rehearsal copy, verify that an unconfigured user cannot start
   inference.
8. Run all scenarios and inspect AI Credits with `gh aw logs` and `gh aw audit`.
9. Adjust `max-ai-credits` only if a successful rehearsal approaches the cap.
10. Reset `.github/workflows/issue-triage.md` to the TODO version.
11. Recompile so the committed lock file matches the starter.
12. Test each script mode in a disposable repository:
   - `./scripts/create-test-issues.sh --seed-duplicate-source`
   - `./scripts/create-test-issues.sh A`
   - `./scripts/create-test-issues.sh B`
   - `./scripts/create-test-issues.sh C`
13. Run `gh aw secrets bootstrap --non-interactive --engine copilot` and confirm
   the participant authentication path is ready.

## 120-minute run of show

| Time | Activity |
|---|---|
| 0–5 | Welcome, outcomes, readiness check |
| 5–17 | Agentic Workflow foundations |
| 17–29 | AI-enabled SDLC framing, examples, and task selection |
| 29–39 | Issue-triage contract and quality bar |
| 39–62 | Customize the three workflow decisions |
| 62–70 | Compile, review, commit, and push |
| 70–78 | Inspect the generated lock file and troubleshoot |
| 78–82 | Assign a scenario and predict the expected result |
| 82–96 | Run one assigned scenario |
| 96–106 | Evaluate and propose one evidence-based refinement |
| 106–114 | Design another SDLC workflow |
| 114–118 | Human approval and adoption roadmap |
| 118–120 | Resources and close |

## Distributed test assignments

- Assign one third of the room scenario A.
- Assign one third scenario B.
- Assign one third scenario C.
- Have each group report:
  - The labels or type applied
  - The suggested team and simulated tag
  - The strongest evidence used
  - The least certain decision
  - One change they would make

Before starting the workflow, require each group to predict:

- Expected labels
- Expected suggested team
- Whether priority should be set
- Missing-information questions
- Duplicate versus related status
- Evidence the agent should cite

During the transfer exercise, use `docs/workflow-design-canvas.md`. Ask groups
to share the task, safe output, human gate, and evaluation cases—not a full
prompt.

After evaluation, ask the repository operator to act as the human approver:

- Add `routing/approved` only when the suggested team is supported by evidence.
- Leave the label unset when the route should be redirected.
- Point out that `routing/approved` exists in the repository but is absent from
  the agent's safe-output allowlist.

## Fallbacks

If authentication or installation fails:

- Confirm the intended account is active with
  `gh auth status --active --hostname github.com`; if Codespaces environment
  authentication is taking precedence, rerun the login commands above.
- If an HTTPS `git push` prompts for a username, run
  `gh auth setup-git --hostname github.com` and retry.
- Pair the attendee with a working environment.
- Use the facilitator repository and ask the attendee to evaluate an output.
- If most of the room is blocked, demonstrate one live run from the facilitator
  repository and continue with the fallback outputs.

If an attendee has Copilot Free:

- Do not spend workshop time trying alternate model names.
- Explain that direct Copilot CLI may work while the current PAT-backed gh-aw
  proxy path returns `400 The requested model is not supported`.
- Pair the attendee or continue with the matching fallback output.

If Actions or inference is slow:

- Use the matching file in `fallback-outputs/`.
- Continue with the rubric and refinement exercise.

The fallback files are representative workshop outputs, not evidence of a live
run in the attendee's repository. Ask participants to evaluate them exactly as
they would evaluate a live result.

If compilation fails broadly:

- Reveal `solutions/issue-triage.complete.md`.
- Copy it into `.github/workflows/issue-triage.md`.
- Compile once as a group and continue to evaluation.
