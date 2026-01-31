#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

attempt_name="${1:-}"
if [[ -z "${attempt_name}" ]]; then
  echo "Usage: bash scripts/new_attempt.sh <attempt_name>" >&2
  exit 2
fi

template_repo="${root_dir}/template_repo"
if [[ ! -d "${template_repo}/.git" ]]; then
  echo "ERROR: template_repo is missing or not a git repo: ${template_repo}" >&2
  echo "Ask the exam author to run the setup step that creates template_repo." >&2
  exit 1
fi

attempt_dir="${root_dir}/attempts/${attempt_name}"
repo_dir="${attempt_dir}/model-eval"

if [[ -e "${attempt_dir}" ]]; then
  echo "ERROR: attempt already exists: ${attempt_dir}" >&2
  exit 1
fi

mkdir -p "${attempt_dir}"
git clone --local "${template_repo}" "${repo_dir}" >/dev/null

cat > "${attempt_dir}/REPORT.md" <<'EOF'
# Report

## Summary (5–15 lines)

- What you changed:
- Why:
- How you verified (commands + results):

## Notes

- Any tradeoffs / known issues:
EOF

echo "Created: ${repo_dir}"
echo "Next:"
echo "  cd ${repo_dir}"
echo "  cat ../../docs/TASKS.md"

