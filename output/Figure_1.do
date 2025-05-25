/****************************************************************
Replicates Figure 1: Average Factor Scores of Subjective Social Integration Dimensions conditional on how often individuals
take part in social activities compared to others of same age (left panel) and socially meet with friends, relatives, or colleagues (right panel)
****************************************************************/
cd "C:\Users\Frama\Documents\GitHub\marolla-EU-social-integration-ESS2012\data\processed"   // 
*-----------------------------------------------------------------------
* 2.  LOCATE THE RAW DATA
*-----------------------------------------------------------------------
use "ANALYSIS_DATA.dta", clear   //
*-----------------------------------------------------------------------

set scheme s1mono

********************************************************************************
* Cross-validation of the Soubjective Social Integration indices 
* Take part in social activities compared to others of same age --> Disintegrated individuals interact less with their peers
fre sclact
graph bar soc_cont soc_acc loc_int, over(sclact) name(social_activities, replace) 
* All the indicators confirm the trend that higher socially integrated individuals have also more meetings with their peers on average. 

* How often socially meet with friends, relatives or colleagues
fre sclmeet
recode sclmeet (1 2 = 1 "Less than once a month") (3 = 2 "Once a month") (4 = 3 "Several times a month") (5 = 4 "Once a week") (6 7 = 5 "Several times a week"), gen(meetings)
graph bar soc_cont soc_acc loc_int, over(meetings) name(friends, replace) 
* All the indicators confirm the trend that higher socially integrated individuals have also more meetings with closest acquiantances 

* Combining the graphs to provide initial validation of the indicators 
graph combine social_activities friends, ycommon xsize(30) ysize(20)
