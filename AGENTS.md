# Participant Instructions (Agent Exam)

You are a CLI coding agent participating in an exam on the baseline repo snapshot in `template_repo/`.

Your job is to produce a patch and a short report for three tasks (T1/T2/T3).

## Hard rules

1) **Write code only. Do not run anything by default.**
   - This includes: tests, self-check scripts, building, running evaluations, starting Shiny, network access, or any API calls.
   - Only run commands if you can justify that it is strictly necessary to produce correct code.
   - If you do run anything non-trivial, record the exact commands and outputs in `attempts/<name>/REPORT.md`.

2) **The grader will validate your work later.**
   - Your deliverables must be complete, correctly placed, and reproducible from the patch.

## Allowed minimal execution (for producing deliverables)

You may execute:
- `bash scripts/new_attempt.sh <attempt_name>` (creates your working copy)
- `bash scripts/collect_submission.sh <attempt_name>` or `git diff` (produces `SUBMISSION.patch`)
- read-only inspection commands (`ls`, `cat`, `rg`, `find`, `git status`, etc.)

Anything beyond that is “not allowed by default”.

## Workspace layout

Do not modify `template_repo/` directly.

You should work under:
- `attempts/<attempt_name>/model-eval/` (your repo working copy)

You must deliver:
- `attempts/<attempt_name>/REPORT.md`
- `attempts/<attempt_name>/SUBMISSION.patch`

## Workflow (you execute this yourself)

1) Create your attempt:

```bash
bash scripts/new_attempt.sh <attempt_name>
```

2) Edit files in:

```bash
cd attempts/<attempt_name>/model-eval
```

3) Write your report in:

- `attempts/<attempt_name>/REPORT.md` (5–15 lines is enough)

4) Generate the submission patch:

```bash
bash scripts/collect_submission.sh <attempt_name>
```

## Tasks

All tasks are grounded in the existing repo structure. Make focused edits only.

### T1 (35 pts) — Fix YAML config propagation

Files:
- `R/eval_functions.R`
- `data/models.yaml` (read only; do not change YAML content)

Background:
`data/models.yaml` includes model entries that define `api_args:` (e.g., “thinking” configs). The code in `build_chat_args()` is intended to forward `config$api_args` downstream, but the YAML parser currently drops `api_args` (so the config silently does nothing).

Requirements:
- Fix `parse_model_configs()` so each model config **includes** `api_args` when present in YAML.
- Preserve `release_date` on the config; validate it is in `YYYY-MM-DD` form.
- Ensure error messages are actionable (missing required fields, invalid release_date).

Acceptance target (grader will check):
- `parse_model_configs("data/models.yaml")[["sonnet_4_thinking"]]$api_args$thinking$type` is present
- `...$budget_tokens` is present

### T2 (35 pts) — Add a safe CLI to `eval/run_eval.R`

File:
- `eval/run_eval.R`

Goal:
Turn the script into a safe, scriptable CLI.

Critical constraint:
- In **safe modes** (`--help`, `--list-models`, `--dry-run`), the script must **exit successfully without requiring API keys** and must not trigger any model calls.
- A strong implementation also avoids loading API-related packages (e.g., `ellmer`, `vitals`) before safe-mode exit.

Must support (base R arg parsing only; do not add new package dependencies):
- `--help` (exit 0)
- `--yaml <path>` (default `data/models.yaml`)
- `--results-dir <path>` (default `results_rds`)
- `--list-models` (print model table and exit 0; TSV recommended with at least `model_id,name,provider,release_date,api_model_id`)
- `--dry-run` (print IDs that would be evaluated, based on `find_unevaluated_models()`, then exit 0)
- `--only <id1,id2,...>` (limit to these model IDs; still skip existing results unless you also implement overwrite)

### T3 (30 pts) — Add an “efficiency” metric to the Shiny app

Files:
- `R/helpers.R`
- `app.R`

Goal:
Add an efficiency metric and a dedicated view.

Recommended metric:
- `usd_per_correct = price / correct`

Requirements:
- Handle divide-by-zero: when `correct == 0`, `usd_per_correct` must not be `Inf` (use `NA_real_` or similar).
- Add a column to the pricing table (e.g., `Cost / Correct`).
- Add an “Efficiency” tab/plot in the Shiny app, with output id `efficiency_plot`.
- Do not break existing “Performance” and “Cost vs. Performance” views.

## Reporting expectations

In `attempts/<attempt_name>/REPORT.md`:
- Summarize what you changed (T1/T2/T3)
- Explain why
- State whether you ran anything (default: “no”)
- If you did run something non-trivial, include commands and outputs

