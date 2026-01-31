args <- commandArgs(trailingOnly = TRUE)
repo_dir <- args[[1]]
if (is.na(repo_dir) || repo_dir == "") {
  stop("Usage: Rscript check_task1.R <repo_dir>")
}

repo_dir <- normalizePath(repo_dir)
eval_functions <- file.path(repo_dir, "R", "eval_functions.R")
yaml_path <- file.path(repo_dir, "data", "models.yaml")

if (!file.exists(eval_functions)) stop("Missing: ", eval_functions)
if (!file.exists(yaml_path)) stop("Missing: ", yaml_path)

source(eval_functions, local = TRUE)

configs <- parse_model_configs(yaml_path)

if (!("sonnet_4_thinking" %in% names(configs))) {
  stop("Expected model_id 'sonnet_4_thinking' not found in parsed configs")
}

cfg <- configs[["sonnet_4_thinking"]]

if (is.null(cfg$api_args)) stop("Expected cfg$api_args to be present (non-NULL)")
if (is.null(cfg$api_args$thinking)) stop("Expected cfg$api_args$thinking to be present")
if (is.null(cfg$api_args$thinking$type)) stop("Expected cfg$api_args$thinking$type to be present")
if (is.null(cfg$api_args$thinking$budget_tokens)) stop("Expected cfg$api_args$thinking$budget_tokens to be present")

if (is.null(cfg$release_date)) stop("Expected cfg$release_date to be present")

message("T1 OK")

