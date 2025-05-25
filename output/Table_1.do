/****************************************************************
Replicates Table 1: Factor analysis performed on subjective social integration items after Oblique Pro-max rotation
****************************************************************/
cd "C:\Users\Frama\Documents\GitHub\marolla-EU-social-integration-ESS2012\data\processed"   // 
*-----------------------------------------------------------------------
* 2.  LOCATE THE RAW DATA
*-----------------------------------------------------------------------
use "ANALYSIS_DATA.dta", clear   //
*-----------------------------------------------------------------------

* Performing factor analysis - Three factor solution
factor ppltrst pplfair pplhlp valuable accomplishment plinsoc sedirlf pplahlp trtrsp close, pcf factors(3)  
rotate, promax blanks(.4) 
estat common

/*
Rotated factor loadings (pattern matrix) and unique variances

    -----------------------------------------------------------
        Variable |  Factor1   Factor2   Factor3 |   Uniqueness 
    -------------+------------------------------+--------------
         ppltrst |             0.8551           |      0.2850  
         pplfair |             0.8404           |      0.2911  
          pplhlp |             0.7951           |      0.3527  
        valuable |   0.7610                     |      0.4267  
    accomplish~t |   0.7579                     |      0.4430  
         plinsoc |   0.6058                     |      0.5349  
         sedirlf |   0.7353                     |      0.4487  
         pplahlp |                       0.8377 |      0.2734  
          trtrsp |                       0.6092 |      0.4469  
           close |                       0.8088 |      0.3833  
    -----------------------------------------------------------
    (blanks represent abs(loading)<.4)

/*