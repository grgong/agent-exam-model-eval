# T3 — Add “efficiency” metric to the Shiny app (30 pts)

文件：`R/helpers.R`、`app.R`

## 目标

在 Shiny app 增加一个效率指标，推荐：

- `usd_per_correct = price / correct`

并在 UI 中展示：

- Pricing table 增加一列（例如 `Cost / Correct`）
- 新增一个 tab/plot 展示效率（例如 x=Cost/Correct, y=%Correct）

## 约束

- 要处理除零：当 `correct == 0` 时，`usd_per_correct` 不能是 `Inf`（建议设为 `NA_real_` 并在图/表中自然显示）。
- 不要破坏现有 `Performance` 与 `Cost vs. Performance` 两个图。

## 验收标准

- `compute_summary_stats()` 返回包含 `usd_per_correct` 的 tibble（或同义字段名，但需在表格中展示）。
- `app.R` 里新增一个与效率相关的 `nav_panel(...)` 和对应 `plotOutput(...)`。
- `../../scripts/run_checks.sh ...` 的 T3 检查通过。

