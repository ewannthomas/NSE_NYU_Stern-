
* RUN this script to get regressions and chnages mentioned in the checklist received from Prof.Madhu on July 20, 2021

use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

******Checklist 2:

*Generating year specific treatment for public sector banks
	gen blah = 1 if cap_infuse_amount !=. & A_B !=.
	replace blah = 0 if cap_infuse_amount ==. & A_B !=.

	bysort co_name year:egen pub_yr_treat= total(blah) if A_B !=.
	replace pub_yr_treat=1 if pub_yr_treat>1 & pub_yr_treat !=.
	label variable pub_yr_treat "Year specific Treatment"
	
	
*Generating year specific treat_post 
	gen pub_yr_treat_post = post_inf_dummy*pub_yr_treat
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-1]==1 & quarter[_n-1]==3
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-2]==1 & quarter[_n-2]==3
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-1]==1 & quarter[_n-1]==4
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-2]==1 & quarter[_n-2]==4
	label variable pub_yr_treat_post "Year specific Treatment x Post Infusion Dummy"
	
*Generating year specific treat_post_median 
	gen pub_yr_treat_post_median = median_ruled_dummy*pub_yr_treat_post
	label variable pub_yr_treat_post_median "Year specific Treatment x Post x Large Infusions"

	drop blah

********************************************Table 7 Regressions (with year specific treatment vars)**************************************************

*For Version 1 Regressions
	foreach alpha in A_B{
		foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o firm, qtr
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' pub_yr_treat pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' pub_yr_treat pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*
************************************************************Table 8 Regressions**************************************************
*For Version 1 Regressions
	foreach alpha in A_B{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' pub_yr_treat pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' pub_yr_treat pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*
************************************************************************Table 9 Network Risk********************************************************************************

*For Version 1 Regressions
	foreach alpha in A_B{
		foreach var in network_risk{
		*w/o year, firm, qtr
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' pub_yr_treat pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' pub_yr_treat pub_yr_treat_post pub_yr_treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*
********************************************************************************************************************************


******Checklist 4:
	
	*creating large inf based on number of infusions received by a firm between 2008 & 2018
	bysort id: egen cap_inf_count = count( cap_infuse_amount) if  cap_infuse_amount!=. & A_B !=.
	gen large_inf_times = 1 if cap_inf_count>7
	replace large_inf_times = 0 if cap_inf_count<7
	label variable large_inf_times "Large Infusions (Number of Infusions)"
	
	*creating treat x post x large
	gen treat_post_large_times = treat_dummy*post_inf_dummy*large_inf_times
	label variable treat_post_large_times "Treatment x Post x Large Infusions (Number of Infusions)"




********************************************Table 7 Regressions (with capital infusion times based Large Infusion Variable)**************************************************

*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_large_times local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_post treat_post_large_times local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

********************************************Table 8 Regressions (with capital infusion times based Large Infusion Variable)**************************************************

*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_large_times local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_post treat_post_large_times local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

********************************************Table 9 Regressions (with capital infusion times based Large Infusion Variable)**************************************************

*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		*w/o year, firm, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg network_risk treat_dummy treat_post treat_post_large_times large_inf_times local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg network_risk post_inf_dummy treat_post treat_post_large_times local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg network_risk treat_post treat_post_large_times local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
*
********************************************************************************************************************************





********************************************************************************************************************************








******Checklist 5:

	foreach var in total_debt_to_common_equity total_debt_to_total_capital tier_1_capital total_assets interest_coverage_ratio loan_to_assets roe{
		bysort co_name: gen lagg_`var' = `var'[_n-1]
	}
	*

	label variable lagg_tier_1_capital "Lagged Tier1 Capital"
	label variable lagg_total_assets "Lagged Total Assets"
	label variable lagg_interest_coverage_ratio "Lagged Interest Coverage Ratio"
	label variable lagg_loan_to_assets "Lagged Loan to Total Assets"
	label variable lagg_roe "Lagged ROE"

************************************************************Table 7 Regressions**************************************************
*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) with FV `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) with FV `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) with FV `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) with FV `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_post treat_post_median lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) with FV `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

************************************************************Table 8 Regressions**************************************************

*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) with FV `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) with FV `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) with FV `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) with FV `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_post treat_post_median lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) with FV `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

