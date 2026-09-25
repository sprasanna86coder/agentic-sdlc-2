#!/usr/bin/env bash
set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$root/scripts/ensure-user-gh-auth.sh"

create_issue() {
  local file="$1"
  local label="${2:-}"
  local title
  local body_file

  title="$(awk '/^## Title/{getline; getline; print; exit}' "$file")"
  body_file="$(mktemp)"
  awk 'found {print} /^## Body/ {found=1; getline}' "$file" > "$body_file"
  if [[ -n "$label" ]]; then
    gh issue create --title "$title" --body-file "$body_file" --label "$label"
  else
    gh issue create --title "$title" --body-file "$body_file"
  fi
  rm -f "$body_file"
}

usage() {
  cat <<'EOF'
Usage:
  ./scripts/create-test-issues.sh A
  ./scripts/create-test-issues.sh B
  ./scripts/create-test-issues.sh C
  ./scripts/create-test-issues.sh --seed-duplicate-source

Create only the scenario assigned by the facilitator. Scenario C requires the
duplicate source to be seeded during pre-work.
EOF
}

if [[ $# -ne 1 ]]; then
  usage
  exit 2
fi

case "$1" in
  --seed-duplicate-source)
    if gh issue list --state all --search \
      '"CLI login loops after the browser authorization succeeds" in:title' \
      --json title --jq '.[].title' |
      grep -Fxq "CLI login loops after the browser authorization succeeds"; then
      echo "Duplicate source issue already exists."
    else
      echo "Seeding the duplicate source issue..."
      create_issue "$root/test-cases/00-duplicate-source.md" "workshop-fixture"
    fi
    ;;
  A|a)
    echo "Creating scenario A: complete bug..."
    create_issue "$root/test-cases/01-complete-bug.md"
    ;;
  B|b)
    echo "Creating scenario B: incomplete bug..."
    create_issue "$root/test-cases/02-incomplete-bug.md"
    ;;
  C|c)
    if ! gh issue list --state all --search \
      '"CLI login loops after the browser authorization succeeds" in:title' \
      --json title --jq '.[].title' |
      grep -Fxq "CLI login loops after the browser authorization succeeds"; then
      echo "Scenario C requires the duplicate source issue." >&2
      echo "Run ./scripts/create-test-issues.sh --seed-duplicate-source first." >&2
      exit 1
    fi
    echo "Creating scenario C: likely duplicate..."
    create_issue "$root/test-cases/03-likely-duplicate.md"
    ;;
  *)
    usage
    exit 2
    ;;
esac

echo "Prepared issue is ready."
