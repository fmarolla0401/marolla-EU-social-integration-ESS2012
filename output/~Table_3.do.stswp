/****************************************************************
Replicates Table 3: Multilevel linear regression analyses of Trust in European Union Parliament
(N=31,746; Countries=21). Beta coefficients reported
****************************************************************/
cd "C:\Users\Frama\Documents\GitHub\marolla-EU-social-integration-ESS2012\data\processed"   // 
*-----------------------------------------------------------------------
* 2.  LOCATE THE RAW DATA
*-----------------------------------------------------------------------
use "ANALYSIS_DATA.dta", clear   //
*-----------------------------------------------------------------------

* Multilevel linear regression ----> Trust in European Parliamnent 
reg trstep oesch5_oeschclass08 edu_level gender agea rural soc_cont soc_acc loc_int
gen mysample_2=1 if e(sample)  
* Model 1 
mixed trstep [pweight= pspwght]  || country: if mysample_2==1
estat icc
estimates store tm1

* Model 2
mixed trstep ib5.oesch5_oeschclass08 i.edu_level ib1.rural [pweight= pspwght]  || country: if mysample_2==1
estat icc
estimates store tm2

* Model 3
mixed trstep ib5.oesch5_oeschclass08 i.edu_level ib1.rural soc_cont soc_acc loc_int [pweight= pspwght]  || country: if mysample_2==1
estat icc
estimates store tm3

* Model 4
mixed trstep ib5.oesch5_oeschclass08 i.edu_level ib1.rural soc_cont soc_acc loc_int i.gender agea  [pweight= pspwght]  || country: if mysample_2==1
estat icc
estimates store tm4

* Comparing Trust in European Parliament models
esttab tm1 tm2 tm3 tm4, b(%9,2f) se(%9,2f) aic bic label star(+ 0.10 * 0.05 ** 0.01 *** 0.001)  mlabels("Model 1" "Model 2" "Model 3" "Model 4") 