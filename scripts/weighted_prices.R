
p_price <- prices %>%
  rename(c("residential" = "residential_price_kwh_2021_dollars",
           "commercial" = "commercial_price_kwh_2021_dollars",
           "other" = "other_price_kwh_2021_dollars")) %>%
  pivot_longer( 
    cols = c("residential",
             "commercial",
             "other"), 
    names_to ="sector", 
    values_to = "price")

long_price <- p_price %>%
  mutate(customers = NA) %>%
  mutate(customers = ifelse(sector == "residential", `residential_customers`, customers)) %>%
  mutate(customers = ifelse(sector == "commercial", `commercial_customers`, customers)) %>%
  mutate(customers = ifelse(sector == "other", `other_customers`, customers)) %>%
  mutate(customers = round(customers, 0)) %>%
  
  select("year",
         "reporting_name",
         "acep_energy_region",
         "sector",
         "price",
         "customers",
         "total_customers")



# calculate weighted averages
weighted_prices <- long_price %>%
  drop_na() %>%
  group_by(`acep_energy_region`, sector, year) %>%
  summarize(avg_price = mean(price, na.rm=T),
            weighted_price = weighted.mean(price, `customers`, na.rm=T)) %>%
  select(
    "year",
    "acep_energy_region",
    "sector",
    "avg_price",
    "weighted_price")



# # clean up
rm(p_price, long_price)



##############
# DEPRECATED #
##############
# # check if table exists
# dbExistsTable(con, "weighted_prices")
# # delete contents
# # dbExecute(con, "DELETE FROM prices")
# # write tables
# dbWriteTable(con, "weighted_prices", weighted, overwrite=T)
# ## test load from database
# weighted_prices <- dbReadTable(con, "weighted_prices")







