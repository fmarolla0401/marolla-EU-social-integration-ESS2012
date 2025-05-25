*-----------------------------------------------------------------------
* 1.  SET THE WORKING DIRECTORY
*-----------------------------------------------------------------------
cd "`'"                     // 
*-----------------------------------------------------------------------
* 2.  LOCATE THE RAW DATA
*-----------------------------------------------------------------------
use "ESS6e02_6.dta", clear   //
*-----------------------------------------------------------------------

********************************************************************************
/* Data_processing.do: 

The dependent variables will pertain to different dimensions related to EU identity:
1) Support for further EU Integration
2) Trust in European Union Parliament 
3) Euroskepticism in party choices 

The indipendent variables will pertain to different characteristics related to objective and subjective social integration
Objective social integration:
1) Occupational class --> Lower classes more exposed to social exclusion risks 
2) Level of Education --> Lower educated more likely to risk social exclusion
3) Living in Rural Areas --> Individuals living in Rural areas more likely to shy away from European Identity
Subjecive Social Integration:
1) Social Acceptance ---> lower trust in generalized others means lower attachment to prevailing social norms and values
2) Social Contribution ---> lower perception of being valued members of society leads to detachment from mainstream social identity
3) Social Coherence ---> lower optimism for societal trajectory alienates individuals from bigger processes such as EU integration and thus European identity

 25/01/2024 
 */

*Country Sample
encode cntry, gen(country)
fre country

* Excluding Non-EU member countries 
drop if inlist(country, 29, 28, 24, 21, 17, 16, 1, 4)

********************************************************************************
***************************Dependent Variables**********************************
********************************************************************************
* 1) European Union: European unification go further or gone too far
fre euftf  
* ! 8.94% of sample Don't know 

* 2) Trust in the European Parliament
fre trstep
* ! 9.55% of sample Don't know 

* 3) Support for Eurosceptic parties -- 
* Using CHES 2010 data to determine Euroscepticism of parties. For each party, I associate the measure on their EU position to determine the extent of Euroscepticism in vote choices. 
* Given that ESS data on voting behaviour may cover some elections not considered by CHES 2010, when scores not provided in 2010, the CHES 2014 will be used. 
gen eurosk=.
* Belgium:
fre prtvtcbe
replace eurosk=6.2 if prtvtcbe==1
replace eurosk=6.571429 if prtvtcbe==2
replace eurosk=5.333333 if prtvtcbe==3
replace eurosk=3.5 if prtvtcbe==4
replace eurosk=6.066667 if prtvtcbe==5
replace eurosk=2.384615 if prtvtcbe==6
replace eurosk=2.6 if prtvtcbe==7
replace eurosk=6.666667 if prtvtcbe==8
replace eurosk=6.571429 if prtvtcbe==9
replace eurosk=6 if prtvtcbe==10
replace eurosk=2.615385 if prtvtcbe==11
replace eurosk=6.666667 if prtvtcbe==12
replace eurosk=6.2 if prtvtcbe==13
replace eurosk=2.384615 if prtvtcbe==14 // (Score for PTB assumed as for PVDA)
replace eurosk=2.5 if prtvtcbe==15 // (Score for Parti Populaire provided in CHES 2014)

* Bulgaria 
fre prtclcbg
replace eurosk=6.727273 if prtclcbg==1  // GERB
replace eurosk=5.818182 if prtclcbg==3  // DPS
replace eurosk=6.454545 if prtclcbg==5  // DSB
replace eurosk=4.222222 if prtclcbg==7  // RZS
replace eurosk=6.545455 if prtclcbg==11 // NDSV
replace eurosk=2.5 if prtclcbg==6  // Ataka 
replace eurosk=5.29 if prtclcbg==2  // BSP (Score provided in CHES 2014)
replace eurosk=6.647059 if prtclcbg==4  // SDS (Score provided in CHES 2014)
replace eurosk=5.294117 if prtclcbg==8  // Balgarski sotsialdemokrati (BSP score provided in CHES 2014)
* replace eurosk=[score] if prtclcbg==10 // Zelena partia (Aleksandar Karakachanov) (Score not provided)
replace eurosk=6.75 if prtclcbg==12 // Dvizhenie Bulgaria na grazhdanite (M.Kuneva) (DBG score provided in CHES 2014)
* replace eurosk=[score] if prtclcbg==13 // Grazhdansko obedinenie za realna demokratsia (S.Binev) (Score not provided)
replace eurosk=6.727273 if prtclcbg==14 // Sayuz na svobodnite demokrati (SSD) (ODS score provided in CHES 2014)
* replace eurosk=[score] if prtclcbg==15 // Novoto vreme (Emil Koshlukov) (Score not provided)
* replace eurosk=[score] if prtclcbg==16 // Sayuz na patriotichnite sili „Zashtita" (Score not provided)
* replace eurosk=[score] if prtclcbg==17 // Drugata Bulgaria (Score not provided)
* replace eurosk=[score] if prtclcbg==18 // Narodna partia „Svoboda i dostoynstvo" (Score not provided)

