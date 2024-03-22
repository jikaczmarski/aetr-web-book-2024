# This script will convert the installed-capacity-certified-utilities-mw.csv into long versions for easier use with Observable JS

# Import required packages
library(tidyr)
library(dplyr)
library(readr)

# Import the data
capacity_data <- read.csv("installed-capacity-certified-utilities-mw.csv")

# Statewide total capacity by year and prime mover
statewide_totals <- capacity_data %>%
group_by(year) %>%
  summarize(
    "Fossil Turbine" = sum(ff.turbines),
    "Recip Engines" = sum(ff.ice),
    "Hydro" = sum(hydro),
    "Wind" = sum(wind),
    "Utility Solar" = sum(solar),
    "Rooftop Solar" = sum(solar.btm),
    "Storage" = sum(storage),
    "Landfill Gas" = sum(landfill)
  ) %>%
  pivot_longer(
    cols = c(
      "Fossil Turbine",
      "Recip Engines",
      "Hydro", "Wind",
      "Utility Solar",
      "Rooftop Solar",
      "Storage",
      "Landfill Gas"
    ),
    names_to = "Prime.Mover",
    values_to = "Capacity"
  )

# Export statewide capacity totals to a CSV
statewide_totals <- subset(statewide_totals, Capacity != 0)
write.csv(statewide_totals, file = "statewide-total-capacity-by-year.csv", row.names = FALSE)

# Regional total capacity by year and prime mover
regional_capacity <- capacity_data %>%
  group_by(acep.region, year) %>%
  summarize(
    "Fossil Turbine" = sum(ff.turbines),
    "Recip Engines" = sum(ff.ice),
    "Hydro" = sum(hydro),
    "Wind" = sum(wind),
    "Utility Solar" = sum(solar),
    "Rooftop Solar" = sum(solar.btm),
    "Storage" = sum(storage),
    "Landfill Gas" = sum(landfill)
  ) %>%
  pivot_longer(
    cols = c(
      "Fossil Turbine",
      "Recip Engines",
      "Hydro", "Wind",
      "Utility Solar",
      "Rooftop Solar",
      "Storage",
      "Landfill Gas"
    ),
    names_to = "Prime.Mover",
    values_to = "Capacity"
  )

# Export the Coastal region capacity, all prime movers
coastal_capacity <- subset(regional_capacity, acep.region == "Coastal" & Capacity != 0) # Coastal only, all prime movers
write.csv(coastal_capacity, "coastal-capacity.csv", row.names = FALSE) # Write to CSV
coastal_capacity_non_fossil <- subset(coastal_capacity, Prime.Mover != "Fossil Turbine" & Prime.Mover != "Recip Engines") # Coastal only, non-fossil prime movers
write.csv(coastal_capacity_non_fossil, "coastal-capacity-non-fossil.csv", row.names = FALSE) # Write to CSV

# Export the Rural Remote region capacity, all prime movers
rural_remote_capacity <- subset(regional_capacity, acep.region == "Rural Remote" & Capacity != 0) # Rural Remote only, all prime movers
write.csv(rural_remote_capacity, "rural-remote-capacity.csv", row.names = FALSE) # Write to CSV
rural_remote_capacity_non_fossil <- subset(rural_remote_capacity, Prime.Mover != "Fossil Turbine" & Prime.Mover != "Recip Engines") # Coastal only, non-fossil prime movers
write.csv(rural_remote_capacity_non_fossil, "rural-remote-capacity-non-fossil.csv", row.names = FALSE) # Write to CSV

# Export the Railbelt region capacity, all prime movers
railbelt_capacity <- subset(regional_capacity, acep.region == "Railbelt" & Capacity != 0) # Railbelt only, all prime movers
write.csv(railbelt_capacity, "railbelt-capacity.csv", row.names = FALSE) # Write to CSV
railbelt_capacity_non_fossil <- subset(railbelt_capacity, Prime.Mover != "Fossil Turbine" & Prime.Mover != "Recip Engines") # Coastal only, non-fossil prime movers
write.csv(railbelt_capacity_non_fossil, "railbelt-capacity-non-fossil.csv", row.names = FALSE) # Write to CSV
