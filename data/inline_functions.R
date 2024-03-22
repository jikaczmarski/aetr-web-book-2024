# Custom functions
#
# Functions are written for each section independently
# 1. Capacity Section
#   - cap_diff(), calculates the difference in total capacity between 2021 and
#                 2011 by prime mover or region
#   - sw_yearly_cap(), calculates the total capacity in a given year for the
#                 statewide data
# 2. Prices Section
#
#
#
#
############################ START Capacity Section ############################
# Calculates the difference in capacity between 2021 and 2011 for a given prime mover and region
# Example call:  
#     mw_diff(coastal_capacity, c("Fossil Turbine"))
cap_diff <- function(dataframe, prime_mover=NULL, gw=TRUE, pct_diff=FALSE) {
  # If no prime mover is specified, then sum all prime movers
  if (missing(prime_mover)) {
    value_2 <- sum(dataframe$Capacity[dataframe$year == 2021])
    value_1 <- sum(dataframe$Capacity[dataframe$year == 2011])
  }
  # If user specifies a prime mover, then only look at the prime mover but deal with zero values
  else if (!missing(prime_mover)){
    value_2 <- ifelse(length(dataframe$Capacity[dataframe$year == 2021 & dataframe$Prime.Mover == prime_mover]) == 0,
                              0,
                              dataframe$Capacity[dataframe$year == 2021 & dataframe$Prime.Mover == prime_mover])
    value_1 <- ifelse(length(dataframe$Capacity[dataframe$year == 2011 & dataframe$Prime.Mover == prime_mover]) == 0,
                      0,
                      dataframe$Capacity[dataframe$year == 2011 & dataframe$Prime.Mover == prime_mover])
  }
  difference <- (value_2 - value_1)
  if (pct_diff == TRUE) {
    result <- ((value_2 - value_1) / abs(value_1))*100
  }
  else {
    if (gw==TRUE) {
      result <- (value_2 - value_1) / 1000
    }
    else if (gw == FALSE) {
      result <- (value_2 - value_1)
    }
  }
  round(result, 2)
}

# Calculates the total capacity in a given year for the state
## Reports GW by default. Pass the argument gw=FALSE to get MW.
sw_yearly_cap <- function(year, gw=TRUE) {
  a <- sum(statewide_capacity$Capacity[statewide_capacity$year == year]) # find the total statewide capacity in specified year
  if (gw == TRUE) {
    b <- a / 1000 # convert to GW (default)
  }
  else if (gw == FALSE) {
    b <- a # keep as MW
  }
  round(b, 2)
}

############################# START Prices Section #############################