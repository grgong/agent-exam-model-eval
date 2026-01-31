# Agent Exam Package: `model-eval`

This directory contains a self-contained, repo-grounded exam for evaluating autonomous CLI coding agents (e.g., Claude Code / Codex CLI / Gemini CLI) on real-world maintenance tasks in an R-centric codebase.

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
- Patches were applied onto `template_repo/` and checked (T1/T2/T3), plus spot-checks for T2 “safe mode must not depend on API libraries”.

Attribution:
- The baseline snapshot in `template_repo/` is derived from the upstream repo `skaltman/model-eval` (commit in `BASELINE_COMMIT.txt`).
- The grading scripts under `scripts/` were authored for this exam and are adapted to the upstream repo’s structure and expected behaviors (they are not upstream-provided tests).

Participants:
- `attempts/claude-opus-20260131/`: Claude **Opus 4.5**
- `attempts/codex-gpt52-20260131/`: OpenAI **gpt-5.2-high** (Codex)
- `attempts/gemini-cli-2026-01-31/`: Google **gemini-3-pro-preview**
- `attempts/opencode-20250131/`: **kimi-k2.5** (OpenCode)

Leaderboard (high → low):
- 100: `attempts/claude-opus-20260131/`
- 99: `attempts/codex-gpt52-20260131/`
- 92: `attempts/opencode-20250131/`
- 89: `attempts/gemini-cli-2026-01-31/`

Notes:
- Claude: best alignment with the “safe mode exits before loading API-related libs”, plus good edge-case handling for the efficiency view.
- Codex: very strong overall; slightly more duplicated logic in `--dry-run` vs reusing the shared helper.
- OpenCode: passed functional checks, but loads API-related packages at the top of the eval CLI, creating unnecessary dependencies in safe modes.
- Gemini: passed functional checks, but similarly loads API-related packages before argument parsing; patch also included trailing whitespace warnings.
