

***Importing Systemic Risk Mother
	import delimited "E:\Canada Project\Mother\Reformed Mother\PD, DTD and Systemic Risk Mother.csv"

*Labelling existing variables
	label variable co_name "Company Name"
	label variable id "Prowess ID"
	label variable year "Year"
	label variable quarter "Quarter"
	label variable category "Company Type"
	label variable cap_infuse_amount "Capital Infusion Amount"
	label variable total_assets "Total Assets"
	label variable loan_to_assets "Loan to Assets"
	label variable tier_1_capital "Tier 1 Capital"
	label variable total_debt_to_common_equity "Total Debt to Common Equity"
	label variable total_debt_to_total_capital "Total Debt to Total Capital"
	label variable cf_beta "CF Beta"
	label variable policy_beta "Policy Beta"
	label variable roe "ROE"
	label variable deposits "Deposits" 
	label variable mes_1p "Mes_1p"
	label variable mes_5p "Mes_5p"
	label variable srisk_1p "Srisk_1p"
	label variable srisk_5p "Srisk_5p"
	label variable nsrisk_1p "Nsrisk_1p"
	label variable nsrisk_5p "Nsrisk_5p"
	label variable covar_1p "Covar_1p"
	label variable covar_5p "Covar_5p"
	label variable local_factor "Local Factor"
	label variable default_factor "Default Factor"
	label variable level_factor "Level Factor"
	label variable slope_factor "Slope Factor"
	label variable vix "VIX"
	label variable network_risk "Network Risk"
	label variable tier_1_ratio "Tier 1 Capital Ratio"
	label variable mkt_to_book "Market to Book"
	label variable long_term_debt "Long Term Debt"
	label variable debt_to_total_assets "Debt to Total Assets"
	label variable deposits_to_total_assets "Deposits to Total Assets"
	
	
*Handling Category missing values (using cross referenced values from R files)
	replace category=3 if id==95627
	replace category=1 if id==56680
	replace category=3 if id==80728
	replace category=3 if id==158427
	replace category=2 if id==194815
	replace category=4 if id==197110
	replace category=4 if id==221313
	replace category=1 if id==236335
	replace category=1 if id==236339
	replace category=1 if id==266114
	replace category=4 if id==385630
	replace category=4 if id==386769
	replace category=2 if id==512651

*creating rescaled sys risk values
	foreach var in mes_1p mes_5p srisk_1p srisk_5p nsrisk_1p nsrisk_5p covar_1p covar_5p totvol ivol pd12_month{
		gen `var'_100= `var'*100
	}
*
*labellling these resacled values
	label variable mes_1p "Mes_1p"
	label variable mes_5p "Mes_5p"
	label variable mes_1p_100 "MES_1p_100"
	label variable mes_5p_100 "MES_5p_100"
	label variable srisk_1p_100 "SRISK_1p_100"
	label variable srisk_5p_100 "SRISK_5p_100"
	label variable nsrisk_1p_100 "NSRISK_1p_100"
	label variable nsrisk_5p_100 "NSRISK_5p_100"
	label variable covar_1p_100 "COVAR_1p_100"
	label variable covar_5p_100 "COVAR_5p_100"
	label variable totvol_100 "totvol_100"
	label variable ivol_100 "ivol_100"
	label variable pd12_month_100 "PD_12_month_100"

*creating slope variable
	gen slope_100= (pd60_month - pd12_month)*100
	label variable slope_100 "Slope 100"

*creating Treatment Public Banks with category code 0
	replace category=0 if id ==11019 | id ==15214 | id ==30136 | id ==30148 | id ==30153 | id ==43461 | id ==51380 | id ==56680 | 	id ==98668 | id ==98918 | id ==100283 | id ==164888 | id ==183764 | id ==183861 | id ==236328 | id ==245437 | id ==256249 | id ==257360 | id ==257827 | id ==266114 | id ==539436 
