args <- commandArgs(trailingOnly = TRUE)
repo_dir <- args[[1]]
if (is.na(repo_dir) || repo_dir == "") {
  stop("Usage: Rscript check_task3.R <repo_dir>")
}

repo_dir <- normalizePath(repo_dir)

helpers <- file.path(repo_dir, "R", "helpers.R")
app_r <- file.path(repo_dir, "app.R")
data_rds <- file.path(repo_dir, "data", "data_combined.rds")

if (!file.exists(helpers)) stop("Missing: ", helpers)
if (!file.exists(app_r)) stop("Missing: ", app_r)
if (!file.exists(data_rds)) stop("Missing: ", data_rds)

source(helpers, local = TRUE)

app_data <- readr::read_rds(data_rds)
eval_data <- app_data$eval_data
cost_data <- app_data$cost_data
model_info <- app_data$model_info

selected <- head(unique(eval_data$model_join), 2)
if (length(selected) < 1) stop("No models found in eval_data")

summary <- compute_summary_stats(eval_data, cost_data, selected, model_info)

if (!("usd_per_correct" %in% names(summary))) {
  stop("Expected column 'usd_per_correct' in compute_summary_stats() output")
}

if (!is.numeric(summary$usd_per_correct)) {
  stop("'usd_per_correct' must be numeric")
}

tbl <- create_pricing_table(summary, model_info)
if (!inherits(tbl, "gt_tbl")) stop("Expected create_pricing_table() to return a gt table")

app_text <- readLines(app_r, warn = FALSE)
has_eff_tab <- any(grepl("Efficiency", app_text, fixed = TRUE)) ||
  any(grepl("efficien", app_text, ignore.case = TRUE))
if (!has_eff_tab) stop("Expected an Efficiency-related UI addition in app.R")

has_output <- any(grepl("efficiency_plot", app_text, fixed = TRUE))
if (!has_output) stop("Expected plotOutput/renderPlot id 'efficiency_plot' in app.R")

message("T3 OK")

