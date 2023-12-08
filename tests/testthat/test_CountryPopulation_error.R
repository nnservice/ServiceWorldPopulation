test_that('CountryPopulation input valid', {
  expect_error(CountryPopulation(-2))
  expect_error(CountryPopulation(China))
  expect_error(CountryPopulation("CHINA"))
})
