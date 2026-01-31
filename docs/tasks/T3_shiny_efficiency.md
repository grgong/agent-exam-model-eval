# T3 — Add an “efficiency” metric to the Shiny app (30 pts)

Files: `R/helpers.R`, `app.R`

## Goal

Add an efficiency metric, recommended:

- `usd_per_correct = price / correct`

And expose it in the UI:

- Add a pricing table column (e.g., `Cost / Correct`)
- Add a new efficiency-focused tab/plot (e.g., x = Cost/Correct, y = %Correct)

## Constraints

- Handle divide-by-zero: when `correct == 0`, `usd_per_correct` must not be `Inf` (use `NA_real_` or similar).
- Do not break the existing `Performance` and `Cost vs. Performance` plots.

## Acceptance

- `compute_summary_stats()` returns a tibble containing `usd_per_correct` (or an equivalent field that is shown in the table).
- `app.R` adds an efficiency-related `nav_panel(...)` and a corresponding `plotOutput(...)`.
- The grader’s T3 checks pass.
