#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${GITHUB_TOKEN+x}" ]]; then
  unset GITHUB_TOKEN
fi

if ! gh auth status --active --hostname github.com >/dev/null 2>&1; then
  cat >&2 <<'EOF'
GitHub Codespaces sets GITHUB_TOKEN, which takes precedence over stored GitHub
CLI user authentication. Workshop repository administration requires user
authentication.

unset GH_TOKEN GITHUB_TOKEN
gh auth login --hostname github.com --git-protocol https \
  --web --scopes repo,workflow,read:org
gh auth setup-git --hostname github.com
EOF
  exit 1
fi

if ! gh auth setup-git --hostname github.com; then
  cat >&2 <<'EOF'
GitHub CLI is authenticated, but Git could not be configured for HTTPS.

unset GH_TOKEN GITHUB_TOKEN
gh auth setup-git --hostname github.com
EOF
  exit 1
fi
