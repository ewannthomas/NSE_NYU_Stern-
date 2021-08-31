*Cleaning L 01  Block 01
*operations on 13/05/2020

use "E:\NSSO 76\Mother\L 01 Block 01.dta"

*dropping variable Blank
drop Blank

*creating common HH Id 
egen HH_ID = concat(FSU Sample Sector NSS_Region District Stratum Sub_stratum Scnd_stg_strtm Sample_HH_no)
*creationg dup tag for HH_ID
duplicates tag HH_ID, gen(dupl_HH_ID)
tab dupl_HH_ID 
*post Dup_tag verification, Dupl_HH_ID was dropped
drop dupl_HH_ID



*Labelling variables of L 01 Block 1
label variable Centr_Round "Centre or Round" 
label variable FSU "FSU"
label variable Round "Round"
label variable Schedule "Schedule"
label variable Sample "Sample"
label variable Sector "Sector"
label variable NSS_Region "NSS Region"
label variable District "District"
label variable Stratum "Stratum"
label variable Sub_stratum "Sub Stratum" 
label variable Sub_Round "Sub Round"
label variable FOD_Sub_Reg "FOD Sub Region"
label variable Scnd_stg_strtm "Second Stage Stratum"
label variable Sample_HH_no "Sample Household Number"
label variable Level "Level"
label variable Filler "Filler"
label variable Sl_No_Informant "Serial Number of Informant"
label variable Response_Code "Response Code"
label variable Survey_Code "Survey Code"
label variable Reason_for_subs "Reason for Substitution"
label variable NSC "NSC"
label variable Multiplier "Multiplier"


*Assigning Value labels for L01 Block 01
label define ResponseCode 1"informant: co-operative and capable" 2"informant: co-operative but not capable" ///
3"informant: busy" 4"informant: reluctant" 9"informant: others" 
label values Response_Code ResponseCode

label define SurveyCode 1"household surveyed: original" 2"household surveyed: substitute" 3"household surveyed: casualty"
label values Survey_Code SurveyCode

label define ReasonForSubstitution 1"informant busy" 2"members away from home" 3"informant non-cooperative" 9"others"
label values Reason_for_subs ReasonForSubstitution


*Adding in the Aspirational Districts









tostring NSS_Region , replace

gen NSS_Region_State= NSS_Region
tostring NSS_Region_State,replace
destring NSS_Region,replace

gen State=substr( NSS_Region_State ,1,1 ) if inrange( NSS_Region ,1,99)

replace State=substr( NSS_Region_State ,1,2 ) if inrange( NSS_Region ,100,362)

egen State_District = concat(State District)

destring State_District, replace 

destring State, replace 

