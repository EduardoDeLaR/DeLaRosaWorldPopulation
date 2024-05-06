# Include packages
library(testthat)
library(DeLaRosaWorldPopulation)

# Check to see that if a country name is not found in the cleaned data file, an error is thrown
test_that( 'Non-existent country name returns an error', {
  expect_error( CountryPopulation( 'Themyscira' ), 'Country not found in dataset' )
  expect_error( CountryPopulation( 'Wakanda'), 'Country not found in dataset' )
  expect_error( CountryPopulation( 'Atlantis'), 'Country not found in dataset' )
} )