* Cyprus ---> Only in 2014 expert Survey
fre prtvtacy
replace eurosk=4.5 if prtvtacy==1  // AKEL
replace eurosk=5.5 if prtvtacy==2  // DIKO
replace eurosk=6.75 if prtvtacy==3  // DISY
replace eurosk=6 if prtvtacy==4  // EVROKO
replace eurosk=3 if prtvtacy==5.5 // The Cyprus Green Party (Assumed KOP - Ecological and Environmental Movement)
replace eurosk=5.75 if prtvtacy==6 // KS EDEK

* Czech Republic 
fre prtvtccz
replace eurosk=2.526316 if prtvtccz==1  // KSČM
replace eurosk=6.157895 if prtvtccz==2  // ČSSD
replace eurosk=5.777778 if prtvtccz==3  // TOP 09
replace eurosk=4.916667 if prtvtccz==4  // VV
replace eurosk=3 if prtvtccz==5 // ODS

* Germany 
fre prtvdde1
replace eurosk=5.882353 if prtvdde1==1  // SPD
replace eurosk=5.470588 if prtvdde1==2  // CDU/CSU (average CDU: 6 CSU: 4.941176)
replace eurosk=6 if prtvdde1==3  // Greens
replace eurosk=6 if prtvdde1==4  // FDP
replace eurosk=3.294118 if prtvdde1==5 // Die Linke 
* replace eurosk= if prtvdde1==6 // Die Republikaners  (Score not provided)
replace eurosk=1.666667 if prtvdde1==7 // NPD  (Score provided in CHES 2014)
replace eurosk=4.714286 if prtvdde1==8 // Pirate Party  (Score provided in CHES 2014)

* Denmark
fre prtvtcdk
replace eurosk=5.909091 if prtvtcdk==1  // Socialdemokraterne
replace eurosk=6.818182 if prtvtcdk==2  // Det Radikale Venstre 
replace eurosk=5.909091 if prtvtcdk==3  // Det Konservative Folkeparti
replace eurosk=4.545455 if prtvtcdk==4  // SF Socialistisk Folkeparti
replace eurosk=2.363636 if prtvtcdk==5 // Dansk Folkeparti
* replace eurosk= if prtvtcdk==6 // Kristendemokraterne (Score not provided)
replace eurosk=6.090909 if prtvtcdk==7 // Venstre, Danmarks Liberale Parti
replace eurosk=6.125 if prtvtcdk==8 // Liberal Alliance
replace eurosk=1.727273 if prtvtcdk==9 // Enhedslisten - Unity List - The Red-Green  Alliance 

* Estonia 
fre prtvtdee
replace eurosk=6.5 if prtvtdee==1       // IRL - Erakond Isamaa ja Res Publica Liit
replace eurosk=5.285714 if prtvtdee==2  // EK - Eesti Keskerakond
replace eurosk=6.785714 if prtvtdee==3  // ER - Eesti Reformierakond
replace eurosk=6.571429 if prtvtdee==5  // SDE - Sotsiaaldemokraatlik Erakond
replace eurosk=5.846154 if prtvtdee==6  // EER - Erakond Eestimaa Rohelised
* replace eurosk=[score] if prtvtdee==4  // EKRE - Eesti Konservatiivne Rahvaerakond (Score not provided)
* replace eurosk=[score] if prtvtdee==7  // EKD - Erakond Eesti Kristlikud Demokraadid (Score not provided)
* replace eurosk=[score] if prtvtdee==8  // EIP - Eesti Iseseisvuspartei (Score not provided)
* replace eurosk=[score] if prtvtdee==9  // EUV - Eestimaa Ühendatud Vasakpartei (Score not provided)
* replace eurosk=[score] if prtvtdee==10 // EVP - Eesti Vabaduspartei – Põllumeeste Kogu (Score not provided)

