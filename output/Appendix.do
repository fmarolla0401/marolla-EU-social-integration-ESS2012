/****************************************************************
Replicates Appendix Material 
****************************************************************/
cd "C:\Users\Frama\Documents\GitHub\marolla-EU-social-integration-ESS2012\data\processed"   // 
*-----------------------------------------------------------------------
* 2.  LOCATE THE RAW DATA
*-----------------------------------------------------------------------
use "ANALYSIS_DATA.dta", clear   //
*-----------------------------------------------------------------------

* Fig. A1
histogram soc_cont, bin(20) normal name(soc_cont, replace)
histogram soc_acc, bin(20) normal name(soc_acc, replace)
histogram loc_int, bin(20) normal name(loc_int, replace)

graph combine soc_cont soc_acc loc_int, xsize(35) ysize(30)

* Fig. A2
tabstat euftf, stat(mean sd)
graph hbar (mean) euftf, over(country, sort(1) descending) blabel(bar, format(%9.2f)) ///
	yline(5.07, lpattern(shortdash) lcolor(gs12)) ytitle("Support for European Unification") yscale(range(0 7)) name(unification, replace)

tabstat trstep, stat(mean sd)
graph hbar (mean) trstep, over(country, sort(1) descending) blabel(bar, format(%9.2f)) ///
	yline(4.29, lpattern(shortdash) lcolor(gs12)) ytitle("Trust in European Parliament") yscale(range(0 5.5)) name(eu_parliament, replace)

tabstat eurosk, stat(mean sd)
graph hbar (mean) eurosk, over(country, sort(1) descending) blabel(bar, format(%9.2f)) ///
	yline(5.43, lpattern(shortdash) lcolor(gs12)) ytitle("Euroskepticism in Vote Choice") yscale(range(1 7)) name(euroskepticism, replace)

graph combine unification eu_parliament euroskepticism, xsize(35) ysize(30)
	
* Fig. A3
* Social Integration indices across countries 
graph hbar (mean) soc_cont, over(country, sort(1) descending) blabel(bar, format(%9.2f)) ///
 ytitle("Social Contribution Index (Factor Scores)") name(acceptance, replace)
graph hbar (mean) soc_acc, over(country, sort(1) descending) blabel(bar, format(%9.2f)) ///
 ytitle("Social Acceptance Index (Factor Scores)") name(contribution, replace)
graph hbar (mean) loc_int, over(country, sort(1) descending) blabel(bar, format(%9.2f)) ///
 ytitle("Local Integration Index (Factor Scores)") name(local_integr, replace)

graph combine contribution acceptance local_integr, xcommon xsize(25) ysize(15)

* Table A1
tab oesch5_oeschclass08, gen(oesch5_oeschclass08_) 
tab edu_level, gen(edu_level_) 
tab gender, gen(gender_) 
tab rural, gen(rural_) 

tabstat euftf trstep eurosk oesch5_oeschclass08_1 oesch5_oeschclass08_2 oesch5_oeschclass08_3 oesch5_oeschclass08_4 oesch5_oeschclass08_5 edu_level_1 edu_level_2 edu_level_3 gender_1 gender_2 agea rural_1 rural_2 soc_cont soc_acc loc_int, stat(mean sd min max)
