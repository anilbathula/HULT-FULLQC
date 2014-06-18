trigger Con_LeadScoring on Contact (before insert) {
        
        String typeful;
        String worldregion;
        Integer worldregionid;
        
        
     If(Trigger.isBefore && Trigger.isInsert ){
        For(Contact con:trigger.new){ 
            
           If(con.LeadSource=='GMASS'){ 
            worldregion=con.World_Region__c!=NULL && con.World_Region__c!=''?con.World_Region__c:'';
            worldregionid=Integer.valueof(con.World_Region_ID__c);
            String regionvalues =con.Region_Values__c!=Null && con.Region_Values__c!=''?con.Region_Values__c:'';
            String region=con.region__c!=NULL&&con.Region__c!=''?con.Region__c:'';  
            
            leadSource_QS_MBA LQ=new leadSource_QS_MBA();
            leadSource_QS_MBA.lead_score_respone ls=new leadSource_QS_MBA.lead_score_respone();
            ls=LQ.gmass_Model(worldregion,con.Country_Of_Residence_Name__c,con.Degree_Objective__c,con.Work_Load__c,regionvalues,worldregionid,Region);
            con.Conversion_Probability__c=ls.GMASS_MBA_probx;
            con.Global_Lead_Score__c=ls.GMASS_MBA_Total;
            }
            
        }
     }
}