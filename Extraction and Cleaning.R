
library(tidyverse)

# Importing Systemic Risk Files ---------------------------------------------------------

sys_mother<-readr::read_csv("./Mother/sysriskvariables_v6.csv")

sys_mother<- sys_mother %>% 
  mutate(date = lubridate::dmy(date)) %>%
  filter(date>="2008-03-31" & date<"2019-03-31") %>% 
  arrange(id, date) %>% mutate(year=lubridate::year(date),
                      quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1)) %>% 
  filter(id!=41860) %>% select(1,15,16,2,5:14)


#eeptools::isid(sys_mother, vars = c("id","year","quarter"))

# Importing PD Files ------------------------------------------------------
PD_mother<-readxl::read_excel("./Mother/All_PD_clean data.xlsx")

PD_mother<- PD_mother %>% rename(id=prowesscode,
                     quarter=qtr) %>% 
  filter(year>="2008" & year<"2019") %>%
  mutate(quarter= case_when(
    is.na(month) ~ NA_real_,
    month<=3 ~ 1,
    month>3 & month<=6 ~ 2,
    month>6 & month<=9 ~ 3,
    month>9 & month<=12 ~ 4,
    TRUE ~ 99)) %>% arrange(id,year,quarter) %>%  subset(.,id!=41860)

PD_mother<-PD_mother %>% group_by(id, year, quarter) %>% mutate(row=max(row_number())) %>% 
  arrange(row)
PD_mother<- PD_mother[,c(1,3,2,13, 6:12)]

vlah<- sys_mother %>% filter(id==236328)

#readr::write_csv(PD_mother, "./Mother/Reformed Mother/All PD Data Mother Reformed.csv", na="")



# Importing DTD Files -----------------------------------------------------

DTD_mother<-readxl::read_excel("./Mother/All_DTD_clean data.xlsx")

DTD_mother<-DTD_mother %>% rename(id=prowesscode,
                                  quarter=QTR) %>% 
  filter(year>="2008" & year<"2019") %>%
  mutate(quarter= case_when(
    is.na(month) ~ NA_real_,
    month<=3 ~ 1,
    month>3 & month<=6 ~ 2,
    month>6 & month<=9 ~ 3,
    month>9 & month<=12 ~ 4,
    TRUE ~ 99)) %>% arrange(id,year,quarter) %>%  subset(.,id!=41860)

eeptools::isid(DTD_mother, vars = c("id", "year", "quarter" ))

DTD_mother<-DTD_mother %>% group_by(id, year, quarter) %>% mutate(row=max(row_number())) %>% 
  arrange(row)

#readr::write_csv(DTD_mother, "./Mother/Reformed Mother/All DTD_Data_Mother_Reformed.csv", na="")

# Matching Id's with company names ----------------------------------------

co_id<- sys_mother %>% distinct(id, category)

co_names<-readxl::read_excel("./Mother/Datastream_data extraction for all groups.xlsx", sheet ="cleaned" )

#for cleaning the co names
co_names$co_name<-stringr::str_replace(co_names$co_name,"2008","")

co_name_id<-left_join(co_names, co_id, by="id")

co_sys_pd<-left_join(co_id,co_names, by="id")



# Creating ID- Quarter Layout for Capital Infusion Data -------------------
#cap_infuse_amount<- sys_mother %>% distinct(id, year, quarter, category)
#readr::write_csv(cap_infuse_amount, "./Mother/All cap_infuse_amount data cleaned.csv", na="")
cap_infuse_amount_mother<- readr::read_csv("./Mother/All cap_infuse_amount data cleaned.csv")


# Independent Vars Cleaning -----------------------------------------------------
Total_Assets<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Total_Assets")

Total_Assets<-Total_Assets %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Total_Assets)-1),names_to = "id", values_to = "Total_Assets") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Total_Assets)
 
  
Loan_to_Assets<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Loan_to_Assets")

Loan_to_Assets<-Loan_to_Assets %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Loan_to_Assets)-1),names_to = "id", values_to = "Loan_to_Assets") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Loan_to_Assets)


Total_Debt_to_Common_Equity<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Total_Debt_to_Common_Equity")

Total_Debt_to_Common_Equity<-Total_Debt_to_Common_Equity %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Total_Debt_to_Common_Equity)-1),names_to = "id", values_to = "Total_Debt_to_Common_Equity") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Total_Debt_to_Common_Equity)

Total_Debt_to_Total_Capital<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Total_Debt_to_Total_Capital")

Total_Debt_to_Total_Capital<-Total_Debt_to_Total_Capital %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Total_Debt_to_Total_Capital)-1),names_to = "id", values_to = "Total_Debt_to_Total_Capital") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Total_Debt_to_Total_Capital)

