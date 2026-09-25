#!/usr/bin/env bash
set -euo pipefail

readonly gh_aw_version="v0.88.8"

echo "Installing GitHub Agentic Workflows CLI ${gh_aw_version}..."
gh extension install github/gh-aw --pin "$gh_aw_version" --force

echo
gh aw --version
copilot --version
echo
echo "Codespace tools are installed."
echo "Authenticate GitHub CLI as your user before running readiness:"
cat <<'EOF'
unset GH_TOKEN GITHUB_TOKEN
gh auth login --hostname github.com --git-protocol https \
  --web --scopes repo,workflow,read:org
gh auth setup-git --hostname github.com
EOF
echo
echo "Complete PREWORK.md, then run ./scripts/workshop-readiness.sh."
