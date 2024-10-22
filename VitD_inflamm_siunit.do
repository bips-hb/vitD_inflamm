*****************
***Import Data***
*****************
 cd "D:/PROGS/STATA/VitD_inflamm/Graphs"  /// change wd to graphs to store graphs generated automatically to wd

***T3***
odbc load, table("lab_data") dsn ("ifamily") noquote clear
rename ID_no id_new3
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_lab.dta", replace

odbc load, table("HMH_CH") dsn ("ifamily") noquote clear
rename ID_no id_new3
keep if codeB_T3==14 | codeB_T3==15
drop if id_new3==.
duplicates drop id_new3, force
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_HMHCH.dta", replace

odbc load, table("HMH_AD") dsn ("ifamily") noquote clear
keep if codeA_T3==5 |codeA_T3==6
drop if dism_T3==. & disf_T3==. 
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_HMHAD.dta", replace

odbc load, table("HMH") dsn ("ifamily") noquote clear
keep weight_m_T3 height_m_T3 family_ID
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_HMH.dta", replace

odbc load, table("core") dsn ("ifamily") noquote clear
rename ID_no id_new3
rename family_id family_ID
rename doe_T3 doe3

merge 1:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_HMHCH.dta", keepusing (codeB_T3) gen(mergeHMHCH)
merge m:1 family_ID using "D:/PROGS/STATA/VitD_inflamm/Data/T3_HMHAD.dta", keepusing (codeA_T3) gen(mergeHMHAD) 
merge m:1 family_ID using "D:/PROGS/STATA/VitD_inflamm/Data/T3_HMH.dta", keepusing (weight_m_T3 height_m_T3) gen(mergeHMH) 
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_coreHMH.dta", replace

odbc load, table("TE") dsn ("ifamily") noquote clear
rename ID_no id_new3
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_TE.dta", replace

odbc load, table("CH") dsn ("ifamily") noquote clear
rename ID_no id_new3
rename club_mbr_T3 club_mbr_T3ch
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_CH.dta", replace

merge 1:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_TE.dta", keepusing (club_mbr_T3) gen(mergeCH_TE)
replace club_mbr_T3 = club_mbr_T3ch if club_mbr_T3==.
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_PA.dta", replace

odbc load, table("PAEC") dsn ("ifamily") noquote clear
rename ID_no id_new3
rename preterm_T3 birth_term_T3
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_pq.dta", replace

odbc load, table("PE_PO") dsn ("ifamily") noquote clear
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_pepo.dta", replace

odbc load, table("BSD_CO") dsn ("ifamily") noquote clear
rename ID_no id_new3
keep if sample_kind_T3 ==1
save "D:\PROGS\STATA\BlackT2D\Data\T3_blood_time.dta", replace

***T1***
use "D:/IDEFICS/T1/data/Core/V20221027/Stata/core.dta", replace
rename ID_no id_new1
rename fasting_blood_t1 fasting_blood_T1
rename AVM_1_week_t1 AVM_1_week_T1
rename bmi_cat_COLE_t1 bmi_cat_COLE_T1
rename BF_1_t1 BF_1_T1
rename HDS_t1 hds_T1
rename isced_cat2011_t1 isced_cat2011_T1
rename doe_t1 doe1
save "D:/PROGS/STATA/VitD_inflamm/Data/T1_core.dta", replace

use "D:/IDEFICS/T1/data/SurvDB/V20210817/Stata/hmh.dta", clear
rename ID_no id_new1
save "D:/PROGS/STATA/VitD_inflamm/Data/T1_HMH.dta", replace

use "D:/IDEFICS/T1/data/SurvDB/V20210817/Stata/pq.dta", clear
rename ID_no id_new1
rename club_mbr_t1 club_mbr_T1 
rename preg_w_up_t1 preg_w_up_T1
rename birth_w_t1 birth_w_T1 
rename birth_term_t1 birth_term_T1 
rename weeksearly_t1 weeksearly_T1 
rename height_m_t1 height_m_T1 
rename weight_m_t1 weight_m_T1 
save "D:/PROGS/STATA/VitD_inflamm/Data/T1_pq.dta", replace

***T0***
use "D:\IDEFICS\T0\data\LaboratoryData\V20221118\STATA\laboratory_analysis_bch.dta", clear
rename ID_no id_new0
rename VitD25 VitD25_T0
save "D:/PROGS/STATA/VitD_inflamm/Data/T0_lab.dta", replace

use "D:/IDEFICS/T0/data/Core/V20221027/Stata/core.dta", clear
rename ID_no id_new0
rename AVM_1_week AVM_1_week_T0
rename bmi_cat_COLE bmi_cat_COLE_T0
rename doe doe0
save "D:/PROGS/STATA/VitD_inflamm/Data/T0_core.dta", replace

use "D:/IDEFICS/T0/data/SurvDB/V20221121/Stata/hmh.dta", clear
rename ID_no id_new0
save "D:/PROGS/STATA/VitD_inflamm/Data/T0_HMH.dta", replace

use "D:/IDEFICS/T0/data/SurvDB/V20221121/Stata/pq.dta", clear
rename ID_no id_new0
save "D:/PROGS/STATA/VitD_inflamm/Data/T0_pq.dta", replace

