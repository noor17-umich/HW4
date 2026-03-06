# HW4

This repository contains my R work for **HW4**. The code in this repository completes the R parts of the assignment, mainly **Question 4** and **Question 5**.

## Repository Files

- `HW4_R_Code.R`  
  Main R script that contains all code for the assignment tasks in R.

- `preprint_growth.rda`  
  Data file used in Question 5. This file should be placed in the same folder as the R script before running the code.

- `Q4_lm_plot.png`  
  Output plot for the `lm` smoothing method.

- `Q4_glm_plot.png`  
  Output plot for the `glm` smoothing method.

- `Q4_gam_plot.png`  
  Output plot for the `gam` smoothing method.

- `Q5_preprint_counts.png`  
  Output plot for the preprint time series graph.

## Purpose of the Code

The script is designed to:

1. load required R libraries,
2. work with the `Cars93` dataset from the `MASS` package,
3. create three scatterplots with different smoothing methods,
4. load and clean the `preprint_growth` dataset,
5. filter selected preprint archives,
6. create a time series line graph,
7. save the generated figures as image files.

---

## Question 4 Explanation

Question 4 uses the `Cars93` dataset from the `MASS` package.

### Dataset
The following line loads the dataset:

```r
cars93 <- MASS::Cars93
```

This dataset contains information about different cars, including:

- `Price`
- `Fuel.tank.capacity`

The code uses:

- `Price` as the x-axis
- `Fuel.tank.capacity` as the y-axis

### What the code does

The script creates **three figures** using `ggplot2` with the same scatterplot but different smoothing methods:

- `lm` = linear model
- `glm` = generalized linear model
- `gam` = generalized additive model

Each figure includes:

- grey scatter points,
- a fitted smooth line,
- a shaded standard error area (`se = TRUE`),
- a custom title,
- a title color matching the line color,
- title font size set to 14,
- custom x-axis labels,
- custom y-axis label.

### Plot 1: lm

This plot uses:

```r
geom_smooth(se = TRUE, method = "lm", formula = y ~ x, color = "#8fe388")
```

This creates a straight fitted regression line with a shaded confidence band.

### Plot 2: glm

This plot uses:

```r
geom_smooth(se = TRUE, method = "glm", formula = y ~ x, color = "#fe8d6d")
```

This creates a generalized linear model smoothing line.

### Plot 3: gam

This plot uses:

```r
geom_smooth(se = TRUE, method = "gam", formula = y ~ s(x), color = "#7c6bea")
```

This creates a more flexible smooth curve using GAM.  
The formula `y ~ s(x)` is commonly used with GAM to create a smooth function of `x`.

### Output files for Question 4

The following files are saved automatically by the script:

- `Q4_lm_plot.png`
- `Q4_glm_plot.png`
- `Q4_gam_plot.png`

These are created with `ggsave()`.

---

## Question 5 Explanation

Question 5 uses the file:

```r
load("./preprint_growth.rda")
```

This loads the data frame `preprint_growth`.

### Step 1: Inspect the data

The code first displays the first few rows:

```r
print(head(preprint_growth))
```

This helps verify that the data loaded correctly.

### Step 2: Create `preprint_full`

The code creates a cleaned data frame called `preprint_full`:

```r
preprint_full <- preprint_growth %>%
  drop_na() %>%
  filter(count > 0, year(date) > 2004)
```

This does three things:

- removes rows with missing values,
- keeps rows where `count > 0`,
- keeps rows where the year is later than 2004.

### Step 3: Filter selected archives

The script then keeps only the two required archives:

```r
preprint_selected <- preprint_full %>%
  filter(archive %in% c("bioRxiv", "F1000Research"))
```

This creates a smaller data frame containing only:

- `bioRxiv`
- `F1000Research`

### Step 4: Draw the time series graph

The code uses `ggplot2` to create a line chart:

```r
ggplot(preprint_selected, aes(x = date, y = count, color = archive)) +
  geom_line(linewidth = 1)
```

The graph also includes:

- manual colors:
  - `bioRxiv` = `#7c6bea`
  - `F1000Research` = `#fe8d6d`
- x-axis starting from `2014-02-01`
- title: `Preprint Counts`
- legend placed on the right

### Output file for Question 5

The script saves the final graph as:

- `Q5_preprint_counts.png`

---

## Required Packages

The script uses the following packages:

```r
ggplot2
MASS
mgcv
dplyr
tidyr
lubridate
```

If they are not installed, run:

```r
install.packages(c("ggplot2", "MASS", "mgcv", "dplyr", "tidyr", "lubridate"))
```

Then load them in R with:

```r
library(ggplot2)
library(MASS)
library(mgcv)
library(dplyr)
library(tidyr)
library(lubridate)
```

---

## How to Run the Code

1. Download or clone this repository.
2. Open `HW4_R_Code.R` in RStudio.
3. Make sure `preprint_growth.rda` is in the same folder as the script.
4. Install the required packages if needed.
5. Run the script from top to bottom.

---

## Notes

- The code prints `head()` outputs so the results can be shown in the assignment PDF.
- The plots are saved as `.png` files for easy insertion into the final report.
- The script also prints `sessionInfo()` at the end for reproducibility.

## Author

Prepared for HW4 submission.
