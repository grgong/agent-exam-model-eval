# T1 — Fix YAML config propagation (35 pts)

文件：`R/eval_functions.R`

## 背景

`data/models.yaml` 中部分模型带有 `api_args:`（例如 thinking 配置）。当前代码中 `build_chat_args()` 试图读取 `config$api_args`，但 `parse_model_configs()` 并没有把 YAML 的 `api_args` 放进 config，导致这些配置静默失效。

## 任务

在不改变整体结构的前提下：

1) 修复 `parse_model_configs()`：让每个 model config 包含 `api_args`（如果 YAML 里有），并保留 `release_date`（建议校验格式为 `YYYY-MM-DD`）。
2) 确保 `build_chat_args()` 能正确把 `api_args` 传给下游（当前已有逻辑，但要确保字段存在且类型正确）。
3) 让错误信息更可读（例如缺字段、release_date 格式非法时）。

## 验收标准

- `parse_model_configs("data/models.yaml")[["sonnet_4_thinking"]]$api_args` 非空，且能访问到 `thinking$type` 与 `thinking$budget_tokens`（具体值以 YAML 为准）。
- `../../scripts/run_checks.sh ...` 的 T1 检查通过。

