# Converting the consumption data from wide to long

# Import the consumption data
consumption_data_wide <- read.csv(file = "data/working/consumption/consumption_wide.csv")

# Restrict data to 2019
consumption_data_wide <- subset(consumption_data_wide, year <= 2019)

# Fix character issue throughout the data
#   Sometimes the data aggregator would allow "." for missing or "#REF" from excel errors
consumption_data_wide = consumption_data_wide %>%
  mutate_at(
    c(
      "residential_revenue",
      "commercial_revenue",
      "other_revenue",
      "total_revenue",
      "residential_sales",
      "commercial_sales",
      "other_sales",
      "total_sales",
      "residential_customers",
      "commercial_customers",
      "other_customers",
      "total_customers",
      "residential_price",
      "commercial_price",
      "other_price",
      "total_price"
    ),
    as.numeric
  )

# Convert the generation data to long for OJS
consumption_data_long <- consumption_data_wide %>%
  pivot_longer(
    cols = c(
      "residential_revenue",
      "commercial_revenue",
      "other_revenue",
      "total_revenue",
      "residential_sales",
      "commercial_sales",
      "other_sales",
      "total_sales",
      "residential_customers",
      "commercial_customers",
      "other_customers",
      "total_customers",
      "residential_price",
      "commercial_price",
      "other_price",
      "total_price"
    ),
    names_to = c("class",".value"),
    names_sep = "_"
  )

# Rename the classes
consumption_data_long <- consumption_data_long %>%
  mutate(class = replace(class, class == "residential", "Residential")) %>%
  mutate(class = replace(class, class == "commercial", "Commercial")) %>%
  mutate(class = replace(class, class == "other", "Other")) %>%
  mutate(class = replace(class, class == "total", "Total"))
