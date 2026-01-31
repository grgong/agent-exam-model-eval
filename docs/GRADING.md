# Grading rubric

Total: 100 points.

## General (all tasks)

- Runnable checks (10): the grading checks can run; safe modes do not fail due to missing keys
- Code quality (10): focused diffs, clear naming, consistent style
- Deliverables (5): `REPORT.md` is clear; `SUBMISSION.patch` is readable/applicable

## T1 (35)

- `api_args` is preserved and forwarded via `build_chat_args()` (15)
- `release_date` handling is reasonable (validated/preserved, no regressions) (10)
- Errors are actionable and easy to locate (5)
- Checks pass (5)

## T2 (35)

- `--help` output is clear (5)
- `--list-models` output is machine-readable (TSV/CSV recommended) (10)
- `--dry-run` never calls any model API and works without keys (15)
- `--only` filtering is correct (5)

## T3 (30)

- Efficiency metric is correct and robust (divide-by-zero / missing values) (12)
- Pricing table shows the new column with correct formatting (8)
- App adds a new efficiency view without breaking existing plots (6)
- Checks pass (4)