*Note: 21 banks had infusions. Hence, we will have 21*44 quarters= 924 changes

*creating cap_infuse qtr identifier
	gen cap_qtr=1 if cap_infuse_amount !=.
	replace cap_qtr=0 if cap_infuse_amount ==.
	label variable cap_qtr "Capital Infusion Qtr Identifier"

*Creating treat dummy
	gen treat_dummy=1 if category==0
	replace treat_dummy=0 if category!=0
	label variable treat_dummy "Treatment Dummy"

*Creating post infusion dummy
	gen post_inf_dummy=1 if year==2009 & quarter==1
	replace post_inf_dummy=1 if year==2009 & quarter==2
	replace post_inf_dummy=1 if year==2009 & quarter==3
	replace post_inf_dummy=1 if year==2010 & quarter==1
	replace post_inf_dummy=1 if year==2010 & quarter==2
	replace post_inf_dummy=1 if year==2010 & quarter==3
	replace post_inf_dummy=1 if year==2010 & quarter==4
	replace post_inf_dummy=1 if year==2011 & quarter==1
	replace post_inf_dummy=1 if year==2011 & quarter==2
	replace post_inf_dummy=1 if year==2011 & quarter==3
	replace post_inf_dummy=1 if year==2012 & quarter==1
	replace post_inf_dummy=1 if year==2012 & quarter==2
	replace post_inf_dummy=1 if year==2012 & quarter==3
	replace post_inf_dummy=1 if year==2012 & quarter==4
	replace post_inf_dummy=1 if year==2013 & quarter==1
	replace post_inf_dummy=1 if year==2013 & quarter==2
	replace post_inf_dummy=1 if year==2013 & quarter==4
	replace post_inf_dummy=1 if year==2014 & quarter==1
	replace post_inf_dummy=1 if year==2014 & quarter==2
	replace post_inf_dummy=1 if year==2015 & quarter==1
	replace post_inf_dummy=1 if year==2015 & quarter==2
	replace post_inf_dummy=1 if year==2015 & quarter==3
	replace post_inf_dummy=1 if year==2015 & quarter==4
	replace post_inf_dummy=1 if year==2016 & quarter==1
	replace post_inf_dummy=1 if year==2016 & quarter==3
	replace post_inf_dummy=1 if year==2016 & quarter==4
	replace post_inf_dummy=1 if year==2017 & quarter==1
	replace post_inf_dummy=1 if year==2017 & quarter==4
	replace post_inf_dummy=1 if year==2018 & quarter==1
	replace post_inf_dummy=1 if year==2018 & quarter==2
	replace post_inf_dummy=1 if year==2018 & quarter==4
	replace post_inf_dummy=0 if post_inf_dummy==.
	label variable post_inf_dummy "Post Infusion Dummy"

*Creating median_rule_dummy
	gen median_ruled_dummy = 1 if id ==11019
	foreach m in 15214	30136	30148	30153	43461	51380	56680	98918	100283	164888	183861	236328	245437	256249	257360	257827	266114	539436 {
		replace median_ruled_dummy = 1 if id == `m'
	}
	replace median_ruled_dummy = 0 if median_ruled_dummy==.
	label variable median_ruled_dummy "Large Infusions"	

*Creating treat*post infuse dummy
	gen treat_post=treat_dummy*post_inf_dummy
	label variable treat_post "Treatment x Post Infusion Dummy"

*Creating treat*post infuse dummy*median ruled dummy
	gen treat_post_median=treat_dummy*post_inf_dummy*median_ruled_dummy
	label variable treat_post_median "Treatment x Post x Large Infusions"

	
*Creating Public Bank treatment and control group
	gen A_B=0 if category==0 
	replace A_B=1 if category==1 
	label variable A_B "Public Banks Control"

*Creating Private Bank treatment and control group
	gen A_C=0 if category==0 
	replace A_C=2 if category==2
	label variable A_C "Private Banks Control"

*Creating Public NBFC treatment and control group
	gen A_D=0 if category==0 
	replace A_D=3 if category==3
	label variable A_D "Public NBFC Control"

*Creating Private NBFC treatment and control group
	gen A_E=0 if category==0 
	replace A_E=4 if category==4
	label variable A_E "Private NBFC Control"

	
	
*Creating lagged values of indeps by firm (yearly lag)
	foreach var in total_assets roe deposits loan_to_assets tier_1_capital total_debt_to_common_equity total_debt_to_total_capital deposits_to_total_assets{
		bysort id: gen lag_`var' = `var'[_n-4]	
	}
