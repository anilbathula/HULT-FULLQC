public with sharing class Lead_scoring_rules 
{
     /*--------------------- leadScore_QS_MBA (JIRA NO:682)------------------------------*/
    /*This method works for four parameters Gmail,Typefull,candidatecountry and years of experience)*/
    public static decimal QS_MBA_model(String gmail,String typeful,string ccountry,String yrofexp)
    {
     
        decimal experlev;   
        decimal countryval;
            
        //*****Country Variant Map****
        Map<String,Integer> ccat=new Map<String,Integer>{'india'=>1,'united states'=>2,'usa - northeast'=>2,'usa - west'=>2,
                                                          'usa - mid-atlantic'=>2,'usa - midwest'=>2,'usa - south'=>2,
                                                          'usa - southwest'=>2,'united arab emirat'=>3,'china'=>4,
                                                          'canada'=>5,'united kingdom'=>6,'germany'=>7,'france'=>8,'russia'=>9,
                                                          ''=> 10,'kenya'=>11,'nigeria'=>12};
                                                              
        Map<Integer,Decimal>ccatval=new Map<Integer,Decimal>{0=>0.012114814256271,1=>0.00907983612003101,2 => 0.00801710315339391,
                                                        3 => 0.00990731863215085,4 => 0.00598404255319149, 5 => 0.00729394602479942,
                                                        6 => 0.0141670737664875, 7 => 0.0157600406710727, 8 => 0.0220905172413793,
                                                        9 => 0.0134078212290503, 10 => 0.0134847409510291, 11 => 0.0032599837000815,
                                                        12 => 0.0129421915444349};
            
        //*****Years of Experience Map****
        Map<String,Integer> Exprs=new Map<String,Integer>{'less than a year'=>1,'1 - 3 years'=>2,'1 to 3 years'=>2,'3-4 years'=>3,
                                                            '4 - 5 years'=>4,'6 - 10 years'=>5,'11 - 14 years'=>6,'11 to 14 years'=>6,
                                                            'more than 15 years'=>7};
             
              
        Map<Integer,Decimal>clev=new Map<Integer,Decimal>{0=>0.0105379922351636,1=>0.00667396061269146,2 => 0.0101704879482657,
                                                              3 => 0.015,4 => 0.0102937010104826, 5 => 0.0140207262910389,
                                                              6 => 0.0177111716621253, 7 => 0.00686106346483705}; 
                                                                
        //*****This is return value for gmail****  
        Integer isnotgmail=1;
        if((gmail!=null||gmail!='')&&(gmail.trim()!=null||gmail.trim()!='')&&gmail.endswith('@gmail.com')){
            isnotgmail=0;
            system.debug('==g=>'+isnotgmail);
        }
            
        //*****This is return value for Type full**** 
        Integer isnotfulltime=1;
        if(typeful!=NULL||typeful!='' && typeful=='Full-time'||typeful=='Full-Time'){
            isnotfulltime=0;
            system.debug('==f=>'+isnotfulltime);
        }
             
        //*****This is return value for candidate country****     
        String ctryname=(ccountry==null||ccountry=='')?'':ccountry.toLowerCase();     
        countryval=ccatval.get(ccat.containsKey(ctryname)?ccat.get(ctryname):0);
        system.debug('--->'+countryval);
               
              
        //*****This is return value for Years of experience****
        String yr=(yrofexp==null||yrofexp=='')?yrofexp:yrofexp.toLowerCase();     
        experlev=clev.get(exprs.ContainsKey(yr)?exprs.get(yr):0);
            
        //***** This is to calculate Sub total****       
        decimal total=(-0.7816*isnotfulltime)
                        +(-0.2395*isnotgmail) 
                        +(90.06*countryval) 
                        +(102.3*experlev)-6.029;
              
        //***** This is to calculate total****                    
        Decimal probx=(1/(1+Math.exp(-total)));
        System.debug('=====***>'+probx);          
        return probx; 
                
    }
    
    /*--------------------- QS MA MODEL (JIRA NO:692)------------------------------*/
    public static Decimal QS_MA_model(string pgmstart,string subject,string nationality,string study_mode,string studylevel,string region1,string region2,string region3,string region4,string region5,string greregion)
    {
        Map<String,Integer> Pgm_start_map=new Map<String,Integer>{'within 6 months'=>1,'6 months to one year'=>2,'more than one year'=>3,
                                                              'under 6 months'=>1,'within 1 year'=>2,'within 2 years'=>3};
        integer subjcat = 0;
        Map<String,Integer> Subject_Area_map=new Map<String,Integer>{'business/management'=>1,'computing/information technology'=>2,
                                                                 'finance/accounting'=>3,'law/legal studies'=>4,
                                                                 'economics'=>5,'electronic/electrical engineering'=>6,
                                                                 'marketing'=>7,''=>8};
                                                                 
        Map<Integer,Decimal> Subject_Area_actual_map=new Map<Integer,Decimal>{0=>0.00242956086593901,1=>0.00914694770332074,2=>0.000386100386100386,
                                                                    3=>0.00498960498960499,4=>0.000562113546936481,
                                                                    5=>0.00256904303147078,6=>0.000711237553342817,
                                                                    7=>0.00369549150036955,8=>0.00300036927621861};                                                           
        Integer nationcat =0; 
        Map<String,Integer> nationality_map=new Map<String,Integer>{'india'=>1,'colombia'=>2,'greece'=>3,'peru'=>4,'russia'=>5,
                                                                'ecuador'=>6,'italy'=>7,'united kingdom'=>8,'unspecified'=>9};
        
        Map<Integer,Decimal> nationality_actual_map=new Map<Integer,Decimal>{0=>0.00458288311785089,1=>0.00208539128525958,2=>0.00172711571675302,
                                                                    3=>0.00095625149414296,4=>0.00197795987567109,
                                                                    5=>0.00458565345561743,6=>0.000333444481493831,
                                                                    7=>0.00535654502845665,8=>0.00191717791411043,9=>0.000323310701584222};
        
        Map<String,Integer> mode_of_Study_map=new Map<String,Integer>{'ft'=>1,'pt'=>2,'dl'=>3};
        
        Map<String,Integer> level_of_Study_map=new Map<String,Integer>{'masters'=>1,'doctoral'=>2,'diploma'=>3,'phd'=>2,''=>4};
        
        Map<String,Integer> regioncode_map=new Map<String,Integer>{'asia'=>1,'australia and new ze'=>1,'australia and new zeland'=>1,'europe'=>2,'latin america'=>3,
                                                                'middle east and africa'=>2,'north america'=>4,'us and canada'=>4};
        
        Map<String,Integer> grecode_map=new Map<String,Integer>{'asia'=>1,'australia & oceania'=>1,'africa'=>2,'europe'=>2,'central america'=>3,
                                                                'south america'=>3,'canada'=>4,'united states of america'=>4,'usa'=>4};
        //*****Start_program section****
        string pgmval=(pgmstart==null||pgmstart=='')?'':(pgmstart.trim()==null?null:pgmstart.trim().toLowerCase());
        integer pgm_startval=Pgm_start_map.containskey(pgmval)?Pgm_start_map.get(pgmval):0;
        
        integer pgm_startval0=pgm_startval==0?1:0;
        integer pgm_startval1=pgm_startval==1?1:0;
        integer pgm_startval2=pgm_startval==2?1:0;
        
        //*****Subject Area section****
        string sub=(subject==null||subject=='')?'':(subject.trim()==null?null:subject.trim().toLowerCase());
        subjcat=Subject_Area_map.ContainsKey(sub)?Subject_Area_map.get(sub):0; 
        Decimal subject_val=Subject_Area_actual_map.get(subjcat);
        
        //*****Nationality Area section****
        string nat=(nationality==null||nationality=='')?'Unspecified':(nationality.trim()==null?'Unspecified':subject.trim().toLowerCase());
        nationcat=nationality_map.ContainsKey(nat)?nationality_map.get(nat):0; 
        Decimal nationality_val=nationality_actual_map.get(nationcat);
        
        //*****Study Mode section****
        string smode=(study_mode==null||study_mode=='')?'':(study_mode.trim()==null?null:study_mode.trim().toLowerCase());
        integer study_mode_val=mode_of_Study_map.containskey(smode)?mode_of_Study_map.get(smode):0;
        
        integer study_mode_val0=study_mode_val==0?1:0;
        integer study_mode_val1=study_mode_val==1?1:0;
        integer study_mode_val2=study_mode_val==2?1:0;
        
        //*****Study Level section****
        string study=(studylevel==null||studylevel=='')?'':(studylevel.trim()==null?null:studylevel.trim().toLowerCase());
        integer studylevelval=level_of_Study_map.containskey(study)?level_of_Study_map.get(study):0;
        
        integer studylevelval0=studylevelval==0?1:0;
        integer studylevelval1=studylevelval==1?1:0;
        integer studylevelval2=studylevelval==2?1:0;
        integer studylevelval3=studylevelval==3?1:0;
        
        //*****Region section****
        string reg1=(region1==null||region1=='')?'':(region1.trim()==null?null:region1.trim().toLowerCase());
        string reg2=(region2==null||region2=='')?'':(region2.trim()==null?null:region2.trim().toLowerCase());
        string reg3=(region3==null||region3=='')?'':(region3.trim()==null?null:region3.trim().toLowerCase());
        string reg4=(region4==null||region4=='')?'':(region4.trim()==null?null:region4.trim().toLowerCase());
        string reg5=(region5==null||region5=='')?'':(region5.trim()==null?null:region5.trim().toLowerCase());
        
        integer regioncode1=regioncode_map.containskey(reg1)?regioncode_map.get(reg1):5;
        integer regioncode2=regioncode_map.containskey(reg2)?regioncode_map.get(reg2):5;
        integer regioncode3=regioncode_map.containskey(reg3)?regioncode_map.get(reg3):5;
        integer regioncode4=regioncode_map.containskey(reg4)?regioncode_map.get(reg4):5;
        integer regioncode5=regioncode_map.containskey(reg5)?regioncode_map.get(reg5):5; 
        
        
        integer region5exist=(regioncode5 >0 && regioncode5 < 5)?1:0;
        integer region4exist=(regioncode4 >0 && regioncode5 < 4)?1:0;
        integer region3exist=(regioncode3 >0 && regioncode5 < 3)?1:0;
        integer region2exist=(regioncode2 >0 && regioncode5 < 2)?1:0;
        integer region1exist=(regioncode1 >0 && regioncode5 < 1)?1:0;
        
        integer regionsum =region1exist + region2exist + region3exist + region4exist + region5exist;
        
        string grereg=( greregion ==null || greregion =='')?'':(greregion.trim()==null?null:greregion.trim().toLowerCase()) ;
        integer grecode=grecode_map.containskey(grereg)?grecode_map.get(grereg):5;
        
        integer regmatch1 =(regioncode1 == grecode)?1:0;
        integer regmatch2 =(regioncode2 == grecode)?1:0;
        integer regmatch3 =(regioncode3 == grecode)?1:0;
        integer regmatch4 =(regioncode4 == grecode)?1:0;
        integer regmatch5 =(regioncode5 == grecode)?1:0;
        
        integer regmatchsum =regmatch1 + regmatch2 + regmatch3 + regmatch4 + regmatch5; 
        
        decimal regmatchproport =99;
        try
        {
            regmatchproport =regmatchsum/regionsum;
        }
        catch(Exception e)
        {
            system.debug(e);
            regmatchproport =99;
        }
        
        /*
        recode regmatchproport
         (sysmis = 99).
        execute.        
        */
        
        integer regproportcat = (regmatchproport == 99)?1:(regmatchproport == 1?2:(regmatchproport == 0?3:((regmatchproport > 0 && regmatchproport < 1)?4:0)));
                
        integer grecode1  =grecode==1?1:0;
        integer grecode2  =grecode==2?1:0;
        integer grecode3  =grecode==3?1:0;
        integer grecode4  =grecode==4?1:0;
        
        integer regproportcat1 =regproportcat ==1?1:0;
        integer regproportcat2 =regproportcat ==2?1:0;
        integer regproportcat3 =regproportcat ==3?1:0;
                
        Decimal total =   (0.7194*pgm_startval0) +(1.135*pgm_startval1) +(0.8611*pgm_startval2) +
                            (270.7*nationality_val) +(203.9*subject_val) +
                            (18.34*study_mode_val0) +(18.02*study_mode_val1) +(17.36*study_mode_val2) +
                            (0.4861*studylevelval0) +(1.644*studylevelval1) +(0.513*studylevelval2) +(0.3664*studylevelval3) +
                            (0.7978*grecode1) +(1.265* grecode2) +(0.153*grecode3) +(0.4764*grecode4) +
                            (-0.3774*regproportcat1) +(-1.222*regproportcat2) +(-0.4812*regproportcat3) + -27.62;
    
        Decimal probx=(1/(1+Math.exp(-total)));
        
        System.debug('===================***regionsum->'+regionsum);
        System.debug('=====================***regmatchsum->'+regmatchsum);
        System.debug('======================***regmatchproport->'+regmatchproport);
        System.debug('======================***total ->'+total);
        System.debug('======================***probx->'+probx);
        
        return probx;
    }
  
   /*--------------------- leadSource_AccessModel (JIRA NO:693)------------------------------*/  
    public static Decimal Access_Model(String gmail,String nationality,string ccountry,String industry,string english_skills){
                 
         Map<String,Integer> nationality_map=new Map<String,Integer>{'india'=>1,'egypt'=>2,'france'=>3,'lebanon'=>4,'romania'=>5,'mexico'=>6,    
                                                                    'russian federation'=>7,'bulgaria'=>8,''=>9};
                                                                    
         Map<Integer,Decimal> nationalitycat_map=new Map<Integer,Decimal>{0=>0.0118639455782313,1=>0.00602605863192182,2 => 0.00748959778085992,3 => 0.0156090939938921,
                                                                  4 => 0.0127528583992964, 5 => 0.00315599639314698,6 => 0.0205278592375367, 
                                                                  7 => 0.0123192287091591, 8 => 0.0138026224982747,9 => 0.00346620450606586};
                                                                  
         Map<String,Integer> country_map=new Map<String,Integer>{'india'=>1,'france'=>2,'russian federation'=>3,'egypt'=>4,'lebanon'=>5,'united arab emirat'=>6,
                                                                'romania'=>7,'mexico'=>8};
                                                                    
         Map<Integer,Decimal> countrycat_map=new Map<Integer,Decimal>{0=>0.0107266799873804,1=>0.0037328909166321,2 => 0.015984015984016,3 => 0.0114632501685772,
                                                                  4 => 0.00750938673341677, 5 => 0.01569995638901,6 => 0.0143240823634736, 
                                                                  7 => 0.00224820143884892, 8 => 0.0198393953708077};
                                                                  
         Map<String,Integer> industry_map=new Map<String,Integer>{'none'=>1,'accounting  /  banking  /  finance'=>2,'communication  /  information technology'=>3,
                                                                 'engineering'=>4,'consulting'=>5,'sales  /  retail'=>6,'marketing'=>7};
                                                                    
         Map<Integer,Decimal> industrycat_map=new Map<Integer,Decimal>{0=>0.0105949470252649,1=>0.00805035128805621,2 => 0.0155086848635236,3 => 0.0124719381391868,
                                                                  4 => 0.00851840584119258, 5 => 0.012589928057554,6 => 0.0103420843277645,7 => 0.0073469387755102};
                                                                                                                                                                                                                                                    
         Map<String,Integer> englishskills_map=new Map<String,Integer>{'average'=>1,'beginer'=>2,'fluent'=>3,'native'=>4};
                                                                 
        
         //*****This is return value for gmail****   
         Integer isnotgmail=1;
         if(gmail.trim()!=null&&gmail.trim()!='' && gmail.trim()!=null && gmail.trim()!='' &&  gmail.trim().toLowerCase().endswith('@gmail.com')){
            isnotgmail=0;
         }  
         
         //*****nationality****
         string natval=(nationality==null || nationality=='')?'':((nationality.trim()==''||nationality.trim()==null)?'':nationality.trim().toLowerCase());
         Integer natcat=nationality_map.containskey(natval)?nationality_map.get(natval):0;
         decimal natlev=nationalitycat_map.get(natcat);
         
         //*****country****
         string ctryval=(ccountry==null || ccountry=='')?'':((ccountry.trim()==''||ccountry.trim()==null)?'':ccountry.trim().toLowerCase());
         Integer ctrycat=country_map.containskey(ctryval)?country_map.get(ctryval):0;
         decimal countrylev =countrycat_map.get(ctrycat);
         
         //*****Industry****
         string indval=(industry==null || industry=='')?'':((industry.trim()==''||industry.trim()==null)?'':industry.trim().toLowerCase());
         Integer indcat=industry_map.containskey(indval)?industry_map.get(indval):0;
         decimal indlev =industrycat_map.get(indcat);
         
         //*****English skills****
         string engval=(english_skills==null || english_skills=='')?'':((english_skills.trim()==''||english_skills.trim()==null)?'':english_skills.trim().toLowerCase());
         Integer engcat=englishskills_map.containskey(engval)?englishskills_map.get(engval):3;
         Integer engcat1=engcat==1?1:0;
         Integer engcat2=engcat==2?1:0;
         Integer engcat3=engcat==3?1:0;
         
         decimal total=  (65.58*natlev)
                          + (50.11*countrylev)
                          +(78.17*indlev)
                          +(-0.998*engcat1) 
                          +(-1.695*engcat2)
                          +(0.03788*engcat3) 
                          +(-0.3403*isnotgmail) - 6.386;
                          
         decimal probx=(1/(1+Math.exp(-total)));
         
         System.debug('===================***natlev->'+natlev);
         System.debug('=====================***countrylev->'+countrylev);
         System.debug('======================***indlev->'+indlev);
         System.debug('======================***total ->'+total);
         System.debug('======================***probx->'+probx);
         
         return probx;
    }
    
    /*--------------------- Leadsource QS SAT Model(JIRA NO:694)------------------------------*/
    
    public static Decimal QS_SAT_model(String Countries,String Yahoo,String age,String Region,Integer Major1,Integer Major2,Integer Major3,Integer Major4,Integer Major5){
    
        Decimal countryval;
        Integer agecat;
        Decimal regionval;
        Integer bizmajcat0=0;
        Integer bizmajcat1=0;
        Integer agecat1 = 0;
        Integer agecat2 = 0;
        Integer agecat3 = 0;
        Integer agecat4 = 0;
        Integer agecat5 = 0;
        
        //*****return value of Country****
        String ctryname=(Countries==null||Countries=='')?'':Countries.toLowerCase();   
        Map<String,Integer> ccat=new Map<string,Integer>{'united states'=>1,'india'=>2,'china'=>3,
                                                'egypt'=>4,'thailand'=>5,'united arab emirates'=>6,
                                                'lebanon'=>7,'saudi arabia'=>8,'singapore'=>9,
                                                'mexico'=>10,'korea south (rok)'=>11,'indonesia'=>12,
                                                'pakistan'=>13};
                                                
        Map<Integer,Decimal>ccatval=new Map<Integer,Decimal>{1=>0.000587335409495711,2 => 0.00239200787955537,
                                                    3 => 0.000592417061611374,4 => 0.00522594528127882, 5 => 0.00189465706707086,
                                                    6 => 0.00323101777059774, 7 => 0.000590318772136954, 8 => 0.00525624178712221,
                                                    9 => 0.00285714285714286, 10 => 0.00480384307445957, 11 => 0.0037243947858473,
                                                    12 => 0.004739336492891,13=>0.00689655172413793,14=>0.00766632713236477};
        
        countryval=ccatval.get(ccat.containsKey(ctryname)?ccat.get(ctryname):14);
        
        //*****return value of yahoo****
        Integer y=0;
            if((yahoo!=null||yahoo!='') &&yahoo.trim()!=null && yahoo.endswith('@yahoo.com')){
                y=1;
                system.debug('==g=>'+yahoo);
            }
            
        //*****return value of age****
        Integer i=(age!=null||age!='')?Integer.valueOf(age):0;
            if(i<=16){
                agecat=1;
                agecat1=1;
            }else if(i==17){
                agecat=2;
                agecat2=1;
            }else if(i==18){
                agecat=3;
                agecat3=1;
            }else if(i==19){
                agecat=4;
                agecat4=1;
            }else if(i==20){
                agecat=5;
                agecat5=1;
            }else{
                agecat=6;
            }
           
       //*****return region values****
       String cregion=(Region==null||Region=='')?'':Region.toLowerCase();         
        
        Map<String,String>cty_region=new Map<String,String>{'algeria'=>'african region','angola'=>'african region','benin'=>'african region',
                                                    'botswana'=>'african region','burkina faso'=>'african region','burundi'=>'african region','cameroon'=>'african region',
                                                    'cape verde'=>'african region','central african republic'=>'african region','chad'=>'african region','comoros'=>'african region',
                                                    'congo'=>'african region','congo, democratic republic of the'=>'african region','cote d\'ivoire'=>'african region',
                                                    'djibouti'=>'african region','equatorial guinea'=>'african region','eritrea'=>'african region','ethiopia'=>'african region',
                                                    'gabon'=>'african region','gambia'=>'african region','ghana'=>'african region','guinea'=>'african region','guinea-bissau'=>'african region',
                                                    'ivory coast'=>'african region','kenya'=>'african region','lesotho'=>'african region','liberia'=>'african region','libya'=>'african region',
                                                    'madagascar'=>'african region','malawi'=>'african region','mali'=>'african region','mauritania'=>'african region','mauritius'=>'african region',
                                                    'morocco'=>'african region','mozambique'=>'african region','namibia'=>'african region','niger'=>'african region','nigeria'=>'african region',
                                                    'reunion'=>'african region','rwanda'=>'african region','sao tome and principe'=>'african region','senegal'=>'african region',
                                                    'seychelles'=>'african region','sierra leone'=>'african region','somalia'=>'african region','south africa'=>'african region',
                                                    'sudan'=>'african region','swaziland'=>'african region','tanzania'=>'african region','togo'=>'african region',
                                                    'tunisia'=>'african region','uganda'=>'african region','zambia'=>'african region','zimbabwe'=>'african region',
                                                    'australia'=>'asia and pacific rim region','bhutan'=>'asia and pacific rim region','brunei darussalam'=>'asia and pacific rim region',
                                                    'burma (myanmar)'=>'asia and pacific rim region','cambodia'=>'asia and pacific rim region','china'=>'asia and pacific rim region',
                                                    'cook islands'=>'asia and pacific rim region','fiji'=>'asia and pacific rim region','french polynesia'=>'asia and pacific rim region',
                                                    'guadeloupe'=>'asia and pacific rim region','hong kong'=>'asia and pacific rim region','indonesia'=>'asia and pacific rim region',
                                                    'japan'=>'asia and pacific rim region','kiribati'=>'asia and pacific rim region','korea, north (dpr)'=>'asia and pacific rim region',
                                                    'korea, south (rok)'=>'asia and pacific rim region','laos'=>'asia and pacific rim region','macao'=>'asia and pacific rim region',
                                                    'malaysia'=>'asia and pacific rim region','midway islands'=>'asia and pacific rim region','mongolia'=>'asia and pacific rim region',
                                                    'myanmar'=>'asia and pacific rim region','nauru'=>'asia and pacific rim region','new caledonia'=>'asia and pacific rim region',
                                                    'new zealand'=>'asia and pacific rim region','niue'=>'asia and pacific rim region','northern mariana islands'=>'asia and pacific rim region',
                                                    'palau'=>'asia and pacific rim region','papua new guinea'=>'asia and pacific rim region','philippines'=>'asia and pacific rim region',
                                                    'samoa'=>'asia and pacific rim region','singapore'=>'asia and pacific rim region','solomon islands'=>'asia and pacific rim region',
                                                    'taiwan'=>'asia and pacific rim region','thailand'=>'asia and pacific rim region','tonga'=>'asia and pacific rim region',
                                                    'tuvalu'=>'asia and pacific rim region','vanuatu'=>'asia and pacific rim region','vietnam'=>'asia and pacific rim region',
                                                    'alberta, canada'=>'canadian region','british columbia, canada'=>'canadian region','manitoba, canada'=>'canadian region',
                                                    'new brunswick, canada'=>'canadian region','newfoundland, canada'=>'canadian region','northwest territory, canada'=>'canadian region',
                                                    'nova scotia, canada'=>'canadian region','nunavut, canada'=>'canadian region','ontario, canada'=>'canadian region',
                                                    'prince edward island, canada'=>'canadian region','quebec, canada'=>'canadian region','saskatchewan, canada'=>'canadian region',
                                                    'yukon territory, canada'=>'canadian region','anguilla'=>'caribbean region','antigua & barbuda'=>'caribbean region',
                                                    'aruba'=>'caribbean region','bahamas'=>'caribbean region','barbados'=>'caribbean region','bermuda'=>'caribbean region',
                                                    'cayman islands'=>'caribbean region','cuba'=>'caribbean region','dominica'=>'caribbean region','dominican republic'=>'caribbean region',
                                                    'grenada'=>'caribbean region','haiti'=>'caribbean region','jamaica'=>'caribbean region','martinique'=>'caribbean region',
                                                    'montserrat'=>'caribbean region','netherlands antilles'=>'caribbean region','saint kitts and nevis'=>'caribbean region',
                                                    'saint lucia'=>'caribbean region','saint vincent and the grenadines'=>'caribbean region','trinidad and tobago'=>'caribbean region',
                                                    'turks and caicos islands'=>'caribbean region','virgin islands, british'=>'caribbean region','virgin islands, u.s.'=>'caribbean region',
                                                    'belize'=>'central american region','costa rica'=>'central american region','el salvador'=>'central american region',
                                                    'guatemala'=>'central american region','honduras'=>'central american region','mexico'=>'central american region',
                                                    'nicaragua'=>'central american region','panama'=>'central american region','albania'=>'central and eastern european region',
                                                    'belarus'=>'central and eastern european region','bosnia & herzegovina'=>'central and eastern european region',
                                                    'bulgaria'=>'central and eastern european region','croatia'=>'central and eastern european region',
                                                    'czech republic'=>'central and eastern european region','estonia'=>'central and eastern european region',
                                                    'hungary'=>'central and eastern european region','kazakhstan'=>'central and eastern european region',
                                                    'latvia'=>'central and eastern european region','lithuania'=>'central and eastern european region',
                                                    'macedonia (f.y.r.o.m.)'=>'central and eastern european region','moldova'=>'central and eastern european region',
                                                    'montenegro'=>'central and eastern european region','romania'=>'central and eastern european region',
                                                    'russia'=>'central and eastern european region','serbia'=>'central and eastern european region',
                                                    'slovakia'=>'central and eastern european region','slovenia'=>'central and eastern european region',
                                                    'ukraine'=>'central and eastern european region','uzbekistan'=>'central and eastern european region',
                                                    'afghanistan'=>'middle east and southern asia region','armenia'=>'middle east and southern asia region',
                                                    'azerbaijan'=>'middle east and southern asia region','bahrain'=>'middle east and southern asia region',
                                                    'bangladesh'=>'middle east and southern asia region','egypt'=>'middle east and southern asia region',
                                                    'georgia'=>'middle east and southern asia region','india'=>'middle east and southern asia region',
                                                    'iran'=>'middle east and southern asia region','iraq'=>'middle east and southern asia region',
                                                    'israel'=>'middle east and southern asia region','jordan'=>'middle east and southern asia region',
                                                    'kuwait'=>'middle east and southern asia region','kyrgyzstan'=>'middle east and southern asia region',
                                                    'lebanon'=>'middle east and southern asia region','maldives'=>'middle east and southern asia region',
                                                    'nepal'=>'middle east and southern asia region','oman'=>'middle east and southern asia region',
                                                    'pakistan'=>'middle east and southern asia region','palestinian territories'=>'middle east and southern asia region',
                                                    'qatar'=>'middle east and southern asia region','saudi arabia'=>'middle east and southern asia region',
                                                    'sri lanka'=>'middle east and southern asia region','syria'=>'middle east and southern asia region',
                                                    'tajikistan'=>'middle east and southern asia region','turkmenistan'=>'middle east and southern asia region',
                                                    'united arab emirates'=>'middle east and southern asia region','yemen'=>'middle east and southern asia region',
                                                    'argentina'=>'south american region','bolivia'=>'south american region','brazil'=>'south american region',
                                                    'chile'=>'south american region','colombia'=>'south american region','ecuador'=>'south american region',
                                                    'french guiana'=>'south american region','guyana'=>'south american region','paraguay'=>'south american region',
                                                    'peru'=>'south american region','suriname'=>'south american region','uruguay'=>'south american region',
                                                    'venezuela'=>'south american region','aaland islands'=>'western european region','andorra'=>'western european region',
                                                    'austria'=>'western european region','belgium'=>'western european region','cyprus'=>'western european region',
                                                    'denmark'=>'western european region','england'=>'western european region','faroe islands'=>'western european region',
                                                    'finland'=>'western european region','france'=>'western european region','germany'=>'western european region',
                                                    'gibraltar'=>'western european region','greece'=>'western european region','greenland'=>'western european region',
                                                    'holy see (vatican city)'=>'western european region','iceland'=>'western european region','ireland'=>'western european region',
                                                    'isle of man'=>'western european region','italy'=>'western european region','liechtenstein'=>'western european region',
                                                    'luxembourg'=>'western european region','malta'=>'western european region','monaco'=>'western european region',
                                                    'netherlands'=>'western european region','northern ireland'=>'western european region','norway'=>'western european region',
                                                    'poland'=>'western european region','portugal'=>'western european region','san marino'=>'western european region',
                                                    'scotland'=>'western european region','spain'=>'western european region','sweden'=>'western european region',
                                                    'switzerland'=>'western european region','turkey'=>'western european region','wales'=>'western european region',
                                                    'united states'=>'usregion','korea south (rok)'=>'asia and pacific rim region','burma (myanmar)'=>'middle east and southern asia region',
                                                    'macedonia (f.y.r.o.m.)'=>'central and eastern european region','congo democratic republic of'=>'african region',
                                                    'virgin islands british'=>'caribbean region','saint vincent and the grenadi'=>'caribbean region',
                                                    'united kingdom'=>'western european region','trinidad and tobago'=>'caribbean region',
                                                    'russian federation'=>'central and eastern european region','macedonia the former yugoslavia'=>'central and eastern european region',
                                                    'canada'=>'usregion','tanzania united republic of'=>'african region','bosnia and herzegovina'=>'central and eastern european region',
                                                    'korea south (rok)'=>'asia and pacific rim region','viet nam'=>'asia and pacific rim region','united states'=>'usregion'};

                                                    
        Map<String,Decimal>cty_val=new Map<String,Decimal>{'central and eastern european region'=> 0.0125786163522013,'western european region'=> 0.0116102978293791,
                                                    'south american region'=> 0.0102511532547412,'african region'=> 0.00849256900212314,
                                                    'caribbean region'=> 0.0066079295154185,'central american region'=> 0.00516674495068107,
                                                    'middle east and southern asia region'=> 0.00372999015697042,'asia and pacific rim region'=> 0.00186477382098171,
                                                    'usregion'=> 0.000587335409495711};
                                                    
        regionval=cty_val.get(cty_region.containsKey(cregion)?cty_region.get(cregion):Null);     
    
      //*****Major Values****    
      Set<Integer>major_val=new set<Integer>{200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,225,230,235};
        
        Integer bizmaj1=Major_val.contains(Major1)?1:0;
        Integer bizmaj2=Major_val.contains(Major2)?1:0;
        Integer bizmaj3=Major_val.contains(Major3)?1:0;
        Integer bizmaj4=Major_val.contains(Major4)?1:0;
        Integer bizmaj5=Major_val.contains(Major5)?1:0;
        
        Integer bizmajorchoice = (bizmaj1==1|| bizmaj2==1|| bizmaj3==1|| bizmaj4==1|| bizmaj5==1)?1:0;
        
        Integer bizmajcat = 0;
        if(bizmaj1==1){
            bizmajcat=1;
        }
        if(bizmaj1==0 && bizmajorchoice==1){
             bizmajcat=2;
        }
            
        bizmajcat0= bizmajcat==0?1:0;
        bizmajcat1= bizmajcat==1?1:0;
    
              System.debug('=====***countryval->'+countryval);
              System.debug('=====***regionval->'+regionval);
              System.debug('=====***bizmajcat0->'+bizmajcat0);
              System.debug('=====***bizmajcat1->'+bizmajcat1);
              System.debug('=====***agecat1->'+agecat1);
              System.debug('=====***agecat2->'+agecat2);
              System.debug('=====***agecat3->'+agecat3);
              System.debug('=====***agecat4->'+agecat4);
              System.debug('=====***agecat5->'+agecat5);
              System.debug('=====***y->'+y);
           
    
        //***** This is to calculate x value****  
        Decimal x=(240.0*countryval)+
                (67.17*regionval)+
                (-0.678 * bizmajcat0) + 
                (0.8592 * bizmajcat1) + 
                (-2.136 * agecat1) + 
                (-0.6103 * agecat2) + 
                (-0.3404 * agecat3) + 
                (-0.1245 * agecat4) + 
                (-0.2857 * agecat5) + 
                (-0.6481 * y) - 6.707;
                
        System.debug('=====***x->'+x);    

        //***** This is to calculate Probability value****
    
        Decimal probx=(1/(1+Math.exp(-x)));    
        return probx;
    
    } 
   /*--------------------- Leadsource GMASS Model (JIRA NO:695) ------------------------------*/
    public static Decimal Gmass_Model(String Worldregion,String country
                                        ,String degreeobjective,String workload
                                        ,String regionvalue1,String regionvalue2
                                        ,String regionvalue3,String regionvalue4
                                        ,String regionvalue5,String regionvalue6){
                                        
        //*****This is return value for Worldregion****
        String regionname=(Worldregion==null||Worldregion=='')?'':((Worldregion.trim()==''||Worldregion.trim()==null)?'':Worldregion.trim().toLowerCase());
        Integer africa=0;
        Integer asia=0;
        Integer australia=0;
        Integer casia=0;
        Integer eeurope=0;
        Integer weurope=0;
        Integer latam =0;
        Integer middlee=0; 
        
            if(regionname!=NULL||regionname!=''){
                if(regionname=='africa'){
                    africa=1;
                }
                else if(regionname=='asia'){
                    asia=1;
                }
                else if(regionname=='australia and the pacific islands'){
                    australia=1;
                }
                else if(regionname=='central asia'){
                    casia=1;
                } 
                else if(regionname=='europe, eastern'){
                    eeurope=1;
                }
                else if(regionname=='europe, western'){
                    weurope=1;
                } 
                else if(regionname=='mexico, the caribbean, and latin america'){
                    latam=1;
                }
                else if(regionname=='middle east'){
                    middlee=1;
                }
            }  
        
        //*****This is return value for Contry**** 
        String ctryname=(country==null||country=='')?'':((country.trim()==''||country.trim()==null)?'':country.trim().toLowerCase());
        Integer nigeria=0;
        Integer china=0;
            if(ctryname!=NULL||ctryname!=''){
                if(ctryname=='nigeria'){
                    nigeria=1;
                }
                else if(ctryname=='china'){
                    china=1;
                }
            }  
            
        //*****This is return value for degreeobjective****
        String degreeobj=(degreeobjective==null||degreeobjective=='')?'':((degreeobjective.trim()==''||degreeobjective.trim()==null)?'':degreeobjective.trim().toLowerCase());
        Integer objmba=0;
        Integer objmabus=0;
            if(degreeobj!=NULL||degreeobj!=''){
                if(degreeobj=='master\'s in business administration (mba)'){
                    objmba=1;
                }
                if(degreeobj=='master\'s in business (ms, msc, ma)'){
                    objmabus=1;
                }
            }  
            
        //*****This is return value for Work load**** 
        String wrklodtime=(workload==null||workload=='')?'':((workload.trim()==''||workload.trim()==null)?'':workload.trim().toLowerCase());
        Integer fulltime=0;
        Integer parttime=0;
            if(wrklodtime!=NULL||wrklodtime!='' ){
                if(wrklodtime=='full-time student'){
                    fulltime=1;
                }
                if(wrklodtime=='part-time student'){
                    parttime=1;
                }
            }                                
             
        String regionval1=(regionvalue1==null||regionvalue1=='')?'':((regionvalue1.trim()==''||regionvalue1.trim()==null)?'':regionvalue1.trim().toLowerCase());
        String regionval2=(regionvalue2==null||regionvalue2=='')?'':((regionvalue2.trim()==''||regionvalue2.trim()==null)?'':regionvalue2.trim().toLowerCase());
        String regionval3=(regionvalue3==null||regionvalue3=='')?'':((regionvalue3.trim()==''||regionvalue3.trim()==null)?'':regionvalue3.trim().toLowerCase());
        String regionval4=(regionvalue4==null||regionvalue4=='')?'':((regionvalue4.trim()==''||regionvalue4.trim()==null)?'':regionvalue4.trim().toLowerCase());
        String regionval5=(regionvalue5==null||regionvalue5=='')?'':((regionvalue5.trim()==''||regionvalue5.trim()==null)?'':regionvalue5.trim().toLowerCase());
        String regionval6=(regionvalue6==null||regionvalue6=='')?'':((regionvalue6.trim()==''||regionvalue6.trim()==null)?'':regionvalue6.trim().toLowerCase());
        
        Map<String,Integer> regionvalmap=new Map<String,Integer>{'united states'=>8,'northeast (ct, ma, me, nh, nj, ny, ri, vt)'=>8
                                                        ,'southwest (az, co, nm, ok, tx)'=>8,'undecided'=>0
                                                        ,'midwest (ia, il, in, ks, mi, mn, mo, nd, ne, oh, sd, wi)'=>8
                                                        ,'middle atlantic (dc, de, md, pa va, wv)'=>8
                                                        ,'west (ak, ca, hi, id, mt, nv, or ut, wa, wy)'=>8,'south (al, ar, fl, ga, ky, la, ms, nc, sc, tn)'=>8
                                                        ,'europe, western'=>9,'asia'=>2,'australia and the pacific islands'=>3
                                                        ,'canada'=>8,'undecided (us)'=>8,'middle east'=>7,'europe, eastern'=>5
                                                        ,'africa'=>1,'mexico, the caribbean, and latin america'=>6
                                                        ,'central asia'=>4};
        Integer regmatch1=0;
        Integer regmatch2=0;
        Integer regmatch3=0;
        Integer regmatch4=0;
        Integer regmatch5=0;
        Integer regmatch6=0;
        if(regionvalmap.containsKey(regionval1) && regionvalmap.get(regionval1)==1){
            regmatch1=1;
        }
        if(regionvalmap.containsKey(regionval2) && regionvalmap.get(regionval2)==1){
            regmatch2=1;
        }
        if(regionvalmap.containsKey(regionval3) && regionvalmap.get(regionval3)==1){
            regmatch3=1;
        }
        if(regionvalmap.containsKey(regionval4) && regionvalmap.get(regionval4)==1){
            regmatch4=1;
        }
        if(regionvalmap.containsKey(regionval5) && regionvalmap.get(regionval5)==1){
            regmatch5=1;
        }
        if(regionvalmap.containsKey(regionval6) && regionvalmap.get(regionval6)==1){
            regmatch6=1;
        }
        
        Integer regmatchsum= regmatch1+regmatch2+regmatch3+regmatch4+regmatch5+regmatch6;
        
        
        Integer reg1exist = 1;
        Integer reg2exist = 1;
        Integer reg3exist = 1;
        Integer reg4exist = 1;
        Integer reg5exist = 1;
        Integer reg6exist = 1;
        if(regionval1=='undecided'){
            reg1exist =0;
        }
        if(regionval2=='undecided'){
            reg2exist =0;
        }
        if(regionval3=='undecided'){
            reg3exist =0;
        }
        if(regionval4=='undecided'){
            reg4exist =0;
        }
        if(regionval5=='undecided'){
            reg5exist =0;
        }
        if(regionval6=='undecided'){
            reg6exist =0;
        }
        
        Integer regionsum =reg1exist+reg2exist+reg3exist+reg4exist+reg5exist+reg6exist;
        
        Decimal regmatchproport = regmatchsum/regionsum;
        
        Integer regproportcat;
        if(regmatchproport == 99){
            regproportcat=1;
        }
        else if(regmatchproport==0){
            regproportcat=3;
        }
        else if(regmatchproport>0 && regmatchproport<1){
            regproportcat=4;
        }
        
        Integer nomatch = 0;
        if (regproportcat == 3){
            nomatch = 1;
        }
        
        Integer allmatch=0;
        if (regproportcat == 2){
            allmatch = 1;
        }
        
        Decimal x=(1.152 * africa)+
                   (0.3386 * asia)+ 
                   (-0.5195 * australia) + 
                   (-0.1094 * casia) + 
                   (1.138 * eeurope) + 
                   (1.318 * weurope)+ 
                   (1.543 * latam) + 
                   (1.188 * middlee) +
                   (-1.321 * china) + 
                   (0.4442 * nigeria) + 
                   (0.354 * objmba) + 
                   (0.5678 * objmabus) + 
                   (0.4619 * fulltime) + 
                   (-1.403 * parttime) + 
                   (-0.8426 * allmatch) + 
                   (0.2081 * nomatch) + 
                   (-5.591) ;
        
        Decimal probx=(1/(1+Math.exp(-x)));
        
        System.debug('=====================***regionsum->'+regionsum);
        System.debug('=======================***regmatchsum->'+regmatchsum);
        System.debug('======================***regmatchproport ->'+regmatchproport);
        System.debug('===================***x->'+x);
        System.debug('=====================***probx->'+probx);
        return probx;
    }
   
   /*--------------------- leadSource_GreModel (JIRA NO:696) ------------------------------*/    
    public static Decimal Gre_Model(String gmail,String undergraduateinstitution,string countryofcitizenship,String intendedgraduatemajor,string countrypostalcode,string regionvalue1,string regionvalue2,string regionvalue3,string regionvalue4,string regionvalue5,string regionvalue6,string regionvalue7,string regionvalue8,string regionvalue9,string regionvalue10,string regionvalue11,string regionvalue12 )
    {
        //*****This is return value for gmail****   
        Integer isnotgmail=1;
        
        if((gmail!=null&&gmail!='')&&(gmail.trim()!=null&&gmail.trim()!='')&&(gmail.trim().toLowerCase().endswith('@gmail.com'))){
            isnotgmail=0;
            system.debug('==g=>'+isnotgmail);
        }
        
        integer undergradinstlist = (undergraduateinstitution!=null&&undergraduateinstitution!=''&&undergraduateinstitution.trim()!=null&&undergraduateinstitution.trim()!='')?0:1;
        
        string ctry=(countryofcitizenship!=null && countryofcitizenship.trim()!=null)?countryofcitizenship.trim().toLowerCase():countryofcitizenship;
        integer citus =ctry =='united states of america'?1:0;
        integer citindia =ctry =='india'?1:0;
        integer citchina =ctry =='china, people\'s republic'?1:0;
        
        integer blankgradmaj =0;
        string intmajorgrad=(intendedgraduatemajor!=null && intendedgraduatemajor.trim()!=null)?intendedgraduatemajor.trim().toLowerCase():intendedgraduatemajor;
        if (intmajorgrad =='no response') blankgradmaj =1;

        integer busrelmaj = 0;
        set<string> intendedgraduatemajor_set=new set<string>{'accounting','actuarial science','actuarial science-business','agricultural business and management',
        'applied economics','applied mathematics','banking and financial support services','business administration and management',
        'business administration and management-other','business operations','business statistics','business/corporate communications','business/managerial economics',
        'business-other','commercial banking','consumer economics','credit management','e-commerce','econometrics','economics','economics, other',
        'entrepreneurship','finance','financial planning and services','international business','international economics','international finance','investments & securities',
        'investments and securities','leadership','management information systems','management science','marketing','marketing & distribution',
        'marketing management and research','organizational leadership','public policy - business','public policy-business','risk management','small business operations'};
        
        if(intendedgraduatemajor_set.contains(intmajorgrad)) busrelmaj = 1;

        integer intmajcat = busrelmaj == 1?1:(blankgradmaj ==1?2:0);
        
        map<integer,string> intmajcat_vals=new map<integer,string>{1 =>'Bus Related',2=>'Missing',0=>'Not Related'};
        
        /*add value labels intmajcat
            1 "Bus Related"
            2 "Missing"
            0 "Not Related".            
            freq intmajcat .
        
         */     
                
        map<string,string> countrypostalcode_map=new map<string,string>{'afghanistan'=>'asia','albania'=>'europe','algeria'=>'africa','angola'=>'africa','antigua and barbuda'=>'central america',
            'argentina'=>'south america','armenia'=>'asia','aruba'=>'central america','australia'=>'australia & oceania','austria'=>'europe','azerbaijan'=>'asia','bahamas'=>'central america',
            'bahrain'=>'asia','bangladesh'=>'asia','barbados'=>'central america','belarus'=>'europe','belgium'=>'europe','belize'=>'central america','benin'=>'africa','bermuda'=>'central america',
            'bhutan'=>'asia','bolivia'=>'south america','bosnia and herzegovina'=>'europe','botswana'=>'africa','brazil'=>'south america','brunei darussalam'=>'asia','bulgaria'=>'europe',
            'burkina faso'=>'africa','burundi'=>'africa','cambodia'=>'asia','cameroon'=>'africa','canada'=>'canada','canary islands'=>'africa','cape verde'=>'africa','cayman islands'=>'central america',
            'central african republic'=>'africa','chad'=>'africa','chile'=>'south america','china, people\'s republic of'=>'asia','colombia'=>'south america','comoros'=>'africa','congo (formerly zaire)'=>'africa',
            'congo republic'=>'africa','costa rica'=>'central america','cote d\'ivoire (ivory coast)'=>'africa','croatia'=>'europe','cyprus'=>'asia','czech republic'=>'europe','denmark'=>'europe',
            'djibouti'=>'africa','dominica, commonwealth of'=>'central america','dominican republic'=>'central america','ecuador'=>'south america','egypt'=>'africa','el salvador'=>'central america','england'=>'europe',
            'eritrea'=>'africa','estonia'=>'europe','ethiopia'=>'africa','equatorial guinea'=>'africa','federated states of micronesia'=>'australia & oceania','fiji'=>'australia & oceania',
            'finland'=>'europe','france'=>'europe','frm yugoslav rep. of macedonia'=>'europe','gabon'=>'africa','gambia, the'=>'africa','gaza strip'=>'asia','germany'=>'europe','ghana'=>'africa',
            'greece'=>'europe','greenland'=>'europe','grenada'=>'central america','guam'=>'united states of america','guatemala'=>'central america','guinea'=>'africa','guinea-bissau'=>'africa','guyana'=>'south america',
            'haiti'=>'central america','honduras'=>'central america','hong kong'=>'asia','hungary'=>'europe','iceland'=>'europe','india'=>'asia','indonesia'=>'asia','iran'=>'asia','iraq'=>'asia',
            'ireland'=>'europe','israel'=>'asia','italy'=>'europe','jamaica'=>'central america','japan'=>'asia','jordan'=>'asia','kazakhstan'=>'asia','kenya'=>'africa','korea (dpr)'=>'asia','korea (rok)'=>'asia',
            'kuwait'=>'asia','kyrgyzstan'=>'asia','latvia'=>'europe','lebanon'=>'asia','liberia'=>'africa','libya'=>'africa','lithuania'=>'europe','luxembourg'=>'europe','macau'=>'asia',
            'madagascar'=>'africa','malawi'=>'africa','malaysia'=>'asia','maldives'=>'asia','mali'=>'africa','malta'=>'europe','mauritius'=>'africa','mexico'=>'central america','moldova'=>'europe',
            'mongolia'=>'asia','morocco'=>'africa','mozambique'=>'africa','myanmar (burma)'=>'asia','namibia'=>'africa','nepal'=>'asia','netherlands'=>'europe','new zealand'=>'australia & oceania',
            'nicaragua'=>'central america','niger'=>'africa','nigeria'=>'africa','northern mariana islands'=>'australia & oceania','norway'=>'europe','oman'=>'asia','pakistan'=>'asia',
            'palestine'=>'asia','panama'=>'central america','papua new guinea'=>'australia & oceania','paraguay'=>'south america','peru'=>'south america','philippines'=>'asia','poland'=>'europe',
            'portugal'=>'europe','puerto rico'=>'central america','qatar'=>'asia','republic of georgia'=>'europe','romania'=>'europe','russia'=>'europe','rwanda'=>'africa','saudi arabia'=>'asia',
            'scotland'=>'europe','senegal'=>'africa','serbia'=>'europe','seychelles'=>'africa','sierra leone'=>'africa','singapore'=>'asia','slovak republic'=>'europe','slovenia'=>'europe',
            'somalia'=>'africa','south africa'=>'africa','spain'=>'europe','sri lanka'=>'asia','st. kitts and nevis'=>'central america','st. lucia'=>'central america','st. vincent and the grenadines'=>'central america',
            'sudan'=>'africa','suriname'=>'south america','swaziland'=>'africa','sweden'=>'europe','switzerland'=>'europe','syria'=>'asia','taiwan'=>'asia','tajikistan'=>'asia','tanzania'=>'africa',
            'thailand'=>'asia','togo'=>'africa','trinidad and tobago'=>'central america','tunisia'=>'africa','turkey'=>'asia','turkmenistan'=>'asia','uganda'=>'africa','ukraine'=>'europe','united arab emirates'=>'asia',
            'united kingdom'=>'europe','united states of america'=>'united states of america','uruguay'=>'asia','us virgin islands'=>'central america','uzbekistan'=>'asia','venezuela'=>'australia & oceania','vietnam'=>'asia',
            'west bank'=>'asia','yemen'=>'asia','zambia'=>'africa','zimbabwe'=>'africa','china, people\'s republic'=>'asia','cote d\'ivoire (ivory coast)'=>'africa','dominica, commonwealth o'=>'south america',
            'federated states of micr'=>'australia & oceania','frm yugoslav rep. of mac'=>'europe','st. vincent and the gren'=>'south america'}; 
        
        string greregion;
        countrypostalcode=(countrypostalcode!=null && countrypostalcode=='' && countrypostalcode.trim()!=null && countrypostalcode.trim()!='')?countrypostalcode.trim().toLowerCase():countrypostalcode;
        greregion=countrypostalcode_map.containsKey(countrypostalcode)?countrypostalcode_map.get(countrypostalcode):null;
        
        map<string,integer> greregion_map=new map<string,integer>{'asia'=>1,'south america'=>2,'central america'=>2,'africa'=>3,'united states of america'=>4,'canada'=>4,'australia & oceania'=>5,'europe'=>6};
        integer regioncode= greregion_map.containsKey(greregion)?greregion_map.get(greregion):0;
        
        
        map<string,integer> regionvalue_map=new map<string,integer>{'africa'=> 3,'asia'=> 1,'australia/new zealand'=> 5,'canada'=> 4,'europe'=> 6,'latin america'=> 2,
            'mid-atlantic, usa (dc, de, md, nj, ny, pa)'=> 4,'midwest, usa (il, in, ia, ks, mi, mn, mo, ne, nd, oh, sd, wi)'=> 4,'new england, usa (ct, me, ma, nh, ri, vt)'=> 4,
            'south, usa (al, fl, ga, ky, la, ms, nc, sc, tn, va, wv)'=> 4,'southwest, usa (az, ar, nm, ok, tx)'=> 4,'west, usa (ak, ca, co, hi, id, mt, nv, or, ut, wa, wy)'=> 4};
        
        string regval1=(regionvalue1!=null && regionvalue1!='' && regionvalue1.trim()!=null && regionvalue1.trim()!='')?regionvalue1.trim().toLowerCase(): regionvalue1;
        string regval2=(regionvalue2!=null && regionvalue2!='' && regionvalue2.trim()!=null && regionvalue2.trim()!='')?regionvalue2.trim().toLowerCase(): regionvalue2;
        string regval3=(regionvalue3!=null && regionvalue3!='' && regionvalue3.trim()!=null && regionvalue3.trim()!='')?regionvalue3.trim().toLowerCase(): regionvalue3;
        string regval4=(regionvalue4!=null && regionvalue4!='' && regionvalue4.trim()!=null && regionvalue4.trim()!='')?regionvalue4.trim().toLowerCase(): regionvalue4;
        string regval5=(regionvalue5!=null && regionvalue5!='' && regionvalue5.trim()!=null && regionvalue5.trim()!='')?regionvalue5.trim().toLowerCase(): regionvalue5;
        string regval6=(regionvalue6!=null && regionvalue6!='' && regionvalue6.trim()!=null && regionvalue6.trim()!='')?regionvalue6.trim().toLowerCase(): regionvalue6;
        string regval7=(regionvalue7!=null && regionvalue7!='' && regionvalue7.trim()!=null && regionvalue7.trim()!='')?regionvalue7.trim().toLowerCase(): regionvalue7;
        string regval8=(regionvalue8!=null && regionvalue8!='' && regionvalue8.trim()!=null && regionvalue8.trim()!='')?regionvalue8.trim().toLowerCase(): regionvalue8;
        string regval9=(regionvalue9!=null && regionvalue9!='' && regionvalue9.trim()!=null && regionvalue9.trim()!='')?regionvalue9.trim().toLowerCase(): regionvalue9;
        string regval10=(regionvalue10!=null && regionvalue10!='' && regionvalue10.trim()!=null && regionvalue10.trim()!='')?regionvalue10.trim().toLowerCase(): regionvalue10;
        string regval11=(regionvalue11!=null && regionvalue11!='' && regionvalue11.trim()!=null && regionvalue11.trim()!='')?regionvalue11.trim().toLowerCase(): regionvalue11;
        string regval12=(regionvalue12!=null && regionvalue12!='' && regionvalue12.trim()!=null && regionvalue12.trim()!='')?regionvalue12.trim().toLowerCase(): regionvalue12;
        
        integer deswrid1=regionvalue_map.containsKey(regval1)?regionvalue_map.get(regval1):0;
        integer deswrid2=regionvalue_map.containsKey(regval2)?regionvalue_map.get(regval2):0;
        integer deswrid3=regionvalue_map.containsKey(regval3)?regionvalue_map.get(regval3):0;
        integer deswrid4=regionvalue_map.containsKey(regval4)?regionvalue_map.get(regval4):0;
        integer deswrid5=regionvalue_map.containsKey(regval5)?regionvalue_map.get(regval5):0;
        integer deswrid6=regionvalue_map.containsKey(regval6)?regionvalue_map.get(regval6):0;
        integer deswrid7=regionvalue_map.containsKey(regval7)?regionvalue_map.get(regval7):0;
        integer deswrid8=regionvalue_map.containsKey(regval8)?regionvalue_map.get(regval8):0;
        integer deswrid9=regionvalue_map.containsKey(regval9)?regionvalue_map.get(regval9):0;
        integer deswrid10=regionvalue_map.containsKey(regval10)?regionvalue_map.get(regval10):0;
        integer deswrid11=regionvalue_map.containsKey(regval11)?regionvalue_map.get(regval11):0;
        integer deswrid12=regionvalue_map.containsKey(regval12)?regionvalue_map.get(regval12):0;
        
        integer regmatch1=(deswrid1 == regioncode)?1:0; 
        integer regmatch2=(deswrid2 == regioncode)?1:0;
        integer regmatch3=(deswrid3 == regioncode)?1:0;
        integer regmatch4=(deswrid4 == regioncode)?1:0;
        integer regmatch5=(deswrid5 == regioncode)?1:0;
        integer regmatch6=(deswrid6 == regioncode)?1:0;
        integer regmatch7=(deswrid7 == regioncode)?1:0;
        integer regmatch8=(deswrid8 == regioncode)?1:0;
        integer regmatch9=(deswrid9 == regioncode)?1:0;
        integer regmatch10=(deswrid10 == regioncode)?1:0;
        integer regmatch11=(deswrid11 == regioncode)?1:0;
        integer regmatch12=(deswrid12 == regioncode)?1:0;
        
        integer regmatchsum =regmatch1+regmatch2+regmatch3+regmatch4+regmatch5+regmatch6+regmatch7+regmatch8+regmatch9+regmatch10+regmatch11+regmatch12;
        
        integer reg1exist =(regval1 == 'undecided'||regval1 == ''||regval1 == null)?0:1;
        integer reg2exist =(regval2 == 'undecided'||regval2 == ''||regval2 == null)?0:1;
        integer reg3exist =(regval3 == 'undecided'||regval3 == ''||regval3 == null)?0:1;
        integer reg4exist =(regval4 == 'undecided'||regval4 == ''||regval4 == null)?0:1;
        integer reg5exist =(regval5 == 'undecided'||regval5 == ''||regval5 == null)?0:1;
        integer reg6exist =(regval6 == 'undecided'||regval6 == ''||regval6 == null)?0:1;
        integer reg7exist =(regval7 == 'undecided'||regval7 == ''||regval7 == null)?0:1;
        integer reg8exist =(regval8 == 'undecided'||regval8 == ''||regval8 == null)?0:1;
        integer reg9exist =(regval9 == 'undecided'||regval9 == ''||regval9 == null)?0:1;
        integer reg10exist =(regval10 == 'undecided'||regval10 == ''||regval10 == null)?0:1;
        integer reg11exist =(regval11 == 'undecided'||regval11 == ''||regval11 == null)?0:1;
        integer reg12exist =(regval12 == 'undecided'||regval12 == ''||regval12 == null)?0:1;
        
        integer regionsum = reg1exist+reg2exist+reg3exist+reg4exist+reg5exist+reg6exist+reg7exist+reg8exist+reg9exist+reg10exist+reg11exist+reg12exist;
        
        Decimal regmatchproport =99;
        
        try
        {
            regmatchproport = regmatchsum/regionsum;
        }
        catch(Exception e)
        {
            regmatchproport =99;
        }
        
        
        integer regproportcat=regmatchproport == 99?1:(regmatchproport == 1?2:(regmatchproport ==0) ?3:(regmatchproport > 0 && regmatchproport < 1) ?4:1);
        
        map<integer,string> regproportcat_vals=new map<integer,string> {1=> 'All Missing',2=>'All Home',3=>'All Away',4=>'Mix'};
        /*  add value labels regproportcat
            1 "All Missing"
            2 "All Home"
            3 "All Away"
            4 "Mix".            
            freq regproportcat.
                        
        */
        integer regproportcat1 =(regproportcat == 1)?1:0;
        integer regproportcat2 =(regproportcat == 2)?1:0;
        integer regproportcat3 =(regproportcat == 3)?1:0;
        
        integer intmajcat0 =(intmajcat==0)?1:0;
        integer intmajcat1 =(intmajcat==1)?1:0;
        
        decimal total = -(0.8867*regproportcat1) 
                        + (-1.293*regproportcat2)
                        + (-0.39*regproportcat3) 
                        + (-0.16*intmajcat0) 
                        + (1.251*intmajcat1)
                        +(-0.6466*citus)
                        +(-1.385*citchina) 
                        + (0.4027*isnotgmail) 
                        + (-1.127*citindia)
                        +(-0.6551*undergradinstlist)
                        + -5.63;
        
        System.debug('======================***total ->'+total);
        
        decimal probx=(1/(1+Math.exp(-total)));
        
        System.debug('======================***probx->'+probx);
        
        return probx;
    }
   
  /*--------------------- Declining_instructions(JIRA NO:697) ------------------------------*/ 
  
  public static Decimal TOFEL_model(String mail,String course,string education,String Countryofcitizenship,String Language,String Degree,String Reason){
     
        Integer courseval;
        Integer prefmajcat0=0;
        Integer prefmajcat1=0;
        Integer prefmajcat2=0;
        Integer prefmajcat3=0;
        Integer prefmajcat4=0;
        Integer prefmajcat5=0;
        Integer prefmajcat6=0;
        Integer prefmajcat7=0;
        Decimal currentedlev;
        Integer citchina = 0;
        Integer korean = 0;
        Integer ukpursuit = 0;
        Integer uspursuit = 0;
        Integer toeflbus = 0;
        Integer toeflbus2 = 0;
        Integer toeflenglish = 0;
        Integer toeflBusiness = 0;
        Integer Match=0;
        Integer Matchcat=1;
        Integer Matchcat1=0;
        Integer Matchcat2=0;
        
        //*****This is return value for gmail****   
        Integer gmail=0;
            if((mail!=null&&mail!='') && mail.trim()!=null && mail.endswith('@gmail.com')){
                gmail=1;               
             }
        
        //*****This is return value for course**** 
        String coursename=(course==null||course=='')?'not applicable':course.toLowerCase(); 
        Map<String,Integer>preferredmajorcourse=new Map<String,Integer>{'not applicable'=> 0,
                                                                'business administration & management'=> 1,
                                                                'engineering & technology'=> 2,
                                                                'economics'=> 3,
                                                                'undecided'=> 4,
                                                                'law'=> 5,
                                                                'public administration'=>5,
                                                                'accounting'=> 6,
                                                                'communications'=> 7,
                                                                'marketing'=>7};
        courseval=preferredmajorcourse.get(coursename);        
        
        System.debug('----> courseval'+courseval);

        Prefmajcat0=courseval==0?1:0;
        Prefmajcat1=courseval==1?1:0;
        Prefmajcat2=courseval==2?1:0;
        Prefmajcat3=courseval==3?1:0;
        Prefmajcat4=courseval==4?1:0;
        Prefmajcat5=courseval==5?1:0;
        Prefmajcat6=courseval==6?1:0;
        Prefmajcat7=courseval==7?1:0;
        
        System.debug('----> prefmajcat0=0'+prefmajcat0);
        
        //*****This is return value for Education level**** 
        String Edu=(education==null||education=='')?'other':education.toLowerCase(); 
        
         Map<String,Decimal>currenteducationlevel=new Map<String,Decimal>{'2 year college/comm. college'=>0.00162999185004075,
                                                                '4 year undergraduate college'=>0.00692067551811035,
                                                                'elementary school'=>0 ,
                                                                'english as a second language'=>0.00275758335422412,
                                                                'graduate / post-graduate advanced degree'=>0.00272108843537415,
                                                                'graduate / post-graduate college'=>0.0080054012345679,
                                                                'graduate / postgraduate advanced degree'=>0.00322061191626409,
                                                                'graduate / postgraduate college'=>0.0064919451791296,
                                                                'high school'=>0.00701048101617269,
                                                                'middle school'=>0.00216919739696312,
                                                                'not applicable'=>0.00255758171256827,
                                                                'not currently in any education institution'=>0.00577264653641208,
                                                                'other'=>0.00469924812030075,
                                                                'pre-degree / vocational'=>0 ,
                                                                'predegree / vocational'=>0,
                                                                'undergraduate/bachelor\'s degree'=>0.00194873332333983};
          
        currentedlev=currenteducationlevel.get(Edu); 
           
        //*****This is return value for Country of citizenship****   
        String CtyCode=(Countryofcitizenship==null||Countryofcitizenship=='')?'null': Countryofcitizenship.toLowerCase(); 
        citchina=ctycode=='china, people\'s republic of'?1:0;    
        
        //*****This is return value for Native Language****
        String Native_language=(Language==null||language=='')?'null':language.toLowerCase();                                                    
        korean=Native_language=='korean'?1:0;
        
        //*****This is return value for uk us pursuit**** 
        String countryofdegree=(Degree==null||Degree=='')?'null':Degree.toLowerCase();
        uspursuit=countryofdegree=='united states'?1:0;
        ukpursuit=countryofdegree=='united kingdom'?1:0;
        matchcat=countryofdegree=='not answered'||countryofdegree==''?3:matchcat;
        
        //*****This is return value for reason value****
        String reasonfortakingtoefl=(reason==null||reason=='')?'null':reason.toLowerCase();
        toeflbus=reasonfortakingtoefl=='to attend masters / grad post-grad business program'?1:0;
        toeflbus2=reasonfortakingtoefl=='to attend masters / grad postgrad business program'?1:0; 
        toeflenglish=reasonfortakingtoefl=='to attend an english language school or program'?1:0;
        toeflbusiness=(toeflbus==1||toeflbus2==1)?1:0;            
        
        //*****This is return value for Match**** 
        Set<String>country_code=new set<String>{'united states','china','korea, republic of','russian federation'};   
        Match=country_code.contains(countryofdegree)?1:0;
        
        if(Match==1){
            matchcat=2;
        }     
     
        //*****This is return value for Matchcat1****
        
        if(Matchcat==1){
        matchcat1 = 1;
        }
        if(Matchcat==2){
        matchcat2 = 1;
        }
        
        Decimal x=(0.3649*prefmajcat0) + 
            (0.8036*prefmajcat1) + 
            (-1.25*prefmajcat2) + 
            (0.1465*prefmajcat3) + 
            (0.09652*prefmajcat4) + 
            (-0.2995*prefmajcat5) + 
            (0.5158*prefmajcat6) + 
            (-0.2273*prefmajcat7) + 
            (175.5*currentedlev) + 
            (0.3794*matchcat1) + 
            (0.02193*matchcat2) + 
            (0.3956*gmail) + 
            (-1.832*citchina) + 
            (-1.819*korean) + 
            (0.3758*uspursuit) + 
            (0.9852*ukpursuit) + 
            (-2.039*toeflenglish) + 
            (1.036*toeflbusiness)  -7.262;
        
        Decimal probx=(1/(1+Math.exp(-x))); 
        System.debug('----> x-->'+x);
        System.debug('----> probx-->'+probx);     
        return probx;
    
    }
    
  /*--------------------- Declining_instructions(JIRA NO:698) ------------------------------*/    
    
    public static Decimal Declining_instructions(Decimal probx,String Region)
    {
        integer gdecile=0;
        string Africadecile,Asiadecile,LatAmdecile,LonEurdecile,LuzEurdecile,MidEastdecile,NorthAmdecile,SouthAsiadecile;
        if (probx >=0.01375) gdecile = 1;
        if (probx >= 0.00837 && probx < 0.01375) gdecile = 2;
        if (probx >= 0.00528 && probx < 0.00837) gdecile = 3;
        if (probx >= 0.00362 && probx < 0.00528) gdecile = 4;
        if (probx >= 0.00245 && probx < 0.00362) gdecile = 5;
        if (probx >= 0.00159 && probx < 0.00245) gdecile = 6;
        if (probx >= 0.00100 && probx < 0.00159) gdecile = 7;
        if (probx >= 0.00056 && probx < 0.00100) gdecile = 8;
        if (probx >= 0.00037 && probx < 0.00056) gdecile = 9;
        if (probx < 0.00037) gdecile = 10;
        string reg=(Region!=null && Region!='' && Region.trim()!=null && Region.trim()!='')?Region.trim().tolowercase():Region;
        if(reg =='africa') 
        {
            if(probx >= 0.03184) Africadecile = 'A';
            if(probx >= 0.01967 && probx < 0.03184) Africadecile = 'B';
            if(probx >= 0.01256 && probx < 0.01967) Africadecile = 'C';
            if(probx >= 0.00931 && probx < 0.01256) Africadecile = 'D';
            if(probx >= 0.00688 && probx < 0.00931) Africadecile = 'E';
            if(probx >= 0.00493 && probx < 0.00688) Africadecile = 'F';
            if(probx >= 0.00352 && probx < 0.00493) Africadecile = 'G';
            if(probx >= 0.00235 && probx < 0.00352) Africadecile = 'H';
            if(probx >= 0.00149 && probx < 0.00235) Africadecile = 'I';
            if(probx < 0.00149) Africadecile = 'J';         
        }
        else if(reg =='asia') 
        {
            if(probx >=  0.00931) Asiadecile = 'A';
            if(probx >=  0.00508 && probx < 0.00931) Asiadecile = 'B';
            if(probx >=  0.00321 && probx < 0.00508) Asiadecile = 'C';
            if(probx >=  0.00212 && probx < 0.00321) Asiadecile = 'D';
            if(probx >=  0.00147 && probx < 0.00212) Asiadecile = 'E';
            if(probx >=  0.00129 && probx < 0.00147) Asiadecile = 'F';
            if(probx >=  0.00072 && probx < 0.00129) Asiadecile = 'G';
            if(probx >=  0.00047 && probx < 0.00072) Asiadecile = 'H';
            if(probx >=  0.00026 && probx < 0.00047) Asiadecile = 'I';
            if( probx < 0.00026) Asiadecile = 'J';          
        }
        else if(reg =='lat am') 
        {
            if(probx >=  0.02875) LatAmdecile  = 'A';
            if(probx >=  0.01471 && probx < 0.02875) LatAmdecile  = 'B';
            if(probx >=  0.00895 && probx < 0.01471) LatAmdecile  = 'C';
            if(probx >=  0.00551 && probx < 0.00895) LatAmdecile  = 'D';
            if(probx >=  0.00352 && probx <  0.00551) LatAmdecile  = 'E';
            if(probx >=  0.00231 && probx < 0.00352) LatAmdecile  = 'F';
            if(probx >=  0.00158 && probx < 0.00231) LatAmdecile  = 'G';
            if(probx >=  0.00091 && probx < 0.00158) LatAmdecile  = 'H';
            if(probx >=  0.00044 && probx < 0.00091) LatAmdecile  = 'I';
            if( probx < 0.00044) LatAmdecile  = 'J';            
        }
        else if(reg =='lon eur') 
        {
            if(probx >=  0.02694) LonEurdecile  = 'A';
            if(probx >=  0.01736 && probx < 0.02694) LonEurdecile  = 'B';
            if(probx >=  0.01375 && probx < 0.01736) LonEurdecile  = 'C';
            if(probx >=  0.00986 && probx < 0.01375) LonEurdecile  = 'D';
            if(probx >=  0.00658 && probx < 0.00986) LonEurdecile  = 'E';
            if(probx >=  0.00498 && probx < 0.00658) LonEurdecile  = 'F';
            if(probx >=  0.00316 && probx < 0.00498) LonEurdecile  = 'G';
            if(probx >=  0.00217 && probx < 0.00316) LonEurdecile  = 'H';
            if(probx >=  0.00144 && probx < 0.00217) LonEurdecile  = 'I';
            if( probx < 0.00144) LonEurdecile  = 'J';           
        }
        else if(reg =='luz eur') 
        {
            if(probx >=  0.02062) LuzEurdecile  = 'A';
            if(probx >=  0.01376 && probx < 0.02062) LuzEurdecile  = 'B';
            if(probx >=  0.01078 && probx < 0.01376) LuzEurdecile  = 'C';
            if(probx >=  0.00780 && probx < 0.01078) LuzEurdecile  = 'D';
            if(probx >=  0.00571 && probx < 0.00780) LuzEurdecile  = 'E';
            if(probx >=  0.00415 && probx < 0.00571) LuzEurdecile  = 'F';
            if(probx >=  0.00297 && probx < 0.00415) LuzEurdecile  = 'G';
            if(probx >=  0.00199 && probx < 0.00297) LuzEurdecile  = 'H';
            if(probx >=  0.00144 && probx < 0.00199) LuzEurdecile  = 'I';
            if( probx < 0.00144) LuzEurdecile  = 'J';           
        }
        else if(reg =='middle east') 
        {
            if(probx >=  0.01859) MidEastdecile  = 'A';
            if(probx >=  0.01256 && probx < 0.01859) MidEastdecile  = 'B';
            if(probx >=  0.01051 && probx < 0.01256) MidEastdecile  = 'C';
            if(probx >=  0.00753 && probx < 0.01051) MidEastdecile  = 'D';
            if(probx >=  0.00518 && probx < 0.00753) MidEastdecile  = 'E';
            if(probx >=  0.00336 && probx < 0.00518) MidEastdecile  = 'F';
            if(probx >=  0.00210 && probx < 0.00336) MidEastdecile  = 'G';
            if(probx >=  0.00158 && probx < 0.00210) MidEastdecile  = 'H';
            if(probx >=  0.00099 && probx < 0.00158) MidEastdecile  = 'I';
            if( probx < 0.00099) MidEastdecile  = 'J';
        }
        else if(reg =='north am') 
        {
            if(probx >=  0.00589) NorthAmdecile = 'A';
            if(probx >=  0.00372 && probx < 0.00589) NorthAmdecile = 'B';
            if(probx >=  0.00255 && probx < 0.00372) NorthAmdecile = 'C';
            if(probx >=  0.00188 && probx < 0.00255) NorthAmdecile = 'D';
            if(probx >=  0.00104 && probx < 0.00188) NorthAmdecile = 'E';
            if(probx >=  0.00056 && probx < 0.00104) NorthAmdecile = 'F';
            if(probx >=  0.00053 && probx < 0.00056) NorthAmdecile = 'G';
            if(probx >=  0.00044 && probx < 0.00053) NorthAmdecile = 'H';
            if(probx >=  0.00028 && probx < 0.00044) NorthAmdecile = 'I';
            if( probx < 0.00028) NorthAmdecile = 'J';
        }
        else if(reg =='south asia') 
        {
            if(probx >=  0.01067) SouthAsiadecile = 'A';
            if(probx >=  0.00923 && probx < 0.01067) SouthAsiadecile = 'B';
            if(probx >=  0.00728 && probx < 0.00923) SouthAsiadecile = 'C';
            if(probx >=  0.00584 && probx < 0.00728) SouthAsiadecile = 'D';
            if(probx >=  0.00410 && probx < 0.00584) SouthAsiadecile = 'E';
            if(probx >=  0.00333 && probx < 0.00410) SouthAsiadecile = 'F';
            if(probx >=  0.00208 && probx < 0.00333) SouthAsiadecile = 'G';
            if(probx >=  0.00106 && probx < 0.00208) SouthAsiadecile = 'H';
            if(probx >=  0.00077 && probx < 0.00106) SouthAsiadecile = 'I';
            if( probx < 0.00077) SouthAsiadecile = 'J';
        }
        return null;
    }
}