# Agent Exam Package: `model-eval`

This directory contains a self-contained, repo-grounded exam for evaluating autonomous CLI coding agents (e.g., Claude Code / Codex CLI / Gemini CLI) on real-world maintenance tasks in an R-centric codebase.

## Origin

This exam is derived from a public benchmark published by Posit in the “Which LLM writes the best R code?” blog series:
- Blog: [https://posit.co/blog/r-llm-evaluation-03/](https://posit.co/blog/r-llm-evaluation-03/)
- Upstream repo: [https://github.com/skaltman/model-eval](https://github.com/skaltman/model-eval)

## About this repo

This repository packages that benchmark into an “agent exam” format:
- A frozen baseline snapshot (`template_repo/`) plus the baseline commit (`BASELINE_COMMIT.txt`)
- Participant instructions (`AGENTS.md`) and grading utilities (`scripts/`)
- Collected submissions under `attempts/` and a written results summary in this README

## Purpose

- Compare agents on **code reading**, **surgical edits**, **safe CLI design**, and **Shiny app feature work**.
- Produce submissions that can be **reviewed and scored offline** against a fixed baseline snapshot.

## Design

**Baseline snapshot**
- The exam is anchored to `template_repo/` (a git clone of the repo state at exam creation time).
- The exact baseline commit is recorded in `BASELINE_COMMIT.txt`.

**Task philosophy**
- All tasks are “write-code-only”: participants should not need to run R or call any APIs to complete them.
- Validation is performed by the grader after submission by applying patches to `template_repo/`.

## Contents

- `AGENTS.md`: participant instructions (what to change, constraints, deliverables)
- `template_repo/`: baseline repo snapshot used for grading
- `attempts/<name>/`: each participant’s deliverables (`REPORT.md`, `SUBMISSION.patch`)
- `docs/`: extra background/rubric (not required for participants)
- `scripts/`: utilities for creating attempts and collecting submissions

## Grading approach

- Apply `attempts/<name>/SUBMISSION.patch` onto `template_repo/`
- Run the provided checks and do a short manual review of key constraints (especially “safe mode” behavior in the eval CLI)

## Results (2026-01-31)

Method:
- Each `attempts/<name>/SUBMISSION.patch` was applied onto `template_repo/`.
- Automated checks were run via `scripts/run_checks.sh`:
  - T1: `scripts/check_task1.R`
  - T2: `scripts/check_task2.sh`
  - T3: `scripts/check_task3.R`
- Manual review focused on T2 “safe mode” robustness:
  - In safe modes (`--help`, `--list-models`, `--dry-run`), the script should exit successfully without requiring API keys.
  - Preferably, safe modes should also avoid importing API-related packages (e.g., `ellmer`, `vitals`) before exiting, so that help/list/dry-run do not depend on those packages being installed.

Attribution:
- The baseline snapshot in `template_repo/` is derived from the upstream repo `skaltman/model-eval` (commit in `BASELINE_COMMIT.txt`).
- The grading scripts under `scripts/` were authored for this exam and are adapted to the upstream repo’s structure and expected behaviors (they are not upstream-provided tests).

Participants:
- `attempts/claude-opus-20260131/`: Claude Code — **Opus 4.5**
- `attempts/codex-gpt52-20260131/`: Codex CLI — **gpt-5.2-high**
- `attempts/gemini-cli-2026-01-31/`: Gemini CLI — **gemini-3-pro-preview**
- `attempts/opencode-20250131/`: OpenCode — **kimi-k2.5**

Leaderboard (high → low):
- 100: `attempts/claude-opus-20260131/`
- 99: `attempts/codex-gpt52-20260131/`
- 92: `attempts/opencode-20250131/`
- 89: `attempts/gemini-cli-2026-01-31/`

Detailed notes:

### `attempts/claude-opus-20260131/` (Score: 100)

- T1: Preserves `api_args` and `release_date` in `parse_model_configs()`, with `YYYY-MM-DD` validation.
- T2: Implements CLI parsing first and exits early in safe modes before importing API-related packages; safe modes do not require keys.
- T3: Adds `usd_per_correct` with safe divide-by-zero handling, adds a pricing column, and adds an Efficiency view. Also handles the edge case where there are no models with any correct answers.

### `attempts/codex-gpt52-20260131/` (Score: 99)

- T1: Strong validation (e.g., `release_date` is both format-checked and date-parsed; `api_args` structure validated).
- T2: Clean separation of safe modes vs full evaluation; `--only` validation is strict and clear; safe modes do not require keys.
- Deduction: In `--dry-run`, it re-implements “unevaluated model” detection by scanning `results_dir` rather than directly reusing the shared helper (`find_unevaluated_models()`). Functionally correct, but slightly higher drift/maintenance risk.

### `attempts/opencode-20250131/` (Score: 92)

- Automated checks pass for T1/T2/T3.
- Deduction: `eval/run_eval.R` imports API-related packages at the top-level (before argument parsing), which makes safe modes unnecessarily depend on those packages being installed.

### `attempts/gemini-cli-2026-01-31/` (Score: 89)

- Automated checks pass for T1/T2/T3.
- Deduction: Same safe-mode dependency issue as OpenCode (API-related packages imported before argument parsing).
- Deduction: Submission patch includes trailing whitespace warnings on apply (see `attempts/gemini-cli-2026-01-31/SUBMISSION.patch`).