************************************************************************Table 9 Network Risk********************************************************************************

*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in network_risk{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) with FV `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) with FV `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) with FV `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) with FV `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_post treat_post_median lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) with FV `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Lagged FV, YES, Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital lagg_tier_1_capital lagg_total_assets lagg_interest_coverage_ratio lagg_roe local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*
********************************************************************************************************************************
clear










******Checklist 6:

use "E:\Canada Project\Agg Risk Measures.dta"

*Generating first difference of all agg risk measures
foreach var in PD_A_C_sprd PD_A_D_sprd MES_A_C_sprd MES_A_D_sprd COVAR_A_C_sprd COVAR_A_D_sprd NSRISK_A_C_sprd NSRISK_A_D_sprd Network_Risk_A_C_sprd Network_Risk_A_D_sprd{
	gen lag_`var' = `var'[_n-1]
	gen diff_`var' = `var' - lag_`var'
	drop lag_`var'
}
*


*****Agg regressions
foreach alpha in A_C A_D{
	foreach var in diff_PD_`alpha'_sprd diff_MES_`alpha'_sprd diff_COVAR_`alpha'_sprd diff_NSRISK_`alpha'_sprd diff_Network_Risk_`alpha'_sprd{
		foreach val in 1 3{
			reg `var' Post_Inf_Dum`val' i.year, vce(rob)
			outreg2 using "E:\Canada Project\Results\ Agg regression `alpha'.xls", excel title("Table 15. Regression of Change in Aggregate Risk Measures over Post Infusion Dummies using Robust Standard Errors") ///
			addtext(Year FE, YES) keep(Post_Inf_Dum`val') label append
		 }
	}
}	
*****
********************************************************************************************************************************
clear


use "E:\Canada Project\PD, DTD and Systemic Risk.dta" 

******Checklist 7:

*Generating Cap Infuse Dummy
	gen cap_infuse=1 if cap_infuse_amount !=.
	replace cap_infuse=0 if cap_infuse_amount ==.

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


	
	
	probit cap_infuse lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio i.year i.id if A_C!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio) label append

	probit cap_infuse lag_cf_beta lag_policy_beta i.year i.id if A_C!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lag_cf_beta lag_policy_beta) label append
	
	probit cap_infuse lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta i.year i.id if A_C!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta) label append


	
	
	
	
******Checklist 8:	
	
	merge 1:1 id year quarter using "E:\Canada Project\Network.dta"
	drop if id==41860
	
foreach alpha in A_C A_D{

	foreach var in Degree BetCent{
		
		foreach m in treat_postlarge_ratio treat_postlarge_ratio_1 treat_postlarge_ratio_2{

		*with year and firm FE
		*reg `var' post_inf_dummy treat_post `m' local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		*outreg2 using "E:\Canada Project\Results\ Table 16 `alpha'.xls", excel title("Table 16. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		*addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) label append
		
		*w/o FE
		reg `var' post_inf_dummy treat_post `m' local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 12 `alpha'.xls", excel title("Table 12. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) label append

		*with quarter FE
		reg `var' post_inf_dummy treat_post `m' local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 12 `alpha'.xls", excel title("Table 12. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) label append

		
		}
	}
}
**

clear	
	
*****************************************************************************************************************************************************************************************************************************************************************************************************************************+







*****************************************************************************************************************************************************************************************************************************************************************************************************************************+
use "E:\Canada Project\PD, DTD and Systemic Risk.dta" 


******Checklist 4 (Revised with sample split based on number of Large Infusions):
	
	*creating large inf based on number of infusions received by a firm between 2008 & 2018
	bysort id: egen cap_inf_count = count( cap_infuse_amount) if  cap_infuse_amount!=. & A_B !=.
	gen large_inf_times = 1 if cap_inf_count>7
	replace large_inf_times = 0 if cap_inf_count<7
	label variable large_inf_times "Large Infusions (Number of Infusions)"
	