* Spain 
fre prtvtces
replace eurosk=6 if prtvtces==1        // Partido Popular - PP
replace eurosk=6.75 if prtvtces==2     // Partido Socialista Obrero Español (PSOE)
replace eurosk=6.090909 if prtvtces==3  // Convergència i Unió (CiU)
replace eurosk=4.75 if prtvtces==4     // Izquierda Unida (IU)
replace eurosk=4.714286 if prtclcbg==5  // AMAIUR (Score provided in CHES 2014)
replace eurosk=5.27273 if prtvtces==6   // Unión, Progreso y Democracia (UPyD)
replace eurosk=5.727273 if prtvtces==7  // Partido Nacionalista Vasco (PNV)
replace eurosk=5.272727 if prtvtces==8  // Esquerra Republicana de Catalunya (ERC)
replace eurosk=4.818182 if prtvtces==9  // Bloque Nacionalista Galego (BNG)
replace eurosk=5.6 if prtvtces==10     // Coalición Canaria - Nueva Canarias
* replace eurosk=[score] if prtclcbg==11 // Compromís - EQUO (Score not provided)
* replace eurosk=[score] if prtclcbg==12 // Foro de Ciudadanos (Score not provided)
replace eurosk=5.727273 if prtclcbg==13 // Geroa Bai (Assumed PNV)

* Finland 
fre prtvtcfi
replace eurosk=6.444445 if prtvtcfi==1  // KOK - The National Coalition Party
replace eurosk=6.333333 if prtvtcfi==2  // SFP/RKP - The Swedish People's Party
replace eurosk=5.4 if prtvtcfi==3       // KESK - The Centre Party
replace eurosk=1.666667 if prtvtcfi==4  // PS - True Finns
replace eurosk=3.777778 if prtvtcfi==5  // KD - Christian Democrats
* replace eurosk=[score] if prtvtcfi==6  // Freedom Party (Score not provided)
* replace eurosk=[score] if prtvtcfi==7  // Change 2011 (Score not provided)
* replace eurosk=[score] if prtvtcfi==8  // Pirate Party (Score not provided)
* replace eurosk=[score] if prtvtcfi==9  // Senior Citizens' Party (Score not provided)
* replace eurosk=[score] if prtvtcfi==10 // Independence Party (Score not provided)
* replace eurosk=[score] if prtvtcfi==11 // For the Poor (Score not provided)
replace eurosk=6.111111 if prtclcbg==12 // VIHR - Green League
replace eurosk=5.888889 if prtclcbg==13 // SDP - Social Democratic Party
replace eurosk=4.111111 if prtclcbg==14 // VAS - Left Alliance
* replace eurosk=[score] if prtvtcfi==15 // Communist Party (Score not provided)
* replace eurosk=[score] if prtvtcfi==16 // The Communist Workers' Party (Score not provided)
* replace eurosk=[score] if prtvtcfi==17 // Workers' Party (Score not provided)

* France 
fre prtvtcfr
replace eurosk=6.285714 if prtvtcfr==1  // NC - Nouveau Centre
replace eurosk=1.222222 if prtvtcfr==2  // FN - Front National
* replace eurosk=[score] if prtvtcfr==3  // PR - Parti Radical Valoisien (Score not provided)
* replace eurosk=[score] if prtvtcfr==4    // NPA - Nouveau Parti Anti-Capitaliste (Score not provided)
* replace eurosk=[score] if prtvtcfr==5    // LO - Lutte Ouvrière (Score not provided)
replace eurosk=2.777778 if prtvtcfr==6  // FDG (assumed PCF) - Front de Gauche
replace eurosk=6.166667 if prtvtcfr==7  // Parti Radical de Gauche - PRG
replace eurosk=1.5 if prtvtcfr==8       // MPF - Mouvement pour la France
replace eurosk=6.125 if prtvtcfr==9     // PS - Parti Socialiste
replace eurosk=6 if prtvtcfr==10        // UMP - Union pour un Mouvement Populaire
replace eurosk=6.666667 if prtvtcfr==11 // MODEM - Mouvement Démocrate
replace eurosk=6.111111 if prtvtcfr==12 // EELV (assumed VERTS) - Europe Ecologie Les Verts

