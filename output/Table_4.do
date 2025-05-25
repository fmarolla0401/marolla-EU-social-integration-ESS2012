/****************************************************************
Replicates Table 4: Multilevel linear regression analyses of Support for Pro-EU parties
(N= 20,271; Countries=21). Beta coefficients reported
****************************************************************/
cd "C:\Users\Frama\Documents\GitHub\marolla-EU-social-integration-ESS2012\data\processed"   // 
*-----------------------------------------------------------------------
* 2.  LOCATE THE RAW DATA
*-----------------------------------------------------------------------
use "ANALYSIS_DATA.dta", clear   //
*-----------------------------------------------------------------------

* Multilevel linear regression ----> Euroskepticism in party choice 
reg eurosk oesch5_oeschclass08 edu_level gender agea rural soc_cont soc_acc loc_int
gen mysample_3=1 if e(sample)  
* Model 1 
mixed eurosk [pweight= pspwght]  || country: if mysample_3==1
estat icc
estimates store em1

* Model 2 
mixed eurosk ib5.oesch5_oeschclass08 i.edu_level ib1.rural [pweight= pspwght]  || country: if mysample_3==1
estat icc
estimates store em2

* Model 3 
mixed eurosk ib5.oesch5_oeschclass08 i.edu_level ib1.rural soc_cont soc_acc loc_int [pweight= pspwght]  || country: if mysample_3==1
estat icc
estimates store em3

* Model 4
mixed eurosk ib5.oesch5_oeschclass08 i.edu_level ib1.rural soc_cont soc_acc loc_int i.gender agea [pweight= pspwght]  || country: if mysample_3==1
estat icc
estimates store em4

* Comparing Euroscepticism models
esttab em1 em2 em3 em4, b(%9,2f) se(%9,2f) aic bic label star(+ 0.10 * 0.05 ** 0.01 *** 0.001)  mlabels("Model 1" "Model 2" "Model 3" "Model 4")