import sas using "D:\IDEFICS\T0\data\BiosampleDocumentation\V20200407\SAS\t_collection.sas7bdat", clear
gen test2 = floor(bioprobe_ID/1e2)
gen ID_cohort = mod(test2,10000000)
gen sample_type = mod(bioprobe_ID, 10)
keep if sample_type==1
gen colldat_m_T0 = month( coll_dat)
save "D:/PROGS/STATA/VitD_inflamm/Data/collection_date.dta", replace

***ATC***
odbc load, table("drugs_code_long") dsn ("IdefIFAM") noquote clear

foreach n of numlist 10 14 {
gen who`n' = substr(atc_who_20`n',1,3)
gen who`n'_cat =1 if who`n'=="A10"
replace who`n'_cat =2 if who`n'=="H02"
replace who`n'_cat =3 if who`n'=="J01"
replace who`n'_cat =4 if who`n'=="M01"
}

foreach n of numlist 0 1 {
preserve
keep ID_no_IDEFICS who10 survey who10_cat 
keep if (who10 =="A10" | who10 =="M01" | who10 =="H02" | who10 =="J01") & survey==`n'
by ID_no_IDEFICS who10_cat , sort: gen nvals = _n == 1 
keep if nvals
reshape wide survey who10 nvals, i(ID_no_IDEFICS) j(who10_cat)
rename ID_no_IDEFICS id_new`n'
keep id_new`n' who101 who102 who103 who104
rename who10* atc*_`n'
save "D:/PROGS/STATA/VitD_inflamm/Data/T`n'_atc.dta", replace
restore
}

preserve
keep ID_no_IFAMILY who14 survey who14_cat 
keep if (who14 =="A10" | who14 =="M01" | who14 =="H02" | who14 =="J01") & survey==3
by ID_no_IFAMILY who14_cat , sort: gen nvals = _n == 1 
keep if nvals
reshape wide survey who14 nvals , i(ID_no_IFAMILY) j(who14_cat)
rename ID_no_IFAMILY id_new3
keep id_new3 who141 who142 who143 who144
rename who14* atc*_3
save "D:/PROGS/STATA/VitD_inflamm/Data/T3_atc.dta", replace
restore

***Longitudinal***

odbc load, table("Zscores_long") dsn ("IdefIFAM") noquote clear

drop Z_HOMA Z_GLU Z_HDL P_HOMA P_GLU P_HDL alert_meta alert_strong_meta 

local m MetS alert_meta alert_strong_meta
foreach x of local m {
gen `x'_c = `x'_IF 
replace `x'_c = `x'_ID if `x'_c==.
}

gen id_new = ID_no_IFAMILY if survey==3
replace id_new = ID_no_IDEFICS if survey==1
replace id_new = ID_no_IDEFICS if survey==0

local var HOMA GLU HDL TRG 
foreach x of local var {
gen Z_`x' = Z_`x'_IF
replace Z_`x' = Z_`x'_ID if Z_`x'==.
gen P_`x' = P_`x'_IF
replace P_`x' = P_`x'_ID if P_`x'==.
gen `x'_c = `x'_IF
replace `x'_c = `x'_ID if `x'_c==.
}

keep ID_cohort survey id_new Z_HOMA Z_GLU Country Age sex Z_Waist Z_DBP Z_SBP Waist Waist_To_Height TRG_c BMI Z_TRG Z_HDL Z_BMI P_HOMA P_GLU Z_Waist_To_Height GLU_c HOMA_c P_TRG P_Waist MetS_c alert_meta_c alert_strong_meta_c HDL_c SBP DBP P_HDL P_SBP P_DBP 

reshape wide id_new Z_GLU Z_HOMA Z_TRG GLU_c HOMA_c P_TRG P_Waist Waist Waist_To_Height TRG_c BMI Z_BMI Z_HDL Country Age sex Z_Waist Z_DBP Z_SBP P_HOMA P_GLU Z_Waist_To_Height MetS_c alert_meta_c alert_strong_meta_c HDL_c SBP DBP P_HDL P_SBP P_DBP, i(ID_cohort) j(survey)

********************
***Merge datasets***
********************

***Vitamin D***
merge m:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_lab.dta", keepusing(VitD25_T3) gen(_mergev3)
drop if _mergev3==2 //ID 5420399 is an adult and therefore was excluded even though vitamin D was measured for this individual
merge m:1 id_new0 using "D:/PROGS/STATA/VitD_inflamm/Data/T0_lab.dta", keepusing(VitD25_T0) gen(_mergev0)
drop if _mergev0==2 //since ID 1910019 was partially included in Zscores_long table, I manually included the important variables that will be used in this analysis
replace id_new0 = 1910019 if ID_cohort== 1910019
replace VitD25_T0=10 if id_new0== 1910019
replace Country0 = 9 if id_new0== 1910019
replace Age0 =  6.5 if id_new0== 1910019
replace sex0 = 2 if id_new0== 1910019

***Inflammatory markers***
merge m:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_lab.dta", keepusing(IL_6_MSD_T3 IL_8_MSD_T3 IL_15_MSD_T3 IL_1Ra_MSD_T3 Adip_MSD_T3 Lept_MSD_T3 CRP_MSD_T3 IP_10_MSD_T3 TNF_a_MSD_T3 Ghrelin_MSD_T3) gen(_merge3)
drop if _merge3==2
merge m:1 id_new0 using "D:/PROGS/STATA/VitD_inflamm/Data/T0_lab.dta", keepusing(Adip_MSD CRP_MSD Lept_MSD TNF_a_MSD IP_10_MSD IL_8_MSD IL_6_MSD IL_15_MSD IL_1Ra_MSD Ghrelin_MSD) gen(_merge0)
drop if _merge0==2


