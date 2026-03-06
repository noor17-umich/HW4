# HW4 - R Code
# This script covers Question 4 and Question 5 from your assignment.


# ==============================
# SETUP
# ==============================
# Install packages once if needed:
# install.packages(c("ggplot2", "MASS", "mgcv", "dplyr", "tidyr", "lubridate", "readr"))

library(ggplot2)
library(MASS)
library(mgcv)
library(dplyr)
library(tidyr)
library(lubridate)

# ==============================
# QUESTION 4
# ==============================
# Use lm, glm, and gam methods in geom_smooth()
# Add titles and match title colors with line colors
# Set title font size to 14

cars93 <- MASS::Cars93

# Show the first few rows
print(head(cars93))

# ---- Figure 1: lm ----
p_lm <- ggplot(cars93, aes(x = Price, y = Fuel.tank.capacity)) +
  geom_point(color = "grey60") +
  geom_smooth(se = TRUE, method = "lm", formula = y ~ x, color = "#8fe388") +
  scale_x_continuous(
    name = "price (USD)",
    breaks = c(20, 40, 60),
    labels = c("$20,000", "$40,000", "$60,000")
  ) +
  scale_y_continuous(name = "fuel-tank capacity\n(US gallons)") +
  labs(title = "Smoothing Method: lm") +
  theme(plot.title = element_text(size = 14, color = "#8fe388"))

print(p_lm)

ggsave("Q4_lm_plot.png", plot = p_lm, width = 8, height = 5, dpi = 300)

# ---- Figure 2: glm ----
p_glm <- ggplot(cars93, aes(x = Price, y = Fuel.tank.capacity)) +
  geom_point(color = "grey60") +
  geom_smooth(se = TRUE, method = "glm", formula = y ~ x, color = "#fe8d6d") +
  scale_x_continuous(
    name = "price (USD)",
    breaks = c(20, 40, 60),
    labels = c("$20,000", "$40,000", "$60,000")
  ) +
  scale_y_continuous(name = "fuel-tank capacity\n(US gallons)") +
  labs(title = "Smoothing Method: glm") +
  theme(plot.title = element_text(size = 14, color = "#fe8d6d"))

print(p_glm)

ggsave("Q4_glm_plot.png", plot = p_glm, width = 8, height = 5, dpi = 300)

# ---- Figure 3: gam ----
# Using y ~ s(x) is the standard smooth formula for GAM
p_gam <- ggplot(cars93, aes(x = Price, y = Fuel.tank.capacity)) +
  geom_point(color = "grey60") +
  geom_smooth(se = TRUE, method = "gam", formula = y ~ s(x), color = "#7c6bea") +
  scale_x_continuous(
    name = "price (USD)",
    breaks = c(20, 40, 60),
    labels = c("$20,000", "$40,000", "$60,000")
  ) +
  scale_y_continuous(name = "fuel-tank capacity\n(US gallons)") +
  labs(title = "Smoothing Method: gam") +
  theme(plot.title = element_text(size = 14, color = "#7c6bea"))

print(p_gam)

ggsave("Q4_gam_plot.png", plot = p_gam, width = 8, height = 5, dpi = 300)

# ==============================
# QUESTION 5
# ==============================
# Make sure preprint_growth.rda is in your working directory.
# You can check your working directory with: getwd()


load("./preprint_growth.rda")

# Show the first few rows
print(head(preprint_growth))

# (a) Create preprint_full with no missing values, count > 0, and year later than 2004
preprint_full <- preprint_growth %>%
  drop_na() %>%
  filter(count > 0, year(date) > 2004)

print(head(preprint_full))

# (b) Filter only bioRxiv and F1000Research
preprint_selected <- preprint_full %>%
  filter(archive %in% c("bioRxiv", "F1000Research"))

print(head(preprint_selected))

# (c), (d), (e), (f) Draw the line graph
p_preprint <- ggplot(preprint_selected, aes(x = date, y = count, color = archive)) +
  geom_line(linewidth = 1) +
  scale_color_manual(values = c("bioRxiv" = "#7c6bea", "F1000Research" = "#fe8d6d")) +
  scale_x_date(
    name = "year",
    limits = c(as.Date("2014-02-01"), max(preprint_selected$date, na.rm = TRUE))
  ) +
  labs(
    title = "Preprint Counts",
    y = "count",
    color = "archive"
  ) +
  theme(legend.position = "right")

print(p_preprint)

ggsave("Q5_preprint_counts.png", plot = p_preprint, width = 9, height = 5, dpi = 300)


print(sessionInfo())