*
*Creating lagged values of indeps by firm (quarterly lag)
	foreach var in cf_beta policy_beta{
		bysort id: gen lag_`var' = `var'[_n-1]	
		}
*



		label variable lag_total_assets "Lagged Total Assets"
		label variable lag_loan_to_assets "Lagged Loan to Assets"
		label variable lag_tier_1_capital "Lagged Tier 1 Capital"
		label variable lag_total_debt_to_common_equity "Lagged Total Debt to Common Equity"
		label variable lag_total_debt_to_total_capital "Lagged Total Debt to Total Capital"
		label variable lag_cf_beta "Lagged CF Beta"
		label variable lag_roe "Lagged ROE"
		label variable lag_deposits "Lagged Deposits" 
		label variable lag_deposits_to_total_assets "Lagged Deposits to Total Assets"	
		label variable lag_policy_beta "Lagged Policy Beta"

		
		
**Cleaning hi vars
	 foreach var in hi_total_assets hi_debt_equity hi_debt_capital hi_debt_assets hi_interest_coverage hi_loan_assets hi_tier_1_ratio hi_deposits_assets hi_mkt_book hi_roe{
	 replace `var' =. if category !=0
	 }
 *
	
*gen tre=1 if category==0 & cap_infuse_amount!=.
*replace tre=0 if tre==.
	
*gen post=1 if tre[_n-2]==1
*replace post=1 if tre[_n-1]==1
*replace post=1 if tre==1
*replace post=0 if post==.


*gen tre_post = tre* post	

	
	
	
*Creating stress year(2011, 2016, 2018) variable
	*gen stress=1 if year==2011 | year==2016 | year==2018
	*replace stress=0 if stress==.	
	*label variable stress "Stress Years Dummy"
	
*Creating Post * stress dummy
	*gen post_stress= post_inf_dummy * stress
	*label variable post_stress "Post Infusion x Stress Years Dummy"

*Creating treat*post*stress infuse dummy
	*gen treat_post_stress=treat_dummy*post_inf_dummy*stress
	*label variable treat_post_stress "Treatment x Post Infusion x Stress Years Dummy"

*Creating treat*post infuse dummy*median ruled dummy* stress dummy
	*gen treat_post_median_stress=treat_dummy*post_inf_dummy*median_ruled_dummy*stress
	*label variable treat_post_median_stress "Treatment x Post x Large Infusions x Stress Years Dummy"

*Creating median*stress dummy
	*gen median_stress= median_ruled_dummy*stress
	*label variable median_stress "Large Infusions x Stress Years Dummy"
	
	
	
*Creating stress year(2011, 2016, 2018) variable V3
foreach val in 2011 2016 2018{
		
	gen stress_`val' =1 if year==`val'
	replace stress_`val'=0 if stress_`val'==.
		
*Creating Post * stress dummy
	gen post_stress_`val'= post_inf_dummy * stress_`val'
	label variable post_stress_`val' "Post Infusion x stress Year `val' Dummy"

*Creating treat*post*stress_`val' infuse dummy
	gen treat_post_stress_`val'=treat_dummy*post_inf_dummy*stress_`val'
	label variable treat_post_stress_`val' "Treatment x Post Infusion x stress Year `val' Dummy"

*Creating treat*post infuse dummy*median ruled dummy* stress dummy
	gen treat_post_median_stress_`val'=treat_dummy*post_inf_dummy*median_ruled_dummy*stress_`val'
	label variable treat_post_median_stress_`val' "Treatment x Post x Large Infusions x stress Year `val' Dummy"

*Creating median*stress dummy
	gen median_stress_`val'= median_ruled_dummy*stress_`val'
	label variable median_stress_`val' "Large Infusions x stress Year `val' Dummy"
		
}
*
	
	
	
