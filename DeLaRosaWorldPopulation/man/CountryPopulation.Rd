% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/CountryPopulation.R
\name{CountryPopulation}
\alias{CountryPopulation}
\title{Generate a Population Graph for a Country}
\usage{
CountryPopulation(Country_Name)
}
\arguments{
\item{Country_Name}{A string of the country name}
}
\value{
A ggplot object showing the population of the country from 1950 to 2020
}
\description{
This function takes in a country name as input and returns a ggplot object
displaying the population trends from 1950 to 2020.
An error is thrown if the country does not exist in the data.
}
\examples{
CountryPopulation( 'Italy' )
CountryPopulation( 'United States of America' )
CountryPopulation( 'United Kingdom' )
}