***Core***
merge m:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_coreHMH.dta", keepusing(PHYS_ACTIV_T3 status sweet_prop_T3 hmh_in_T3 fasting_blood_T3 AVM_1_week_T3 bmi_cat_COLE_T3 BF_1_T3 hds_T3 pub_T3 weight_m_T3 height_m_T3 isced_cat2011_T3 doe3) gen(_mergecore3)
drop if _mergecore3==2
merge m:1 id_new1 using "D:/PROGS/STATA/VitD_inflamm/Data/T1_core.dta", keepusing(hmh_in fasting_blood AVM_1_week_T1 bmi_cat_COLE_T1 BF_1_T1 hds_T1 isced_cat2011_T1 doe1) gen(_mergecore1)
drop if _mergecore1==2
merge m:1 id_new0 using "D:/PROGS/STATA/VitD_inflamm/Data/T0_core.dta", keepusing(sweet_prop PHYS_ACTIV hmh_in fasting_blood AVM_1_week_T0 bmi_cat_COLE_T0 BF_1 hds isced_cat2011 doe0) gen(_mergecore0)
drop if _mergecore0==2

***Smoking and alcohol***
merge m:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_TE.dta", keepusing (smoke_freq alc_days_T3 smoke_occ_T3 alc_life_T3) gen (_mergeTE3)
drop if _mergeTE3==2

***PA_club_mbr***
merge m:1 id_new0 using "D:/PROGS/STATA/VitD_inflamm/Data/T0_pq.dta", keepusing(club_mbr birth_w birth_term weeksearly preg_w_up height_m weight_m) gen(_mergepq0)
drop if _mergepq0==2
merge m:1 id_new1 using "D:/PROGS/STATA/VitD_inflamm/Data/T1_pq.dta", keepusing(club_mbr_T1 birth_w_T1 birth_term_T1 weeksearly_T1 preg_w_up_T1 height_m_T1 weight_m_T1) gen(_mergepq1)
drop if _mergepq1==2
merge m:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_PA.dta", keepusing(club_mbr_T3) gen(_mergepq3)
drop if _mergepq3==2
merge m:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_pq.dta", keepusing(birth_w_T3 birth_term_T3 weeksearly_T3 preg_w_up_T3) gen(_mergepq3_1)
drop if _mergepq3_1==2

merge m:1 ID_cohort using "D:/PROGS/STATA/VitD_inflamm/Data/T3_pepo.dta", keepusing(compl_week_preg weight_birth_U) gen(_mergepq3_2)
drop if _mergepq3_2==2

***Blood_time***
merge m:1 id_new3 using "D:/PROGS/STATA/BlackT2D/Data/T3_blood_time.dta", keepusing(colldat_m_T3) gen(_mergeblood3)
drop if _mergeblood3==2

merge m:1 ID_cohort using "D:/PROGS/STATA/VitD_inflamm/Data/collection_date.dta", keepusing(colldat_m_T0) gen(_mergeblood0)
drop if _mergeblood0==2

***ATC codes***
merge m:1 id_new0 using "D:/PROGS/STATA/VitD_inflamm/Data/T0_atc.dta", keepusing(atc*) gen(_mergeatc0)
drop if _mergeatc0==2

merge m:1 id_new1 using "D:/PROGS/STATA/VitD_inflamm/Data/T1_atc.dta", keepusing(atc*) gen(_mergeatc1)
drop if _mergeatc1==2

merge m:1 id_new3 using "D:/PROGS/STATA/VitD_inflamm/Data/T3_atc.dta", keepusing(atc*) gen(_mergeatc3)
drop if _mergeatc3==2
drop _merge*

**********************
***Rename variables***
**********************
local var1 PHYS_ACTIV sweet_prop fasting_blood club_mbr birth_w birth_term weeksearly preg_w_up BF_1 hds height_m weight_m isced_cat2011 Adip_MSD CRP_MSD Lept_MSD TNF_a_MSD IP_10_MSD IL_8_MSD IL_6_MSD IL_15_MSD IL_1Ra_MSD Ghrelin_MSD
foreach x of local var1 {
rename `x' `x'_T0
}
rename compl_week_preg compl_week_preg_T3
rename weight_birth_U weight_birth_U_T3

************************
***Generate variables***
************************
***Continuous follow-up time***
gen surveytime0 = 0 if Age0 !=.
gen surveytime1 = Age1 - Age0 if Age1 !=. & Age0 !=. 
replace surveytime1 = 0 if Age1 !=. & Age0==.
gen surveytime3 = Age3 - Age0 if Age3 !=. & Age0 !=. 
replace surveytime3 = 0 if Age3 !=. & Age0==. & Age1==.
replace surveytime3 = Age3 - Age1 if Age3 !=. & Age1 !=. & Age0==.

***Maternal BMI***
foreach num of numlist 0 1 3 {
gen BMI_m_T`num' = weight_m_T`num'/(height_m_T`num'/100)^2
}

