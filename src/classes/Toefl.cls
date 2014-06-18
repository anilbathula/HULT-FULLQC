public class Toefl{
    
    /*This method works for four parameters Gmail,Typefull,candidatecountry and years of experience)*/
    public static Decimal Toefl(String mail,String course,string education,String Countryofcitizenship,String Language,String Degree,String Reason){
     
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
        
        
        /****This is return value for gmail*****/   
        Integer gmail=0;
            if((mail!=null&&mail!='') && mail.trim()!=null && mail.endswith('@gmail.com')){
                gmail=1;               
             }
        
        /****This is return value for course*****/ 
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
        
        /****This is return value for Education level*****/ 
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
          //System.debug('---------->'+Edu);
          currentedlev=currenteducationlevel.get(Edu); 
               
        /****This is return value for Country of citizenship*****/   
        String CtyCode=(Countryofcitizenship==null||Countryofcitizenship=='')?'null': Countryofcitizenship.toLowerCase(); 
        citchina=ctycode=='china, people\'s republic of'?1:0;    
        
        /****This is return value for Native Language*****/ 
        String Native_language=(Language==null||language=='')?'null':language.toLowerCase();                                                    
        korean=Native_language=='korean'?1:0;
        
        /****This is return value for uk us pursuit*****/ 
        String countryofdegree=(Degree==null||Degree=='')?'null':Degree.toLowerCase();
        uspursuit=countryofdegree=='united states'?1:0;
        ukpursuit=countryofdegree=='united kingdom'?1:0;
        matchcat=countryofdegree=='not answered'||countryofdegree==''?3:matchcat;
        
         /****This is return value for reason value*****/ 
         String reasonfortakingtoefl=(reason==null||reason=='')?'null':reason.toLowerCase();
         toeflbus=reasonfortakingtoefl=='to attend masters / grad post-grad business program'?1:0;
         toeflbus2=reasonfortakingtoefl=='to attend masters / grad postgrad business program'?1:0; 
         toeflenglish=reasonfortakingtoefl=='to attend an english language school or program'?1:0;
         toeflbusiness=(toeflbus==1||toeflbus2==1)?1:0;            
         
        /****This is return value for Match*****/  
        Set<String>country_code=new set<String>{'united states','china','korea, republic of','russian federation'};   
        Match=country_code.contains(countryofdegree)?1:0;
        
        if(Match==1){
            matchcat=2;
        }     
     
      /****This is return value for Matchcat1*****/
      
      if(Matchcat==1){
          matchcat1 = 1;
      }
      if(Matchcat==2){
          matchcat2 = 1;
      }
     
          
    System.debug('----> courseval'+courseval);
    System.debug('----> prefmajcat0=0'+prefmajcat0);
    System.debug('----> prefmajcat1=0'+prefmajcat1);
    System.debug('----> prefmajcat2=0'+prefmajcat2);
    System.debug('----> prefmajcat3=0'+prefmajcat3);
    System.debug('----> prefmajcat4=0'+prefmajcat4);
    System.debug('----> prefmajcat5=0'+prefmajcat5);
    System.debug('----> prefmajcat6=0'+prefmajcat6);
    System.debug('----> prefmajcat7=0'+prefmajcat7);
    System.debug('----> Educationval'+currentedlev);
    System.debug('----> citchina = 0'+citchina);
    System.debug('----> nativelanguage = 0'+korean);
    System.debug('----> ukpursuit = 0'+ukpursuit);
    System.debug('----> uspursuit = 0'+uspursuit);
    System.debug('----> toeflbus = 0'+toeflbus);
    System.debug('----> toeflbus2 = 0'+toeflbus2);
    System.debug('----> toeflenglish = 0'+toeflenglish);
    System.debug('----> toeflBusiness = 0'+toeflBusiness);
    System.debug('----> Match=0'+Match);
    System.debug('----> Matchcat=1'+Matchcat);
    System.debug('----> Matchcat1=0'+Matchcat1);
    System.debug('----> Matchcat2=0'+Matchcat2);
      
      
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
 }