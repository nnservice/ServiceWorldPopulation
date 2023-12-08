#' Generate a graph of a country's estimated population in thousands from 1950
#' to 2020.
#'
#' Generate a graph of a country's estimated population in thousands from 1950
#' to 2020. The function takes a string as input. if the string matches a country name
#' in the data frame `WorldPopulation`, the function will produce a line graph
#' of estimated population data from the United Nations.
#'
#' @param x A string
#' @return a graph of the population of x
#' @examples
#' CountryPopulation('China')
#' CountryPopulation('United States of America')
#' @export
CountryPopulation<-function(x){
  result<-str_equal(WorldPopulation$`Country Name`, x)
  if(sum(result)==1){
   graph<-WorldPopulation%>%
     pivot_longer("1950":"2020",
                  names_to  = 'Year',
                  values_to = 'Population')%>%
    filter(`Country Name`== x)%>%
    mutate(Population=as.numeric(Population))%>%
    mutate(Year=make_date(Year))%>%
    ggplot(aes(x=Year,y=Population))+
      geom_line()+
      labs( x="Year", y="Population (thousands)" )+
      labs( title=paste(x))
  }
  else{
    stop("Country not Found")
  }
return(graph)
}

usethis::use_testthat()