**Variable creations for Table 6
	gen tre=1 if cap_infuse_amount >=937.5 & cap_infuse_amount !=.
	replace tre=0 if tre==.


	gen postlarge_inf = 1 if tre==1 
	bysort id: replace postlarge_inf=1 if tre[_n-2]==1
	bysort id: replace postlarge_inf=1 if tre[_n-1]==1
	replace postlarge_inf=0 if postlarge_inf==.
	label variable postlarge_inf "Post Large Infusions"
	drop tre


**Creating variables for Tbale 16 Cap -Total assets
	gen cap_inf_tot_assets = cap_infuse_amount/ total_assets
	label variable cap_inf_tot_assets "Capital Infusion to Total Assets"

	gen tre =1 if cap_inf_tot_assets>=3.70e-07 & cap_inf_tot_assets!=.

	gen post_large_inf_ratio = 1 if tre==1 
	bysort id: replace post_large_inf_ratio=1 if tre[_n-2]==1
	bysort id: replace post_large_inf_ratio=1 if tre[_n-1]==1
	replace post_large_inf_ratio=0 if post_large_inf_ratio==.
	label variable post_large_inf_ratio "Post Large Infusions (Capital Infusion to Total Assets)"
	drop tre

*Creating Treatment x Post Large Infusion Ratio Dummy
	gen treat_postlarge_ratio = treat_dummy* post_large_inf_ratio
	label variable treat_postlarge_ratio "Treatment x Post Large Infusion-Assets Ratio Dummy"
	
	

**Creating variables for Tbale 16 cap - deposits
	gen cap_inf_deposits = cap_infuse_amount/ deposits
	label variable cap_inf_deposits "Capital Infusion to Total Deposits"

	gen tre =1 if cap_inf_deposits>=4.37e-07 & cap_inf_deposits!=.

	gen post_large_inf_ratio_dep = 1 if tre==1 
	bysort id: replace post_large_inf_ratio_dep=1 if tre[_n-2]==1
	bysort id: replace post_large_inf_ratio_dep=1 if tre[_n-1]==1
	replace post_large_inf_ratio_dep=0 if post_large_inf_ratio_dep==.
	label variable post_large_inf_ratio_dep "Post Large Infusions (Capital Infusion to Total Deposits)"
	drop tre

*Creating Treatment x Post Large Infusion Ratio Dummy
	gen treat_postlarge_ratio_1 = treat_dummy* post_large_inf_ratio_dep
	label variable treat_postlarge_ratio_1 "Treatment x Post Large Infusion-Deposits Ratio Dummy"


	
**Creating variables for Tbale 16 cap - tier 1 capital
	gen cap_inf_tier_1 = cap_infuse_amount/ tier_1_capital
	label variable cap_inf_tier_1 "Capital Infusion to Tier 1 Capital"

	gen tre =1 if cap_inf_tier_1>= 7.69e-06 & cap_inf_tier_1!=.

	gen post_large_inf_ratio_tier1 = 1 if tre==1 
	bysort id: replace post_large_inf_ratio_tier1=1 if tre[_n-2]==1
	bysort id: replace post_large_inf_ratio_tier1=1 if tre[_n-1]==1
	replace post_large_inf_ratio_tier1=0 if post_large_inf_ratio_tier1==.
	label variable post_large_inf_ratio_tier1 "Post Large Infusions (Capital Infusion to Tier 1 capital)"
	drop tre

