# Tasks (Background)

This file is optional background. Participants should follow `AGENTS.md`.

All tasks are completed in a working copy under `attempts/<name>/model-eval/`.

Expectations per task:
- Focused, minimal edits
- A short write-up in `attempts/<name>/REPORT.md` (what/why/what you ran)

## T1 (35 pts) — Fix YAML config propagation

Goal: fix YAML → runtime config propagation so `api_args` actually takes effect.

Details: `docs/tasks/T1_parse_model_configs.md`

## T2 (35 pts) — Add a safe CLI to `eval/run_eval.R`

Goal: add safe CLI argument parsing for `eval/run_eval.R` and ensure `--dry-run` cannot trigger any API calls (must work without keys).

Details: `docs/tasks/T2_run_eval_cli.md`

## T3 (30 pts) — Add “efficiency” metric to the Shiny app

Goal: add an “efficiency” metric (e.g., USD per correct) to the Shiny app, show it in the table, and add a dedicated view.

Details: `docs/tasks/T3_shiny_efficiency.md`