****************************
***Data Management - wide***
****************************
***Gender discordance***
list ID_cohort sex* if sex0 !=. & sex1 !=. & (sex0 != sex1)
list ID_cohort sex* if sex1 !=. & sex3 !=. & (sex1 != sex3) 
list ID_cohort sex* if sex0 !=. & sex3 !=. & (sex0 != sex3)
replace sex0 = 2 if ID_cohort == 1810053 

***Country discordance***
list ID_cohort Country* if Country0 !=. & Country1 !=. & (Country0 != Country1)
list ID_cohort Country* if Country1 !=. & Country3 !=. & (Country1 != Country3) 
list ID_cohort Country* if Country0 !=. & Country3 !=. & (Country0 != Country3)

***Age ambiguity***
list ID_cohort Age* if Age0 !=. & Age1 !=. & (Age0 > Age1)
list ID_cohort Age* if Age1 !=. & Age3 !=. & (Age1 > Age3) 
list ID_cohort Age* if Age0 !=. & Age3 !=. & (Age0 > Age3)

***Time of follow-up ambiguity***
list ID_cohort surveytime* if surveytime0 !=. & surveytime1 !=. & (surveytime0 > surveytime1)
list ID_cohort surveytime* if surveytime1 !=. & surveytime3 !=. & (surveytime1 > surveytime3) 
list ID_cohort surveytime* if surveytime0 !=. & surveytime3 !=. & (surveytime0 > surveytime3)

***Normality of exposure & outcome variables in T0 and T3***
local marker Adip_MSD_T CRP_MSD_T Lept_MSD_T TNF_a_MSD_T IP_10_MSD_T IL_8_MSD_T IL_6_MSD_T IL_15_MSD_T IL_1Ra_MSD_T Ghrelin_MSD_T VitD25_T
foreach x of local marker {
sum `x'3 `x'0 if `x'0 !=. & `x'3 !=.
sktest `x'0
sktest `x'3
histogram `x'3, normal
graph save "D:/PROGS/STATA/VitD_inflamm/Graphs/`x'3.gph", replace
histogram `x'0, normal
graph save "D:/PROGS/STATA/VitD_inflamm/Graphs/`x'0.gph", replace
}

******************************
***Data Management - long***
******************************
keep surveytime* *MSD_T* Z_* Country* Age* sex* id_new* ID_cohort* survey* smoke_* alc_* P_* preg_w_up* birth_term* weeksearly* birth_w* compl_week_preg weight_birth_U pub_T3 BF_1* hds* fast* club_mbr* AVM_1_week_T* GLU_c* HOMA_c* atc* bmi_cat_COLE_T* Waist* Waist_To_Height* TRG_c* BMI* BMI_m_T* height_m_T* weight_m_T* VitD25_T* isced_cat2011_T* Waist* SBP* DBP* P_HDL* P_SBP* P_DBP* *_MSD_T* doe* colldat_m_T*

***Covert data to long***
reshape long id_new Z_GLU Z_HOMA Z_TRG Z_BMI Z_HDL surveytime smoke_occ_T alc_life_T preg_w_up_T birth_term_T weeksearly_T birth_w_T compl_week_preg_T weight_birth_U_T pub_T BF_1_T hds_T Country Age sex Z_Waist Z_DBP Z_SBP smoke_freq_T alc_days_T P_HOMA P_GLU fasting_blood_T club_mbr_T AVM_1_week_T GLU_c HOMA_c atc1_ atc2_ atc3_ atc4_  bmi_cat_COLE_T P_TRG P_Waist Waist Waist_To_Height Z_Waist_To_Height TRG_c BMI BMI_m_T height_m_T weight_m_T VitD25_T isced_cat2011_T SBP DBP P_HDL P_SBP P_DBP Adip_MSD_T CRP_MSD_T Lept_MSD_T TNF_a_MSD_T IP_10_MSD_T IL_8_MSD_T IL_6_MSD_T IL_15_MSD_T IL_1Ra_MSD_T Ghrelin_MSD_T doe colldat_m_T, i(ID_cohort) j(survey)

drop if Age==. & sex==. 

foreach m of varlist alc_days_T smoke_freq_T alc_life_T smoke_occ_T {
replace `m'=0 if survey==0 | survey==1 //alcohol & smoking question not asked to children under 12 and in T0, T1
replace `m'=0 if Age <=11.99 & survey ==3 //alcohol & smoking question not asked to children under 12 and in T0, T1
}
replace alc_days_T=0 if alc_life_T==0 & survey ==3
replace smoke_freq_T =0 if smoke_occ_T==0 & survey ==3

gen alc_lifecat =1 if alc_life_T>0 & alc_life_T<999
replace alc_lifecat =0 if alc_life_T==0

gen smoke_occcat =1 if smoke_occ_T>0 & smoke_occ_T<999
replace smoke_occcat =0 if smoke_occ_T==0

replace pub_T=0 if survey==0 | survey==1 

replace atc3 = "0" if atc3 == ""
replace atc3 = "1" if atc3 == "J01"
destring atc3_, replace

sort ID_cohort survey

egen n1 = count(ID_cohort), by(ID_cohort)

egen final = total (VitD25_T !=.), by (ID_cohort)
drop if final==0

duplicates re ID_cohort if final >0

