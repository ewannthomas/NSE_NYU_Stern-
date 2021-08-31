************************************************************Table 8 Regressions**************************************************

use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

*With year FE
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
			reg `var' treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median i.year i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append		
		}
	}
	*
	
*Without Local_US (VCE) and without year FE
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
			reg `var' treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append		
		}
	}
	*


*With Local_US (VCE)and without year FE
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
			reg `var' treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append
		}
	}
	*

*With quarter and without Post Infusion (VCE)
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
			reg `var' treat_dummy median_ruled_dummy treat_post treat_post_median i.quarter i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append		
		}
	}
	*

*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*
	
	
	
	
	

	
********************************************************************************************************************************







************************************************************Table 7 Regressions**************************************************

use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

*With year FE
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
			reg `var' treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median i.year i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append
		}
	}
	*
	
*Without Local_US (VCE) and without year FE
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
			reg `var' treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append
		}
	}
	*


*With Local_US (VCE) and without year FE
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
			reg `var' treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append
		}
	}
	*
	
*With quarter and without Post Infusion (VCE)
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
			reg `var' treat_dummy median_ruled_dummy treat_post treat_post_median i.quarter i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") label append
		}
	}
	*
	
	
	
	
*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*



********************************************************************************************************************************





************************************************************************Table 9 Network Risk********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

*For Version 1 Regressions
	foreach alpha in A_B A_C A_D A_E{
		*w/o year, firm, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg network_risk treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg network_risk post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg network_risk treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 (Network Risk VCE) `alpha'.xls", excel title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
*
********************************************************************************************************************************





************************************************************************IV REGRESSIONS********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

global Indeps post_inf_dummy median_ruled_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id

global IV lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets

**IV for PD (VCE)
foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		ivregress 2sls `var' $Indeps (treat_dummy = $IV) if `alpha'!=., vce(robust)
			outreg2 using "E:\Canada Project\Results\PD IV `alpha' (VCE).xls", excel keep(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			sortvar(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			addtext(Local Factor, YES, US Factors, YES, Firm Fixed Effects, YES) title("IV Regression of PD with Robust Standard Errors") cttop("Second Stage") label append
		ivregress2 2sls `var' $Indeps (treat_dummy = $IV) if `alpha'!=., vce(robust) first
		est restore first
			outreg2 using "E:\Canada Project\Results\PD IV `alpha' (VCE).xls", excel keep(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			sortvar(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			addtext(Local Factor, NO, US Factors, NO, Firm Fixed Effects, NO) title("IV Regression of PD with Robust Standard Errors") cttop("First Stage") label append
	}
}
*
**IV for Sys (VCE)
foreach alpha in A_B A_C A_D A_E{
	foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100 {
		ivregress 2sls `var' $Indeps (treat_dummy = $IV) if `alpha'!=., vce(robust)
			outreg2 using "E:\Canada Project\Results\SYS RISK IV `alpha' (VCE).xls", excel keep(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			sortvar(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			addtext(Local Factor, YES, US Factors, YES, Firm Fixed Effects, YES) title("IV Regression of Systemic Risk Variables with Robust Standard Errors") cttop("Second Stage") label append
		ivregress2 2sls `var' $Indeps (treat_dummy = $IV) if `alpha'!=., vce(robust) first
		est restore first
			outreg2 using "E:\Canada Project\Results\SYS RISK IV `alpha' (VCE).xls", excel keep(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			sortvar(treat_dummy post_inf_dummy median_ruled_dummy treat_post treat_post_median lag_total_debt_to_common_equity lag_total_debt_to_total_capital lag_cf_beta lag_deposits_to_total_assets) ///
			addtext(Local Factor, NO, US Factors, NO, Firm Fixed Effects, NO) title("IV Regression of Systemic Risk Variables with Robust Standard Errors") cttop("First Stage") label append
	}
}
*
********************************************************************************************************************************



foreach alpha in A_E{
	foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100 {
		qui ivregress 2sls `var' $Indeps (treat_dummy = $IV) if `alpha'!=., vce(robust)
 estat endogenous
 estat overid
}
}
*






********************************************************************************************************************************





************************************************************************Table 13 Macro stress periods Regression V1********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"



***For PD Risk
foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		foreach val in 2011 2016 2018{
*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if year==`val' & `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (PD RISK VCE) `alpha'.xls", excel title("Table 13. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy)label append
*w/o year, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id if year==`val' & `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (PD RISK VCE) `alpha'.xls", excel title("Table 13. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy)label append
}
}
}
**


***For sys risk
foreach alpha in A_B A_C A_D A_E{
	foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
		foreach val in 2011 2016 2018{
*w/o year, firm, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if year==`val' & `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (SYS RISK VCE) `alpha'.xls", excel title("Table 13. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy)label append
*w/o year, qtr
		reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id if year==`val' & `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (SYS RISK VCE) `alpha'.xls", excel title("Table 13. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy)label append
}
}
}
**


***For Ntework Risk Variable
foreach alpha in A_B A_C A_D A_E{
	foreach val in 2011 2016 2018{
*w/o year, firm, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if year==`val' & `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (Network RISK VCE) `alpha'.xls", excel title("Table 13. Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy)label append
*w/o year, qtr
		reg network_risk treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id if year==`val' & `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (Network RISK VCE) `alpha'.xls", excel title("Table 13. Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy)label append

}
}
**






