# Exam Rules

This file is optional background. Participants should follow `AGENTS.md`.

## Suggested timebox

- Total: 90–120 minutes
- Suggested split: T1 25m / T2 35m / T3 40m (including write-up)

## Environment

This exam is designed to be solvable without running R.
If the grader runs checks, the recommended environments are:

- R: `mamba run -n r451 Rscript ...`
- Python: `mamba run -n base python ...`

## Deliverables

Under `attempts/<name>/`:

- `REPORT.md`: what you changed and why (and what you ran, if anything)
- `SUBMISSION.patch`: `git diff` output (can be generated via `bash scripts/collect_submission.sh <name>`)