***Participants with no inflammatory marker information in all 3 surveys***
egen nbad3 = total( Adip_MSD_T==. & CRP_MSD_T==. & Lept_MSD_T==. & TNF_a_MSD_T==. & IP_10_MSD_T==. & IL_8_MSD_T==. & IL_6_MSD_T==. & IL_15_MSD_T==. & IL_1Ra_MSD_T==. & Ghrelin_MSD_T==.) , by( ID_cohort )
drop if nbad3==n1
duplicates re ID_cohort

***Remove participants with gender discordance***
bysort ID_cohort (sex): gen tag = sex[1] != sex[_N]
drop if tag
duplicates re ID_cohort

***Remove participants with medications***
egen nbad2 = total( atc4 == "M01" | atc2 == "H02") , by( ID_cohort )
drop if nbad2
duplicates re ID_cohort

***Remove participants with high CRP levels***
egen nbad1 = total( CRP_MSD_T >10000 & CRP_MSD_T !=.) , by( ID_cohort )
drop if nbad1
duplicates re ID_cohort

***Maternal BMI, Birthweight, Birth term, Breastfeeding***
*Collected at time of interview
bysort ID_cohort (survey) : gen bmi_mat = BMI_m_T[1] if BMI_m_T[1] !=. //created Maternal BMI var with Mothers BMI at entry

foreach var of varlist preg_w_up_T birth_w_T BF_1_T birth_term_T weeksearly_T compl_week_preg_T weight_birth_U_T {
	bysort ID_cohort  (`var') : gen OK = (`var' == `var'[1]) | missing(`var') 
by ID_cohort: egen allOK = min(OK)
bysort ID_cohort: mipolate `var' survey if allOK, gen(new`var') groupwise
drop OK allOK
} //generated new vars with copied values at entry

egen nbad4 = total (newbirth_term_T==2 & newweeksearly_T==.), by (ID_cohort)
replace newweeksearly = 0 if nbad4
corr newweight_birth_U_T newbirth_w_T // excellent corr

