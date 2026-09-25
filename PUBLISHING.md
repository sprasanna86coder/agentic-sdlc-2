# Publish the workshop template

Use these steps after uploading this folder to your GitHub.com namespace.

1. Create a public repository from this folder.
2. Open **Settings → General** and select **Template repository**.
3. Confirm GitHub Actions and Issues are enabled.
4. Create a clean repository from the template under a separate personal
   account. Test both public and private visibility.
5. Launch a Codespace from the copied repository.
6. Authenticate GitHub CLI as the intended user:

   ```shell
   unset GH_TOKEN GITHUB_TOKEN
   gh auth login --hostname github.com --git-protocol https \
     --web --scopes repo,workflow,read:org
   gh auth setup-git --hostname github.com
   gh auth status --active --hostname github.com
   ```

7. Complete [PREWORK.md](PREWORK.md) exactly as an attendee would.
8. Confirm the duplicate fixture's workflow is skipped, then confirm scenario A
   proceeds past pre-activation. The workflow's root-level `if:` must inspect
   only the triggering issue; do not replace it with a repository-wide
   `skip-if-match` query.
9. Confirm `on.roles: all` and the operator-aware root condition are present.
   Open one issue as the configured `WORKSHOP_OPERATOR` and, in a public test
   copy, open another from a different account. Only the configured operator or
   a personal repository owner may start inference.
10. Confirm the generated workflow reports `COPILOT_MODEL: auto`.
11. Test the same PAT directly with the secure diagnostic in `PREWORK.md`.
12. Run all three scenarios and record their AI Credits:

   ```shell
   gh aw logs issue-triage --last 5 --json
   ```

13. If successful runs approach the configured `max-ai-credits` limit, raise the
   limit before the event and recompile the workflow.
14. Replace the representative files in `fallback-outputs/` with output captured
   during the rehearsal.
15. Keep one facilitator-owned repository and Codespace ready for a live demo.

## Copilot plan requirement

The live exercise requires Copilot Pro, Pro+, Max, or an eligible
Business/Enterprise seat. Copilot Free and other Auto-only plans can run
Copilot CLI directly but currently fail in the released PAT-backed gh-aw proxy
path with `400 The requested model is not supported`.

Ask attendees to confirm their plan before the event. Assign anyone using
Copilot Free to a partner with a compatible account. Keep the captured outputs
available when no compatible account exists at a table.

## Suggested attendee instructions

1. Select **Use this template → Create a new repository**.
2. Create a public or private repository under a personal GitHub.com account or
   an organization where you have administrative access.
3. Open **Code → Codespaces → Create codespace on main**.
4. Run the GitHub CLI user-login and `gh auth setup-git` commands in
   `PREWORK.md`.
5. Complete `PREWORK.md`.
6. Run `./scripts/workshop-readiness.sh`.

Do not instruct attendees to open a Codespace directly against the original
template. Each pair needs its own repository for secrets, workflow runs, issues,
and generated files.