********************************************************************************************************************************

************************************************************************Table 13 Macro stress periods Regression V2********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

*For PD Risk
foreach alpha in A_B A_C A_D A_E{
		foreach var in pd12_month_100 slope_100 dtd{
			*w/o year, qtr
			reg `var' treat_dummy post_inf_dummy post_stress treat_post treat_post_stress treat_post_median treat_post_median_stress median_ruled_dummy median_stress ///
			local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 13 (PD RISK VCE) `alpha'.xls", excel title("Table 13. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) ///
			keep(treat_dummy post_inf_dummy post_stress treat_post treat_post_stress treat_post_median treat_post_median_stress median_ruled_dummy median_stress)label append
	}
}
*

*For Sys Risk 
foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
			*w/o year, qtr
			reg `var' treat_dummy post_inf_dummy post_stress treat_post treat_post_stress treat_post_median treat_post_median_stress median_ruled_dummy median_stress ///
			local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 13 (SYS RISK VCE) `alpha'.xls", excel title("Table 13. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) ///
			keep(treat_dummy post_inf_dummy post_stress treat_post treat_post_stress treat_post_median treat_post_median_stress median_ruled_dummy median_stress)label append
	}
}
*

*For Network Risk
 foreach alpha in A_B A_C A_D A_E{
		foreach var in network_risk{
			*w/o year, qtr
			reg `var' treat_dummy post_inf_dummy post_stress treat_post treat_post_stress treat_post_median treat_post_median_stress median_ruled_dummy median_stress ///
			local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 13 (Network Risk VCE) `alpha'.xls", excel title("Table 13. Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) ///
			keep(treat_dummy post_inf_dummy post_stress treat_post treat_post_stress treat_post_median treat_post_median_stress median_ruled_dummy median_stress)label append
	}
}
*



********************************************************************************************************************************




************************************************************************Table 13 Macro stress periods Regression V3********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"



***For PD Risk
foreach alpha in A_C A_D{
	foreach var in pd12_month_100 slope_100 dtd{
		foreach val in 2011 2016 2018{
		
*w/o year, qtr
		reg `var' treat_dummy post_inf_dummy post_stress_`val' treat_post treat_post_stress_`val' treat_post_median treat_post_median_stress_`val' median_ruled_dummy median_stress_`val' ///
		local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (PD RISK VCE) `alpha'.xls", excel title("Table 13. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy post_stress_`val' treat_post treat_post_stress_`val' treat_post_median treat_post_median_stress_`val' median_ruled_dummy median_stress_`val')label append
}
}
}
**


