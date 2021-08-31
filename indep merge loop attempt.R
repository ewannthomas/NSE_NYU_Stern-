

Total_Assets<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Total_Assets")

Total_Assets<-Total_Assets %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Total_Assets)-1),names_to = "id", values_to = "Total_Assets") 

Loan_to_Assets<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Loan_to_Assets")

Loan_to_Assets<-Loan_to_Assets %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Loan_to_Assets)-1),names_to = "id", values_to = "Loan_to_Assets") 

Total_Debt_to_Common_Equity<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Total_Debt_to_Common_Equity")

Total_Debt_to_Common_Equity<-Total_Debt_to_Common_Equity %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Total_Debt_to_Common_Equity)-1),names_to = "id", values_to = "Total_Debt_to_Common_Equity")
Total_Debt_to_Total_Capital<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Total_Debt_to_Total_Capital")

Total_Debt_to_Total_Capital<-Total_Debt_to_Total_Capital %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Total_Debt_to_Total_Capital)-1),names_to = "id", values_to = "Total_Debt_to_Total_Capital")
  
Deposits<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Deposits")

Deposits<-Deposits %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Deposits)-1),names_to = "id", values_to = "Deposits")

ROE<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "ROE")

ROE<-ROE %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(ROE)-1),names_to = "id", values_to = "ROE") 
  
Tier_1_capital<-readxl::read_excel("./Mother/Independent Variables/Indeps.xlsx", sheet = "Tier_1_capital")

Tier_1_capital<-Tier_1_capital %>% select(-`41860`) %>% 
  pivot_longer(., 2:(ncol(Tier_1_capital)-1),names_to = "id", values_to = "Tier_1_capital")
  



remodel<-function(data){
  data<-data %>% mutate(quarter=stringr::str_sub(`Prowess id`, start = 1L, end = 2L),
         year=stringr::str_sub(`Prowess id`,start = 4L, end = 7L),
         date= lubridate::yq(paste0(year," ",quarter)),
         quarter=lubridate::quarter(date, with_year = F, fiscal_start = 1),
         year=lubridate::year(date),
         id=as.double(id)) %>% 
  arrange(id, year, quarter) %>%
  filter(date>="2008-01-01" & date<"2019-01-01") %>%
  select(id, year, quarter, Total_Assets)
  
  return(data)
  
}

Total_Assets<-remodel(noquote(Total_Assets))

vars= c("Total_Assets","ROE","Deposits", "Loan_to_Assets", "Tier_1_capital", "Total_Debt_to_Common_Equity", "Total_Debt_to_Total_Capital")

vars=c(Total_Assets, ROE, Deposits, Loan_to_Assets, Tier_1_capital,Total_Debt_to_Common_Equity,Total_Debt_to_Total_Capital)
       
lapply(vars, function(x){
  remodel(x)
})
