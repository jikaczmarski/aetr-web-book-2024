
# read CSV from data/raw/
capacity_utilities <- read_csv("./raw/capacity_utilities.csv")

# check if exists
dbExistsTable(con, "capacity_utilites")


# write to DB
dbWriteTable(con, "capacity_utilities", capacity_utilities, overwrite = F, append = T)

# clean up
rm(
   capacity_utilities
)

## check write
capacity_utilities <- dbReadTable(con, "capacity_utilities")
