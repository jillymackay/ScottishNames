# Search names

library(tidyverse)

all_names <- read.csv("data/all_names.csv") %>% 
  select(-X) %>% 
  mutate(names = tolower(names))




how_popular <- function(name) {
  name <- tolower(name)
  x <- enquo(name)
  
  temp <- all_names %>% 
    filter(names == !!x) 
  
  print(paste0("In 2019, there were 49,857 babies born in Scotland, and 583,969 babies born in the Rest of the UK"))
  
  if(nrow(temp) == 0){print(paste0("None were regstered with the name ", name))}
  
  if(nrow(temp) >0){print(paste0(temp$names, " was a ", temp$gender, " name, ranked ", temp$rank, " of the baby names registered in ", 
                           temp$country, " in 2019, with ", temp$number, " babies born."))}
  
}

how_popular("Connell")