label define State_Districts 3501 "Nicobars" ///		
3502 "North & Middle Andaman" ///		
3503 "South Andaman" ///		
2801 "Srikakulam" ///		
2802 "Vizianagaram" ///		
2803 "Visakhapatnam" ///		
2804 "East Godavari" ///		
2805 "West Godavari" ///		
2806 "Krishna" ///		
2807 "Guntur" ///		
2808 "Prakasam" ///		
2809 "Sri Potti Sriramulu Nellore" ///		
2810 "Y.S.R. (Cuddapah)" ///		
2811 "Kurnool" ///		
2812 "Anantapur" ///		
2813 "Chittoor" ///		
1201 "Tawang" ///		
1202 "West Kameng" ///		
1203 "East Kameng" ///		
1204 "Papum Pare" ///		
1205 "Upper Subansiri" ///		
1206 "West Siang" ///		
1207 "East Siang" ///		
1208 "Upper Siang" ///		
1209 "Changlang" ///		
1210 "Tirap" ///		
1211 "Lower Subansiri" ///		
1212 "Kurung Kumey" ///		
1213 "Dibang Valley" ///		
1214 "Lower Dibang Valley" ///		
1215 "Lohit" ///		
1216 "Anjaw" ///		
1808 "Lakhimpur" ///		
1809 "Dhemaji" ///		
1810 "Tinsukia" ///		
1811 "Dibrugarh" ///		
1812 "Sivasagar" ///		
1813 "Jorhat" ///		
1814 "Golaghat" ///		
1801 "Kokrajhar"  ///	
1802	"Dhubri" ///		
1803	"Goalpara" ///		
1804	"Barpeta" ///		
1820	"Bongaigaon" ///
1821	"Chirang" ///		
1822	"Kamrup" ///		
1823	"Kamrup Metropolitan" ///		
1824	"Nalbari" ///		
1825	"Baksa" ///		
1815	"Karbi Anglong" ///		
1816	"Dima Hasao" ///		
1817	"Cachar" ///		
1818	"Karimganj" ///		
1819	"Hailakandi" ///		
1805	"Morigaon" ///		
1806	"Nagaon" ///		
1807	"Sonitpur" ///		
1826	"Darrang" ///		
1827	"Udalguri" ///		
1001	"Pashchim Champaran" ///		
1002	"Purba Champaran" ///		
1003	"Sheohar" ///		
1004	"Sitamarhi" ///		
1005	"Madhubani" ///		
1006	"Supaul" ///		
1007	"Araria" ///		
1008	"Kishanganj" ///		
1009	"Purnia" ///		
1010	"Katihar" ///		
1011	"Madhepura" ///		
1012	"Saharsa" ///		
1013	"Darbhanga" ///		
1014	"Muzaffarpur" ///		
1015	"Gopalganj" ///		
1016	"Siwan" ///		
1017	"Saran" ///		
1018	"Vaishali" ///		
1019	"Samastipur" ///		
1020	"Begusarai" ///		
1021	"Khagaria" ///		
1022	"Bhagalpur" ///		
1023	"Banka" ///		
1024	"Munger" ///		
1025	"Lakhisarai" ///		
1026	"Sheikhpura" ///		
1027	"Nalanda" ///		
1028	"Patna" ///		
1029	"Bhojpur" ///		
1030	"Buxar" ///		
1031	"Kaimur (Bhabua)" ///		
1032	"Rohtas" ///		
1033	"Aurangabad" ///		
1034	"Gaya" ///		
1035	"Nawada" ///		
1036	"Jamui" ///		
1037	"Jehanabad" ///		
1038	"Arwal" ///		
401	"Chandigarh'" ///		
2201	"Koriya" ///		
2202	"Surguja" ///		
2226	"Surajpur" ///		
2227	"Balrampur" ///		
2203	"Jashpur" ///		
2204	"Raigarh" ///		
2205	"Korba" ///		
2206	"Janjgir-Champa" ///		
2207	"Bilaspur" ///		
2208	"Kabeerdham" ///		
2209	"Rajnandgaon" ///		
2210	"Durg" ///		
2211	"Raipur" ///		
2212	"Mahasamund" ///		
2213	"Dhamtari" ///		
2219	"Balodabazar" ///		
2220	"Gariyaband" ///		
2223	"Bemetara" ///		
2224	"Balod" ///		
2225	"Mungeli" ///		
2214	"Uttar Bastar Kanker" ///		
2215	"Bastar" ///		
2216	"Narayanpur" ///		
2217	"Dakshin Bastar Dantewada" ///		
2218	"Bijapur" ///		
2221	"Kondagaon" ///		
2222	"Sukama" ///		
2601	"Dadra  & Nagar Haveli" ///		
2501	"Diu" ///		
2502	"Daman" ///		
701	"North West Delhi" ///		
702	"North Delhi" ///		
703	"North East Delhi " ///		
704	"East Delhi " ///		
705	"New Delhi" ///		
706	"Central Delhi " ///		
707	"West Delhi" ///		
708	"South West Delhi" ///		
709	"South Delhi" ///		
301	"North Goa" ///		
302	"South Goa" ///		
2417	"Panch Mahals" ///		
2418	"Dohad" ///		
2419	"Vadodara" ///		
2420	"Narmada" ///		
2421	"Bharuch" ///		
2422	"The Dangs" ///		
2423	"Navsari" ///		
2424	"Valsad" ///		
2425	"Surat" ///		
2426	"Tapi" ///		
2404	"Mahesana" ///		
2405	"Sabar Kantha" ///		
2406	"Gandhinagar" ///		
2407	"Ahmadabad" ///		
2415	"Anand" ///		
2416	"Kheda" ///		
2402	"Banas Kantha" ///		
2403	"Patan" ///		
2401	"Kachchh" ///		
2408	"Surendranagar" ///		
2409	"Rajkot" ///		
2410	"Jamnagar" ///		
2411	"Porbandar" ///		
2412	"Junagadh" ///		
2413	"Amreli" ///		
2414	"Bhavnagar" ///		
601	"Panchkula" ///		
602	"Ambala" ///		
603	"Yamunanagar" ///		
604	"Kurukshetra" ///		
605	"Kaithal" ///		
606	"Karnal" ///		
607	"Panipat" ///		
608	"Sonipat" ///		
614	"Rohtak" ///		
615	"Jhajjar" ///		
618	"Gurgaon" ///		
619	"Mewat" ///		
620	"Faridabad" ///		
621	"Palwal" ///		
609	"Jind" ///		
610	"Fatehabad" ///		
611	"Sirsa" ///		
612	"Hisar" ///		
613	"Bhiwani" ///		
616	"Mahendragarh" ///		
617	"Rewari" ///		
202	"Kangra" ///		
204	"Kullu" ///		
205	"Mandi" ///		
206	"Hamirpur" ///		
207	"Una" ///		
201	"Chamba" ///		
203	"Lahul & Spiti" ///		
208	"Bilaspur" ///		
209	"Solan" ///		
210	"Sirmaur" ///		
211	"Shimla" ///		
212	"Kinnaur" ///		
107	"Kathua" ///		
121	"Jammu" ///		
122	"Samba" ///		
105	"Punch" ///		
106	"Rajouri" ///		
116	"Doda" ///		
117	"Ramban" ///		
118	"Kishtwar" ///		
119	"Udhampur" ///		
120	"Reasi" ///		
101	"Kupwara" ///		
102	"Badgam" ///		
108	"Baramula" ///		
109	"Bandipore" ///		
110	"Srinagar" ///		
111	"Ganderbal" ///		
112	"Pulwama" ///		
113	"Shupiyan" ///		
114	"Anantnag" ///		
115	"Kulgam" ///		
103	"Leh" ///		
104	"Kargil" ///		
2001	"Garhwa" ///		
2011	"Lohardaga" ///		
2012	"Purbi Singhbhum" ///		
2013	"Palamu" ///		
2014	"Latehar" ///		
2019	"Ranchi" ///		
2020	"Khunti" ///		
2021	"Gumla" ///		
2022	"Simdega" ///		
2023	"Pashchimi Singhbhum" ///		
2024	"Saraikela-Kharsawan" ///		
2002	"Chatra" ///		
2003	"Kodarma" ///		
2004	"Giridih" ///		
2005	"Deoghar" ///		
2006	"Godda" ///		
2007	"Sahibganj" ///		
2008	"Pakur" ///		
2009	"Dhanbad" ///		
2010	"Bokaro" ///		
2015	"Hazaribagh" ///		
2016	"Ramgarh" ///		
2017	"Dumka" ///		
2018	"Jamtara" ///		
2909	"Uttara Kannada" ///		
2915	"Udupi" ///		
2921	"Dakshina Kannada" ///		
2914	"Shimoga" ///		
2916	"Chikmagalur" ///		
2920	"Hassan" ///		
2921	"Dakshina Kannada" ///	
2922 	"Kodagu" ///
2917	"Tumkur" ///		
2918	"Bangalore" ///		
2919	"Mandya" ///		
2923	"Mysore" ///		
2924	"Chamarajanagar" ///		
2927	"Kolar" ///		
2928	"Chikkaballapura" ///		
2929	"Bangalore Rural" ///		
2930	"Ramanagara" ///		
2901	"Belgaum" ///		
2902	"Bagalkot" ///		
2903	"Bijapur" ///		
2904	"Bidar" ///		
2905	"Raichur" ///		
2906	"Koppal" ///		
2907	"Gadag" ///		
2908	"Dharwad" ///		
2910	"Haveri" ///		
2911	"Bellary" ///		
2912	"Chitradurga" ///		
2913	"Davanagere" ///		
2925	"Gulbarga" ///		
2926	"Yadgir" ///		
3201	"Kasaragod" ///		
3202	"Kannur" ///		
3203	"Wayanad" ///		
3204	"Kozhikode" ///		
3205	"Malappuram" ///		
3206	"Palakkad" ///		
3207	"Thrissur" ///		
3208	"Ernakulam" ///		
3209	"Idukki" ///		
3210	"Kottayam" ///		
3211	"Alappuzha" ///		
3212	"Pathanamthitta" ///		
3213	"Kollam" ///		
3214	"Thiruvananthapuram" ///		
3101	"Lakshadweep" ///		
2307	"Tikamgarh" ///		
2308	"Chhatarpur" ///		
2309	"Panna" ///		
2312	"Satna" ///		
2313	"Rewa" ///		
2314	"Umaria" ///		
2343	"Shahdol" ///		
2344	"Anuppur" ///		
2345	"Sidhi" ///		
2346	"Singrauli" ///		
2310	"Sagar" ///		
2311	"Damoh" ///		
2326	"Vidisha" ///		
2327	"Bhopal" ///		
2328	"Sehore" ///		
2329	"Raisen" ///		
2315	"Neemuch" ///		
2316	"Mandsaur" ///		
2317	"Ratlam" ///		
2318	"Ujjain" ///		
2319	"Shajapur" ///		
2320	"Dewas" ///		
2321	"Dhar" ///		
2322	"Indore" ///		
2325	"Rajgarh" ///		
2347	"Jhabua" ///		
2348	"Alirajpur" ///		
2333	"Katni" ///		
2334	"Jabalpur" ///		
2335	"Narsimhapur" ///		
2336	"Dindori" ///		
2337	"Mandla" ///		
2338	"Chhindwara" ///		
2339	"Seoni" ///		
2340	"Balaghat" ///		
2323	"Khargone (West Nimar)" ///		
2324	"Barwani" ///		
2330	"Betul" ///		
2331	"Harda" ///		
2332	"Hoshangabad" ///		
2349	"Khandwa (East Nimar)" ///		
2350	"Burhanpur" ///		
2301	"Sheopur" ///		
2302	"Morena" ///		
2303	"Bhind" ///		
2304	"Gwalior" ///		
2305	"Datia" ///		
2306	"Shivpuri" ///		
2341	"Guna" ///		
2342	"Ashoknagar" ///		
2721	"Thane" ///		
2722	"Mumbai Suburban" ///		
2723	"Mumbai" ///		
2724	"Raigarh" ///		
2732	"Ratnagiri" ///		
2733	"Sindhudurg" ///		
2725	"Pune" ///		
2726	"Ahmadnagar" ///		
2730	"Solapur" ///		
2731	"Satara" ///		
2734	"Kolhapur" ///		
2735	"Sangli" ///		
2701	"Nandurbar" ///		
2702	"Dhule" ///		
2703	"Jalgaon" ///		
2720	"Nashik" ///		
2715	"Nanded" ///		
2716	"Hingoli" ///		
2717	"Parbhani" ///		
2718	"Jalna" ///		
2719	"Aurangabad" ///		
2727	"Bid" ///		
2728	"Latur" ///		
2729	"Osmanabad" ///		
2704	"Buldana" ///		
2705	"Akola" ///		
2706	"Washim" ///		
2707	"Amravati" ///		
2708	"Wardha" ///		
2709	"Nagpur" ///		
2714	"Yavatmal" ///		
2710	"Bhandara" ///		
2711	"Gondiya" ///		
2712	"Gadchiroli" ///		
2713	"Chandrapur" ///		
1404	"Bishnupur" ///		
1405	"Thoubal" ///		
1406	"Imphal West" ///		
1407	"Imphal East" ///		
1401	"Senapati" ///		
1402	"Tamenglong" ///		
1403	"Churachandpur" ///		
1408	"Ukhrul" ///		
1409	"Chandel" ///		
1701	"West Garo Hills" ///		
1702	"East Garo Hills" ///		
1703	"South Garo Hills" ///		
1704	"West Khasi Hills" ///		
1705	"Ribhoi" ///		
1706	"East Khasi Hills" ///		
1707	"Jaintia Hills" ///		
1501	"Mamit" ///		
1502	"Kolasib" ///		
1503	"Aizwal" ///		
1504	"Champhai" ///		
1505	"Serchhip" ///		
1506	"Lunglei" ///		
1507	"Lawngtlai" ///		
1508	"Saiha" ///		
1301	"Mon" ///		
1302	"Mokokchung" ///		
1303	"Zunheboto" ///		
1304	"Wokha" ///		
1305	"Dimapur" ///		
1306	"Phek" ///		
1307	"Tuensang" ///		
1308	"Longleng" ///		
1309	"Kiphire" ///		
1310	"Kohima" ///		
1311	"Peren" ///		
2108	"Baleshwar" ///		
2109	"Bhadrak" ///		
2110	"Kendrapara" ///		
2111	"Jagatsinghapur" ///		
2112	"Cuttack" ///		
2113	"Jajapur" ///		
2116	"Nayagarh" ///		
2117	"Khordha" ///		
2118	"Puri" ///		
2119	"Ganjam" ///		
2120	"Gajapati" ///		
2121	"Kandhamal" ///		
2122	"Baudh" ///		
2123	"Subarnapur" ///		
2124	"Balangir" ///		
2125	"Nuapada" ///		
2126	"Kalahandi" ///		
2127	"Rayagada" ///		
2128	"Nabarangapur" ///		
2129	"Koraput" ///		
2130	"Malkangiri" ///		
2101	"Bargarh" ///		
2102	"Jharsuguda" ///		
2103	"Sambalpur" ///		
2104	"Debagarh" ///		
2105	"Sundargarh" ///		
2106	"Kendujhar" ///		
2107	"Mayurbhanj" ///		
2114	"Dhenkanal" ///		
2115	"Anugul" ///		
3401	"Yanam" ///		
3402	"Puducherry" ///		
3403	"Mahe" ///		
3404	"Karaikal" ///		
301	"Gurdaspur" ///		
302	"Kapurthala" ///		
303	"Jalandhar" ///		
304	"Hoshiarpur" ///		
305	"Shahid Bhagat Singh Nagar" ///		
315	"Amritsar" ///		
316	"Tarn Taran" ///		
317	"Rupnagar" ///		
318	"Sahibzada Ajit Singh Nagar" ///		
321	"Pathankot" ///		
306	"Fatehgarh Sahib" ///		
307	"Ludhiana" ///		
308	"Moga" ///		
309	"Firozpur" ///		
310	"Muktsar" ///		
311	"Faridkot" ///		
312	"Bhatinda" ///		
313	"Mansa" ///		
314	"Patiala" ///		
319	"Sangrur" ///		
320	"Barnala" ///		
322	"Fazilka" ///		
803	"Bikaner" ///		
815	"Jodhpur" ///		
816	"Jaisalmer" ///		
817	"Barmer" ///		
818	"Jalor" ///		
819	"Sirohi" ///		
820	"Pali" ///		
806	"Alwar" ///		
807	"Bharatpur" ///		
808	"Dhaulpur" ///		
809	"Karauli" ///		
810	"Sawai Madhopur" ///		
811	"Dausa" ///		
812	"Jaipur" ///		
821	"Ajmer" ///		
822	"Tonk" ///		
824	"Bhilwara" ///		
825	"Rajsamand" ///		
826	"Dungarpur" ///		
827	"Banswara" ///		
832	"Udaipur" ///		
823	"Bundi" ///		
828	"Chittaurgarh" ///		
829	"Kota" ///		
830	"Baran" ///		
831	"Jhalawar" ///		
833	"Pratapgarh" ///		
801	"Sri Ganganagar" ///		
802	"Hanumangarh" ///		
804	"Churu" ///		
805	"Jhunjhunun" ///		
813	"Sikar" ///		
814	"Nagaur" ///		
1101	"North District Sikkim" ///		
1102	"West District Sikkim" ///		
1103	"South District Sikkim" ///		
1104	"East District Sikkim" ///		
3301	"Thiruvallur" ///		
3302	"Chennai" ///		
3303	"Kancheepuram" ///		
3304	"Vellore" ///		
3305	"Tiruvannamalai" ///		
3306	"Viluppuram" ///		
3316	"Cuddalore" ///		
3612	"Karur" ///		
3613	"Tiruchirappalli" ///		
3614	"Perambalur" ///		
3615	"Ariyalur" ///		
3617	"Nagapattinam" ///		
3618	"Thiruvarur" ///		
3619	"Thanjavur" ///		
3620	"Pudukkottai" ///		
3611	"Dindigul" ///		
3321	"Sivaganga" ///		
3322	"Madurai" ///		
3323	"Theni" ///		
3324	"Virudhunagar" ///		
3325	"Ramanathapuram" ///		
3326	"Thoothukkudi" ///		
3327	"Tirunelveli" ///		
3328	"Kanniyakumari" ///		
3307	"Salem" ///		
3308	"Namakkal" ///		
3309	"Erode" ///		
3310	"The Nilgiris" ///		
3329	"Dharmapuri" ///		
3330	"Krishnagiri" ///		
3331	"Coimbatore " ///		
3332	"Tiruppur" ///		
3312    "Karur" ///
3313   "Tiruchirappalli" ///
3314   "Perambalur" ///
3315   "Ariyalur" ///
3317   "Nagapattinam" ///
3318   "Thiruvarur" ///
3319   "Thanjavur" ///
3320   "Pudukkottai" ///
3601	"Adilabad" ///		
3602	"Komaram Bheem " ///		
3603	"Mancherial" ///		
3604	"Nirmal" ///		
3605	"Nizamabad " ///		
3615	"Kamareddy" ///		
3616	"Sangareddy" ///		
3617	"Medak" ///		
3618	"Siddhipet" ///		
3621	"Medchal-Malkajgiri" ///		
3622	"Hyderabad" ///		
3623	"Rangareddy" ///		
3624	"Vikarabad" ///		
3625	"Mahbubnagar" ///		
3626	"Jogulamba" ///		
3627	"Wanaparthy" ///		
3628	"Nagarkurnool" ///		
3606	"Jagtial" ///		
3607	"Peddappali" ///		
3608	"Jayashankkar" ///		
3609	"Bhadradri" ///		
3610	"Mahbubabad" ///		
3611	"Warangal Rural" ///		
3612	"Warangal Urban" ///		
3613	"Karimnagar" ///		
3614	"Rajanna" ///		
3619	"Jangaon" ///		
3620	"Yadadri" ///		
3629	"Nalgonda" ///		
3630	"Suryapet" ///		
3631	"Khammam" ///		
1601	"West Tripura" ///		
1602	"South Tripura" ///		
1603	"Dhalai" ///		
1604	"North Tripura" ///		
501	"Uttar Kashi" ///		
502	"Chamoli" ///		
503	"Rudraprayag" ///		
504	"Tehri Garhwal" ///		
505	"Dehardun" ///		
506	"Garhwal" ///		
507	"Pithorgarh" ///		
508	"Bageshwar" ///		
509	"Almora" ///		
510	"Champawat" ///		
511	"Nainital" ///		
512	"Udham Singh Nagar" ///		
513	"Haridwar" ///		
901	"Sahranpur" ///		
902	"Muzzafarnagar" ///		
903	"Bijnor" ///		
904	"Moradabad" ///		
905	"Rampur" ///		
906	"Jyotiba Phule Nagar " ///		
907	"Meerut" ///		
908	"Baghpat" ///		
909	"Ghaziabad" ///		
910	"Gautam Buddha Nagar" ///		
923	"Sitapur" ///		
924	"Hardoi" ///		
925	"Unnao" ///		
926	"Lucknow" ///		
927	"Rae Bareli" ///		
932	"Kanpur Dehat" ///		
933	"Kanpur Nagar" ///		
941	"Fatepur" ///		
945	"Bara Banki" ///		
942	"Pratapgarh" ///		
943	"Kaushambi" ///		
944	"Allahabad" ///		
946	"Faizabad" ///		
947	"Ambedkar Nagar" ///		
948	"Sultanpur" ///		
949	"Bahraich" ///		
950	"Shrawasti" ///		
951	"Balrampur " ///		
952	"Gonda" ///		
953	"Siddharthnagar" ///		
954	"Basti" ///		
955	"Sant Kabir Nagar" ///		
956	"Maharajganj" ///		
957	"Gorakhpur" ///		
958	"Kushinagar" ///		
959	"Deoria" ///		
960	"Azamgarh" ///		
961	"Mau" ///		
962	"Ballia" ///		
963	"Jaunpur " ///		
964	"Ghazipur" ///		
965	"Chandrauli" ///		
966	"Varanasi" ///		
967	"Sant Ravidas Nagar(Bhadohi)" ///		
968	"Mirzapur " ///		
969	"Sonbhadra" ///		
934	"Jalaun" ///		
935	"Jhansi" ///		
936	"Lalitpur" ///		
937	"Hamirpur" ///		
938	"Mahoba" ///		
939	"Banda" ///		
940	"Chitrakoot " ///		
911	"Bulandashr " ///		
912	"Aligarh " ///		
913	"Mahamaya Nagar " ///		
914	"Mathura " ///		
915	"Agra " ///		
916	"Firozabad" ///		
917	"Mainpuri" ///		
918	"Buduan" ///		
919	"Bareilly" ///		
920	"Philbit " ///		
921	"Shajahanpur" ///		
922	"Kheri" ///		
928	"Farukkabad" ///		
929	"Kannauj " ///		
930	"Etawah " ///		
931	"Auraiya" ///		
970	"Etah " ///		
971	"Kanshiram Nagar " ///		
1901	"Darjeeling " ///		
1902	"Jalpaiguri " ///		
1903	"Koch Bihar " ///		
1904	"Uttar Dinajpur " ///		
1905	"Dakshin Dinajpur " ///		
1906	"Maldah " ///		
1907	"Murshidabad" ///		
1908	"Bhirbum" ///		
1910	"Nadia" ///		
1911	"North Twenty Four Paraganas" ///		
1916	"Kolkata" ///		
1917	"South Twenty Four Paraganas" ///		
1909	"Bardhamman " ///		
1912	"Hugli" ///		
1915	"Haora" ///		
1913	"Bankura " ///		
1914	"Puruliya" ///		
1918	"Pashchim Medinipur" ///		
1919	"Purba Medinipur "	///
3001    "North Goa" ///
3002    "South Goa"


