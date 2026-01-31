# Exam Rules / 考试规则

## Timebox（建议）

- 总时长：90–120 分钟
- 建议分配：T1 25m / T2 35m / T3 40m（含自检与写报告）

## Allowed / Not allowed

- ✅ 允许：阅读仓库代码、运行本地脚本、自检、合理重构（不改变功能行为除非题目要求）
- ✅ 允许：新增少量辅助函数/脚本（若能提升可维护性/可测试性）
- ❌ 不建议：大范围重构/格式化全仓库、引入大量新依赖
- ❌ 不允许：把答案写在 `docs/` 中覆盖题目；删除关键文件导致题目无法运行

## Environment（重要）

本环境推荐使用 Conda/Mamba：

- R：`mamba run -n r451 Rscript ...`
- Python：`mamba run -n base python ...`

如题目脚本提供了运行命令，请优先使用题目脚本。

## Deliverables（交付物）

在 `attempts/<name>/` 下生成：

- `REPORT.md`：简要说明你做了什么、为什么这么做、如何验证
- `SUBMISSION.patch`：`git diff` 输出

可以通过 `bash scripts/collect_submission.sh <name>` 自动生成。

