# Include packages
library(tidyverse)      # dplyr, tidyr, ggplot2, etc.
library(readxl)         # for reading excel files
library(usethis)        # for automating repetitive tasks for R packages

# Read data from the 'ESTIMATES' tab of the Excel file,
# skipping uninformative lines
World_Population = read_excel( 'World_Population.xlsx',
                               sheet = 'ESTIMATES',
                               skip = 15 )

# Update the column names based on the first row in the file
colnames( World_Population ) = as.character( unlist( World_Population[1, ] ) )

# With the columns renames, remove the first row from the file
World_Population = World_Population[-1, ]

# Clean the data to include only population information from `1950` to `2020`
# for all countries
WorldPopulation = World_Population %>%
  # Filter all the rows that are not countries
  filter( Type == 'Country/Area' ) %>%
  # Rename the 'Region, subregion, country or area *' column to
  # 'Country Name' for better clarity and concision
  rename( 'Country Name' = 'Region, subregion, country or area *' ) %>%
  # Remove all extra information regarding regions, subregions, income, etc.
  # retaining only the 'Country Name' and population estimates for years
  # 1950 to 2020
  select( `Country Name`, `1950`:`2020` ) %>%
  # Pivot the data to a long format to better readability of population
  # estimates with their corresponding year
  pivot_longer( cols = `1950`:`2020`,
                names_to = "Year",
                values_to = "Population Estimates" ) %>%
  # Properly format the 'Population Estimates' column as numeric values
  mutate( `Population Estimates` = as.numeric( `Population Estimates` ) ) %>%
  # Properly format the 'Year' column as numeric values
  mutate( Year = as.numeric( Year ) )

# Save the cleaned data
use_data( WorldPopulation )
