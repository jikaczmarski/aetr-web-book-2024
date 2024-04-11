################################################################################
# Regional and statewide capacity by year
#
# Attributes
#   - region: ACEP region (string), of ["Coastal","Railbelt","Rural Remote"], default=NULL
#             NULL returns sum of all regions, specifying returns only that region
#   - prime_mover: Prime mover code of interest (string), of ["Fossil Turbines", "Recip Engines", "Hydro", "Wind","Utility Solar","Rooftop Solar","Storage","Landfill Gas"], default=NULL
#             NULL returns sum of all prime movers
#   - year: Calendar year of interest (integer), of [2011:2021]
#   - decimals: Number of decimals for rounding (integer), default=2
#   - numeric_out: Output the value as a number instead of a string (boolean), default=FALSE
################################################################################
##
#

capacity <- function(region=NULL, prime_mover=NULL, year, decimals=2, numeric_out=FALSE) {
  
  # Dataframe declaration
  df = regional_capacity
  
  # Statewide capacity
  if (is.null(region)) {
    if (is.null(prime_mover)) {
      result = sum(df$total_capacity[df$year == year], na.rm=TRUE)
    }
    else if (!is.null(prime_mover)) {
      result = sum(df$total_capacity[df$prime_mover == prime_mover & df$year == year], na.rm=TRUE)
    }
  }
  
  # Regional capacity
  if (!is.null(region)) {
    if (is.null(prime_mover)) {
      result = sum(df$total_capacity[df$acep_region == region & df$year == year], na.rm=TRUE)
    }
    else if (!is.null(prime_mover)) {
      result = sum(df$total_capacity[df$acep_region == region & df$prime_mover == prime_mover & df$year == year], na.rm=TRUE)
    }
  }
  
  # Output the result as a number for calculations
  if (numeric_out==TRUE) {
    result
  }
  
  # Output the result as a string with a comma for large numbers
  else if (numeric_out==FALSE) {
    formatC(result, format="d", big.mark=",")
  }
}

################################################################################
# Regional capacity changes by year
#
# Attributes
#   - region: ACEP region (string), of ["Coastal","Railbelt","Rural Remote"]
#   - prime_mover: Prime mover code of interest (string), of ["Fossil Turbines", "Recip Engines", "Hydro", "Wind","Utility Solar","Rooftop Solar","Storage","Landfill Gas"], default=NULL
#             NULL returns sum of all prime movers
#   - year1: First year of comparison (integer), default=2011
#   - year2: Second year of comparison (integer), default=2021
#   - decimals: Number of decimals for rounding (integer), default=2
#   - pct: Returns percentage change if TRUE (boolean), default=FALSE
#   - gw: Reports consumption in GW instead of MW (boolean), default=FALSE
################################################################################
##
#

capacity_delta <- function(region, prime_mover=NULL, year1=2011, year2=2021, decimals=2, pct=FALSE, gw=FALSE, numeric_out=FALSE) {
  
  # Dataframe declaration
  df = regional_capacity
  
  # All capacity in a region
  if (is.null(prime_mover)) {
    cap_2 <- capacity(region = region,
                     year = year2, 
                     numeric_out = TRUE)
    cap_1 <- capacity(region = region, 
                     year = year1, 
                     numeric_out = TRUE)
  }
  
  # Capacity in a region for a specific prime mover
  else if (!is.null(prime_mover)) {
    cap_2 <- capacity(region = region, 
                     prime_mover = prime_mover, 
                     year = year2, 
                     numeric_out = TRUE)
    cap_1 <- capacity(region = region, 
                     prime_mover = prime_mover, 
                     year = year1, 
                     numeric_out = TRUE)
  }
  
  # Calculating the difference
  result <- cap_2 - cap_1
  
  # Output as GW (Optional)
  if (gw==TRUE) {
    result <- (result / 1000)
  }
  
  # Output as a percentage (Optional)
  if (pct==TRUE) {
    result <- (result / abs(cap_1))*100
    
    if (numeric_out==TRUE){
      # Output the result as a number
      round(result,2)
    }
    else {
      # Output the result as a string if percentage
      formatC(round(result,2), format="g")
    }
    
  }
  
  # Output the result
  else  {
    if (numeric_out==TRUE){
      # Output the result as a number
      round(result,2)
    }
    else {
      # Output the result as a string if difference
      formatC(round(result,2), format="g", big.mark = ",")
    }
  }
}