Deposits<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Deposits")

Deposits<-Deposits %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Deposits)-1),names_to = "id", values_to = "Deposits") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Deposits)


ROE<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "ROE")

ROE<-ROE %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(ROE)-1),names_to = "id", values_to = "ROE") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, ROE)


Tier_1_capital<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Tier_1_capital")

Tier_1_capital<-Tier_1_capital %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Tier_1_capital)-1),names_to = "id", values_to = "Tier_1_capital") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Tier_1_capital)


CF_beta<-readxl::read_excel("./Mother/Independent Variables/Capflows_ Ecoc Policy_Uncert_betas.xlsx", sheet = "Ret_cap inflows_betas")

CF_beta<-CF_beta %>% tidyr::pivot_longer(.,3:84,names_to = "id", values_to = "CF_beta") %>% 
  mutate(id= as.double(id)) %>% 
  filter(year>=2008 & year<2019, id!=41860) %>%
  select(3,2,1,4) %>% 
  arrange(id, year, quarter)




Policy_Uncert_Beta<-readxl::read_excel("./Mother/Independent Variables/Capflows_ Ecoc Policy_Uncert_betas.xlsx", sheet = "Ret_Ecnomic_Policy_Uncert_betas")

Policy_Uncert_Beta<-Policy_Uncert_Beta %>% tidyr::pivot_longer(.,3:84,names_to = "id", values_to = "Policy_Beta") %>% 
  mutate(id= as.double(id)) %>% 
  filter(year>=2008 & year<2019, id!=41860) %>%
  select(3,2,1,4) %>% 
  arrange(id, year, quarter)

local_us<- readxl::read_excel("./Mother/Independent Variables/Local US Factors.xlsx")

local_us<-local_us %>% mutate(quarter=stringr::str_sub(qy, start = 1L, end = 2L),
                      year=stringr::str_sub(qy,start = 4L, end = 7L),
                      date= lubridate::yq(paste0(year," ",quarter)),
                      quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
                      year=lubridate::year(date),
                      vix= vix-lag(vix)) %>% 
  filter(year>=2008 & year<2019) %>% 
  select(9,8,3:7) %>% arrange(year, quarter)


Interest_coverage_ratio<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Interest_coverage_ratio")

Interest_coverage_ratio<-Interest_coverage_ratio %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Interest_coverage_ratio)-1),names_to = "id", values_to = "Interest_coverage_ratio") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Interest_coverage_ratio)


Mkt_to_book<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Mkt_to_book")

Mkt_to_book<-Mkt_to_book %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Mkt_to_book)-1),names_to = "id", values_to = "Mkt_to_book") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Mkt_to_book)


Tier_1_ratio<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Tier_1_ratio")

Tier_1_ratio<-Tier_1_ratio %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Tier_1_ratio)-1),names_to = "id", values_to = "Tier_1_ratio") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Tier_1_ratio)


Long_Term_Debt<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Long_Term_Debt")

Long_Term_Debt<-Long_Term_Debt %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Long_Term_Debt)-1),names_to = "id", values_to = "Long_Term_Debt") %>% 
  mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Long_Term_Debt)



Indeps<-left_join(Total_Assets, ROE, by=c("id","year", "quarter")) %>% 
  left_join(., Deposits, by=c("id","year", "quarter")) %>% 
  left_join(., Loan_to_Assets, by=c("id","year", "quarter")) %>% 
  left_join(., Tier_1_capital, by=c("id","year", "quarter")) %>% 
  left_join(., Total_Debt_to_Common_Equity, by=c("id","year", "quarter")) %>% 
  left_join(., Total_Debt_to_Total_Capital, by=c("id","year", "quarter")) %>% 
  left_join(., CF_beta, by=c("id","year", "quarter")) %>%
  left_join(., Policy_Uncert_Beta, by=c("id","year", "quarter")) %>%
  left_join(., Interest_coverage_ratio, by=c("id","year", "quarter")) %>%
  left_join(., Mkt_to_book, by=c("id","year", "quarter")) %>%
  left_join(., Tier_1_ratio, by=c("id","year", "quarter")) %>%
  left_join(., Long_Term_Debt, by=c("id","year", "quarter")) %>%
  left_join(., local_us, by=c("year", "quarter")) %>% 
  mutate(Debt_to_total_assets = Long_Term_Debt/Total_Assets,
         Deposits_to_total_assets = Deposits/Total_Assets)



#bb<-c("Total_Assets", "Total_Debt_to_Common_Equity", "Total_Debt_to_Total_Capital", 
      #"Loan_to_Assets", "Interest_coverage_ratio", "Mkt_to_book", "ROE", "Deposits_to_Total_assets")
  

  

readr::write_csv(Indeps, "./Mother/Reformed Mother/Indeps Reformed.csv", na="")

