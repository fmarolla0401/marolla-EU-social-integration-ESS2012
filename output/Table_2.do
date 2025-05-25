/****************************************************************
Replicates Table 2: Multilevel linear regression analyses of Support for further European Integration 
(N=31,637; Countries=21). Beta coefficients reported
****************************************************************/
cd "C:\Users\Frama\Documents\GitHub\marolla-EU-social-integration-ESS2012\data\processed"   // 
*-----------------------------------------------------------------------
* 2.  LOCATE THE RAW DATA
*-----------------------------------------------------------------------
use "ANALYSIS_DATA.dta", clear   //
*-----------------------------------------------------------------------

* Multilevel linear regression ----> Support for further European Union Integration
reg euftf oesch5_oeschclass08 edu_level gender agea rural soc_cont soc_acc loc_int
gen mysample_1=1 if e(sample)  
* Model 1
mixed euftf [pweight= pspwght]  || country: if mysample_1==1
estat icc
estimates store model1

* Model 2
mixed euftf ib5.oesch5_oeschclass08 i.edu_level ib1.rural [pweight= pspwght]  || country: if mysample_1==1
estat icc
estimates store model2

* Model 3
mixed euftf ib5.oesch5_oeschclass08 i.edu_level ib1.rural soc_cont soc_acc loc_int [pweight= pspwght]  || country: if mysample_1==1
estat icc
estimates store model3

* Model 4
mixed euftf ib5.oesch5_oeschclass08 i.edu_level ib1.rural soc_cont soc_acc loc_int i.gender agea [pweight= pspwght]  || country: if mysample_1==1
estat icc
estimates store model4

* Comparing all models
esttab model1 model2 model3 model4, b(%9,2f) se(%9,2f) aic bic label star(+ 0.10 * 0.05 ** 0.01 *** 0.001)  mlabels("Model 1" "Model 2" "Model 3" "Model 4") 
