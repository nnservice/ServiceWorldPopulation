library(tidyverse)
library(lubridate)
library(readxl)

World_Population <- read_excel("data-raw/World_Population.xlsx", sheet=1,
                               skip = 16)

WorldPopulation<-World_Population%>% filter(Type=="Country/Area")%>%
  select(matches("Region|\\d{4}"))%>%
  rename("Country Name"="Region, subregion, country or area *")

usethis::use_data(WorldPopulation, overwrite = TRUE)