*Creating Treatment x Post Large Infusion Ratio Dummy
	gen treat_postlarge_ratio_2 = treat_dummy* post_large_inf_ratio_tier1
	label variable treat_postlarge_ratio_2 "Treatment x Post Large Infusion-Tier 1 capital Ratio Dummy"
	
	
	
	
	
	
	
*Saving file
save "E:\Canada Project\PD, DTD and Systemic Risk.dta", replace



***Importing Placebo post infusions
	*import delimited "E:\Canada Project\Mother\Reformed Mother\Placebo.csv"

**Merging palcebo to PD SYS DTD Mother

	merge m:1 year quarter using "E:\Canada Project\Placebo.dta"

	drop _merge

	sort id year quarter

	rename placebo placebo_post_inf
	replace placebo_post_inf=0 if cap_infuse_amount!=.
	label variable placebo_post_inf "Placebo Post Infusion Dummy"

*Creating treat*post infuse dummy
	gen treat_placebo_post=treat_dummy*placebo_post_inf
	label variable treat_placebo_post "Treatment x Placebo Post Infusion Dummy"

*Creating treat*post infuse dummy*median ruled dummy
	gen treat_placebopost_median=treat_dummy*placebo_post_inf*median_ruled_dummy
	label variable treat_placebopost_median "Treatment x Placebo Post x Large Infusions"


*Creating Placebo POst Inf t-1
	gen placebt1=1 if year==2008 & quarter==4
	replace placebt1=0 if year==2009 & quarter==1
	replace placebt1=1 if year==2009 & quarter==4
	replace placebt1=0 if year==2010 & quarter==1
	replace placebt1=1 if year==2010 & quarter==3
	replace placebt1=0 if year==2010 & quarter==4
	replace placebt1=0 if year==2011 & quarter==1
	replace placebt1=1 if year==2011 & quarter==4
	replace placebt1=0 if year==2012 & quarter==1
	replace placebt1=1 if year==2012 & quarter==3
	replace placebt1=0 if year==2012 & quarter==4
	replace placebt1=1 if year==2013 & quarter==3
	replace placebt1=0 if year==2013 & quarter==4
	replace placebt1=1 if year==2014 & quarter==4
	replace placebt1=0 if year==2015 & quarter==1
	replace placebt1=1 if year==2015 & quarter==2
	replace placebt1=0 if year==2015 & quarter==3
	replace placebt1=1 if year==2016 & quarter==2
	replace placebt1=0 if year==2016 & quarter==3
	replace placebt1=1 if year==2017 & quarter==3
	replace placebt1=0 if year==2017 & quarter==4
	replace placebt1=1 if year==2018 & quarter==3
	replace placebt1=0 if year==2018 & quarter==4
	replace placebt1=0 if placebt1==.

	label variable placebt1 "Placebo Post Infusion t-1"
	
*Creating treat*post infuse dummy
	gen treat_placebt1=treat_dummy*placebt1
	label variable treat_placebt1 "Treatment x Placebo Post Infusion t-1"

*Creating treat*post infuse dummy*median ruled dummy
	gen treat_placeb1_median=treat_dummy*placebt1*median_ruled_dummy
	label variable treat_placeb1_median "Treatment x Placebo Post t-1 x Large Infusions"


