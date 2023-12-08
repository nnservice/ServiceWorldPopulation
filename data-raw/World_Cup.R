library(tidyverse)
library(rvest)

url='https://en.wikipedia.org/wiki/FIFA_World_Cup#Attendance'

page<-read_html(url)
attendance<-page%>%
  html_nodes('table')%>%
  .[[4]]%>%
  html_table(header=FALSE, fill=TRUE)

World_Cup<-attendance%>%
  slice(-1 * 1:2 )%>%
  select(X1, X2, X5, X4, X6)%>%
  magrittr::set_colnames( c('Year', 'Hosts','Matches', 'Totalattendance',
                            'Averageattendance') )%>%
  mutate(Totalattendance = str_replace_all(Totalattendance, pattern=',',
                                           replacement=''))%>%
  mutate(Averageattendance = str_replace_all(Averageattendance,pattern=',',
                                             replacement=''))%>%
  mutate(Totalattendance=as.numeric(Totalattendance))%>%
  mutate(Averageattendance=as.numeric(Averageattendance))%>%
  mutate(Matches=as.numeric(Matches))%>%
  drop_na()%>%
  filter(!(Year=="Overall"))%>%
  mutate(WorldCup=str_c(Hosts, Year, sep=''))%>%
  mutate(WorldCup=str_replace_all(WorldCup, pattern='\\s', replacement=''))%>%
  select(-Year,-Hosts)%>%
  mutate(WorldCup=factor(WorldCup))

usethis::use_data(World_Cup, overwrite = TRUE)
