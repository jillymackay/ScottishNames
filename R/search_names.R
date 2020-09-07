# Search names

library(tidyverse)

scot_names <- read.csv("data/scot_names.csv") %>% 
  select(-X)



search_names <- function(name) {
  x <- enquo(name)
  
  temp <- scot_names %>% 
    filter(names == !!x)
  
  ifelse(nrow(temp) ==0, 
         paste0("Of 49,857 babies born in Scotland in 2019, none were registered with the name ", name),
         paste0(temp$names, " is a ", temp$gender, " name, ranked ",
                temp$rank, " of the 49,857 babies registered in Scotland in 2019, with ", temp$number, " babies born."))

}