remove(Total_Assets,ROE,Deposits,Loan_to_Assets, Tier_1_capital,Total_Debt_to_Common_Equity,
       Total_Debt_to_Total_Capital, CF_beta, local_us, Policy_Uncert_Beta, Interest_coverage_ratio, Mkt_to_book,
       Tier_1_ratio, Long_Term_Debt)

#blah<-Indeps %>% distinct(id)

#eeptools::isid(Indeps, vars = c("id","year","quarter"))


# PD Mother 2 -------------------------------------------------------------
PD_mother2<-readxl::read_excel("./Mother/All_PD_clean data2.xlsx", guess_max = 5000) 

PD_mother2<- PD_mother2 %>% rename(id=prowesscode,
                                   quarter=qtr) %>% 
  filter(year>="2008" & year<"2019") %>% 
  mutate(id= case_when(
    is.na(name) ~ id,
    name=="SBI" ~ 236328,
    name=="SBM" ~ 236335,
    name=="SBT" ~ 236339,
    TRUE ~ id
  ))  %>% 
  filter(id!=41860) %>% 
  group_by(id, year, quarter) %>% 
  mutate(row=max(row_number())) %>% 
  ungroup %>% 
  arrange(id, year, quarter) %>% 
  filter(row!=2) %>% select(1:3, 6:12)



# DTD Mother 2 ------------------------------------------------------------
DTD_mother2<-readxl::read_excel("./Mother/All_DTD_clean data2.xlsx", guess_max = 5000) 

DTD_mother2<- DTD_mother2 %>% rename(id=prowesscode,
                                   quarter=Qtr) %>% 
  filter(year>="2008" & year<"2019") %>% 
  mutate(id= case_when(
    is.na(name) ~ id,
    name=="SBI" ~ 236328,
    name=="SBM" ~ 236335,
    name=="SBT" ~ 236339,
    TRUE ~ id
  ))  %>% 
  filter(id!=41860) %>% 
  group_by(id, year, quarter) %>% 
  mutate(row=max(row_number())) %>% 
  ungroup %>% select(1:3,6) %>% 
  arrange(id, year, quarter)

# Network Risk  -----------------------------------------------------------
Network_risk<- readr::read_csv("./Mother/Network Risk.csv")

Network_risk<-Network_risk %>% mutate(quarter= lubridate::quarter(QtrEnd, with_year = F, fiscal_start = 1),
                        year= lubridate::year(QtrEnd)) %>% 
  filter(year>=2008 & year<2019) %>% 
  rename(id=Id,
         Network_risk=Decomp) %>% 
  arrange(id, year, quarter) %>% 
  select(2,8,7,6)

#eeptools::isid(Network_risk, vars=c("id", "year", "quarter"))


# Creating Systemic Risk Mother -------------------------------------------
Systemic_Risk_Mother<-sys_mother %>%  #all firms with cap infusions are there in sys mother new
  left_join(Indeps,., by=c("id", "year", "quarter")) %>% 
  left_join(.,cap_infuse_amount_mother, by=c("id", "year", "quarter")) %>% # adding capital infused to the sys risk mother new
  left_join(., co_names,by="id") %>% # adding company names to the sys risk mother new
  select(37,1:3,24,35,25:34,4:23) %>% 
  rename(category=category.x) %>% 
  left_join(.,PD_mother2, by=c("id", "year", "quarter")) %>% 
  left_join(.,DTD_mother2, by=c("id", "year", "quarter")) %>% 
  left_join(.,Network_risk, by=c("id", "year", "quarter")) %>% 
  mutate(category = case_when(
    is.na(id) ~ NA_real_,
    id==95627 ~ 3,
    id==80728 ~ 3,
    id==158427 ~ 3,
    id==194815 ~ 2,
    id==197110 ~ 4,
    id==221313 ~ 4,
    id==236335 ~ 1,
    id==236339 ~ 1,
    id==385630 ~ 4,
    id==386769 ~ 4,
    id==512651 ~ 2,
    id==11019 ~ 0,
    id==15214 ~ 0,
    id==30136 ~ 0,
    id==30148 ~ 0,
    id==30153 ~ 0,
    id==43461 ~ 0,
    id==51380 ~ 0,
    id==98668 ~ 0,
    id==98918 ~ 0,
    id==100283 ~ 0,
    id==164888 ~ 0,
    id==183764 ~ 0,
    id==183861 ~ 0,
    id==236328 ~ 0,
    id==245437 ~ 0,
    id==256249 ~ 0,
    id==257360 ~ 0,
    id==257827 ~ 0,
    id==266114 ~ 0,
    id==539436 ~ 0,
    id==56680 ~ 0,
    TRUE ~ category))

    

