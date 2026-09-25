# Pre-work checklist

Complete this checklist before the workshop. The primary path uses a repository
in your personal namespace or an organization you administer, with a Codespace
created from your copy of the template.

## Account requirements

- [ ] I am signed in with a personal GitHub.com account.
- [ ] I can create a repository in my personal namespace or an organization
  where I can manage Actions secrets and variables.
- [ ] My account can create a GitHub Codespace.
- [ ] My account has Copilot Pro, Pro+, Max, or an eligible
  Business/Enterprise seat with available AI Credits.
- [ ] I can create a fine-grained personal access token.

Organization policies may restrict template access, Actions, Codespaces,
personal access tokens, or Copilot. Confirm those capabilities before selecting
an organization-owned repository. If they are unavailable, use a personal
repository or pair with another attendee.

Copilot Free and other Auto-only plans are not currently compatible with the
released PAT-backed gh-aw workflow path. A direct Copilot CLI prompt may work
while the same PAT still receives `400 The requested model is not supported`
inside an agentic workflow. If you use Copilot Free, arrange to pair with a
participant who has compatible access.

## Create the workshop repository

1. Select **Use this template → Create a new repository**.
2. Create a public or private repository under your personal account or an
   organization where you have administrative access.
3. Open **Code → Codespaces → Create codespace on main**.
4. Wait for the terminal to report that the Codespace tools are installed.

## Authenticate GitHub CLI as your user

Codespaces provides a `GITHUB_TOKEN` environment variable. GitHub CLI gives
that environment token precedence over stored user authentication, but the
workshop scripts administer repository variables, labels, issues, secrets, and
workflows as the signed-in user.

Run:

```shell
unset GH_TOKEN GITHUB_TOKEN
gh auth login --hostname github.com --git-protocol https \
  --web --scopes repo,workflow,read:org
gh auth setup-git --hostname github.com
gh auth status --active --hostname github.com
```

Confirm the intended GitHub account is active and that the status does not
report authentication from an environment token. The workshop scripts ignore
Codespaces' `GITHUB_TOKEN` so stored GitHub CLI user authentication can be used.
An intentionally supplied `GH_TOKEN` remains supported. The scripts also run
`gh auth setup-git --hostname github.com` to configure GitHub CLI as Git's
HTTPS credential helper and prevent `git push` from prompting for a username.

`COPILOT_GITHUB_TOKEN` is separate: it remains a repository Actions secret used
by the Agentic Workflow for Copilot inference, not GitHub CLI authentication in
the Codespace.

## Configure Copilot inference

Create a fine-grained token owned by your personal account:

<https://github.com/settings/personal-access-tokens/new?name=COPILOT_GITHUB_TOKEN&description=GitHub+Agentic+Workflows+-+Copilot+engine+authentication&user_copilot_requests=read>

Confirm **Account permissions → Copilot Requests: Read**, generate the token,
then run this inside the Codespace:

```shell
gh aw secrets bootstrap --engine copilot
```

Store the token as the repository Actions secret `COPILOT_GITHUB_TOKEN`. This is
an Actions secret, not a Codespaces secret.

The workflow uses `model: auto` and the Copilot CLI version supplied by the
installed gh-aw release.

If inference still fails, test the same PAT directly without placing it in
shell history:

```shell
read -rsp "Copilot PAT: " COPILOT_GITHUB_TOKEN; echo
export COPILOT_GITHUB_TOKEN
copilot -p "Reply with exactly OK." --model auto --allow-all-tools --no-ask-user
unset COPILOT_GITHUB_TOKEN
```

The workshop prerequisite remains a paid individual plan or eligible
organization seat.

## Run the readiness check

```shell
./scripts/workshop-readiness.sh
```

- [ ] The intended GitHub account is active in GitHub CLI without
  environment-token authentication.
- [ ] GitHub CLI is configured as Git's HTTPS credential helper.
- [ ] gh-aw version 0.88.8 is installed.
- [ ] The Copilot repository secret is detected.
- [ ] `WORKSHOP_OPERATOR` is set to my signed-in GitHub username.
- [ ] Workshop labels are created.
- [ ] The duplicate fixture is created without starting the AI agent.
- [ ] The starter workflow compiles.

Do not complete the TODOs before the workshop. Do not use a production
repository.

The workflow permits all issue authors through the framework's role check but
restricts inference to the personal repository owner or the configured
`WORKSHOP_OPERATOR`. The readiness script sets the operator to the signed-in
user, allowing both personal and organization-owned repositories without
exposing Copilot credits to arbitrary issue authors.

The workshop standardizes on the default GitHub Copilot engine with a
fine-grained personal access token stored as the `COPILOT_GITHUB_TOKEN`
repository secret. The token must be owned by your user account and have
**Account permissions → Copilot Requests: Read**. Do not add
`copilot-requests: write` to the workshop workflow; that organization-billed
authentication path is intentionally outside the participant setup.

Create the token:
<https://github.com/settings/personal-access-tokens/new?name=COPILOT_GITHUB_TOKEN&description=GitHub+Agentic+Workflows+-+Copilot+engine+authentication&user_copilot_requests=read>
