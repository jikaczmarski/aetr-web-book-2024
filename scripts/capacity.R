# Convert the capacity data from wide to long
# Import the capacity data
capacity_data_wide <- read.csv("data/working/capacity/capacity_wide.csv")

# Convert from wide to long
capacity_data_long <- capacity_data_wide %>%
  group_by(aea_region, year) %>%
  summarise(
    "acep_region" = acep_region,
    "ft" = sum(ff_turbines),
    "re" = sum(ff_ice),
    "hy" = sum(hydro),
    "wi" = sum(wind),
    "us" = sum(solar),
    "rs" = sum(rooftop_solar),
    "st" = sum(storage),
    "lg" = sum(landfill_gas)
  ) %>%
  pivot_longer(
    cols = c(
      "ft",
      "re",
      "hy", 
      "wi",
      "us",
      "rs",
      "st",
      "lg"
    ),
    names_to = "prime_mover",
    values_to = "capacity"
  )

# Rename the prime movers
capacity_data_long <- capacity_data_long %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "ft", "Fossil Turbines")) %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "re", "Recip Engines")) %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "hy", "Hydro")) %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "wi", "Wind")) %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "us", "Utility Solar")) %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "rs", "Rooftop Solar")) %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "st", "Storage")) %>%
  mutate(prime_mover = replace(prime_mover, prime_mover == "lg", "Landfill Gas"))