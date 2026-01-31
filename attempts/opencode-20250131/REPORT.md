# Exam Report — opencode-20250131

## Changes Made

### T1 (eval_functions.R)
- Added `release_date` validation (YYYY-MM-DD format) in `parse_model_configs()`
- Added `release_date` and `api_args` fields to the config list
- `build_chat_args()` already had support for `api_args`; now the data flows through correctly

### T2 (eval/run_eval.R)
- Added CLI argument parsing using base R `commandArgs()`
- Implemented `--help`, `--yaml`, `--results-dir`, `--list-models`, `--dry-run`, `--only` flags
- `--list-models` and `--dry-run` exit before any API calls (no key needed)
- `--only` filters model_configs before processing

### T3 (helpers.R, app.R)
- Added `usd_per_correct = price / correct` to `compute_summary_stats()` with `NA_real_` for zero correct
- Added `plot_efficiency()` function for cost-per-correct visualization
- Added "Efficiency" tab to the Shiny app between "Cost vs. Performance" and "Pricing Details"
- Added "Cost / Correct" column to the pricing table

## Not Run

No code was executed during this exam. All changes were made by reading the source files and writing modifications.
