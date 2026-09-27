#----------------------------------------------------------------------------------------
# File: 001_startHere.R
# Project:
# Author: Mykel Brinkerhoff
# Date: 2026-09-15 (T)
# Description: What does this script do?
#     - Load in the packages needed for the analysis
#     - make sure the enviornment is ready to go
#
# Usage:
#   Rscript 001_startHere.R
#
# Notes:
#   - Ensure all required packages are installed.
#   - Modify the script as needed for your specific dataset and analysis requirements.
#----------------------------------------------------------------------------------------

# Install the packages
# pkgs <- c(
#   "renv",
#   "dplyr",
#   "tidyr",
#   "readr",
#   "here",
#   "ggplot2",
#   "ggokabeito",
#   "ggpubr",
#   "lme4",
#   "lmerTest"
#   "broom",
#   "emmeans"
# )

# renv::install(pkgs)

# Data cleaning/plotting packages
library(renv)
library(dplyr)
library(tidyr)
library(readr)
library(here)
library(ggplot2)
library(ggokabeito)
library(ggpubr)

# Data analysis
library(lme4)
# library(lmerTest)
# library(broom)
library(emmeans)

# renv::snapshot()
renv::restore()
