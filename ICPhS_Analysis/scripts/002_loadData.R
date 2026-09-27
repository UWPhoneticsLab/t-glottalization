#----------------------------------------------------------------------------------------
# File: 002_loadData.R
# Project: t-glottalization
# Author: Mykel Brinkerhoff
# Date: 2026-09-15 (T)
# Description: What does this script do?
#   - Loads in the data and prepares it analysis
#
# Usage:
#   Rscript 002_loadData.R
#
# Notes:
#   - Ensure all required packages are installed.
#   - Modify the script as needed for your specific dataset and analysis requirements.
#----------------------------------------------------------------------------------------

icphs <- readr::read_csv(
  # Read in the file
  here::here(
    "ICPhs_Analysis",
    "data",
    "raw",
    "2027icphs_data.csv"
  )
) |>
  dplyr::filter(
    # Filter for the t-glottalization tokens that are valid for analysis
    icphs_analysis == "yes" & variable == "t_glottalization"
  ) |>
  dplyr::filter(
    # Remove the speakers that only produced t^h or creaky voice
    !(speaker_id %in% c("007", "014", "018"))
  ) |>
  dplyr::mutate(
    # Create variables for logistic regression
    glottal = dplyr::case_when(
      realization %in% c("glottal", "creaky") ~ 1,
      .default = 0
    ),
    stop = dplyr::case_when(
      realization == "creaky" ~ 0,
      .default = 1
    ),
    list = dplyr::case_when(
      reading_list %in% c("A1", "A2") ~ "A",
      reading_list %in% c("B1", "B2") ~ "B",
      reading_list == "C" ~ "C",
      reading_list == "D" ~ "D"
    )
  )

icphs <- icphs |>
  dplyr::mutate(
    # Factor the variables for treatment coding and analysis
    reading_list = factor(reading_list),
    list = factor(list),
    information_load = factor(
      information_load,
      levels = c("low", "high")
    ),
    speaker_id = factor(speaker_id),
    target_word = factor(target_word)
  )

# Sum coding the information load
(contrasts(icphs$information_load) <- contr.sum(2))

phono <- readr::read_csv(
  here::here(
    "ICPhS_Analysis",
    "data",
    "raw",
    "icphs_phonoenvironment.csv"
  )
)

icphs_comb <- icphs |>
  dplyr::left_join(phono) |>
  dplyr::mutate(
    phonetic_environment = factor(
      phonetic_environment,
      levels = c("V_N", "V_V", "N_V", "N_N", "R_V", "R_N")
    ),
    phono_environment = factor(
      phono_environment,
      levels = c("V_N", "N_N", "R_N")
    ),
    reading_list = factor(reading_list),
    list = factor(list),
    information_load = factor(
      information_load,
      levels = c("low", "high")
    ),
    speaker_id = factor(speaker_id),
    target_word = factor(target_word)
  ) |>
  dplyr::mutate(
    prenasal = dplyr::case_when(
      phonetic_environment %in% c("V_N", "N_N", "R_N") ~ 1,
      .default = 0
    )
  )


(contrasts(icphs_comb$information_load) <- contr.sum(2))
(contrasts(icphs_comb$phonetic_environment) <- contr.sum(6))
(contrasts(icphs_comb$phono_environment) <- contr.sum(3))
