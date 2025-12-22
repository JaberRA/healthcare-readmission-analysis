# ------------------------------------------------------------
# Project: Healthcare Readmission Risk Analysis
# File: eda_readmissions.R
#
# Goal:
# I’m loading the raw hospital encounter dataset and recreating
# key SQL findings in R so I can visualize trends and build a
# dashboard-friendly story around readmissions.
# ------------------------------------------------------------

# 1) Install + load packages (run install.packages only once)
# install.packages(c("tidyverse", "readr", "janitor", "scales"))

library(tidyverse)  # data manipulation + plotting
library(janitor)    # cleaning column names, tabyl summaries
library(scales)     # formatting percentages and numbers

# 2) Load the dataset
# IMPORTANT: update the path to wherever you saved diabetic_data.csv locally.
# Example on Windows: "C:/Users/YourName/Downloads/diabetic_data.csv"
file_path <- "C:/PATH/TO/YOUR/diabetic_data.csv"

diabetes <- readr::read_csv(file_path, show_col_types = FALSE)

# 3) Quick structure check
glimpse(diabetes)
nrow(diabetes)

# 4) Clean column names (makes coding easier)
diabetes <- diabetes %>% janitor::clean_names()

# 5) Basic readmission distribution (matches what we did in SQL)
readmit_summary <- diabetes %>%
  count(readmitted) %>%
  mutate(pct = round(100 * n / sum(n), 2)) %>%
  arrange(desc(n))

readmit_summary

# 6) 30-day readmission KPI
readmit_30day_rate <- diabetes %>%
  summarise(rate_30day = round(100 * mean(readmitted == "<30", na.rm = TRUE), 2))

readmit_30day_rate

# 7) Readmission rate by age group
age_risk <- diabetes %>%
  group_by(age) %>%
  summarise(
    encounters = n(),
    readmit_30day_pct = round(100 * mean(readmitted == "<30", na.rm = TRUE), 2)
  ) %>%
  arrange(age)

age_risk

# 8) Readmission rate by length of stay
los_risk <- diabetes %>%
  group_by(time_in_hospital) %>%
  summarise(
    encounters = n(),
    readmit_30day_pct = round(100 * mean(readmitted == "<30", na.rm = TRUE), 2)
  ) %>%
  arrange(time_in_hospital)

los_risk

# 9) Medication burden buckets
med_risk <- diabetes %>%
  mutate(
    medication_bucket = case_when(
      num_medications >= 0  & num_medications <= 5  ~ "0–5",
      num_medications >= 6  & num_medications <= 10 ~ "6–10",
      num_medications >= 11 & num_medications <= 15 ~ "11–15",
      num_medications >= 16 & num_medications <= 20 ~ "16–20",
      TRUE ~ "21+"
    )
  ) %>%
  group_by(medication_bucket) %>%
  summarise(
    encounters = n(),
    readmit_30day_pct = round(100 * mean(readmitted == "<30", na.rm = TRUE), 2)
  ) %>%
  arrange(desc(encounters))

med_risk

# 10) High-risk patient profiles (same logic as SQL)
high_risk_profiles <- diabetes %>%
  mutate(
    medication_bucket = case_when(
      num_medications >= 0  & num_medications <= 5  ~ "0–5",
      num_medications >= 6  & num_medications <= 10 ~ "6–10",
      num_medications >= 11 & num_medications <= 15 ~ "11–15",
      num_medications >= 16 & num_medications <= 20 ~ "16–20",
      TRUE ~ "21+"
    )
  ) %>%
  group_by(age, medication_bucket) %>%
  summarise(
    avg_length_of_stay = mean(time_in_hospital, na.rm = TRUE),
    encounters = n(),
    readmit_30day_pct = round(100 * mean(readmitted == "<30", na.rm = TRUE), 2),
    .groups = "drop"
  ) %>%
  filter(encounters >= 500) %>%
  arrange(desc(readmit_30day_pct)) %>%
  slice_head(n = 5)

high_risk_profiles
