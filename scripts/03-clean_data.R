#### Preamble ####
# Purpose: Cleans the raw plane data recorded by two observers..... [...UPDATE THIS...]
# Author: Rohan Alexander [...UPDATE THIS...]
# Date: 6 April 2023 [...UPDATE THIS...]
# Contact: rohan.alexander@utoronto.ca [...UPDATE THIS...]
# License: MIT
# Pre-requisites: [...UPDATE THIS...]
# Any other information needed? [...UPDATE THIS...]

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)
library(janitor)

#### Clean data ####
# Load the raw simulated data
raw_data <- read_csv("data/00-simulated_data/simulated_data.csv")

# Clean and transform the data
cleaned_data <- 
  raw_data |> 
  janitor::clean_names() |>  # Clean column names
  filter(sample_size > 0) |>  # Ensure valid sample sizes
  mutate(
    percentage = if_else(pct > 100, 100, pct),  # Cap percentages at 100
    party = case_when(  # Standardize party names
      party == "REP" ~ "Republican",
      party == "DEM" ~ "Democrat",
      TRUE ~ party
    )
  ) |> 
  rename(
    candidate_name = candidate,
    pollster_name = pollster
  ) |> 
  select(poll_id, pollster_name, methodology, transparency_score, state, party, 
         candidate_name, percentage, sample_size) |> 
  tidyr::drop_na()  # Drop rows with missing values

# Display the first few rows of the cleaned data
print(head(cleaned_data))

#### Save data ####
# Save the cleaned data to a CSV file
write_csv(cleaned_data, "data/02-analysis_data/analysis_data.csv")

