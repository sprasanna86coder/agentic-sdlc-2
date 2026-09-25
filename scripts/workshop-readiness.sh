#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$root/scripts/ensure-user-gh-auth.sh"

required_secret="COPILOT_GITHUB_TOKEN"

echo "Checking GitHub authentication..."
gh auth status --active --hostname github.com

repo="$(gh repo view --json nameWithOwner --jq .nameWithOwner)"
owner_type="$(gh api "repos/$repo" --jq .owner.type)"
visibility="$(gh repo view --json visibility --jq .visibility)"
operator="$(gh api user --jq .login)"

echo
echo "Repository: $repo ($visibility)"
echo "Repository owner type: $owner_type"

echo
echo "Configuring workshop operator: $operator"
gh variable set WORKSHOP_OPERATOR --repo "$repo" --body "$operator"
configured_operator="$(gh variable get WORKSHOP_OPERATOR --repo "$repo")"
if [[ "$configured_operator" != "$operator" ]]; then
  echo "Failed to verify WORKSHOP_OPERATOR repository variable." >&2
  exit 1
fi

echo
echo "Checking GitHub Agentic Workflows CLI..."
gh aw --version
gh aw doctor --repo "$repo" --dir .

echo
echo "Checking Copilot inference secret..."
if ! gh secret list --json name --jq '.[].name' |
  grep -Fxq "$required_secret"; then
  cat >&2 <<EOF
Missing repository Actions secret: $required_secret

Create the fine-grained token described in PREWORK.md, then run:
  gh aw secrets bootstrap --engine copilot

Restart this readiness check after the secret is configured.
EOF
  exit 1
fi
gh aw secrets bootstrap --non-interactive --engine copilot

echo
echo "Creating workshop labels..."
"$root/scripts/create-labels.sh"

echo
echo "Seeding the duplicate fixture without starting the AI agent..."
"$root/scripts/create-test-issues.sh" --seed-duplicate-source

echo
echo "Compiling the starter workflow..."
gh aw compile

echo
echo "Readiness check complete."
echo "Do not complete the TODOs before the workshop."
git status --short
