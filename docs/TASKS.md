# Tasks / 题目

在 `attempts/<name>/model-eval/`（仓库副本）内完成以下 3 题。

每题都应该做到：
- 改动小而精确
- 通过 `../../scripts/run_checks.sh` 自检
- 在 `attempts/<name>/REPORT.md` 里写 5–15 行说明（重点：决策与验证）

## T1 (35 pts) — Fix YAML config propagation

目标：修复并增强 `R/eval_functions.R` 中 YAML → 运行参数的传递，确保 `api_args` 等配置真正生效。

详情：`docs/tasks/T1_parse_model_configs.md`

## T2 (35 pts) — Add a safe CLI to `eval/run_eval.R`

目标：为 `eval/run_eval.R` 增加命令行参数解析，支持 `--help / --list-models / --dry-run / --only`，并确保 `--dry-run` 不会触发任何 API 调用（即使没有 key 也能跑）。

详情：`docs/tasks/T2_run_eval_cli.md`

## T3 (30 pts) — Add “efficiency” metric to the Shiny app

目标：在 Shiny app 增加一个“效率”指标（如 `USD per correct`），在表格中展示，并新增一个对应的图/Tab。

详情：`docs/tasks/T3_shiny_efficiency.md`

