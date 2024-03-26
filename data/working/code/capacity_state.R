
# read from db
capacity_utilities <- dbReadTable(con, "capacity_utilities")


# Statewide total capacity by year and prime mover
capacity_state <- capacity_utilities %>%
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
  ) %>%
  filter(Capacity != 0)



# check if table exists
dbExistsTable(con, "capacity_state")


# write to DB
dbWriteTable(con, "capacity_state", capacity_state, overwrite = F, append = T)

# clean up
rm(
  capacity_state
)

## check write
capacity_state <- dbReadTable(con, "capacity_state")
