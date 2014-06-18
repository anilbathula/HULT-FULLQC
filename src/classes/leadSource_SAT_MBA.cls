public class leadSource_SAT_MBA{
    /***************SAT_Model**************************************************************/
    public static Decimal SAT_model(String Countries,String Yahoo,String age,String Region,Integer Major1,Integer Major2,Integer Major3,Integer Major4,Integer Major5){
    
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
        
         /*********return value of Country***********/
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
        
        /*********return value of yahoo***********/
        Integer y=0;
            if((yahoo!=null||yahoo!='') &&yahoo.trim()!=null && yahoo.endswith('@yahoo.com')){
                y=1;
                system.debug('==g=>'+yahoo);
            }
        
        
        /*********return value of age***********/
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
           
       
            
            
       /*************return region values**********/
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
    
  /**************Major Values**********************/  
    
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
           
    
  /***** This is to calculate x value*************/ 
  
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

    /***** This is to calculate Probability value*************/
    
      Decimal probx=(1/(1+Math.exp(-x)));
    
       return null;
    
    } 
    }