# Converting the net generation data

# Import the generation data
generation_data <- read.csv("data/working/generation/net_generation_wide.csv")

# Convert the generation data to long for OJS
generation_data_long <- generation_data %>%
  pivot_longer(
    cols = c(
      "oil",
      "gas",
      "coal",
      "hydro",
      "wind",
      "solar",
      "storage",
      "other"
    ),
    names_to = "fuel_type",
    values_to = "generation"
  )

# Renaming the fuel types
generation_data_long <- generation_data_long %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "oil", "Oil")) %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "gas", "Gas")) %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "coal", "Coal")) %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "hydro", "Hydro")) %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "wind", "Wind")) %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "solar", "Solar")) %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "storage", "Storage")) %>%
  mutate(fuel_type = replace(fuel_type, fuel_type == "other", "Other"))

# Creating an ACEP Energy Region column
## Railbelt region
generation_data_long$acep_region <- ifelse(
  generation_data_long$aea_energy_region == "Railbelt",
  "Railbelt",
  NA
)

## Coastal region
generation_data_long$acep_region <- ifelse(
  generation_data_long$aea_energy_region == "Southeast",
  "Coastal",
  generation_data_long$acep_region
)
generation_data_long$acep_region <- ifelse(
  generation_data_long$aea_energy_region == "Kodiak",
  "Coastal",
  generation_data_long$acep_region
)
generation_data_long$acep_region <- ifelse(
  generation_data_long$aea_energy_region == "Copper River/Chugach",
  "Coastal",
  generation_data_long$acep_region
)


## Rural remote region
generation_data_long$acep_region <- ifelse(
  is.na(generation_data_long$acep_region),
  "Rural Remote",
  generation_data_long$acep_region
)

# Remove zeros from the data
generation_data_long$generation <- ifelse(
  generation_data_long$generation == 0.0,
  NA,
  generation_data_long$generation
)