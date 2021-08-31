


***********************************************AGG PD MES COVAR NSRISK regression*************************************************

**Importing Excel File

	import excel "E:\Canada Project\New folder\Aggragate risk data_ for_sovereign risk hyp.xlsx", sheet("agg values") firstrow

	save "E:\Canada Project\Agg Risk Measures.dta"


**Labelling all vars
	foreach var in PD_A_C_ PD_A_D_ MES_A_C_ MES_A_D_ COVAR_A_C_ COVAR_A_D_ NSRISK_A_C_ NSRISK_A_D_ Network_Risk_A_C_ Network_Risk_A_D_{
		label variable `var'sprd "`var'Spread"
	}
**



**Creating Post Infusion Dummy for Dummy_1
	gen Post_Inf_Dum1= 0 if dum_1==0
	replace Post_Inf_Dum1= 1 if dum_1==1
	replace Post_Inf_Dum1= 1 if dum_1[_n-2]==1
	replace Post_Inf_Dum1= 1 if dum_1[_n-1]==1

**Creating Post Infusion Dummy for Dummy_3
	gen Post_Inf_Dum3= 0 if dum_3==0
	replace Post_Inf_Dum3= 1 if dum_3==1
	replace Post_Inf_Dum3= 1 if dum_3[_n-2]==1
	replace Post_Inf_Dum3= 1 if dum_3[_n-1]==1


	label variable Post_Inf_Dum1 "Post Infusion Dummy 1"
	label variable Post_Inf_Dum3 "Post Infusion Dummy 3"

	
	
save "E:\Canada Project\Agg Risk Measures.dta"



*****Agg regressions
foreach alpha in A_C A_D{
	foreach var in PD_`alpha'_sprd MES_`alpha'_sprd COVAR_`alpha'_sprd NSRISK_`alpha'_sprd Network_Risk_`alpha'_sprd{
		foreach val in 1 3{
			reg `var' Post_Inf_Dum`val' i.year, vce(rob)
			outreg2 using "E:\Canada Project\Results\ Agg regression `alpha'.xls", excel title("Table 15. Regression of Aggregate Risk Measures over Post Infusion Dummies using Robust Standard Errors") ///
			addtext(Year FE, YES) keep(Post_Inf_Dum`val') label append
		 }
	}
}	
*****


