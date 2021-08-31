

use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

*****************************************************************************************************************************************************************

**************************************************************************Basline Model MH Large Inf***************************************************************************************

**Defining Indeps
global IV1 Qtr_post_inf local_factor default_factor level_factor slope_factor vix i.id i.yq

global IV2 Qtr_post_inf Large_inf_MH Qtr_post_pre local_factor default_factor level_factor slope_factor vix i.id i.yq

global IV Qtr_post_inf Large_inf_MH Qtr_post_pre

**PD vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		foreach m in IV1 IV2{
	
			reg `var' $`m' if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel ///
			title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

		}
	}
}
*


**SYS vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		foreach m in IV1 IV2{
	
			reg `var' $`m' if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel ///
			title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

		}
	}
}
*


**Network vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in network_risk{
		foreach m in IV1 IV2{
	
			reg `var' $`m' if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) `alpha'.xls", excel ///
			title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

		}
	}
}
*
*****************************************************************************************************************************************************************




**************************************************************************Basline Model Large inf***************************************************************************************

**Defining Indeps

global IV1 Qtr_post_inf Large_inf_8Q local_factor default_factor level_factor slope_factor vix i.id i.yq

global IV2 Qtr_post_inf CurrentQ_Large_inf local_factor default_factor level_factor slope_factor vix i.id i.yq

global IV3 Qtr_post_inf Large_inf_MH Qtr_post_MH_Large local_factor default_factor level_factor slope_factor vix i.id i.yq


global IV Qtr_post_inf Large_inf_8Q Qtr_post_8Q_Large CurrentQ_Large_inf Qtr_post_CurrentQ_Large Large_inf_MH Qtr_post_MH_Large

**PD vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		foreach m in IV1 IV2 IV3{
	
			reg `var' $`m' if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel ///
			title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

		}
	}
}
*


**SYS vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		foreach m in IV1 IV2 IV3{
	
			reg `var' $`m' if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel ///
			title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

		}
	}
}
*


**Network vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in network_risk{
		foreach m in IV1 IV2 IV3{
	
			reg `var' $`m' if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) `alpha'.xls", excel ///
			title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

		}
	}
}
*
*****************************************************************************************************************************************************************


**************************************************************************Table 6 Model Large inf***************************************************************************************

global IV Qtr_post_inf Large_inf_8Q CurrentQ_Large_inf  Large_inf_MH 

**PD vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in pd12_month_100 slope_100 dtd{
		foreach m in Qtr_post_inf Large_inf_8Q CurrentQ_Large_inf  Large_inf_MH{


			reg `var' `m' local_factor default_factor level_factor slope_factor vix i.id i.yq if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 7 (PD RISK VCE) `alpha'.xls", excel ///
			title("Table 7. Regression of PD Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

}
}
}
*

**SYS vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in mes_5p_100 nsrisk_5p_100 covar_5p_100 mes_1p_100 nsrisk_1p_100 covar_1p_100{
		foreach m in Qtr_post_inf Large_inf_8Q CurrentQ_Large_inf  Large_inf_MH{


			reg `var' `m' local_factor default_factor level_factor slope_factor vix i.id i.yq if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 8 (SYS RISK VCE) `alpha'.xls", excel ///
			title("Table 8. Regression of Systemic Risk Variables with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append

}
}
}
*

**Network vars
foreach alpha in A_B A_C A_D A_E{
	foreach var in network_risk{
		foreach m in Qtr_post_inf Large_inf_8Q CurrentQ_Large_inf Large_inf_MH{


			reg `var' `m' local_factor default_factor level_factor slope_factor vix i.id i.yq if `alpha'!=., vce(cl id)
			outreg2 using "E:\Canada Project\Results\ Table 9 (Network RISK VCE) `alpha'.xls", excel ///
			title("Table 9. Regression of Network Risk Variable with Robust Standard Errors (Clustered at Bank Level)") ///
			addtext(Local Factor, YES, US Factors, YES, Firm FE, YES, Year FE, NO, Quarter FE, YES) ///
			keep($IV)label append


}
}
}
*
