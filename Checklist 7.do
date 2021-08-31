use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

******Checklist 7: revamped to run for A_B sub sample and year specific treatment

*Generating year specific treatment for public sector banks
	gen blah = 1 if cap_infuse_amount !=. & A_B !=.
	replace blah = 0 if cap_infuse_amount ==. & A_B !=.

	bysort co_name year:egen pub_yr_treat= total(blah) if A_B !=.
	replace pub_yr_treat=1 if pub_yr_treat>1 & pub_yr_treat !=.
	label variable pub_yr_treat "Year specific Treatment"
	
	drop blah
	
*Generating year specific treat_post 
	gen pub_yr_treat_post = post_inf_dummy*pub_yr_treat
	label variable pub_yr_treat_post "Year specific Treatment x Post Infusion Dummy"
	
*Generating year specific treat_post_median 
	gen pub_yr_treat_post_median = median_ruled_dummy*pub_yr_treat
	label variable pub_yr_treat_post_median "Year specific Treatment x Post x Large Infusions"
	
*Generating lagged FV's
	foreach var in total_debt_to_common_equity total_debt_to_total_capital debt_to_total_assets interest_coverage_ratio tier_1_ratio{
		bysort co_name: gen lagg_`var' = `var'[_n-4]
	}
	*

	label variable lagg_total_debt_to_common_equity "Lagged Debt to Equity"
	label variable lagg_total_debt_to_total_capital "Lagged Debt to Total Capital"
	label variable lagg_debt_to_total_assets "Lagged Total Assets"
	label variable lagg_interest_coverage_ratio "Lagged Interest Coverage Ratio"
	label variable lagg_tier_1_ratio "Lagged Tier 1 Ratio"




********************************************Table 7 based Heckman (with year specific treatment vars)**************************************************

global IV1 lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio i.year i.id

global IV2 lag_cf_beta lag_policy_beta i.year i.id

global IV3 lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta i.year i.id

global blah pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta



*For Version 1 Regressions
	foreach alpha in A_B{
		foreach var in pd12_month_100 slope_100 dtd{
				foreach m in IV1 IV2 IV3{
				
						*w/o year, firm, qtr
						heckman `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., two sel(pub_yr_treat $`m') first
						outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha' `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
						addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($blah) label append
						*w/o firm, qtr
						heckman `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., two sel(pub_yr_treat $`m') first
						outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha' `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
						addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($blah) label append
						*w/o year, firm 
						heckman `var' pub_yr_treat pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., two sel(pub_yr_treat $`m') first
						outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha' `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
						addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) keep($blah) label append
						*w/o qtr 
						heckman `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., two sel(pub_yr_treat $`m') first
						outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha' `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
						addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($blah) label append
						*w/o year
						heckman `var' pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., two sel(pub_yr_treat $`m') first
						outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha' `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
						addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) keep($blah) label append
	}
  }
}
*
************************************************************Table 8 Regressions**************************************************
