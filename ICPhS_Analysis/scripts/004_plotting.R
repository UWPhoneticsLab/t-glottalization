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

t_productions <- icphs_comb |>
  dplyr::count(realization) |>
  dplyr::mutate(
    realization = dplyr::case_when(
      realization == "creaky" ~ "Creaky voice",
      realization == "glottal" ~ "Glottal stop",
      realization == "tʰ" ~ "Alveolar stop"
    ),
    realization = factor(
      realization,
      levels = c(
        "Glottal stop",
        "Creaky voice",
        "Alveolar stop"
      )
    )
  ) |>
  dplyr::mutate(
    percent = 100 * n / sum(n),
    percent_label = sprintf("%.1f%%", percent),
    count_label = sprintf("(%d tokens)", n)
  )

max_count <- max(t_productions$n)

offset_large <- 0.08 * max_count
offset_small <- 0.03 * max_count

t_productions |>
  ggplot2::ggplot(
    aes(
      x = realization,
      y = percent,
      fill = realization,
      colour = realization
    )
  ) +
  ggplot2::geom_col(width = 0.8) +
  ggplot2::geom_text(
    aes(y = percent + offset_large, label = percent_label),
    # size = 7,
    colour = "black",
    # fontface = "bold"
  ) +
  ggplot2::geom_text(
    aes(y = percent + offset_small, label = count_label),
    colour = "black",
    # size = 4.5
  ) +
  ggplot2::scale_y_continuous(
    expand = expansion(mult = c(0, 0.10))
  ) +
  ggokabeito::scale_fill_okabe_ito() +
  ggokabeito::scale_color_okabe_ito() +
  ggplot2::labs(
    x = "/t/ productions",
    y = "Percentage (%)"
  ) +
  ggplot2::theme_bw(base_size = 14) +
  ggplot2::theme(legend.position = "none") -> t


ggplot2::ggsave(
  filename = here::here(
    "ICPhS_Analysis",
    "output",
    "figs",
    "t_plots_annotated.eps"
  ),
  plot = t,
  width = 6,
  height = 4,
  units = "in",
  dpi = "print"
)
