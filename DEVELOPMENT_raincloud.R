
#| output: false

library(readr)
library(dplyr)
library(tidyr)
library(stringr)
library(ggplot2)
library(ggiraph)

library(see)  # slices violin plots in half
library(ggridges) # mountains beyond mountains
library(ggrepel) # labels on ends of lines
library(ggdist) # raincloud plots
library(ggrain) # other raincloud package

weighted_prices <- read_csv("./data/working/prices/weighted_prices.csv")
prices <- read_csv("./data/working/prices/prices.csv")





p_prices <- prices %>%
  rename(c("residential" = "residential_price_kwh_2021_dollars",
           "commercial" = "commercial_price_kwh_2021_dollars",
           "other" = "other_price_kwh_2021_dollars")) %>%
  pivot_longer( 
    cols = c("residential",
             "commercial",
             "other"), 
    names_to ="sector", 
    values_to = "price")

long_price <- p_prices %>%
  mutate(customers = NA) %>%
  mutate(customers = ifelse(sector == "residential", residential_customers, customers)) %>%
  mutate(customers = ifelse(sector == "commercial", commercial_customers, customers)) %>%
  mutate(customers = ifelse(sector == "other", other_customers, customers)) %>%
  mutate(customers = round(customers, 0)) %>%
  
  select("year",
         "reporting_name",
         "acep_energy_region",
         "sector",
         "price",
         "customers",
         "total_customers")

raincloud <- function(sector_input="residential", start_year=2011, end_year=2019, x_axis_max=65){
  d <- long_price %>%
    filter(sector == sector_input) %>% 
    filter(price > 0) %>%
    filter(year >= start_year & year <= end_year) %>%
    left_join(weighted_prices, join_by(year, sector, acep_energy_region))
  
  output <-
    ggplot(d) +
    
    geom_violinhalf(
      aes(x=acep_energy_region, 
          y=price, 
          fill=acep_energy_region),
      position = position_nudge(x=.1, y=0)) +
    
    geom_jitter(
      aes(x=acep_energy_region, y=price), 
      color="black",
      alpha=0.25, 
      width = .05,
      height = 0) +
    
    scale_fill_manual(values = c("#98BAD6", "#A4CD9A", "#E3918F")) +
    scale_color_manual(values = c("#98BAD6", "#A4CD9A", "#E3918F")) +
    
    scale_y_continuous(
      breaks = seq(0, x_axis_max, 20), 
      limits = c(0, x_axis_max),
      expand = c(0, 0.1)) + 
    
    theme_classic() +
    theme(legend.position = "none",
          # plot.title = element_text(size=16, hjust = 0.5),
          # plot.subtitle = element_text(size=14, hjust = 0.5),
          plot.caption = element_text(size = 8),
          panel.grid.major.x = element_line(color = "grey80", size = 0.5),
          plot.margin = unit(c(t=5, r=15, b=5, l=0), "pt")) +
    
    labs(title = paste(str_to_title(sector_input), "Sector Prices,", start_year, "-", end_year),
         x = "",
         y = "Cents per kWh") +
    
    # ylim(c(0,x_axis_max)) + #remember the coord_flip, y axis is now the x axis
    coord_flip() 
  
  
  #E3918F Rural Remote
  #98BAD6 Coastal
  #A4CD9A Railbelt
  #F1BF42 State
  
  print(output)
  
}

raincloud(sector_input="commercial", start_year=2011, end_year=2019, x_axis_max=120)