*Creating Placebo POst Inf t-2
	gen placebt2=1 if year==2008 & quarter==3
	replace placebt2=0 if year==2009 & quarter==1
	replace placebt2=1 if year==2009 & quarter==3
	replace placebt2=0 if year==2010 & quarter==1
	replace placebt2=1 if year==2010 & quarter==2
	replace placebt2=0 if year==2010 & quarter==4
	replace placebt2=1 if year==2010 & quarter==3
	replace placebt2=0 if year==2011 & quarter==1
	replace placebt2=1 if year==2011 & quarter==3
	replace placebt2=0 if year==2012 & quarter==1
	replace placebt2=1 if year==2012 & quarter==2
	replace placebt2=0 if year==2012 & quarter==4
	replace placebt2=1 if year==2013 & quarter==2
	replace placebt2=0 if year==2013 & quarter==4
	replace placebt2=1 if year==2014 & quarter==3
	replace placebt2=0 if year==2015 & quarter==1
	replace placebt2=0 if year==2015 & quarter==3
	replace placebt2=1 if year==2016 & quarter==1
	replace placebt2=0 if year==2016 & quarter==3
	replace placebt2=1 if year==2017 & quarter==2
	replace placebt2=0 if year==2017 & quarter==4
	replace placebt2=1 if year==2018 & quarter==2
	replace placebt2=0 if year==2018 & quarter==4
	replace placebt2=0 if placebt2==.
	
	label variable placebt2 "Placebo Post Infusion t-2"
	
*Creating treat*post infuse dummy
	gen treat_placebt2=treat_dummy*placebt2
	label variable treat_placebt2 "Treatment x Placebo Post Infusion t-2"

*Creating treat*post infuse dummy*median ruled dummy
	gen treat_placeb2_median=treat_dummy*placebt2*median_ruled_dummy
	label variable treat_placeb2_median "Treatment x Placebo Post t-2 x Large Infusions"



************************************************************************************************************************************************************************************************


***************************************************************Creating Quarter Specific Variables for New Analysis*********************************************************************************************************************************



*Generating quarter specific treatment for public sector banks
	gen Qtr_treat = 1 if cap_infuse_amount !=.
	replace Qtr_treat = 0 if cap_infuse_amount ==.
	label variable Qtr_treat "Quarter Specific Treatment"
	
	
**Creating quarter specific Post Inf Dummy
	gen Qtr_post_inf = 1 if Qtr_treat==1
	bysort id: replace Qtr_post_inf = 1 if Qtr_treat[_n-1]==1
	bysort id: replace Qtr_post_inf = 1 if Qtr_treat[_n-2]==1
	bysort id: replace Qtr_post_inf = 0 if Qtr_post_inf==.
	label variable Qtr_post_inf "Quarter Specific Post Infusion Dummy"
	
