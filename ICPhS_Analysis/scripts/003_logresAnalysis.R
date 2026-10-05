#----------------------------------------------------------------------------------------
# File: .R
# Project:
# Author: Mykel Brinkerhoff
# Date: YYYY-MM-DD (M-Su)
# Description: What does this script do?
#
# Usage:
#   Rscript .R
#
# Notes:
#   - Ensure all required packages are installed.
#   - Modify the script as needed for your specific dataset and analysis requirements.
#----------------------------------------------------------------------------------------

glottal_modal <- lme4::glmer(
  formula = glottal ~ information_load + phono_environment + (1 | speaker_id),
  data = icphs_comb,
  family = binomial
)

glottal_modal_2 <- glm(
  formula = glottal ~ information_load + phono_environment,
  data = icphs_comb,
  family = binomial
)

summary(glottal_modal)
summary(glottal_modal_2)
anova(glottal_modal, glottal_modal_2)

stop_modal <- lme4::glmer(
  formula = stop ~ information_load +
    phono_environment +
    (1 | speaker_id),
  data = icphs_comb,
  family = binomial
)

summary(stop_modal)

glottal_envi <- lme4::glmer(
  glottal ~ phono_environment +
    (1 | speaker_id),
  data = icphs_comb,
  family = binomial
)

summary(glottal_envi)

# Estimated marginal means

glottal_phono_emmeans <- emmeans::emmeans(
  glottal_modal,
  ~phono_environment,
  type = "response"
)

glottal_phono_emmeans

glottal_load_emmeans <- emmeans::emmeans(
  glottal_modal,
  ~information_load,
  type = "response"
)
glottal_load_emmeans

glottal_load_contrasts <- glottal_load_emmeans |>
  pairs() |>
  summary(
    infer = c(TRUE, TRUE),
    type = "response"
  )
glottal_load_contrasts

glottal_load_emmeans |>
  emmeans::contrast(
    method = "revpairwise"
  ) |>
  summary(
    infer = c(TRUE, TRUE),
    type = "response"
  )

glottal_phono_contrasts <- emmeans::emmeans(
  glottal_modal,
  ~phono_environment
) |>
  pairs() |>
  summary(
    infer = c(TRUE, TRUE),
    type = "response"
  )

glottal_phono_contrasts

g_comb_emm <- emmeans::emmeans(
  glottal_modal,
  ~ information_load + phono_environment
) |>
  pairs() |>
  summary(
    infer = c(TRUE, TRUE),
    type = "response"
  )

g_comb_emm

# Pre-syllabic nasal

prenasal_model <- lme4::glmer(
  prenasal ~ information_load + (1 | speaker_id),
  data = icphs_comb,
  family = binomial
)


prenasal_contrast <- emmeans::emmeans(
  prenasal_model,
  ~information_load
) |>
  emmeans::contrast(
    method = "revpairwise"
  ) |>
  summary(
    infer = c(TRUE, TRUE),
    type = "response"
  )

prenasal_contrast

prenasal_contrast2 <- emmeans::emmeans(
  prenasal_model,
  ~information_load
) |>
  pairs() |>
  summary(
    infer = c(TRUE, TRUE),
    type = "response"
  )

prenasal_contrast2

prenasal_emm <- emmeans::emmeans(
  prenasal_model,
  ~information_load,
  type = "response"
) |>
  as.data.frame()

prenasal_emm

prenasal_emm |>
  as.data.frame() |>
  dplyr::transmute(
    information_load,
    probability = prob,
    CI_lower = asymp.LCL,
    CI_upper = asymp.UCL
  ) |>
  dplyr::mutate(
    dplyr::across(
      probability:CI_upper,
      ~ .x * 100
    )
  )
