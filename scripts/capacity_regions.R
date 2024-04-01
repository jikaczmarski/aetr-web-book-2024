
# read from db
capacity_utilities <- dbReadTable(con, "capacity_utilities")


# Regional total capacity by year and prime mover
capacity_regions <- capacity_utilities %>%
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



# check if table exists
dbExistsTable(con, "capacity_regions")

# write to DB
dbWriteTable(con, "capacity_regions", capacity_regions, overwrite = F, append = T)

# clean up
rm(
   capacity_regions
)

## check write
capacity_regions <- dbReadTable(con, "capacity_regions")