**Creating 8 Quarter Pre Infusion Dummy
	gen Qtr_pre_inf = 0
	foreach val in 1 2 3 4 5 6 7 8{
		bysort id: replace Qtr_pre_inf = 1 if Qtr_treat[_n-`val']==1
	}
	*
	label variable Qtr_pre_inf "Previous Infusion Dummy"


**Creating post * pre inf
	gen Qtr_post_pre = Qtr_post_inf * Qtr_pre_inf
	label variable Qtr_post_pre "Quarter Specific Post x Previous Infusion Dummy"

	
**Concating year and quarter
	egen y_q = concat(year quarter)
	encode(y_q), gen (yq)
	drop y_q
	
****************************************Creating Moral Hazard recognizing Quarter specific Large Infusions****************************************************

*Creating total iinfusions for each firms per year
	bysort id year: egen Firm_total_CI = total(cap_infuse_amount) 
*creating a 1 year lag of above total CI per firm
	bysort id: gen lag_firm_total_CI = Firm_total_CI[_n-4]
*Taking the median of lagged total firm CI for each year without considering the firms. 
*Since only A_B firms receive infusions its justified to take only median for that sub sample otherwise all median values would be zero	
	bysort year : egen median_lag_CI = median(lag_firm_total_CI) if A_B!=.
	
	gen Large_inf_MH = 1 if lag_firm_total_CI > median_lag_CI
	replace Large_inf_MH = 0 if lag_firm_total_CI < median_lag_CI
	*to make points where both variables are zero and hence doesnt result in 1
	replace Large_inf_MH = 0 if lag_firm_total_CI==0 & median_lag_CI==0
	label variable Large_inf_MH "Moral Hazard Large Infusion Dummy"
	
	drop Firm_total_CI lag_firm_total_CI median_lag_CI

	
**Creating post * MH Large inf
	gen Qtr_post_MH_Large = Qtr_post_inf * Large_inf_MH
	label variable Qtr_post_MH_Large "Quarter Specific Post x Moral Hazard Large Infusion Dummy"

	
****************************************Creating Current Quarter Median Large Infusions Dummy****************************************************
*Creating Current Quarter sepecifc median
	bysort yq : egen median_lag_CI = median(cap_infuse_amount) if A_B!=.
	
	gen CurrentQ_Large_inf = 1 if cap_infuse_amount > median_lag_CI & cap_infuse_amount!=.
	replace CurrentQ_Large_inf=0 if CurrentQ_Large_inf==.
	
	gen blah = 1 if CurrentQ_Large_inf==1
	sort id year quarter
	bysort id: replace CurrentQ_Large_inf=1 if blah[_n-1]==1
	bysort id: replace CurrentQ_Large_inf=1 if blah[_n-2]==1
	label variable CurrentQ_Large_inf "Current Quarter Median Large Infusion"
		drop median_lag_CI blah


**Creating post * CurrentQ_Large_inf_MH
	gen Qtr_post_CurrentQ_Large = Qtr_post_inf * CurrentQ_Large_inf
	label variable Qtr_post_CurrentQ_Large "Quarter Specific Post x Current Quarter Median Large Infusion Dummy"



****************************************Creating 8 Quarter Median (of all firm capital infusions) Large Infusions Dummy****************************************************

**Concating year and quarter
	egen y_q = concat(year quarter)
	
**Creating previous 8 quarter median of all firm capital infusions
foreach val in 20091 20101 20104 20111 20121 20124 20134 20151 20153 20163 20174 20184{
	gen proxy = "`val'" if y_q=="`val'" & A_B!=.
	gen proxy2 = " "
			foreach value in 1 2 3 4 5 6 7 8{
				bysort id: replace proxy2 ="`val'" if proxy[_n+`value']=="`val'" & A_B!=.
	}
	egen crazy_median_`val' = median(cap_infuse_amount) if proxy2=="`val'"
	drop proxy proxy2
}
*
foreach val in 20091 20101 20104 20111 20121 20124 20134 20151 20153 20163 20174 20184{
	gen proxy = "`val'" if y_q=="`val'" & A_B!=.
	bysort id: replace crazy_median_`val' = crazy_median_`val'[_n-1] if proxy == "`val'"
	bysort id: replace crazy_median_`val' =. if proxy != "`val'"
	drop proxy
}
*

**Summing all crazy medians rowwise to getr one single column of adequate 8Q medians
	egen crazy_median = rowtotal(crazy_median_20091 - crazy_median_20184), missing
**Dropping misc vars
	drop y_q crazy_median_20091 - crazy_median_20184
	

**Creating 8Q Lareg Infusion Dummy
	gen Large_inf_8Q = 1 if cap_infuse_amount > crazy_median & cap_infuse_amount!=.
	replace Large_inf_8Q=0 if Large_inf_8Q==.
	replace Large_inf_8Q=. if year==2008 | year==2009
	sort id year quarter
	gen blah = 1 if Large_inf_8Q==1
	bysort id: replace Large_inf_8Q=1 if blah[_n-1]==1
	bysort id: replace Large_inf_8Q=1 if blah[_n-2]==1
	
	label variable Large_inf_8Q "8 Quarter Median Large Infusion"
		drop crazy_median blah


**Creating post * CurrentQ_Large_inf_MH
	gen Qtr_post_8Q_Large = Qtr_post_inf * Large_inf_8Q
	label variable Qtr_post_8Q_Large "Quarter Specific Post x 8 Quarter Median Large Infusion Dummy"

	
	
*Saving file
save "E:\Canada Project\PD, DTD and Systemic Risk.dta", replace

























