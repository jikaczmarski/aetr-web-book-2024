################################################################################
# Regional and statewide price by year
#
# Attributes
#   - region: ACEP region (string), of ["Coastal","Railbelt","Rural Remote"], default=NULL
#             NULL returns average of all regions, specifying returns only that region
#   - sector: Sector of interest (string), of ["commercial", "residential", "other"], default=NULL
#             NULL returns average of all sectors
#   - year: Calendar year of interest (integer), of [2011:2021]
#   - decimals: Number of decimals for rounding (integer), default=2
#   - numeric_out: Output the value as a number instead of a string (boolean), default=FALSE
################################################################################
##
#

price <- function(region=NULL, sector=NULL, year, decimals=2, pct=FALSE, numeric_out=FALSE) {
  
  # Dataframe declaration
  df = weighted_prices
  
  # Initialize result
  result <- NA
  
  # Statewide capacity
  if (is.null(region)) {
    if (is.null(sector)) {
      result = mean(df$weighted_price[df$year == year], na.rm = TRUE)
    }
    else if (!is.null(sector)) {
      result = mean(df$weighted_price[df$sector == sector & df$year == year], na.rm = TRUE)
    }
  }
  
  # Regional capacity
  if (!is.null(region)) {
    if (is.null(sector)) {
      result = mean(df$weighted_price[df$acep_energy_region == region & df$year == year], na.rm = TRUE)
    }
    else if (!is.null(sector)) {
      result = mean(df$weighted_price[df$acep_energy_region == region & df$sector == sector & df$year == year], na.rm = TRUE)
    }
  }
  
return(round(result, digits = decimals))
}


test <- price(region="Railbelt", sector="residential", year=2017)


################################################################################
# Regional price changes by year
#
# Attributes
#   - region: ACEP region (string), of ["Coastal","Railbelt","Rural Remote"]
#   - sector: Sector of interest (string), of ["commercial", "residential", "other"], default=NULL
#             NULL returns average of all sectors
#   - year1: First year of comparison (integer), default=2011
#   - year2: Second year of comparison (integer), default=2021
#   - decimals: Number of decimals for rounding (integer), default=2
#   - pct: Returns percentage change if TRUE (boolean), default=FALSE
################################################################################
##
#

price_delta <- function(region, sector=NULL, year1=2011, year2=2019, decimals=2, pct=FALSE, numeric_out=FALSE) {
  
  # Dataframe declaration
  df = weighted_prices
  
  # All price in a region
  if (is.null(sector)) {
    price_2 <- price(region = region,
                      year = year2, 
                      decimals = decimals,
                      numeric_out = TRUE)
    price_1 <- price(region = region, 
                      year = year1, 
                      numeric_out = TRUE)
  }
  
  # price in a region for a specific sector
  else if (!is.null(sector)) {
    price_2 <- price(region = region, 
                      sector = sector, 
                      year = year2,
                      decimals = decimals,
                      numeric_out = TRUE)
    price_1 <- price(region = region, 
                      sector = sector, 
                      year = year1, 
                      decimals = decimals,
                      numeric_out = TRUE)
  }
  
  # Calculating the difference
  result <- price_2 - price_1
  
  
  # Output as a percentage (Optional)
  if (pct==TRUE) {
    result <- (result / abs(price_1))*100
    
    if (numeric_out==TRUE){
      # Output the result as a number
      round(result,0)
    }
    else {
      # Output the result as a string if percentage
      formatC(round(result,0), format="g")
    }
    
  }
  
  # Output the result
  else  {
    if (numeric_out==TRUE){
      # Output the result as a number
      round(result,0)
    }
    else {
      # Output the result as a string if difference
      formatC(round(result,0), format="g", big.mark = ",")
    }
  }
}

price(region="Rural Remote", sector="commercial", year=2011)
price(region="Rural Remote", sector="other", year=2019)

price_delta(region="Rural Remote", sector="other", pct=TRUE, numeric_out=TRUE)