label define NSS_Region 351	"Andaman & Nicobar Islands" ///
281	"Coastal Northern Andhra Pradesh" ///
282	"Coastal Southern Andhra Pradesh" ///
283	"Inland Southern Andhra Pradesh" ///
121	"Arunachal Pradesh" ///
181	"Plains Eastern Assam" ///
182	"Plains Western Assam " ///
183	"Cachar Plain" ///
184	"Central Brahamputra Plains" ///
101	"Northern Bihar" ///
102	"Central Bihar" ///
41	"Chandigarh" ///
221	"Northern Chhattisgarh" ///
222	"Mahanadi Basin" ///
223	"Southern Chhattisgarh" ///
261	"Dadra & Nagar Haveli" ///
251	"Daman & Diu" ///
71	"Delhi" ///
301	"Goa" ///
241	"South Eastern (Gujarat)" ///
242	"Plains Northern (Gujarat)" ///
243	"Dry areas (Gujarat)" ///
244	"Kachchh (Gujarat)" ///
245	"Saurashtra (Gujarat)" ///
061	"Eastern Haryana" ///
062	"Western Haryana" ///
021	"Central HP" ///
022	"Trans Himalayan & Southern HP" ///
011	"Mountainous ( J&K)" ///
012	"Outer Hills (J&K)" ///
013	"Jhelam Valley (J&K)" ///
014	"Ladakh (J&K) " ///
201	"Ranchi Plateau" ///
202	"Hazaribagh Plateau" ///
291	"Coastal & Ghats Karnataka" ///
292	"Inland Eastern Karnataka" ///
293	"Inland Southern Karnataka" ///
294	"Inland Northern Karnataka " ///
321	"Northern Kerala" ///
322	"Southern Kerala" ///
311	"Lakshadweep" ///
231	"Vindhya (MP)" ///
232	"Central  (MP)" ///
233	"Malwa  (MP)" ///
234	"South  (MP)" ///
235	"South Western  (MP)" ///
236	"Northern  (MP)" ///
271	"Coastal Maharashtra" ///
272	"Inland Western Maharashtra" ///
273	"Inland Northern Maharashtra" ///
274	"Inland Central Maharashtra" ///
275	"Inland Eastern Maharashtra" ///
276	"Eastern Maharashtra" ///
141	"Plains Manipur" ///
142	"Hills Manipur" ///
171	"Meghalaya" ///
151	"Mizoram" ///
131	"Nagaland" ///
211	"Coastal Odisha" ///
212	"Southern Odisha" ///
213	"Northern Odisha" ///
341	"Puducherry" ///
31	"Northern Punjab" ///
32	"Southern Punjab" ///
81	"Western Rajasthan" ///
82	"North-Eastern Rajasthan" ///
083	"Southern Rajasthan" ///
084	"South-Eastern Rajasthan" ///
085	"Northern Rajasthan" ///
111	"Sikkim" ///
331	"Coastal Northern Tamil Nadu" ///
332	"Coastal Tamil Nadu" ///
333	"Southern Tamil Nadu" ///
334	"Inland Tamil Nadu" ///
361	"Inland North Western Telangana" ///
362	"Inland North Eastern Telangana" ///
161	"Tripura" ///
051	"Uttarakhand" ///
091	"Northern Upper Ganga Plains (UP)" ///
092	"Central (UP)" ///
093	"Eastern (UP)" ///
094	"Southern (UP)" ///
095	"Southern Upper Ganga Plains (UP)" ///
191	"Himalayan (WB)" ///
192	"Eastern Plains (WB)" ///
193	"Southern Plains (WB)" ///
194	"Central Plains (WB)" ///
195	"Western Plains (WB)"

	
label define State 35 "Andaman & Nicobar Islands" 28 "Andhra Pradesh" ///
12 "Arunachal Pradesh" 18 "Assam" 10 "Bihar" 4 "Chandigarh" 22 "Chhattisgarh" ///
26 "Dadra & Nagar Haveli" 25 "Daman & Diu " 7 "Delhi" 30 "Goa" 24 "Gujarat" 6 "Haryana" ///
2 "Himachal Pradesh" 1 "Jammu & Kashmir " 20 "Jharkhand" 29 "Karnataka" 32 "Kerala" 31 "Lakshadweep" ///
23 "Madhya Pradesh" 27 "Maharashtra" 14 "Manipur" 17 "Meghalaya" 15 "Mizoram" 13 "Nagaland" 21 "Odisha" 34 "Puducherry" ///
3 "Punjab" 8 "Rajasthan" 11 "Sikkim" 33 "Tamil Nadu" 36 "Telangana" 16 "Tripura" 5 "Uttarakhand" 35 "Andaman & Nicobar Islands" 36 "Telengana" ///
9 "Uttar Pradesh" 19 "West Bengal" 