********************************************Table 7 Regressions (with capital infusion times based Large Infusion Variable)**************************************************
	foreach val in 0 1{
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year
		reg `var' treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
	}
}
}
*

	

********************************************Table 8 Regressions (with capital infusion times based Large Infusion Variable)**************************************************

*For Version 1 Regressions
	foreach val in 0 1{
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year
		reg `var' treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
	}
}
}
*
	

********************************************Table 9 Regressions (with capital infusion times based Large Infusion Variable)**************************************************

*For Version 1 Regressions
	foreach val in 0 1{
	foreach alpha in A_B A_C A_D A_E{
		*w/o year, firm, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year, firm, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year, firm 
		reg network_risk treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o qtr 
		reg network_risk post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
		*w/o year
		reg network_risk treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=. & large_inf_times==`val', vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) cttop("Large Infusion= `val'") label append
	}
	}
*
********************************************************************************************************************************




******Checklist 7: revamped to run for A_B sub sample

*Generating Cap Infuse Dummy
	gen cap_infuse=1 if cap_infuse_amount !=.
	replace cap_infuse=0 if cap_infuse_amount ==.

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


	
	
	probit cap_infuse lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio i.year i.id if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio) label append

	probit cap_infuse lag_cf_beta lag_policy_beta i.year i.id if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lag_cf_beta lag_policy_beta) label append
	
	probit cap_infuse lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta i.year i.id if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta) label append

	

******Checklist 7: revamped to run for A_B sub sample and year specific treatment

*Generating year specific treatment for public sector banks
	gen blah = 1 if cap_infuse_amount !=. & A_B !=.
	replace blah = 0 if cap_infuse_amount ==. & A_B !=.

	bysort co_name year:egen pub_yr_treat= total(blah) if A_B !=.
	replace pub_yr_treat=1 if pub_yr_treat>1 & pub_yr_treat !=.
	label variable pub_yr_treat "Year specific Treatment"
	
	drop blah
	
	*Generating lagged FV's
	foreach var in total_debt_to_total_capital debt_to_total_assets interest_coverage_ratio tier_1_ratio{
		bysort co_name: gen lagg_`var' = `var'[_n-4]
	}
	*

	label variable lagg_total_debt_to_total_capital "Lagged Debt to Total Capital"
	label variable lagg_debt_to_total_assets "Lagged Total Assets"
	label variable lagg_interest_coverage_ratio "Lagged Interest Coverage Ratio"
	label variable lagg_tier_1_ratio "Lagged Tier 1 Ratio"


	
	probit pub_yr_treat lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio i.year i.id if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio) label append

	probit pub_yr_treat lag_cf_beta lag_policy_beta i.year i.id if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lag_cf_beta lag_policy_beta) label append
	
	probit pub_yr_treat lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta i.year i.id if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Probit version.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Firm FE, YES, Year FE, YES) keep(lagg_total_debt_to_common_equity lagg_total_debt_to_total_capital ///
	lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta) label append

	
	
*Probit Regressions with local, US and Year FE on/off as on 20/08/2021	
global IV1 lagg_total_debt_to_total_capital lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio

global IV2 lag_cf_beta lag_policy_beta

global IV3 lagg_total_debt_to_total_capital lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 lagg_total_debt_to_total_capital lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


	foreach m in IV1 IV2 IV3{
		*Probit for estimating fitted probabilities with local and US factors only
		probit pub_yr_treat $`m' local_factor default_factor level_factor slope_factor if A_B!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Probit `m'.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) ///
		keep($IV4) sortvar($IV4) label append
		
		*Probit for estimating fitted probabilities with local and US factors only
		probit pub_yr_treat $`m' i.year if A_B!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Probit `m'.xls", excel title("Probit Regression with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, YES, Quarter FE, NO) ///
		keep($IV4) sortvar($IV4) label append

}
*

	
clear

use "E:\Canada Project\PD, DTD and Systemic Risk.dta" 
	
	

******Checklist 7: IV regression revamped to run for A_B sub sample and year specific treatment

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

	rename lagg_total_debt_to_common_equity blah
	rename lagg_total_debt_to_total_capital glah
	
********************************************Table 7 based IV (with year specific treatment vars)**************************************************
	
global IV1 blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio

global IV2 lag_cf_beta lag_policy_beta

global IV3 blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


*For Version 1 Regressions

foreach var in pd12_month_100 slope_100 dtd{
	foreach m in IV1 IV2 IV3{
				
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=$`m') if A_B!=., first vce(cl id) 
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=$`m') if A_B!=., first vce(cl id) 
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

	}
}
*
********************************************Table 8 based IV (with year specific treatment vars)**************************************************
	
global IV1 blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio

global IV2 lag_cf_beta lag_policy_beta

global IV3 blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


*For Version 1 Regressions

foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{

	foreach m in IV1 IV2 IV3{
				
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=$`m') if A_B!=., first vce(cl id) 
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=$`m') if A_B!=., first vce(cl id) 
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

	}
}
*
********************************************Table 9 based IV (with year specific treatment vars)**************************************************
	
global IV1 blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio

global IV2 lag_cf_beta lag_policy_beta

global IV3 blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy blah glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta



*For Version 1 Regressions

foreach var in network_risk{

	foreach m in IV1 IV2 IV3{
				
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network Risk VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 9 (Network Risk VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=$`m') if A_B!=., first vce(cl id) 
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network Risk VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 9 (Network Risk VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=$`m') if A_B!=., first vce(cl id)
		
		estat firststage, forcenonrobust
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network Risk VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`r(mineig)') label append
			
			ivregress2 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
			local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=$`m') if A_B!=., first vce(cl id) 
			est restore first
			outreg2 using "E:\Canada Project\Results\ Table 9 (Network Risk VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
			addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("First Stage") label append

	}
}
*

clear

use "E:\Canada Project\PD, DTD and Systemic Risk.dta" 
	
	

******Checklist 7: IV regression (using Forbidden Regression rules) revamped to run for A_B sub sample and year specific treatment

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
	foreach var in total_debt_to_total_capital debt_to_total_assets interest_coverage_ratio tier_1_ratio{
		bysort co_name: gen lagg_`var' = `var'[_n-4]
	}
	*

	label variable lagg_total_debt_to_total_capital "Lagged Debt to Total Capital"
	label variable lagg_debt_to_total_assets "Lagged Total Assets"
	label variable lagg_interest_coverage_ratio "Lagged Interest Coverage Ratio"
	label variable lagg_tier_1_ratio "Lagged Tier 1 Ratio"

	rename lagg_total_debt_to_total_capital glah
	
********************************************Table 7 based IV (with year specific treatment vars)**************************************************
	
global IV1 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio

global IV2 lag_cf_beta lag_policy_beta

global IV3 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


*For Version 1 Regressions

	foreach m in IV1 IV2 IV3{
		*Probit for estimating fitted probabilities
		probit pub_yr_treat $`m' i.id i.year if A_B!=., vce(cl id)
		predict pub_yr_treat_`m', xb
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, NO, US Factors, NO, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append
}
*

foreach var in pd12_month_100 slope_100 dtd{
	foreach m in IV1 IV2 IV3{
	
		*IV regression using fitted values as instrument
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id) 
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		

		}
}
*
drop pub_yr_treat_IV1 pub_yr_treat_IV2 pub_yr_treat_IV3

********************************************Table 8 based IV (with year specific treatment vars)**************************************************
	
global IV1 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio

global IV2 lag_cf_beta lag_policy_beta

global IV3 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


*For Version 1 Regressions

	foreach m in IV1 IV2 IV3{
		*Probit for estimating fitted probabilities
		probit pub_yr_treat $`m' i.id i.year if A_B!=., vce(cl id)
		predict pub_yr_treat_`m', xb
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, NO, US Factors, NO, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append
}
*

foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
	foreach m in IV1 IV2 IV3{
	
		*IV regression using fitted values as instrument
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id) 
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		

		}
}
*

drop pub_yr_treat_IV1 pub_yr_treat_IV2 pub_yr_treat_IV3


********************************************Table 9 based IV (with year specific treatment vars)**************************************************
	
global IV1 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio

global IV2 lag_cf_beta lag_policy_beta

global IV3 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


*For Version 1 Regressions

	foreach m in IV1 IV2 IV3{
		*Probit for estimating fitted probabilities
		probit pub_yr_treat $`m' i.id i.year if A_B!=., vce(cl id)
		predict pub_yr_treat_`m', xb
		outreg2 using "E:\Canada Project\Results\ Table 9 (NetworkRISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, NO, US Factors, NO, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append
}
*

foreach var in network_risk{
	foreach m in IV1 IV2 IV3{
	
		*IV regression using fitted values as instrument
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (NetworkRISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.year (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id) 
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (NetworkRISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.quarter (pub_yr_treat=pub_yr_treat_`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (NetworkRISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		

		}
}
*

drop pub_yr_treat_IV1 pub_yr_treat_IV2 pub_yr_treat_IV3

	
********************************************************************************************************************************
	

	
	
	
	                                                  * 2SLS IV REGRESSION CODES (USE THIS FOR REPRODUCTION)
********************************************************************************************************************************
	
clear

use "E:\Canada Project\PD, DTD and Systemic Risk.dta" 
	


******Checklist 7: Final IV regression (using Forbidden Regression rules) revamped to run for A_B sub sample and year specific treatment

*Generating year specific treatment for public sector banks
	gen blah = 1 if cap_infuse_amount !=. & A_B !=.
	replace blah = 0 if cap_infuse_amount ==. & A_B !=.

	bysort co_name year:egen pub_yr_treat= total(blah) if A_B !=.
	replace pub_yr_treat=1 if pub_yr_treat>1 & pub_yr_treat !=.
	label variable pub_yr_treat "Year specific Treatment"
	
	
*Generating year specific treat_post 
	gen pub_yr_treat_post = post_inf_dummy*pub_yr_treat
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-1]==1 & quarter[_n-1]==3
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-2]==1 & quarter[_n-2]==3
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-1]==1 & quarter[_n-1]==4
	bysort id: replace pub_yr_treat_post = 1 if blah[_n-2]==1 & quarter[_n-2]==4
	label variable pub_yr_treat_post "Year specific Treatment x Post Infusion Dummy"
	
*Generating year specific treat_post_median 
	gen pub_yr_treat_post_median = median_ruled_dummy*pub_yr_treat_post
	label variable pub_yr_treat_post_median "Year specific Treatment x Post x Large Infusions"

	drop blah

	
*Generating lagged FV's
	foreach var in total_debt_to_total_capital debt_to_total_assets interest_coverage_ratio tier_1_ratio{
		bysort co_name: gen lagg_`var' = `var'[_n-4]
	}
	*

	label variable lagg_total_debt_to_total_capital "Lagged Debt to Total Capital"
	label variable lagg_debt_to_total_assets "Lagged Total Assets"
	label variable lagg_interest_coverage_ratio "Lagged Interest Coverage Ratio"
	label variable lagg_tier_1_ratio "Lagged Tier 1 Ratio"

	rename lagg_total_debt_to_total_capital glah

	

	
********************************************Table 7 based Final IV (with year specific treatment vars)**************************************************

*For Version 1 Regressions

global IV3 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


		*Probit for estimating fitted probabilities
		probit pub_yr_treat $IV3 local_factor default_factor level_factor slope_factor if A_B!=., vce(cl id)
		predict pub_yr_treat_local, xb
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B pub_yr_treat_local.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append

		probit pub_yr_treat $IV3 i.year if A_B!=., vce(cl id)
		predict pub_yr_treat_year, xb
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B pub_yr_treat_year.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append


foreach var in pd12_month_100 slope_100 dtd{
	foreach m in pub_yr_treat_local pub_yr_treat_year{
	
		*IV regression using fitted values as instrument
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id i.year (pub_yr_treat=`m') if A_B!=., first vce(cl id) 
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id i.quarter (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		

		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median ///
		local_factor default_factor level_factor slope_factor vix i.id i.year (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median ///
		local_factor default_factor level_factor slope_factor vix i.id i.quarter (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) A_B `m'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append

		
		}
}
*
drop pub_yr_treat_local pub_yr_treat_year

********************************************Table 8 based Final IV (with year specific treatment vars)**************************************************


*For Version 1 Regressions

global IV3 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


		*Probit for estimating fitted probabilities
		probit pub_yr_treat $IV3 local_factor default_factor level_factor slope_factor if A_B!=., vce(cl id)
		predict pub_yr_treat_local, xb
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B pub_yr_treat_local.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append

		probit pub_yr_treat $IV3 i.year if A_B!=., vce(cl id)
		predict pub_yr_treat_year, xb
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B pub_yr_treat_year.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append


foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
	foreach m in pub_yr_treat_local pub_yr_treat_year{
	
		*IV regression using fitted values as instrument
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id i.year (pub_yr_treat=`m') if A_B!=., first vce(cl id) 
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id i.quarter (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		

		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median ///
		local_factor default_factor level_factor slope_factor vix i.id i.year (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median ///
		local_factor default_factor level_factor slope_factor vix i.id i.quarter (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) A_B `m'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append

		
		}
}
*
drop pub_yr_treat_local pub_yr_treat_year


********************************************Table 9 based Final IV (with year specific treatment vars)**************************************************


*For Version 1 Regressions

global IV3 glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta

global IV4 pub_yr_treat post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy glah lagg_debt_to_total_assets lagg_interest_coverage_ratio lagg_tier_1_ratio lag_cf_beta lag_policy_beta


		*Probit for estimating fitted probabilities
		probit pub_yr_treat $IV3 local_factor default_factor level_factor slope_factor if A_B!=., vce(cl id)
		predict pub_yr_treat_local, xb
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) A_B pub_yr_treat_local.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append

		probit pub_yr_treat $IV3 i.year if A_B!=., vce(cl id)
		predict pub_yr_treat_year, xb
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) A_B pub_yr_treat_year.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, NO, US Factors, NO, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Probit Model") label append


foreach var in network_risk{
	foreach m in pub_yr_treat_local pub_yr_treat_year{
	
		*IV regression using fitted values as instrument
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id i.year (pub_yr_treat=`m') if A_B!=., first vce(cl id) 
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
	    addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
			
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median median_ruled_dummy ///
		local_factor default_factor level_factor slope_factor vix i.id i.quarter (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		

		ivregress 2sls `var' post_inf_dummy pub_yr_treat_post pub_yr_treat_post_median ///
		local_factor default_factor level_factor slope_factor vix i.id i.year (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append
		
		
		ivregress 2sls `var' pub_yr_treat_post pub_yr_treat_post_median ///
		local_factor default_factor level_factor slope_factor vix i.id i.quarter (pub_yr_treat=`m') if A_B!=., first vce(cl id)
		
		estat firststage
		matrix cc =  r(singleresults)
		local F1 = cc[1,4]
		
		outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) A_B `m'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors and Year specific Treatment (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) keep($IV4) sortvar($IV4) cttop("Second Stage") addstat(Cragg-Donald Wald F,`F1') label append

		
		}
}
*
drop pub_yr_treat_local pub_yr_treat_year


	
	
********************************************************************************************************************************


******Checklist 8: revamped using baseline regression model of table 9	
	
	merge 1:1 id year quarter using "E:\Canada Project\Network.dta"
	drop if id==41860
	

	foreach var in Degree BetCent{
	foreach alpha in A_B A_C A_D A_E{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy) label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy) label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy) label append
		*w/o year
		reg `var' treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy) label append
	}
}
*

clear

********************************************************************************************************************************
