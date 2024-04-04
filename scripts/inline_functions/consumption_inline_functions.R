################################################################################
# Regional compound average growth rate
#
# Attributes
#   - region: ACEP region (string), of ["Coastal","Railbelt","Rural Remote"]
#   - class: Customer class (string), of ["Residential","Commercial","Other"]
#   - attribute: Attribute of interest (string), of ["revenue","sales","customers"]
#   - year1: First year of comparison (integer), default=2011
#   - year2: Second year of comparison (integer), default=2019
#   - decimals: Number of decimals for rounding (integer), default=2
################################################################################
##
#

cagr <- function(region, class, attribute, year1=2011, year2=2019, decimals=2) {
  
  # Dataframe declaration
  df = regional_consumption_data
  
  # Define the number of periods
  n = year2 - year1
  
  # Generation in year 1
  gen_1 = (df[[attribute]][df$acep_region == region & df$class == class & df$year == year1])
  
  # Generation in year 2
  gen_2 = (df[[attribute]][df$acep_region == region & df$class == class & df$year == year2])
  
  # Compound Average Growth Rate Calculation
  result = (((gen_2 / gen_1)^(1/n)) - 1)*100
  
  # Output the rounded CAGR to the specified decimal place as a string
  formatC(round(result, decimals), format="g")
}

################################################################################
# Statewide consumption deltas
#
# Attributes
#   - class: Customer class (string), of ["Residential","Commercial","Other","Total"]
#   - attribute: Attribute of interest (string), of ["revenue","sales","customers"]
#   - pct: Returns percentage change if TRUE (boolean), default=FALSE
#   - year1: First year of comparison (integer), default=2011
#   - year2: Second year of comparison (integer), default=2019
#   - decimals: Number of decimals for rounding (integer), default=2
################################################################################
##
#

statewide_consumption_delta <- function(class, attribute, pct=FALSE, year1=2011, year2=2019, decimals=2) {
  
  # Dataframe declaration
  df = statewide_consumption_data
  
  # Generation in year 1
  gen_1 = (df[[attribute]][df$class == class & df$year == year1])
  
  # Generation in year 2
  gen_2 = (df[[attribute]][df$class == class & df$year == year2])
  
  # Calculating delta
  result = gen_2 - gen_1
  
  # Percentage calculation (Optional)
  if (pct==TRUE) {
    result = (result / abs(gen_1))*100
    
    # Output the result as a string
    formatC(round(result, decimals), format="g")
  }
  
  # Non-percentage calcaulation as a string with a comma for large numbers
  else if (pct==FALSE) {
    # Output the result
    formatC(round(result, decimals), format="d", big.mark=",")
  }
}

################################################################################
# Statewide consumption numbers by year
#
# Attributes
#   - class: Customer class (string), of ["Residential","Commercial","Other","Total"]
#   - attribute: Attribute of interest (string), of ["revenue","sales","customers"]
#   - year: Calendar year of interest (integer)
#   - decimals: Number of decimals for rounding (integer), default=2
#   - gwh: Reports consumption in GWh instead of MWh (boolean), default=TRUE
################################################################################
##
#

statewide_consumption <- function(class, attribute, year, decimals=2, gwh=TRUE) {
  
  # Dataframe declaration
  df = statewide_consumption_data
  
  # Consumption in MWh
  result = (df[[attribute]][df$class == class & df$year == year])
  
  # Consumption in GWh
  if (gwh==TRUE & attribute == "sales") {
    result = result / 1000
  }
  
  # Output the result as a string with a comma for large numbers
  formatC(round(result, decimals), format="d", big.mark=",")
}

################################################################################
# Regional consumption per number of customers
#
# Attributes
#   - region: ACEP region (string), of ["Coastal","Railbelt","Rural Remote"]
#   - class: Customer class (string), of ["Residential","Commercial","Other","Total"]
#   - year: Calendar year of interest (integer), default=NULL
#           NULL default results in average across all years
#   - kwh: Reports consumption in kWh instead of MWh (boolean), default=TRUE
################################################################################
##
#

regional_consumption_per_capita <- function(region, class, year=NULL, kwh=TRUE) {
  
  # Dataframe declaration
  df = regional_consumption_data
  
  # Series Average
  if (is.null(year)) {
    result = mean(df[["sales_per_capita"]][df$acep_region == region & df$class == class], na.rm=TRUE)
  }
  
  # Yearly Average
  if (!is.null(year)) {
    result = mean(df[["sales_per_capita"]][df$acep_region == region & df$class == class & df$year == year], na.rm=TRUE)
  }
  
  # Convert output from MWh to kWh
  if (kwh==TRUE) {
    result = (result * 1000)
  }
  
  # Output the result as a string with a comma for large numbers
  formatC(result, format="d", big.mark=",")
}