label value State_District State_Districts
label value NSS_Region NSS_Region 
label value State State 

gen Aspirational_Districts=1 if inlist(State_District, 2802,2803, 2810,1215,1803,1804,1825,1819,1826,1827, ///
1004,1007,1009,1010,1014,1020,1021,1023,1026,1033,1034,1035,1036,2205,2209,2212,2214,2215,2216,2217,2218,2221,2222, ///
2418, 2420,619,201,101,108,2001,2011,2012,2013,2014,2019,2020,2021,2022,2023,2002,2004,2006,2007,2008,2010,2015,2016,2017, ///
2905,2907,2925,2926,2903, 2308,2346,2311,2326,2325,2324,2349,2341,2701,2703,2715,2729,2706,2712,1409,1705,1501,1309,2120,2121,2124,2125,2126, ///
2127,2128,2129,2130,2114,308,309,816,817,819,808,809,830,1102,1104,3324,3325,3601,3602,3608,3611,3631,1603,512,513,941,949,950,951,953,965,969, ///
940,1905,1908,1910)

replace Aspirational_Districts=0 if Aspirational_Districts==.
label define  Aspirational_Districts 1 " Aspirational_Districts" 0 "Other Districts"
label value  Aspirational_Districts  Aspirational_Districts

save "E:\NSSO 76\L 01 Block 01.dta", replace

