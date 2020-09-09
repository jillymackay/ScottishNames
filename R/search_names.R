# Search names

library(tidyverse)

scot_names <- read.csv("data/scot_names.csv") %>% 
  select(-X) %>% 
  mutate(names = tolower(names))

all_names <- read.csv("data/all_names.csv") %>% 
  select(-X) %>% 
  mutate(names = tolower(names))



search_scotnames <- function(name) {
  name <-tolower(name)
  x <- enquo(name)
  
  temp <- scot_names %>% 
    filter(names == !!x)
  
  ifelse(nrow(temp) ==0, 
         paste0("Of 49,857 babies born in Scotland in 2019, none were registered with the name ", name),
         paste0(temp$names, " is a ", temp$gender, " name, ranked ",
                temp$rank, " of the 49,857 babies registered in Scotland in 2019, with ", temp$number, " babies born."))

}



search_names <- function(name) {
  name <- tolower(name)
  x <- enquo(name)
  
  temp <- all_names %>% 
    filter(names == !!x) 
  
  ifelse(nrow(temp) ==0, 
         paste0("In 2019, there were 49,857 babies born in Scotland, and 583,969 babies born in the Rest of the UK. None were regstered with the name ", name),
         paste0(temp$names, " is a ", temp$gender, " name, ranked ",
                temp$rank, " of the 49,857 babies registered in ", temp$country, " in 2019, with ", temp$number, " babies born."))
  
}





search_all <- function(name) {
  name <- tolower(name)
  x <- enquo(name)
  
  temp <- all_names %>% 
    filter(names == !!x) 
  
  paste0(temp$names, " is a ", temp$gender, " name, ranked ",
                temp$rank, " of the 49,857 babies registered in ", temp$country, 
         " in 2019, with ", temp$number, " babies born.")
  
}

search_names("Charlie")

search_all("Matt")


search_scotnames("Jamie")
