# Agent Exam Package: `agent-exam-model-eval`

An “agent exam” built from a real R codebase benchmark, designed to evaluate autonomous CLI coding agents on repo navigation, safe changes, and Shiny feature work.

## Upstream benchmark

- Blog context: [https://posit.co/blog/r-llm-evaluation-03/](https://posit.co/blog/r-llm-evaluation-03/)
- Upstream repository: [https://github.com/skaltman/model-eval](https://github.com/skaltman/model-eval)

## What this repo contains

- `template_repo/`: a frozen baseline snapshot of the upstream repo used for grading
- `BASELINE_COMMIT.txt`: the upstream commit hash of the snapshot
- `AGENTS.md`: participant instructions (tasks, constraints, deliverables)
- `scripts/`: grading/check utilities used by the reviewer
- `attempts/`: collected submissions (`REPORT.md` + `SUBMISSION.patch`) for each participant
- `docs/`: optional background and rubric (not required for participants)

## How grading works

- Apply `attempts/<name>/SUBMISSION.patch` onto `template_repo/`
- Run automated checks via `scripts/run_checks.sh` (T1/T2/T3)
- Manually spot-check the most important constraint: **T2 safe modes must not trigger any API calls and should not require API keys**

Note: safe modes are ideally implemented so they also avoid importing API-related packages (e.g., `ellmer`, `vitals`) before exiting, keeping `--help/--list-models/--dry-run` lightweight and dependency-tolerant.

## Attribution

- `template_repo/` is derived from `skaltman/model-eval` (commit in `BASELINE_COMMIT.txt`).
- `scripts/` were authored for this exam and adapted to the upstream repo’s structure and expected behaviors (they are not upstream-provided tests).

## Results (2026-01-31)

Participants:
- `attempts/claude-opus-20260131/`: Claude Code — **Opus 4.5**
- `attempts/codex-gpt52-20260131/`: Codex CLI — **gpt-5.2-high**
- `attempts/gemini-cli-2026-01-31/`: Gemini CLI — **gemini-3-pro-preview**
- `attempts/opencode-20250131/`: OpenCode — **kimi-k2.5**

Leaderboard:

| Rank | Attempt | Agent/model | Score |
|---:|---|---|---:|
| 1 | `attempts/claude-opus-20260131/` | Claude Code/Opus 4.5 | 100 |
| 2 | `attempts/codex-gpt52-20260131/` | Codex CLI/gpt-5.2-high | 99 |
| 3 | `attempts/opencode-20250131/` | OpenCode/kimi-k2.5 | 92 |
| 4 | `attempts/gemini-cli-2026-01-31/` | Gemini CLI/gemini-3-pro-preview | 89 |

Notes:
- **Claude Code (100)**: Best alignment with T2 safe-mode expectations (early exit before importing API-related packages) and strong T3 edge-case handling (no “correct” models case).
- **Codex CLI (99)**: Strong overall and stricter validation in T1; minor deduction for re-implementing unevaluated-model detection in `--dry-run` rather than reusing `find_unevaluated_models()`.
- **OpenCode (92)**: Functional checks pass, but T2 imports API-related packages at top-level, making safe modes unnecessarily depend on those packages.
- **Gemini CLI (89)**: Similar safe-mode dependency issue as OpenCode; submission patch also triggers trailing whitespace warnings on apply (`attempts/gemini-cli-2026-01-31/SUBMISSION.patch`).