**Age and Sex specific z-scores of vitamin D and Inflammatory markers***
foreach var of varlist VitD25_T Adip_MSD_T CRP_MSD_T Lept_MSD_T TNF_a_MSD_T IP_10_MSD_T IL_8_MSD_T IL_6_MSD_T IL_15_MSD_T IL_1Ra_MSD_T Ghrelin_MSD_T {
stndzxage `var' Age sex survey, continuous graph
graph save all "D:/PROGS/STATA/VitD_inflamm/Graphs/`var'stdage.gph", replace
tab sex survey, sum(stx_`var')
}
rename stx_* stx*

***Count number of individuals at each survey in analaysis dataset***
egen sample = total(VitD25_T !=. & (Adip_MSD_T !=. | CRP_MSD_T !=. | Lept_MSD_T !=. | TNF_a_MSD_T !=. | IP_10_MSD_T !=. | IL_8_MSD_T !=. | IL_6_MSD_T !=. | IL_15_MSD_T !=. | IL_1Ra_MSD_T !=. | Ghrelin_MSD_T !=.)) , by( ID_cohort )
duplicates re ID_cohort if sample==2
duplicates re ID_cohort if sample==1 |sample==0
br *_MSD_T* nbad3 ID_cohort survey n1 sample if sample==1 & survey==0 & VitD !=. & (Adip_MSD_T !=. | CRP_MSD_T !=. | Lept_MSD_T !=. | TNF_a_MSD_T !=. | IP_10_MSD_T !=. & IL_8_MSD_T !=. | IL_6_MSD_T !=. | IL_15_MSD_T !=. | IL_1Ra_MSD_T !=. | Ghrelin_MSD_T !=.)

*drop if sample==0

***Combine inflammatory markers***
gen comb_il15anti = stxCRP_MSD_T + stxLept_MSD_T + stxTNF_a_MSD_T + stxIP_10_MSD_T + stxIL_8_MSD_T + stxIL_6_MSD_T - stxIL_15_MSD_T - stxIL_1Ra_MSD_T - stxAdip_MSD_T - stxGhrelin_MSD_T

gen comb_il15pro = stxCRP_MSD_T + stxLept_MSD_T + stxTNF_a_MSD_T + stxIP_10_MSD_T + stxIL_8_MSD_T + stxIL_6_MSD_T + stxIL_15_MSD_T - stxIL_1Ra_MSD_T - stxAdip_MSD_T - stxGhrelin_MSD_T

gen comb_il15none = stxCRP_MSD_T + stxLept_MSD_T + stxTNF_a_MSD_T + stxIP_10_MSD_T + stxIL_8_MSD_T + stxIL_6_MSD_T - stxIL_1Ra_MSD_T - stxAdip_MSD_T - stxGhrelin_MSD_T

*******************************
***Generate variables - long***
*******************************
gen n_VitD25_T = VitD25_T/5

gen bmi_cat = 2 if bmi_cat_COLE_T <0 //underwt
replace bmi_cat = 0 if bmi_cat_COLE_T ==0 //normalwt
replace bmi_cat = 1 if bmi_cat_COLE_T >0 & bmi_cat_COLE_T <9999 //overwt/obese

bysort ID_cohort  (bmi_cat) : gen OK = (bmi_cat != bmi_cat[1]) | missing(bmi_cat) //to check if the categories of bmi changed within the individuals

gen vitD_cat =0 if VitD25_T >=29.5 & VitD25_T <=50.4 //normal levels
replace vitD_cat =1 if VitD25_T >=20 & VitD25_T <=29.4 //insufficient
replace vitD_cat =2 if VitD25_T <20 //deficient

gen vitd_si = VitD25_T*2.5

gen vitdsi_cat = 0 if vitd_si <75
replace vitdsi_cat =1 if vitd_si >=75 & vitd_si <=125

gen vitD_catnew =0 if vitd_si >=75 & vitd_si <=125 //normal levels
replace vitD_catnew =1 if vitd_si >=50 & vitd_si <75  //insufficient
replace vitD_catnew =2 if vitd_si <50 //deficient
replace vitD_catnew =3 if vitd_si >125 & vitd_si <999 //high

gen age_cat = 0 if Age <6
replace age_cat = 1 if Age >=6 & Age <10
replace age_cat = 2 if Age >=10 & Age <20

gen n_vitd_si = vitd_si/12.5

*************
***Table 1***
*************
foreach var of varlist sex* Country* smoke* alc_* club_mbr_T fasting_blood bmi_cat_COLE_T atc3_ newbirth_term_T pub_T bmi_cat vitD_catnew {
tab `var' survey if final >0, col chi2 miss
}

foreach var of varlist Age* Z_* surveytime* *_c newbirth_w_T newBF_1_T hds_T bmi_mat vitd_si AVM_1_week_T *MSD* Waist SBP DBP *_MSD_T* BMI hds_T* comb* stx* {
bysort survey: sum `var' if final >0, detail
} 
 
preserve
drop if survey==1
save "D:/PROGS/STATA/VitD_inflamm/Data/ttest.dta", replace
foreach var of varlist Age* Z_* surveytime* *_c AVM_1_week_T vitd_si stx* Waist SBP DBP BMI {
display _newline(3)"ttest of `var' "
ttest `var' if final >0, by(survey)
} 
restore

save "D:/PROGS/STATA/VitD_inflamm/Data/final_data.dta", replace

***Normality of exposure & outcome variables in T0 and T3***
local marker Adip_MSD_T CRP_MSD_T Lept_MSD_T TNF_a_MSD_T IP_10_MSD_T IL_8_MSD_T IL_6_MSD_T IL_15_MSD_T IL_1Ra_MSD_T Ghrelin_MSD_T VitD25_T stxAdip_MSD_T stxCRP_MSD_T stxLept_MSD_T stxTNF_a_MSD_T stxIP_10_MSD_T stxIL_8_MSD_T stxIL_6_MSD_T stxIL_15_MSD_T stxIL_1Ra_MSD_T stxGhrelin_MSD_T
foreach x of local marker {
by survey: sum `x', detail
histogram `x', by(survey) normal
graph save "D:/PROGS/STATA/VitD_inflamm/Graphs/`x'.gph", replace
}

*************************
***Supplementary Table***
*************************

foreach var of varlist  Adip_MSD_T CRP_MSD_T Ghrelin_MSD_T Lept_MSD_T TNF_a_MSD_T IP_10_MSD_T IL_8_MSD_T IL_6_MSD_T IL_15_MSD_T IL_1Ra_MSD_T comb_il15anti {
bysort survey bmi_cat: sum `var' if final >0, detail
display "Kruskalwallis for `var' for survey==0"
kwallis `var' if survey==0 & final>0, by(bmi_cat)
display "Kruskalwallis for `var' for survey==3"
kwallis `var' if survey==3 & final>0, by(bmi_cat)
} 

*************************************
***New table suggested by reviewer***
*************************************

bysort survey age_cat: sum vitd_si if final >0, detail
bysort survey bmi_cat: sum vitd_si if final >0, detail

bys survey: tab age_cat vitdsi_cat, miss col
bys survey: tab bmi_cat vitdsi_cat , miss col

*************************
***Regression Analysis***
*************************
*There is no difference between z-scores and raw values of vitD therefore decided to run models only with raw values (check scatter plots)
*Assumption the change in the relation for all individuals is not the same , therefore random slope.
*Statistically AIC and BIC lower in random slope vs. random intercept models, hence randome slope was chosen
*lrtest significant for inflammatory markers thus favoring random slope model
foreach var of varlist n_vitd_si {
foreach m of varlist stx*_MSD_T comb* {
mixed c.`m' c.`var' c.Age i.sex || ID_cohort: c.Age, cov(unstr) iterate(100)  
estat ic

mixed c.`m' c.`var' c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)
est store slo`m'_vitd
estat ic

mixed c.`m' c.`var'##c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)
estat ic

margins, dydx(`var') at(Age =(4 8 12 16))  saving (`m', replace)	
	}
}

combomarginsplot stxLept_MSD_T stxAdip_MSD_T stxGhrelin_MSD_T, recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("Leptin" "Adiponectin" "Ghrelin") fileci1opts(color(gs9%90)) fileci2opts(color(gs7%40)) fileci3opts(color(gs12%40)) plot2opts(lc(gs0) lpattern(dot)) plot1opts(lc(gs0) lpattern(solid)) plot3opts(lc(gs0) lpattern(dash)) recastci (rarea) xtitle("") title ("") ytitle("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_1,replace)

combomarginsplot stxTNF_a_MSD_T stxCRP_MSD_T stxIL_6_MSD_T , recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("TNF-α" "CRP" "IL-6") fileci1opts(color(gs9%90)) fileci2opts(color(gs7%40)) fileci3opts(color(gs12%40)) plot2opts(lc(gs0) lpattern(dot)) plot1opts(lc(gs0) lpattern(solid)) plot3opts(lc(gs0) lpattern(dash)) recastci (rarea) xtitle("") title ("") ytitle("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_2,replace)

combomarginsplot  stxIL_15_MSD_T stxIL_1Ra_MSD_T, recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("IL-15" "IL-1Ra" ) fileci1opts(color(gs9%90)) fileci2opts(color(gs7%40)) plot2opts(lc(gs0) lpattern(dot)) plot1opts(lc(gs0) lpattern(solid)) recastci (rarea) xtitle("") title ("") ytitle("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_3,replace) 

combomarginsplot stxIL_8_MSD_T stxIP_10_MSD_T comb_il15anti, recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("IL-8" "IP-10" "Inflammation score") fileci1opts(color(gs9%90)) fileci2opts(color(gs7%40)) fileci3opts(color(gs12%40)) plot2opts(lc(gs0) lpattern(dot)) plot1opts(lc(gs0) lpattern(solid)) plot3opts(lc(gs0) lpattern(dash)) recastci (rarea)  xtitle("")  ytitle("") title ("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_4,replace) 

graph combine vit_1.gph vit_2.gph vit_3.gph vit_4.gph, row(2) col(2) ycommon title("") graphregion(fcolor(white)) l1(regression coefficient) b1(age (in years)) 
 graph save Graph "D:/PROGS/STATA/VitaminD/Graphs/inflammation_si.gph", replace
 
 /***Figure 1-quadratic***
foreach var of varlist n_VitD25_T {
foreach m of varlist stxAdip_MSD_T stxCRP_MSD_T stxTNF_a_MSD_T stxIP_10_MSD_T stxIL_8_MSD_T stxIL_6_MSD_T stxIL_15_MSD_T stxIL_1Ra_MSD_T stxGhrelin_MSD_T comb {


mixed c.`m' c.`var'##c.Age##c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI || ID_cohort: c.Age##c.Age, cov(unstr) iterate(100) 
estat ic

margins, dydx(`var') at(Age =(4 8 12 16))  saving (`m', replace)	
	}
}

combomarginsplot stxAdip_MSD_T stxCRP_MSD_T stxLept_MSD_T , recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("Adiponectin" "CRP" "Leptin") ciopt(color(%60)) recastci (rarea) xtitle("") title ("") ytitle("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_1,replace)

combomarginsplot stxTNF_a_MSD_T stxIP_10_MSD_T stxIL_8_MSD_T, recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("TNF-α" "IP-10" "IL-8") ciopt(color(%60)) recastci (rarea) xtitle("") title ("") ytitle("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_2,replace)

combomarginsplot stxIL_6_MSD_T stxIL_15_MSD_T stxIL_1Ra_MSD_T , recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("IL-6" "IL-15" "IL-1Ra") ciopt(color(%60)) recastci (rarea) xtitle("") title ("") ytitle("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_3,replace) 

combomarginsplot stxGhrelin_MSD_T comb, recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) labels ("Ghrelin" "Inflammation score") ciopt(color(%60)) recastci (rarea)  xtitle("")  ytitle("") title ("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(4 "4" 8 "8" 12 "12" 16 "16") graphregion(fcolor(white)) saving(vit_4,replace) 

graph combine vit_1.gph vit_2.gph vit_3.gph vit_4.gph, row(2) col(2) ycommon title("") graphregion(fcolor(white)) l1(regression coefficient) b1(age (in years)) 
 graph save Graph "D:/PROGS/STATA/vitD_inflamm/Graphs/inflammation_quadratic.gph", replace
 */

***Sex stratified***
foreach m of varlist stx*_MSD_T comb* {
foreach var of varlist n_vitd_si {

bys sex: mixed c.`m' c.`var' c.Age i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)

mixed c.`m' c.`var'##i.sex c.Age i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)
	} 
 }
 
 ***BMI stratified***
foreach m of varlist stx*_MSD_T comb* {
foreach var of varlist n_vitd_si {

bys bmi_cat: mixed c.`m' c.`var' c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)

mixed c.`m' c.`var'##i.bmi_cat c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)
	} 
 }
 
***Adjustment for additional risk factors***
 foreach var of varlist n_vitd_si {
foreach m of varlist stx*_MSD_T comb* {

mixed c.`m' c.`var' c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI c.newbirth_w_T i.newbirth_term_T c.newBF_1_T i.pub_T c.bmi_mat c.colldat_m_T c.hds_T || ID_cohort: c.Age, cov(unstr) iterate(100)
estat ic
	}
 }
 
***Categories of Vitamin D***
foreach m of varlist stx*_MSD_T comb* {
foreach var of varlist vitD_catnew {
mixed c.`m' i.`var' c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)
estat ic
	} 
 }

 /*
***Change in vitD with change in inflammatory markers***
*Covert data to wide
drop _est_slostxAdip_MSD_T_vitd _est_slostxCRP_MSD_T_vitd _est_slostxLept_MSD_T_vitd _est_slostxTNF_a_MSD_T_vitd _est_slostxIP_10_MSD_T_vitd _est_slostxIL_8_MSD_T_vitd _est_slostxIL_6_MSD_T_vitd _est_slostxIL_15_MSD_T_vitd _est_slostxIL_1Ra_MSD_T_vitd _est_slostxGhrelin_MSD_T_vitd _est_slocomb_vitd

reshape wide sex Age Country Waist_To_Height SBP DBP Waist BMI P_Waist Z_Waist Z_Waist_To_Height P_SBP Z_SBP P_DBP Z_DBP Z_BMI id_new Z_HOMA P_HOMA HOMA_c Z_GLU P_GLU GLU_c Z_HDL P_HDL Z_TRG P_TRG TRG_c Adip_MSD_T CRP_MSD_T Ghrelin_MSD_T Lept_MSD_T TNF_a_MSD_T IP_10_MSD_T IL_8_MSD_T IL_6_MSD_T IL_15_MSD_T IL_1Ra_MSD_T VitD25_T fasting_blood_T doe hds_T BF_1_T AVM_1_week_T isced_cat2011_T pub_T bmi_cat_COLE_T weight_m_T height_m_T smoke_occ_T smoke_freq_T alc_life_T alc_days_T club_mbr_T preg_w_up_T birth_term_T weeksearly_T birth_w_T compl_week_preg_T weight_birth_U_T colldat_m_T atc1_ atc2_ atc3_ atc4_ surveytime BMI_m_T alc_lifecat smoke_occcat n1 final nbad3 tag nbad2 nbad1 bmi_mat newpreg_w_up_T newbirth_w_T newBF_1_T newbirth_term_T newweeksearly_T newcompl_week_preg_T newweight_birth_U_T nbad4 stxVitD25_T stxAdip_MSD_T stxCRP_MSD_T stxLept_MSD_T stxTNF_a_MSD_T stxIP_10_MSD_T stxIL_8_MSD_T stxIL_6_MSD_T stxIL_15_MSD_T stxIL_1Ra_MSD_T stxGhrelin_MSD_T comb n_VitD25_T bmi_cat vitD_cat, i(ID_cohort) j(survey)

local var stxAdip_MSD_T stxCRP_MSD_T stxLept_MSD_T stxTNF_a_MSD_T stxIP_10_MSD_T stxIL_8_MSD_T stxIL_6_MSD_T stxIL_15_MSD_T stxIL_1Ra_MSD_T stxGhrelin_MSD_T comb n_VitD25_T 
foreach x of local var {
gen c_`x' = `x'3 -`x'0
}

foreach var of varlist c_stx*_MSD_T c_comb {
regress `var' c_n_VitD25_T c.Age0 i.sex0 i.Country0 i.isced_cat2011_T0 c.AVM_1_week_T0 i.club_mbr_T0 c.Z_BMI0 c.colldat_m_T0
}
*/

***Testing non-linearity of association between vitamin D and inflammatory markers***

label variable stxAdip_MSD_T "Adiponectin"
label variable stxLept_MSD_T "Leptin"
label variable stxCRP_MSD_T "CRP"
label variable stxTNF_a_MSD_T "TNF-α"
label variable stxIP_10_MSD_T "IP-10"
label variable stxIL_8_MSD_T "IL-8"
label variable stxIL_6_MSD_T "IL-6"
label variable stxIL_15_MSD_T  "IL-15"
label variable stxGhrelin_MSD_T "Ghrelin"
label variable stxIL_1Ra_MSD_T "IL-1Ra"
label variable comb_il15anti "Inflammation score"

 *Testing
 mkspline2 vitDspline1 25 vitDspline2 50 vitDspline3 75 vitDspline4 100 vitDspline5 = vitd_si, display
foreach m of varlist stx*_MSD_T comb_il15anti  {
	local mtext : variable label `m' 
	if `"`mtext'"' == "" local mtext "`m'" 
	
	display "`mtext'"

mixed c.`m' c.vitDspline* c.Age i.sex i.Country i.isced_cat2011_T c.AVM_1_week_T i.smoke_occcat i.alc_lifecat i.club_mbr_T c.Z_BMI c.colldat_m_T || ID_cohort: c.Age, cov(unstr) iterate(100)
estat ic
margins, dydx(vitDspline*) saving (`m', replace)
marginsplot, recast(line) yline(0, lwidth(vthin) lpattern(dash) lcolor(black)) ciopt(color(%50)) recastci (rarea) xtitle("") title (`"`mtext'"') ytitle("") legend(col(2) pos(12) size(vsmall) symxsize(6) bmargin(zero) region(lstyle(none))) xlabel(1 "<25" 2 "25-<50" 3 "50-<75" 4 "75-<100" 5 "≥100", labsize(tiny))graphregion(fcolor(white)) saving (`m', replace)
}

graph combine stxAdip_MSD_T.gph stxCRP_MSD_T.gph stxLept_MSD_T.gph stxTNF_a_MSD_T.gph stxIP_10_MSD_T.gph stxIL_8_MSD_T.gph stxIL_6_MSD_T.gph stxIL_15_MSD_T.gph stxIL_1Ra_MSD_T.gph stxGhrelin_MSD_T.gph comb_il15anti.gph, row(2) col(6) ycommon graphregion(fcolor(white)) l1(regression coefficient) b1(Vitamin D (nmol/L)) 
 graph save Graph "D:/PROGS/STATA/VitD_inflamm/Graphs/spline40_si.gph", replace