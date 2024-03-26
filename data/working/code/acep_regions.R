# DML script for acep_regions table

# make the acep_regions dataframe by hand
empty <- NULL

acep_regions <- empty %>% 
  tibble(acep_region_name = c("Coastal", "Railbelt", "Rural Remote")) %>%
  mutate(acep_region_id = row_number(), .before = acep_region_name)

# check if table exists
dbExistsTable(con, "acep_regions")

# delete contents
dbExecute(con, "DELETE FROM acep_regions")

# write tables
dbWriteTable(con, "acep_regions", acep_regions, overwrite = F, append = T)

# clean up
rm(empty,
   acep_regions
   )

## test load from database
acep_regions <- dbReadTable(con, "acep_regions")