* Great Britain 
fre prtvtgb
replace eurosk=2.266667 if prtvtgb==1  // Conservative
replace eurosk=4.8 if prtvtgb==2       // Labour
replace eurosk=6 if prtvtgb==3         // Liberal Democrat
replace eurosk=5.133333 if prtvtgb==4  // Scottish National Party
replace eurosk=5 if prtvtgb==5         // Plaid Cymru
replace eurosk=4.692307 if prtvtgb==6  // Green Party
* replace eurosk=[score] if prtvtgb==11 // Ulster Unionist Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==12 // Democratic Unionist Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==13 // Sinn Féin (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==14 // Social Democratic and Labour Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==15 // Alliance Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==16 // Progressive Unionist Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==17 // United Kingdom Unionist Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==18 // Women's Coalition (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==19 // United Unionist Assembly Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==20 // Northern Ireland Unionist Party (nir) (Score not provided)
* replace eurosk=[score] if prtvtgb==21 // Workers' Party (nir) (Score not provided)


* Hungary
fre prtvtdhu
replace eurosk=5.352941 if prtvtdhu==3  // Fidesz - KDNP
replace eurosk=2.352941 if prtvtdhu==4  // Jobbik
replace eurosk=6.470588 if prtvtdhu==5  // LMP
replace eurosk=5.928571 if prtvtdhu==6  // MDF
replace eurosk=6.647059 if prtvtdhu==8  // MSZP
replace eurosk=6.6 if prtvtdhu==13      // SZDSZ
* replace eurosk=[score] if prtvtdhu==1  // Centrum Párt (Score not provided)
* replace eurosk=[score] if prtvtdhu==2  // CM (Score not provided)
* replace eurosk=[score] if prtvtdhu==7  // MIÉP (Score not provided)
* replace eurosk=[score] if prtvtdhu==9  // MSZDP (Score not provided)
* replace eurosk=[score] if prtvtdhu==10 // Munkáspárt (Score not provided)
* replace eurosk=[score] if prtvtdhu==11 // MCF Roma Összefogás Párt (Score not provided)
* replace eurosk=[score] if prtvtdhu==12 // ÖP (Score not provided)

* Ireland
fre prtvtaie
replace eurosk=6.375 if prtvtaie==1    // Fianna Fáil
replace eurosk=6.5 if prtvtaie==2      // Fine Gael
replace eurosk=5 if prtvtaie==3        // Green Party
* replace eurosk=[score] if prtvtaie==4 // Independent (Score not provided)
replace eurosk=5.875 if prtvtaie==5    // Labour
replace eurosk=2.25 if prtvtaie==6 // People Before Profit (Score provided in CHES 2014)
replace eurosk=2.625 if prtvtaie==7    // Sinn Féin
replace eurosk=2.428571 if prtvtaie==8 // Socialist Party
* replace eurosk=[score] if prtvtaie==9 // United Left Alliance (Score not provided)

