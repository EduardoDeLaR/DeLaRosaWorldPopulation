#' Generate a Population Graph for a Country
#'
#' This function takes in a country name as input and returns a ggplot object
#' displaying the population trends from 1950 to 2020.
#' An error is thrown if the country does not exist in the data.
#'
#' @param Country_Name A string of the country name
#' @return A ggplot object showing the population of the country from 1950 to 2020
#' @examples
#' CountryPopulation( 'Italy' )
#' CountryPopulation( 'United States of America' )
#' CountryPopulation( 'United Kingdom' )
#' @export
# Produce a the function named 'CountryPopulation' that uses the
# `WorldPopulation` data.frame to generate a graph of any countries
# population over time
CountryPopulation = function( Country_Name ) {
  # Check if the input country is in the 'WorldPopulation' dataset
  if ( !( Country_Name %in% WorldPopulation$`Country Name` ) ) {
    # Print an error message indicating the country is not in the dataset
    stop( 'Country not found in the dataset' )
  }

  # Filter all countries in the `Country Name` column for the input country name
  Country_Data = WorldPopulation %>%
    filter( `Country Name` == Country_Name )

  # Create a single panel graph displaying the population against year graph for
  # the input country
  Country_Population_Graph = ggplot( Country_Data,
                                     aes( x = Year,
                                          y = `Population Estimates` ) ) +
    # Add a line plot to visualize populations estimations throughout the years
    geom_line() +
    # Properly label the axes to read 'Year' and 'Population Estimates'
    labs( x = 'Year',
          y = 'Population Estimates',
          # Include the name of the country within the graph title, add a new
          # line for titles that are long in length
          title = paste( Country_Name, 'Population \nvs. Year' ) ) +
    # Set the year breaks on the x-axis in steps of 10 for better readability
    scale_x_continuous( breaks = seq( 1950, 2020, 10 ) ) +
    # Use the 'theme_minimal()' theme to remove any options for color and
    # produce a black and white graph
    theme_minimal()

  # Return the 'Country_Population_Graph' object for the input country
  return( Country_Population_Graph )
}
