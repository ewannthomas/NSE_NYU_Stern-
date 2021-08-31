************************************************************************ Table 6  with qtr specific treatment********************************************************************************

clear
use "E:\Canada Project\PD, DTD and Systemic Risk.dta"

*Generating year specific treatment for public sector banks
	gen qtr_specific_treat = 1 if cap_infuse_amount !=. & A_B !=.
    replace qtr_specific_treat = 0 if cap_infuse_amount ==. & A_B !=.
	label variable qtr_specific_treat "Quarter Specific Treatment"


foreach var in pd12_month_100 slope_100 dtd mes_5p_100 nsrisk_5p_100 covar_5p_100 network_risk{

	reg `var' qtr_specific_treat local_factor default_factor level_factor slope_factor vix i.id i.year if A_B!=., vce(cl id)
	est store `var'_1
	
	reg `var' median_ruled_dummy local_factor default_factor level_factor slope_factor vix i.id i.quarter if A_B!=., vce(cl id)
	est store `var'_2
}
*


coefplot (*_1, label(Quarter Specific Treatment)) (*_2, label(Large Infusions)), keep(qtr_specific_treat median_ruled_dummy) xlabel(, angle(vertical)) ///
xline(0) msymbol(D) mfcolor(white) ciopts(lwidth(*3) lcolor(*.6)) mlabel ///
format(%9.2f) mlabposition(12) mlabgap(*2) title(Quarter Specific Treatment and Large Infusions across Risk Measures) ///
asequation swapnames xsize(8) eqrename(_100_([0-9])$=. _([0-9])$=., regex)

graph export "E:\Canada Project\Results\Graphs\Table 6.tif", replace wid(1500) hei(800)
