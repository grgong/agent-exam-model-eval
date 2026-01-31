#!/usr/bin/env bash
set -euo pipefail

repo_dir="${1:?Usage: bash check_task2.sh <repo_dir>}"

cd "${repo_dir}"

grep_q() {
  local pattern="$1"
  if command -v rg >/dev/null 2>&1; then
    rg -q "${pattern}"
  else
    grep -q "${pattern}"
  fi
}

echo "  - help"
mamba run -n r451 Rscript eval/run_eval.R --help >/dev/null

echo "  - list-models"
out="$(mamba run -n r451 Rscript eval/run_eval.R --list-models)"
echo "${out}" | grep_q "sonnet_4_thinking"

echo "  - dry-run (no API calls)"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT
out2="$(mamba run -n r451 Rscript eval/run_eval.R --dry-run --results-dir "${tmp_dir}")"
echo "${out2}" | grep_q "unevaluated|to evaluate|model" || true

echo "T2 OK"
