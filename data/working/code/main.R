# This is the file you're looking for

## This script will create a database in the working directory, then populate the database with clean data
### Run this puppy and you'll build a relational database from scratch


######################
# Build me a library #
######################

# call from renv.lock file to load versioned packages
# renv::restore()

# package management
library(renv)

# database packages
library(DBI)
library(RSQLite)

# wrangling packages
library(readr)
library(readxl)
library(dplyr)
library(tidyr)

# reading excel file from github
library(httr)



#########################
# Create Empty Database #
#########################

### Set working directory to location of this script
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
### set working directory up one level to "working/"
setwd("..")

# delete database (careful here!)
system("rm aetr.db")

# create empty database
system("sqlite3 aetr.db .quit;")

# run DDL script
system("sqlite3 aetr.db < ./code/ddl.sql;")


#######################
# Connect to Database #
#######################

# Establish the connection
con <- dbConnect(RSQLite::SQLite(), "aetr.db")

# Check if the connection is open
if (dbIsValid(con)) {
  cat("Connection is open.\n")
} else {
  stop("Connection is not valid. Please check your connection.")
}


########################
# Run scripts in order #
########################

### set working directory up on more level to "data/"
setwd("..")

# ACEP Regions
source(file = "./working/code/acep_regions.R")

# AEA Regions
source(file = "./working/code/aea_regions.R")

# Interties
# source(file = "./interties.R")

# Prices
# NOTE: no DDL for this yet, shooting from the hip
source(file = "./working/code/prices.R")

# Weighted Prices
# NOTE: no DDL for this yet, shooting from the hip
source(file = "./working/code/weighted_prices.R")



# Capacity Utilities
# no DDL yet
source(file = "./working/code/capacity_utilities.R")

# Capacity Regions
# no DDL yet
source(file = "./working/code/capacity_regions.R")

# Capacity State
# no DDL yet
source(file = "./working/code/capacity_state.R")



########
# test #
########

# dbExecute(con, "drop table interties")
# 
# test <- dbReadTable(con, "interties")




######################
# Package Management #
######################

# Save the current project library
# renv::snapshot()



