# Include packages
library(tidyverse)      # dplyr, tidyr, ggplot2, etc.
library(rvest)          # for web scraping
library(usethis)        # for automating repetitive tasks for R packages

# Define the URL for the Wikipedia page
Wiki_Url = 'https://en.wikipedia.org/wiki/FIFA_World_Cup'

# Read the HTML content from the URL
Wiki_Page = read_html( Wiki_Url )

# Scrape this information from the page and get the proper 'Attendance' table
World_Cup_Attendance = Wiki_Page %>%
  html_elements( 'table.wikitable' ) %>%
  .[[2]] %>%
  html_table( fill = TRUE )

# Clean the scraped data to include the `Year`, `Hosts`, `Matches`,
# `Totalattendance`, and `Averageattendance` columns, assign to the variable
# 'World_Cup"
World_Cup = World_Cup_Attendance %>%
  # Select the following columns to include in the table
  select( Year = 1,
          Hosts = 2,
          Matches = 5,
          Totalattendance = 4,
          Averageattendance = 6) %>%
  # Remove commas from numerical values in the 'Totalattendance' and
  # 'Averageattendance' columns.
  mutate( across( c( Totalattendance,
                     Averageattendance ),
                  ~ gsub( ',', '', . ) ) ) %>%
  # Properly format the Totalattendance' and 'Averageattendance' columns as
  # numerical data
  mutate( across( c( Totalattendance,
                     Averageattendance ),
                  as.numeric ) ,
          # Keep the `Year` variable as strings
          Year = as.character( Year ) ) %>%
  # Remove data related to World Cups that haven't happened and the
  # Overall statistics column
  filter( !grepl( 'Year|2026|2030|2034|Overall', Year ) )

# Make unique identifiers for each World Cup
World_Cup = World_Cup %>%
  # Create a new `WorldCup` column, which contains unique identifiers,
  # by pasting the `Hosts` and `Year` columns together
  mutate( WorldCup = str_replace_all( paste( Hosts,
                                             Year ),
                                      ' ', '' ),
          # Remove any remaining spaces in the `WorldCup` names
          WorldCup = str_replace_all( WorldCup,
                                      ' ',
                                      '' ) ) %>%
  # Remove the `Hosts` and `Year` columns, make sure the new WorldCup` column
  # is first in the data frame for readability
  select( WorldCup, everything(), -Hosts, -Year )

# Save the cleaned data
use_data( World_Cup )
