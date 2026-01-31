#!/usr/bin/env bash
set -euo pipefail

root_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

repo_dir="${1:-}"
if [[ -z "${repo_dir}" ]]; then
  echo "Usage: bash scripts/run_checks.sh <path_to_attempt_repo>" >&2
  exit 2
fi

repo_dir="$(cd "${repo_dir}" && pwd)"

echo "[checks] repo=${repo_dir}"

echo "[checks] T1"
mamba run -n r451 Rscript "${root_dir}/scripts/check_task1.R" "${repo_dir}"

echo "[checks] T2"
bash "${root_dir}/scripts/check_task2.sh" "${repo_dir}"

echo "[checks] T3"
mamba run -n r451 Rscript "${root_dir}/scripts/check_task3.R" "${repo_dir}"

echo "[checks] OK"