* Italy  -- Da rivedere
fre prtvtbit
replace eurosk=6.555555 if prtvtbit==1    // PD - Partido Democratico
replace eurosk=4.5 if prtvtbit==2    // SEL - Sinistra Ecologia e Libertà 
* replace eurosk=[score] if prtvtbit==3    // Rivoluzione Civile (Ingroia) (Score not provided, assuming RC)
replace eurosk=1.428571 if prtvtbit==4     // Movimento 5 Stelle (Score provided in CHES 2014)
replace eurosk=6.857143 if prtvtbit==5     // Scelta Civica (con Monti) (Score provided in CHES 2014)
replace eurosk=6.333333 if prtvtbit==6    // UDC
replace eurosk=4.666667 if prtvtbit==8    // PdL - Popolo delle Libertà
replace eurosk=2.666667 if prtvtbit==9    // Lega Nord
replace eurosk=2.166667 if prtvtbit==10   // Fratelli d'Italia (Score provided in CHES 2014)
* replace eurosk=[score] if prtvtbit==11   // Radicali Italiani (Score not provided, no match in scores)
* replace eurosk=[score] if prtvtbit==12   // FARE - Giannino (Score not provided, no match in scores)
* replace eurosk=[score] if prtvtbit==13   // La destra (Score not provided, possibly SD or PdCI)

* Lithuania 
fre prtvalt1
replace eurosk=6.384615 if prtvalt1==1    // LRLS - Liberals' Movement of the Republic of Lithuania
* replace eurosk=[score] if prtvalt1==2    // RP - Republican Party (Score not provided)
replace eurosk=5.538462 if prtvalt1==3    // DP - Labour Party
* replace eurosk=[score] if prtvalt1==4    // DDVP - Democratic Labour and Unity Party (Score not provided)
replace eurosk=6.692307 if prtvalt1==5    // TS-LKD - Homeland Union - Lithuanian Christian Democrats
replace eurosk=3.111111 if prtvalt1==6    // DK - Political Party 'The Way of Courage' (Score provided in CHES 2014)
replace eurosk=5.555555 if prtvalt1==7    // LLRA - Electoral Action of Poles in Lithuania
replace eurosk=6.538462 if prtvalt1==8    // LSDP - Lithuanian Social Democratic Party
replace eurosk=4.615385 if prtvalt1==9    // TT - Party Order and Justice
* replace eurosk=[score] if prtvalt1==10   // ULL - National Association 'For Lithuania in Lithuania' (Score not provided)
* replace eurosk=[score] if prtvalt1==11   // KP - Christian Party (Score not provided)
* replace eurosk=[score] if prtvalt1==12   // LVZS - Lithuanian People's Party (Score not provided)
* replace eurosk=[score] if prtvalt1==13   // SLF - Socialist People's Front (Score not provided)
replace eurosk=4.692307 if prtvalt1==14   // LVZS - Lithuanian Peasant and Greens Union (Score provided in CHES 2014)
* replace eurosk=[score] if prtvalt1==15   // JL - Party 'Young Lithuania' (Score not provided)
replace eurosk=6.076923 if prtvalt1==16   // LiCS - Liberal and Centre Union
* replace eurosk=[score] if prtvalt1==17   // EP - Emigrants' Party (Score not provided)
* replace eurosk=[score] if prtvalt1==18   // ST - Political Party 'Union Yes' (Score not provided, assuming NS)

* Netherlands 
fre prtvtenl
replace eurosk=3.928571 if prtvtenl==1    // VVD - People's Party for Freedom and Democracy
replace eurosk=5.285714 if prtvtenl==2    // PvdA - Labour Party
replace eurosk=1.357143 if prtvtenl==3    // PVV - Party for Freedom
replace eurosk=5.285714 if prtvtenl==4    // CDA - Christian Democratic Appeal
replace eurosk=2.428571 if prtvtenl==5    // SP - Socialist Party
replace eurosk=6.642857 if prtvtenl==6    // D66 - Democrats '66
replace eurosk=6.214286 if prtvtenl==7    // GL - Green Left
replace eurosk=3.785714 if prtvtenl==8    // CU - Christian Union
replace eurosk=3 if prtvtenl==9           // SGP - Reformed Political Party
replace eurosk=3.625 if prtvtenl==10      // PvdD - Party for the Animals
* replace eurosk=[score] if prtvtenl==11  // Pirate Party (Score not provided)
replace eurosk=4.8 if prtvtenl==12  // 50Plus (Score provided in CHES 2014)

