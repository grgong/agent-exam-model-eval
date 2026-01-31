# T2 — Add a safe CLI to `eval/run_eval.R` (35 pts)

File: `eval/run_eval.R`

## Goal

Turn `eval/run_eval.R` into a scriptable, safe CLI:

- With **no API keys**, `--help / --list-models / --dry-run` must still succeed (exit code 0).
- Only create `scorer_chat` and call `model_eval()` when actually running evaluations.

## Required flags

- `--help`: print usage and exit 0
- `--yaml <path>`: default `data/models.yaml`
- `--results-dir <path>`: default `results_rds`
- `--list-models`: print model list and exit 0 (TSV recommended; at least `model_id,name,provider,release_date,api_model_id`)
- `--dry-run`: print “models that would be evaluated” (based on `find_unevaluated_models()`) and exit 0
- `--only <id1,id2,...>`: only consider these models (still skip existing results unless you also implement `--overwrite`)

## Constraints

- Do not introduce new R package dependencies (use base R `commandArgs(trailingOnly=TRUE)` parsing).

## Acceptance

These should exit 0:

```bash
mamba run -n r451 Rscript eval/run_eval.R --help
mamba run -n r451 Rscript eval/run_eval.R --list-models
mamba run -n r451 Rscript eval/run_eval.R --dry-run --results-dir /tmp/somewhere
```

And the grader’s T2 checks pass.
