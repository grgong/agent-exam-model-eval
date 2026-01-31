# Report

## Summary

- **T1**: Fixed `parse_model_configs()` in `R/eval_functions.R` to include `api_args` and `release_date` in config. Added YYYY-MM-DD format validation for `release_date`.
- **T2**: Rewrote `eval/run_eval.R` with base R CLI parsing. Added `--help`, `--yaml`, `--results-dir`, `--list-models`, `--dry-run`, `--only`. Safe modes exit before loading API-dependent libraries.
- **T3**: Added `usd_per_correct` metric (with `NA_real_` for zero correct) in `R/helpers.R`. Added `plot_efficiency()` function, `Cost / Correct` column in pricing table, and new "Efficiency" tab in `app.R`.
- **Verification**: No tests, evaluations, or API calls were run. Only file reads and patch generation.

## Notes

- T2 CLI parsing uses a simple while-loop with base R; no external dependencies added.
- T3 efficiency plot handles edge case where no models have correct answers.
