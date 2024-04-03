# This is the file you're looking for


######################
# Build me a library #
######################

# call from renv.lock file to load versioned packages
# renv::restore()

# get rid of scientific notation
options(scipen=999)

# package management
library(renv)

# database packages
library(DBI)
library(RSQLite)

# wrangling packages
library(readr)
library(tidyr)
library(dplyr)
library(tidyr)
library(readr)
library(lubridate)
library(stringr)

# read excel from disk
library(readxl)

# reading excel from github
library(httr)







#############
# Directory #
#############


### Set working directory to location of this script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
### set working directory up one level to the repo
setwd("..")


########################
# Run scripts in order #
########################


# ACEP Regions
source(file = "./scripts/acep_regions.R")

# AEA Regions
source(file = "./scripts/aea_regions.R")

# Interties
# source(file = "./interties.R")

# Net Generation
source(file = "./scripts/generation.R")

# Prices
source(file = "./scripts/prices.R")

# Weighted Prices
source(file = "./scripts/weighted_prices.R")

# Capacity
source(file = "./scripts/capacity.R")

# Consumption
source(file = "./scripts/consumption.R")

# Capacity Utilities
# source(file = "./scripts/capacity_utilities.R")

# Capacity Regions
# source(file = "./scripts/capacity_regions.R")

# Capacity State
# source(file = "./scripts/capacity_state.R")




#################
# write to file #
#################
setwd("./data/working/")

# regions
write_csv(acep_regions, file = "./regions/acep_regions.csv")
write_csv(aea_regions, file = "./regions/aea_regions.csv")

# prices
write_csv(prices, file = "./prices/prices.csv")
write_csv(weighted_prices, file = "./prices/weighted_prices.csv")

# generation
write.csv(generation_data_long, file = "./generation/net_generation_long.csv", row.names = FALSE)

# capacity
write.csv(capacity_data_long, file = "./capacity/capacity_long.csv", row.names = FALSE)

# consumption
write.csv(consumption_data_long, file = "./consumption/consumption_long.csv", row.names = FALSE)






######################
# Package Management #
######################

# Save the current project library
# renv::snapshot()









######################
# # DEPRECATED BELOW #
######################
# # Create Empty Database #
# # delete database (careful here!)
# system("rm aetr.db")
# # create empty database
# system("sqlite3 aetr.db .quit;")
# # run DDL script
# system("sqlite3 aetr.db < ./code/ddl.sql;")
# 
# # Connect to Database #
# 
# # Establish the connection
# con <- dbConnect(RSQLite::SQLite(), "aetr.db")
# 
# # Check if the connection is open
# if (dbIsValid(con)) {
#   cat("Connection is open.\n")
# } else {
#   stop("Connection is not valid. Please check your connection.")
# }


# dbExecute(con, "drop table interties")
# 
# test <- dbReadTable(con, "interties")


