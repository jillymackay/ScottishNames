# Data read

library(tidyverse)



ruk_boys <-readxl::read_excel("data/2019boysnames.xlsx", 
                               sheet = "Table 6", skip = 4) %>% 
  select(rank = Rank,
         names = Name,
         number = Count3) %>% 
  mutate(gender = "boys",
         country = "rUK")

ruk_girls <-readxl::read_excel("data/2019girlsnames.xlsx", 
                               sheet = "Table 6", skip = 4) %>% 
  select(rank = Rank,
         names = Name,
         number = Count3) %>% 
  mutate(gender = "girls",
         country = "rUK")

ruk_names <- ruk_girls %>% 
  full_join(ruk_boys) %>% 
  mutate(rank = as.character(rank))

rm(ruk_boys, ruk_girls)


scot_names <- readxl::read_excel("~/data/ScottishNames/data/babies-first-names-19-table5.xlsx",
                            skip = 4) %>% 
  janitor::clean_names() %>% 
  rename(boy_rank = rank1_1,
         boy_number = number_of_babies_3,
         girl_rank = rank1_6,
         girl_number = number_of_babies_8) %>% 
  select(-c(nb_4, x5, nb_9)) 

girls <- scot_names %>% 
  select(girl_rank, girls_names, girl_number) %>% 
  mutate(gender = "girls",
         country = "Scotland") %>% 
  filter(!is.na(girls_names)) %>% 
  rename(names = girls_names,
         rank = girl_rank,
         number = girl_number)
boys <- scot_names %>% 
  select(boy_rank, boys_names, boy_number) %>% 
  mutate(gender = "boys",
         country = "Scotland") %>% 
  filter(!is.na(boys_names)) %>% 
  rename(names = boys_names,
         rank = boy_rank,
         number = boy_number)


scot_names<- girls %>% 
  full_join(boys)

rm(girls, boys)

all_names <- scot_names %>% 
  full_join(ruk_names)

write.csv("~/data/ScottishNames/data/all_names.csv", x = all_names)