Systemic_Risk_Mother<-Systemic_Risk_Mother %>% mutate(HI_Total_Assets = case_when(
  is.na(Total_Assets) ~ NA_real_,
  category==0 & Total_Assets > median(Total_Assets[category==0], na.rm = T) ~ 1,
  category==0 & Total_Assets < median(Total_Assets[category==0], na.rm = T) ~ 0),
  
  HI_Debt_Equity = case_when(
    is.na(Total_Debt_to_Common_Equity) ~ NA_real_,
    category==0 & Total_Debt_to_Common_Equity > median(Total_Debt_to_Common_Equity[category==0], na.rm = T) ~ 1,
    category==0 & Total_Debt_to_Common_Equity < median(Total_Debt_to_Common_Equity[category==0], na.rm = T) ~ 0),
  
  HI_Debt_Capital = case_when(
    is.na(Total_Debt_to_Total_Capital) ~ NA_real_,
    category==0 & Total_Debt_to_Total_Capital > median(Total_Debt_to_Total_Capital[category==0], na.rm = T) ~ 1,
    category==0 & Total_Debt_to_Total_Capital < median(Total_Debt_to_Total_Capital[category==0], na.rm = T) ~ 0),
  
  HI_Debt_Assets = case_when(
    is.na(Debt_to_total_assets) ~ NA_real_,
    category==0 & Debt_to_total_assets > median(Debt_to_total_assets[category==0], na.rm = T) ~ 1,
    category==0 & Debt_to_total_assets < median(Debt_to_total_assets[category==0], na.rm = T) ~ 0),
  
  HI_Interest_Coverage = case_when(
    is.na(Interest_coverage_ratio) ~ NA_real_,
    category==0 & Interest_coverage_ratio > median(Interest_coverage_ratio[category==0], na.rm = T) ~ 1,
    category==0 & Interest_coverage_ratio < median(Interest_coverage_ratio[category==0], na.rm = T) ~ 0),
  
  HI_Loan_Assets = case_when(
    is.na(Loan_to_Assets) ~ NA_real_,
    category==0 & Loan_to_Assets > median(Loan_to_Assets[category==0], na.rm = T) ~ 1,
    category==0 & Loan_to_Assets < median(Loan_to_Assets[category==0], na.rm = T) ~ 0),
  
  HI_Tier_1_ratio = case_when(
    is.na(Tier_1_ratio) ~ NA_real_,
    category==0 & Tier_1_ratio > median(Tier_1_ratio[category==0], na.rm = T) ~ 1,
    category==0 & Tier_1_ratio < median(Tier_1_ratio[category==0], na.rm = T) ~ 0),
  
  HI_Deposits_Assets = case_when(
    is.na(Deposits_to_total_assets) ~ NA_real_,
    category==0 & Deposits_to_total_assets > median(Deposits_to_total_assets[category==0], na.rm = T) ~ 1,
    category==0 & Deposits_to_total_assets < median(Deposits_to_total_assets[category==0], na.rm = T) ~ 0),
  
  HI_Mkt_Book = case_when(
    is.na(Mkt_to_book) ~ NA_real_,
    Mkt_to_book > median(Mkt_to_book[category==0], na.rm = T) ~ 1,
    Mkt_to_book < median(Mkt_to_book[category==0], na.rm = T) ~ 0),
  
  HI_ROE = case_when(
    is.na(ROE) ~ NA_real_,
    category==0 & ROE > median(ROE[category==0], na.rm = T) ~ 1,
    category==0 & ROE < median(ROE[category==0], na.rm = T) ~ 0))


readr::write_csv(Systemic_Risk_Mother, "./Mother/Reformed Mother/PD, DTD and Systemic Risk Mother.csv", na="")


# Creating company name list ----------------------------------------------
co_name_list<- haven::read_dta("./PD, DTD and Systemic Risk.dta") %>% 
  select (co_name, id, category) %>% 
  distinct(co_name, id, category) %>% 
  arrange(category)
writexl::write_xlsx(co_name_list, "./Company Names List.xlsx")


# Network vars for checklist ----------------------------------------------




Network_risk<- readr::read_csv("./Mother/Network Risk.csv")

Network_risk<-Network_risk %>% mutate(quarter= lubridate::quarter(QtrEnd, with_year = F, fiscal_start = 1),
                                      year= lubridate::year(QtrEnd)) %>% 
  filter(year>=2008 & year<2019) %>% 
  rename(id=Id,
         Network_risk=Decomp) %>% 
  arrange(id, year, quarter) %>% 
  select(-1)

haven::write_dta(Network_risk, "./Mother/Reformed Mother/Network.dta", version = 13)
# Saving work space --------------------------------------------------------
save.image("E:/Canada Project/First Men.RData")






