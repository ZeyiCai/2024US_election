#### Preamble ####
# Purpose: Simulates a dataset of US electoral divisions, including the
# state, sample size, and candidate support for each division.
# Author:
# Date: 20 October 2024
# License: MIT
# Pre-requisites: The `tidyverse` package must be installed
# Any other information needed? Make sure you are in the `starter_folder` rproj

#### Workspace setup ####
# Load necessary libraries
library(tidyverse)

# Set seed for reproducibility
set.seed(123)

# Define parameters
num_polls <- 100  # Number of polls to simulate
pollsters <- c("ActiVote", "TIPP Insights", "YouGov", "Ipsos")
methodologies <- c("Phone", "Online", "Mixed", "In-person")  # Methodology options
transparency_scores <- round(runif(num_polls, 0, 10), 1)
states <- c("California", "Texas", "Florida", "New York", "Pennsylvania",
            "Illinois", "Ohio", "Georgia", "Michigan", "North Carolina")
parties <- c("REP", "DEM")
candidates <- c("Donald Trump", "Joe Biden", "Kamala Harris", "Ron DeSantis")
sample_size_range <- c(500, 3000)  # Sample sizes between 500 and 3000

#### Simulate data ####
# Generate the simulated data
simulated_data <- data.frame(
  poll_id = 1:num_polls,
  pollster = sample(pollsters, num_polls, replace = TRUE),
  methodology = sample(methodologies, num_polls, replace = TRUE),  # Random methodology
  transparency_score = transparency_scores,  # Simulated transparency score
  state = sample(states, num_polls, replace = TRUE),
  party = sample(parties, num_polls, replace = TRUE),
  candidate = sample(candidates, num_polls, replace = TRUE),
  pct = round(runif(num_polls, 20, 60), 1),  # Random vote percentages between 20% and 60%
  sample_size = sample(seq(sample_size_range[1], sample_size_range[2]), num_polls, replace = TRUE)
)

# Display the first few rows of the simulated data
print(head(simulated_data))

#### Example aggregation: Average percentage per candidate ####
aggregated_data <- simulated_data %>%
  group_by(candidate) %>%
  summarize(average_pct = mean(pct))

# Display the aggregated results
print(aggregated_data)

#### Save data ####
# Save the simulated data to CSV
write_csv(simulated_data, "data/00-simulated_data/simulated_data.csv")

