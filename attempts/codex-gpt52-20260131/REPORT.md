# Report

## Summary (5–15 lines)

- What you changed: (T1) `parse_model_configs()` now preserves `api_args` + `release_date` (validated) and `build_chat_args()` validates/passes `api_args`; (T2) `eval/run_eval.R` is now a base-R-argparse CLI with `--help/--list-models/--dry-run/--only`; (T3) added `usd_per_correct = price / correct` (safe for `correct==0`) plus an “Efficiency” tab + pricing-table column.
- Why: YAML `api_args` was being dropped so model settings silently did nothing; the eval runner needed non-API CLI modes; the Shiny app needed an efficiency metric view.
- How you verified (commands + results): No tests/evals were run; changes were done by reading/modifying files only (created attempt via `bash scripts/new_attempt.sh ...`, and generated patch via `bash scripts/collect_submission.sh ...`).

## Notes

- Any tradeoffs / known issues:
