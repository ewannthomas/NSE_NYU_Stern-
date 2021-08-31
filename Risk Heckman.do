************************************************************************ V1 Heckman Results********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"


**For PD
global IV lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_cf_beta lag_policy_beta

**Heckman for PD (VCE)

foreach alpha in A_C A_E{
	foreach var in dtd {
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
**
foreach alpha in A_D{
	foreach var in dtd {
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
**


**For Sys Risk
foreach alpha in A_B{
	foreach var in mes_1p_100 mes_5p_100 covar_1p_100{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
**

foreach alpha in A_C{
	foreach var in mes_1p_100 mes_5p_100 nsrisk_5p_100 covar_1p_100{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
**


foreach alpha in A_D{
	foreach var in mes_1p_100 mes_5p_100 covar_1p_100{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
**

foreach alpha in A_E{
	foreach var in mes_1p_100 mes_5p_100{
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
**

***For Network Risk

*Note: A_B doesnt optimize
foreach alpha in A_C{
		*w/o year, firm, qtr
		heckman network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk VCE) V1 `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman network_risk treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk VCE) V1 `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
**
foreach alpha in A_D{
		heckman network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk VCE) V1 `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk VCE) V1 `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
**

foreach alpha in A_E{
		heckman network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk VCE) V1 `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $IV) first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk VCE) V1 `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
**

*works for Heck-dtd
*works for Heck-nsrisk_5p_100 mes_1p_100 mes_5p_100 covar_1p_100 


*doesnt work for Heck-nsrisk_1p_100 covar_5p_100
*doesnt work for Heck-pd12_month_100 slope_100



************************************************************************ V2 Heckman Results********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"


**For PD
global IV1 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets

global IV2 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_cf_beta

global IV3 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_policy_beta

**Heckman for PD (VCE)

foreach alpha in A_C A_E{
	foreach var in dtd {
		foreach m in IV1 IV2 IV3 {
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**
foreach alpha in A_D{
	foreach var in dtd {
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK VCE) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**


**For Sys Risk
foreach alpha in A_B{
	foreach var in mes_1p_100 mes_5p_100 covar_1p_100{
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**

foreach alpha in A_C{
	foreach var in mes_1p_100 mes_5p_100 covar_1p_100{
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**
foreach alpha in A_C{
	foreach var in nsrisk_5p_100{
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**



foreach alpha in A_D{
	foreach var in mes_1p_100 mes_5p_100 covar_1p_100{
	 foreach m in IV1 IV2 IV3{
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**

foreach alpha in A_E{
	foreach var in mes_1p_100{
		foreach m in IV1 IV2 IV3{
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**

foreach alpha in A_E{
	foreach var in mes_5p_100{
		foreach m in IV1 IV2{
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK VCE) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**



*works for Heck-dtd
*works for Heck-nsrisk_5p_100 mes_1p_100 mes_5p_100 covar_1p_100 


*doesnt work for Heck-nsrisk_1p_100 covar_5p_100
*doesnt work for Heck-pd12_month_100 slope_100




***For Network Risk

global IV1 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets

global IV2 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_cf_beta

global IV3 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_policy_beta


foreach alpha in A_B {
	foreach var in network_risk {
		foreach m in IV2 {
				heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK VCE) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
***

foreach alpha in A_D {
	foreach var in network_risk {
		foreach m in IV1 IV2 IV3 {
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK VCE) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**

foreach alpha in A_D {
	foreach var in network_risk {
		foreach m in IV2 IV3 {
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK VCE) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
***




foreach alpha in A_E {
	foreach var in network_risk {
		foreach m in IV1 IV2{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK VCE) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**

foreach alpha in A_E {
	foreach var in network_risk {
		foreach m in IV1 IV2 IV3 {
				heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		vce(cl id) select(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK VCE) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		adds(Mills, e(lambda), SE of Mills, e(selambda)) addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
***



************************************************************************ V3 Heckman Results (w/o VCE Robust)********************************************************************************
**For PD
global IV1 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets

global IV2 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_cf_beta

global IV3 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_policy_beta

**Heckman for PD ()

foreach alpha in A_E{
	foreach var in dtd {
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		two sel (treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**
foreach alpha in A_C{
	foreach var in pd12_month_100 slope_100 dtd {
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		two sel (treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**

foreach alpha in A_D{
	foreach var in dtd {
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		two sel (treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(PD RISK ) `alpha'.xls", excel title("Table 10 Heckman Selection Bias Adjusted Regression of PD Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**


**For Sys Risk
foreach alpha in A_B{
	foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK ) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK ) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		two sel (treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK ) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**

foreach alpha in A_C{
	foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK ) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK ) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		two sel (treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(SYS RISK ) `alpha'.xls", excel title("Table 11 Heckman Selection Bias Adjusted Regression of Systemic Risk Variables") ///
		 addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
}
}
}
**




*works for Heck-dtd
*works for Heck-nsrisk_5p_100 mes_1p_100 mes_5p_100 covar_1p_100 


*doesnt work for Heck-nsrisk_1p_100 covar_5p_100
*doesnt work for Heck-pd12_month_100 slope_100




***For Network Risk

global IV1 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets

global IV2 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_cf_beta

global IV3 lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_deposits_to_total_assets lag_policy_beta


foreach alpha in A_B{
	foreach var in network_risk{
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK ) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK ) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		two sel (treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK ) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append

}
}
}
**


foreach alpha in A_C{
	foreach var in network_risk{
		foreach m in IV1 IV2 IV3{
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK ) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		heckman `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., ///
		two sel(treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK ) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		heckman `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., ///
		two sel (treat_dummy $`m') first
		outreg2 using "E:\Canada Project\Results\ Heckman(Network Risk RISK ) `alpha'.xls", excel title("Table 12 Heckman Selection Bias Adjusted Regression of Network Risk") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append

}
}
}
**
