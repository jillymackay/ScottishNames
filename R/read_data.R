# Data read

library(tidyverse)

scot_names <- readxl::read_excel("~/data/babies-first-names-19-table5.xlsx",
                            skip = 4) %>% 
  janitor::clean_names() %>% 
  rename(boy_rank = rank1_1,
         boy_number = number_of_babies_3,
         girl_rank = rank1_6,
         girl_number = number_of_babies_8) %>% 
  select(-c(nb_4, x5, nb_9)) 

girls <- scot_names %>% 
  select(girl_rank, girls_names, girl_number) %>% 
  mutate(gender = "girls") %>% 
  filter(!is.na(girls_names)) %>% 
  rename(names = girls_names,
         rank = girl_rank,
         number = girl_number)
boys <- scot_names %>% 
  select(boy_rank, boys_names, boy_number) %>% 
  mutate(gender = "boys") %>% 
  filter(!is.na(boys_names)) %>% 
  rename(names = boys_names,
         rank = boy_rank,
         number = boy_number)
rm(girls, boys)

scot_names<- girls %>% 
  full_join(boys)

write.csv("~/data/scot_names.csv", x = scot_names)
