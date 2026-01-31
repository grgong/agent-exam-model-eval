# T2 — Add a safe CLI to `eval/run_eval.R` (35 pts)

文件：`eval/run_eval.R`

## 目标

把 `eval/run_eval.R` 变成一个可脚本化、安全的 CLI：

- 在没有任何 API key 的情况下，`--help / --list-models / --dry-run` 也必须能运行成功（退出码 0）。
- 只有在真正需要跑模型时才创建 `scorer_chat` 并调用 `model_eval()`。

## 必须支持的参数

- `--help`：打印用法并退出 0
- `--yaml <path>`：默认 `data/models.yaml`
- `--results-dir <path>`：默认 `results_rds`
- `--list-models`：打印模型列表并退出 0（建议 TSV，至少包含 `model_id,name,provider,release_date,api_model_id`）
- `--dry-run`：打印“将要评估的模型 IDs”（基于 `find_unevaluated_models()`）并退出 0
- `--only <id1,id2,...>`：只考虑这些模型（仍然要跳过已有结果文件，除非你额外实现 `--overwrite`）

## 约束

- 不要引入新 R 包依赖（用 base R 解析 `commandArgs(trailingOnly=TRUE)` 即可）。

## 验收标准

以下命令都应 exit 0：

```bash
mamba run -n r451 Rscript eval/run_eval.R --help
mamba run -n r451 Rscript eval/run_eval.R --list-models
mamba run -n r451 Rscript eval/run_eval.R --dry-run --results-dir /tmp/somewhere
```

并且 `../../scripts/run_checks.sh ...` 的 T2 检查通过。

