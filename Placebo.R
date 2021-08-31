library(tidyverse)
library(haven)


Risk<- haven::read_dta("./PD, DTD and Systemic Risk.dta")

Co_name_list<-Risk %>% filter(!is.na(cap_infuse_amount)) %>% select() %>%  distinct(co_name, id, category, post_inf_dummy) %>% arrange(category, co_name)

Inf_time<-Risk %>% filter(!is.na(cap_infuse_amount)) %>% 
  select(year, quarter, post_inf_dummy) %>% 
  distinct(year, quarter, post_inf_dummy) %>% arrange(year, quarter)

pivot_wider(names_from = "quarter", values_from = "post_inf_dummy")

placebo_df<-Risk %>% distinct(year, quarter) %>% mutate(placebo = runif(44),
                                            placebo = case_when(placebo > 0.5 ~ 1,
                                                                placebo < 0.5 ~ 0))

readr::write_csv(placebo_df,"./Mother/Reformed Mother/Placebo.csv", na="")





Inf_time<-Risk %>% filter(!is.na(cap_infuse_amount)) %>% select(year, quarter, post_inf_dummy) %>% distinct(year, quarter) %>% arrange(year, quarter)
writexl::write_xlsx(Inf_time,"./inf quarters.xlsx")
