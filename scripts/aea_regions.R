


### read from (extracted) workbook
raw <- read_csv("./data/raw/2021_table_2.5a.csv")

### isolate regions
raw_regions <- raw %>%
  select(`AEA Energy Region`) %>%
  rename(aea_region_name = `AEA Energy Region`) %>%
  distinct(aea_region_name)

### add acep_region_name
stage_regions <- raw_regions %>%
  mutate(acep_region_name = NA) %>%
  mutate(acep_region_name = case_when(
    aea_region_name == "Railbelt" ~ "Railbelt",
    aea_region_name %in% c("Southeast", 
                           "Kodiak",
                           "Copper River/Chugach") ~ "Coastal",
    .default = "Rural Remote"))

# join
aea_regions <- left_join(stage_regions, acep_regions) %>%
  select(aea_region_name, acep_region_id)

# clean up
rm(raw,
   raw_regions, 
   stage_regions
   )







# DEPRECATED DATABASE CALLS BELOW
# # check if exists
# dbExistsTable(con, "aea_regions")
# # delete contents
# dbExecute(con, "DELETE FROM aea_regions")
# # write to DB
# dbWriteTable(con, "aea_regions", aea_regions, overwrite = F, append = T)
# ## check write
# aea_regions <- dbReadTable(con, "aea_regions")

