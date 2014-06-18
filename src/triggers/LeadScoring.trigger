trigger LeadScoring on Lead (before insert) {
        
        String typeful;
        String worldregion;
        Integer worldregionid;
        
        
     If(Trigger.isBefore && Trigger.isInsert ){
        For(Lead ld:trigger.new){ 
            /*typeful=ld.Work_Load__c=='Full-time Student'?'Full-time':ld.Work_Load__c; 
            leadSource_QS_MBA LQ=new leadSource_QS_MBA();
            leadSource_QS_MBA.lead_score_respone ls=new leadSource_QS_MBA.lead_score_respone();
            ls=LQ.leadSource_QS_MBA(ld.email,typeful,ld.Country_Of_Residence_Name__c,ld.GMASS_Work_Experience__c);
            ld.QS_MBA_Score__c=ls.QS_MBA_probx;*/ 
           If(ld.LeadSource=='GMASS'){ 
            worldregion=ld.World_Region__c!=NULL&&ld.World_Region__c!=''?ld.World_Region__c:'';
            worldregionid=Integer.valueof(ld.World_Region_ID__c);
            String regionvalues =ld.Region_Values__c!=Null&&ld.Region_Values__c!=''?ld.Region_Values__c:'';
            String region=ld.Region__c!=null&&ld.Region__c!=''?ld.Region__c:'';
              
            
            leadSource_QS_MBA LQ=new leadSource_QS_MBA();
            leadSource_QS_MBA.lead_score_respone ls=new leadSource_QS_MBA.lead_score_respone();
            ls=LQ.gmass_Model(worldregion,ld.Country_Of_Residence_Name__c,ld.Degree_Objective__c,ld.Work_Load__c,regionvalues,worldregionid,region);
            ld.Conversion_Probability__c=ls.GMASS_MBA_probx;
            ld.Global_Lead_Score__c=ls.GMASS_MBA_Total;
            ld.Lead_Score__c=ls.GMASS_lead_score;
            }
            
        }
     }
     
     /*If(Trigger.isBefore && Trigger.isUpdate ){
        For(Lead ld:trigger.new){
             If(trigger.oldmap.get(ld.id).Email!=ld.Email||
                trigger.oldmap.get(ld.id).Country_Of_Residence_Name__c!=ld.Country_Of_Residence_Name__c ||
                trigger.oldmap.get(ld.id).GMASS_Work_Experience__c!=ld.GMASS_Work_Experience__c ||
                trigger.oldmap.get(ld.id).Work_Load__c!=ld.Work_Load__c){
            
                typeful=ld.Work_Load__c=='Full-time Student'?'Full-time':ld.Work_Load__c;
                
                ld.QS_MBA_Score__c =leadSource_QS_MBA.leadSource_QS_MBA(ld.email,typeful,ld.Country_Of_Residence_Name__c,ld.GMASS_Work_Experience__c); 
                system.debug('----->'+ld.QS_MBA_Score__c);  
             }      
        }
    }*/
}