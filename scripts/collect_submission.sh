#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
attempt_name="${1:-}"
if [[ -z "${attempt_name}" ]]; then
  echo "Usage: bash scripts/collect_submission.sh <attempt_name>" >&2
  exit 2
fi

attempt_dir="${root_dir}/attempts/${attempt_name}"
repo_dir="${attempt_dir}/model-eval"

if [[ ! -d "${repo_dir}/.git" ]]; then
  echo "ERROR: attempt repo missing: ${repo_dir}" >&2
  exit 1
fi

if [[ ! -f "${attempt_dir}/REPORT.md" ]]; then
  echo "ERROR: missing ${attempt_dir}/REPORT.md" >&2
  exit 1
fi

(
  cd "${repo_dir}"
  git diff > "${attempt_dir}/SUBMISSION.patch"
)

echo "Wrote: ${attempt_dir}/SUBMISSION.patch"
echo "Report: ${attempt_dir}/REPORT.md"