* Poland 
fre prtvtcpl
* replace eurosk=[score] if prtvtcpl==1  // Nowa Prawica (Score not provided)
replace eurosk=6.6 if prtvtcpl==2       // PO - Platforma Obywatelska
* replace eurosk=[score] if prtvtcpl==3  // Polska Jest Najważniejsza (Score not provided)
* replace eurosk=[score] if prtvtcpl==4  // Polska Partia Pracy – Sierpień '80 (Score not provided, assuming SDPL or S)
replace eurosk=5.133333 if prtvtcpl==5  // PSL - Polskie Stronnictwo Ludowe
replace eurosk=2.933333 if prtvtcpl==6  // PiS - Prawo i Sprawiedliwość
* replace eurosk=[score] if prtvtcpl==7  // Ruch Palikota (Score not provided, possibly SD or S)
replace eurosk=6.6 if prtvtcpl==8       // SLD - Sojusz Lewicy Demokratycznej

* Portugal 
fre prtvtbpt
replace eurosk=3.666667 if prtvtbpt==1  // BE - Bloco de Esquerda
replace eurosk=5.5 if prtvtbpt==2       // CDS-PP - Centro Democrático Social - Partido Popular
replace eurosk=3 if prtvtbpt==3         // CDU - Coligação Democrática Unitária
* replace eurosk=[score] if prtvtbpt==4 // PCTP/MRPP - Partido Comunista dos Trabalhadores Portugueses (Score not provided)
* replace eurosk=[score] if prtvtbpt==5 // PDA - Partido Democrático do Atlântico (Score not provided)
* replace eurosk=[score] if prtvtbpt==6 // PH - Partido Humanista (Score not provided)
* replace eurosk=[score] if prtvtbpt==7 // PND - Nova democracia (Score not provided)
* replace eurosk=[score] if prtvtbpt==8 // PNR - Partido Nacional Renovador (Score not provided)
* replace eurosk=[score] if prtvtbpt==9 // POUS - Partido Operário de Unidade Socialista (Score not provided)
replace eurosk=6.666667 if prtvtbpt==10 // PSD - Partido Social Democrata
replace eurosk=7 if prtvtbpt==11        // PS - Partido Socialista

* Sweden 
fre prtvtbse
replace eurosk=5.733333 if prtvtbse==1  // C - Centern
replace eurosk=6.866667 if prtvtbse==2  // FP - Folkpartiet liberalerna
replace eurosk=5.933333 if prtvtbse==3  // KD - Kristdemokraterna
replace eurosk=3.4 if prtvtbse==4       // MP - Miljöpartiet de gröna
replace eurosk=6.333333 if prtvtbse==5  // M - Moderata samlingspartiet
replace eurosk=6 if prtvtbse==6         // SAP - Socialdemokraterna
replace eurosk=2 if prtvtbse==7         // V - Vänsterpartiet
replace eurosk=3.157895 if prtvtbse==8 // FI - Feministiskt initiativ (Score provided in CHES 2014)
replace eurosk=3.8 if prtvtbse==9       // PIRAT - Piratpartiet
replace eurosk=1.615385 if prtvtbse==10 // SD - Sverigedemokraterna

* Slovenia 
fre prtvtdsi
replace eurosk=4.9 if prtvtdsi==1       // DeSUS - Demokraticna stranka upokojencev Slovenije
replace eurosk=6.545455 if prtvtdsi==2  // LDS - Liberalna demokracija Slovenije
replace eurosk=4.9 if prtvtdsi==3       // NSI - Nova Slovenija – Kršcanski demokrati
replace eurosk=5.818182 if prtvtdsi==4  // SDS - Slovenska demokratska stranka
replace eurosk=4.727273 if prtvtdsi==5  // SLS - Slovenska ljudska stranka (assuming SLS-SMS)
replace eurosk=6.545455 if prtvtdsi==6  // SD - Socialni demokrati
replace eurosk=6.076923 if prtvtdsi==7  // PS - Pozitivna Slovenija (Score not provided)
replace eurosk=6.363636 if prtvtdsi==8  // Zares
* replace eurosk=[score] if prtvtdsi==9  // Piratpartiet (Score not provided)
replace eurosk=3 if prtvtdsi==10        // SNS - Slovenska nacionalna stranka
* replace eurosk=[score] if prtvtdsi==11 // TRS - Stranka za Trajnostni Razvoj Slovenije (Score not provided)