***For sys risk
foreach alpha in A_C A_D{
	foreach var in mes_1p_100 mes_5p_100 nsrisk_1p_100 nsrisk_5p_100 covar_1p_100 covar_5p_100{
		foreach val in 2011 2016 2018{
		
*w/o year, qtr
		reg `var' treat_dummy post_inf_dummy post_stress_`val' treat_post treat_post_stress_`val' treat_post_median treat_post_median_stress_`val' median_ruled_dummy median_stress_`val' ///
		local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (SYS RISK VCE) `alpha'.xls", excel title("Table 13. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy post_stress_`val' treat_post treat_post_stress_`val' treat_post_median treat_post_median_stress_`val' median_ruled_dummy median_stress_`val')label append
}
}
}
**


***For Network Risk Variable
foreach alpha in A_C A_D{
	foreach val in 2011 2016 2018{
*w/o year, qtr
		reg network_risk treat_dummy post_inf_dummy post_stress_`val' treat_post treat_post_stress_`val' treat_post_median treat_post_median_stress_`val' median_ruled_dummy median_stress_`val' ///
		local_factor default_factor level_factor slope_factor vix i.id if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 13 (Network RISK VCE) `alpha'.xls", excel title("Table 13. Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, NO) cttop("Macro Stress Year = `val'") ///
		keep(treat_dummy post_inf_dummy post_stress_`val' treat_post treat_post_stress_`val' treat_post_median treat_post_median_stress_`val' median_ruled_dummy median_stress_`val')label append

}
}
**






********************************************************************************************************************************




************************************************************************Placebo Tests********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"


*For SYS Risk Placebo Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' treat_dummy placebo_post_inf treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy placebo_post_inf treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' placebo_post_inf treat_placebo_post treat_placebopost_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_placebo_post treat_placebopost_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

*For PD Regressions

foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' treat_dummy placebo_post_inf treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy placebo_post_inf treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' placebo_post_inf treat_placebo_post treat_placebopost_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_placebo_post treat_placebopost_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

*For Network Risk
foreach alpha in A_B A_C A_D A_E{
		*w/o year, firm, qtr
		reg network_risk treat_dummy placebo_post_inf treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg network_risk treat_dummy placebo_post_inf treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg network_risk treat_dummy treat_placebo_post treat_placebopost_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg network_risk placebo_post_inf treat_placebo_post treat_placebopost_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg network_risk treat_placebo_post treat_placebopost_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append 
     }
*



****************************

*******Placebo with t-1 infusion dummies

*For SYS Risk Placebo Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt1 treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt1 treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' placebt1 treat_placebt1 treat_placeb1_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_placebt1 treat_placeb1_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

*For PD Regressions

foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt1 treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt1 treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' placebt1 treat_placebt1 treat_placeb1_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_placebt1 treat_placeb1_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

*For Network Risk
foreach alpha in A_B A_C A_D A_E{
		*w/o year, firm, qtr
		reg network_risk treat_dummy placebt1 treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg network_risk treat_dummy placebt1 treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg network_risk treat_dummy treat_placebt1 treat_placeb1_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg network_risk placebt1 treat_placebt1 treat_placeb1_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg network_risk treat_placebt1 treat_placeb1_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append 
     }
*




*******Placebo with t-2 infusion dummies

*For SYS Risk Placebo Regressions
	foreach alpha in A_B A_C A_D A_E{
		foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt2 treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt2 treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' placebt2 treat_placebt2 treat_placeb2_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_placebt2 treat_placeb2_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 8 SYS RISK Placebo (VCE) `alpha'.xls", excel title("Table 8. Placebo Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

*For PD Regressions

foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt2 treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg `var' treat_dummy placebt2 treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg `var' treat_dummy treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg `var' placebt2 treat_placebt2 treat_placeb2_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg `var' treat_placebt2 treat_placeb2_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 7 PD RISK Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
	}
}
*

*For Network Risk
foreach alpha in A_B A_C A_D A_E{
		*w/o year, firm, qtr
		reg network_risk treat_dummy placebt2 treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm, qtr
		reg network_risk treat_dummy placebt2 treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year, firm 
		reg network_risk treat_dummy treat_placebt2 treat_placeb2_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o qtr 
		reg network_risk placebt2 treat_placebt2 treat_placeb2_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append
		*w/o year
		reg network_risk treat_placebt2 treat_placeb2_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 9 Network Risk Placebo (VCE) `alpha'.xls", excel title("Table 7. Placebo Regression of Network Risk with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year)label append 
     }
*








******************************************************************************************



************************************************************************Table 14********************************************************************************

****initial table 14 codes, DO NOT RUN
foreach alpha in A_B A_C A_D A_E{

	foreach m in hi_total_assets hi_debt_equity hi_debt_capital hi_debt_assets hi_interest_coverage hi_loan_assets hi_tier_1_ratio hi_deposits_assets hi_mkt_book hi_roe{
		
		foreach var in pd12_month_100 slope_100 dtd{
		
			foreach val in 1 0{

**temp sun sample filter generations
			gen new_cat = category + `m'
			gen `alpha'_fake = 0 if new_cat == `val'
			replace `alpha'_fake = A_C  if new_cat == .
			replace `alpha'_fake =. if `alpha'_fake== 0 & `m'==.
			
				
				
					*w/o year, firm, qtr
					reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix if `alpha'_fake!=., vce(cl id)
					outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
					addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) ///
					cttop("`m' = `val'")label append
					*w/o year, firm, qtr
					reg `var' treat_dummy post_inf_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.year if `alpha'_fake!=., vce(cl id)
					outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
					addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) ///
					cttop("`m' = `val'")label append
					*w/o year, firm 
					reg `var' treat_dummy treat_post treat_post_median median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'_fake!=., vce(cl id)
					outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
					addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) ///
					cttop("`m' = `val'")label append
					*w/o qtr 
					reg `var' post_inf_dummy treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'_fake!=., vce(cl id)
					outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
					addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) ///
					cttop("`m' = `val'")label append
					*w/o year
					reg `var' treat_post treat_post_median local_factor default_factor level_factor slope_factor vix i.id i.quarter if `alpha'_fake!=., vce(cl id)
					outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
					addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) ///
					cttop("`m' = `val'")label append
					
drop new_cat
drop `alpha'_fake
	                
					}
			}
	  }

}
***





use "E:\Canada Project\PD, DTD and Systemic Risk.dta"
foreach alpha in A_C A_D{

	foreach m in hi_total_assets hi_debt_equity hi_interest_coverage hi_loan_assets hi_tier_1_ratio hi_deposits_assets hi_mkt_book hi_roe{
		
		foreach var in pd12_month_100 slope_100 dtd mes_5p_100 nsrisk_5p_100 covar_5p_100 network_risk{
		
			foreach val in 1 0{

**temp sun sample filter generations
			gen new_cat = category + `m'
			gen `alpha'_fake = 0 if new_cat == `val'
			replace `alpha'_fake = `alpha'  if new_cat == .
			replace `alpha'_fake =. if `alpha'_fake== 0 & `m'==.
			
			
			bysort `m' : egen median_case = median(cap_infuse_amount) if `m'!=.	
			gen median_cose = 1 if median_case > cap_infuse_amount & median_case!=.
			replace median_cose = 0 if median_case < cap_infuse_amount
			replace median_cose = 0 if median_case==.
			label variable median_cose "Large Infusions"
			gen treat_post_median_cose=treat_dummy*post_inf_dummy*median_cose
	        label variable treat_post_median_cose "Treatment x Post x Large Infusions"

				

					*w/o qtr 
					reg `var' post_inf_dummy treat_post treat_post_median_cose local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'_fake!=., vce(cl id)
					outreg2 using "E:\Canada Project\Results\ Table 14 (Channels VCE) `alpha'.xls", excel title("Table 14. Chanels Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
					addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) ///
					cttop("`m' = `val'")label append
					

drop median_case
drop median_cose
drop treat_post_median_cose					
drop new_cat
drop `alpha'_fake
	                
					}
			}
	  }

}
***
********************************************************************************************************************************



************************************************************************ Table 6 ********************************************************************************

use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

foreach var in pd12_month_100 slope_100 dtd mes_5p_100 nsrisk_5p_100 covar_5p_100 network_risk{

	reg `var' post_inf_dummy local_factor default_factor level_factor slope_factor vix i.id i.year if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Table 6.xls", excel title("Table 6. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) label append

	reg `var' median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.quarter if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Table 6.xls", excel title("Table 6. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) keep(median_ruled_dummy) label append
}
*


********************************************************************************************************************************

************************************************************************ Table 6  with qtr specific treatment********************************************************************************
clear
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

*Generating year specific treatment for public sector banks
	gen qtr_specific_treat = 1 if cap_infuse_amount !=. & A_B !=.
	replace qtr_specific_treat = 0 if cap_infuse_amount ==. & A_B !=.
	label variable qtr_specific_treat "Quarter Specific Treatment"

foreach var in pd12_month_100 slope_100 dtd mes_5p_100 nsrisk_5p_100 covar_5p_100 network_risk{

	reg `var' qtr_specific_treat local_factor default_factor level_factor slope_factor vix i.id i.year if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Table 6.xls", excel title("Table 6. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) keep(qtr_specific_treat) label append	
	
	reg `var' median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.quarter if A_B!=., vce(cl id)
	outreg2 using "E:\Canada Project\Results\ Table 6.xls", excel title("Table 6. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
	addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) keep(median_ruled_dummy) label append
}
*


********************************************************************************************************************************





************************************************************************ Table 16 ********************************************************************************
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"


foreach alpha in A_C A_D{

	foreach var in pd12_month_100 slope_100 dtd mes_5p_100 nsrisk_5p_100 covar_5p_100 network_risk{
		
		foreach m in treat_postlarge_ratio treat_postlarge_ratio_1 treat_postlarge_ratio_2{

		*with year and firm FE
		*reg `var' post_inf_dummy treat_post `m' local_factor default_factor level_factor slope_factor vix i.id i.year if `alpha'!=., vce(cl id)
		*outreg2 using "E:\Canada Project\Results\ Table 16 `alpha'.xls", excel title("Table 16. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		*addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, YES, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) label append
		
		*w/o FE
		reg `var' post_inf_dummy treat_post `m' local_factor default_factor level_factor slope_factor vix if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 16 `alpha'.xls", excel title("Table 16. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, NO) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) label append

		*with quarter FE
		reg `var' post_inf_dummy treat_post `m' local_factor default_factor level_factor slope_factor vix i.quarter if `alpha'!=., vce(cl id)
		outreg2 using "E:\Canada Project\Results\ Table 16 `alpha'.xls", excel title("Table 16. Regression of PD, Systemic and Network Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
		addtext(Local Factor, YES, US Factors, YES, Firm FE, NO, Year FE, NO, Quarter FE, YES) drop(local_factor default_factor level_factor slope_factor vix i.quarter i.id i.year) label append

		
		}
	}
}
**

********************************************************************************************************************************









************************************************************************ T Test for FV's ********************************************************************************


foreach alpha in A_B A_C A_D A_E{

	estpost ttest total_assets roe deposits loan_to_assets tier_1_capital total_debt_to_common_equity total_debt_to_total_capital ///
	cf_beta policy_beta interest_coverage_ratio mkt_to_book tier_1_ratio long_term_debt debt_to_total_assets deposits_to_total_assets, ///
	by (`alpha') w

	est store `alpha'
}
******

esttab A_B A_C A_D A_E using "E:\Canada Project\Results\ttest.rtf", ///
	title("T test of Sample Mean Differences by Bank Category") ///
	mtitle("B-A" "C-A" "D-A" "E-A") eqlabels(,lhs("Varibales"))addnotes("Mean Difference = Mean of Control - Mean of Treatment") append label b(%13.2f)
***********************************************************************************************************************************************************














