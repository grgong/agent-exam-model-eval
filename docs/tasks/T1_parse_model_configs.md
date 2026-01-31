# T1 — Fix YAML config propagation (35 pts)

File: `R/eval_functions.R`

## Background

Some models in `data/models.yaml` include `api_args:` (e.g., “thinking” configs). The code in `build_chat_args()` is intended to forward `config$api_args`, but `parse_model_configs()` currently drops it, causing those settings to silently do nothing.

## Task

Without changing the overall structure:

1) Fix `parse_model_configs()` so each model config includes `api_args` when present in YAML, and preserve `release_date` (validate `YYYY-MM-DD` format).
2) Ensure `build_chat_args()` correctly forwards `api_args` downstream (field exists and has the correct type).
3) Improve error messages (missing fields, invalid `release_date`, etc.).

## Acceptance

- `parse_model_configs("data/models.yaml")[["sonnet_4_thinking"]]$api_args` is non-NULL and has `thinking$type` and `thinking$budget_tokens` (values per YAML).
- The grader’s T1 checks pass.