* Slovakia 
fre prtvtcsk
replace eurosk=3 if prtvtcsk==1 // OLaNO - Ordinary People and Independent Personalities (Score provided in 2014)
replace eurosk=5.2 if prtvtcsk==2       // SDKU - Slovak Democratic Christian Union
replace eurosk=5.866667 if prtvtcsk==3  // SMER-Social Democracy
replace eurosk=5.866667 if prtvtcsk==4  // Most-Híd
replace eurosk=4.533333 if prtvtcsk==5  // KDH - Christian Democratic Movement
replace eurosk=4.533333 if prtvtcsk==6  // SaS - Freedom and Solidarity

fre eurosk
histogram eurosk, bin(50) normal

********************************************************************************
***************************Independent Variables********************************
********************************************************************************
* Objective indicators of social disintegration
* 1) Occupational class 
* Daniel Oesch's scheme (2008)
* 5-Class scheme 
iscooesch oeschclass08, isco(isco08) emplrel(emplrel) emplno(emplno) five replace
fre oesch8_oeschclass08

* 2) Level of education
fre edulvlb
gen edu_level=.
replace edu_level=1 if inlist(edulvlb, 0, 113, 129, 212, 213, 221, 222, 223, 229)
replace edu_level=2 if inlist(edulvlb, 311, 312, 313, 321, 322, 323, 412, 413, 421, 422, 423, 510, 520)
replace edu_level=3 if inlist(edulvlb, 610, 620, 710, 720, 800)
replace edu_level=. if inlist(edulvlb, 5555)
tab edulvlb edu_level
lab def edu_level 1 "Lower educated" 2 "Medium educated" 3 "Higher educated"
lab val edu_level edu_level
fre edu_level

* 3) Gender
recode gndr (1= 0 "Male") (2 = 1 "Female"), gen(gender)
fre gender

* 4) Age
fre agea

* 5) Rural/Urban
fre domicil 
recode domicil (1 2 3 = 0 "Urban") (4 5 = 1 "Rural"), gen(rural)
fre rural

* 7) Subjective indicators of Social Integration
* Ensuring direction of variables: higher scores should point towards higher social integration
fre ppltrst pplfair pplhlp dngval accdng plinsoc pplahlp trtrsp flclpla
vreverse dngval, gen(valuable)
drop dngval
vreverse accdng, gen(accomplishment)
drop accdng
vreverse flclpla, gen(close)
drop flclpla

*Checking correlations between items
pwcorr ppltrst pplfair pplhlp valuable accomplishment plinsoc pplahlp trtrsp close 
* Checking consistency of dimensionalities 
factortest ppltrst pplfair pplhlp valuable accomplishment plinsoc sedirlf pplahlp trtrsp close 
* KMO=0.741 , p-value=0.000 --> variables are intercorrelated
* Performing factor analysis - One Factor solution
factor ppltrst pplfair pplhlp valuable accomplishment plinsoc sedirlf pplahlp trtrsp close, pcf factors(1)  
* Performing factor analysis - Three factor solution
factor ppltrst pplfair pplhlp valuable accomplishment plinsoc sedirlf pplahlp trtrsp close, pcf factors(3)  
rotate, promax blanks(.4) 
estat common
predict soc_cont soc_acc loc_int  if e(sample)
sum soc_cont soc_acc loc_int, detail	
histogram soc_cont, bin(20) normal name(soc_cont, replace)
histogram soc_acc, bin(20) normal name(soc_acc, replace)
histogram loc_int, bin(20) normal name(loc_int, replace)

graph combine soc_cont soc_acc loc_int, xsize(35) ysize(30)


* Reliability analysis 
alpha ppltrst pplfair pplhlp, item casewise std gen(social_acceptance) // 0.7868
alpha pplahlp trtrsp close, item casewise std gen(local_integration) // 0.6751
alpha valuable accomplishment plinsoc sedirlf, item casewise std gen(social_contribution) // 0.6940

********************************************************************************

* 3.  SAVE THE PROCESSED DATA INTO DATA/PROCESSED 
*-----------------------------------------------------------------------
save "ANALYSIS_DATA.dta", replace		
*-----------------------------------------------------------------------
