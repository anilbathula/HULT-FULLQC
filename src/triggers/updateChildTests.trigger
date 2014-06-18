// Trigger to update Test records associated to an Opportunity when the stage is changed.
/*****************
Modified By:-Anil.B on 15/11/2013-----JIRA No:::SFSUP-672.
******************/

trigger updateChildTests on Opportunity (before update) {
   //  integer i;
     List<Exam__c> oppTest = new List<Exam__c>();
     List<Opportunity> opp = Trigger.new;
     list<string> oppid=new list<string>();
     /*
     Harsha - 7/17/12
     only when stage name field is changed and it is equal to Admission Endorsed/Admission Endorsed Confirmed 
     then update each exam record under it with Application_Stage_Auto_Update_FLAG__c = TRUE
     */
     for(opportunity opps:Trigger.new)
     {
        if ((opps.StageName == 'Admissions Endorsed' || opps.StageName == 'Admissions Endorsed Confirmed'||opps.StageName == 'Conditionally Confirmed'||opps.StageName == 'Conditionally Accepted'||opps.StageName == 'Soft Rejected Confirmed')&&(opps.StageName!=Trigger.oldMap.get(opps.Id).StageName))
        {   
            oppid.add(opps.Id);
        }
     }
     
     oppTest = [select id, Planned_Test_Date__c,Application_Stage_Auto_Update_FLAG__c from Exam__c where Application__c In:oppid];
     if(!opptest.ISempty())
     {
         for(integer i=0;i<oppTest.size();i++)     
         {
            oppTest[i].Application_Stage_Auto_Update_FLAG__c = TRUE;   
         }
         try
         {
            update oppTest;             
         }
         catch(System.DmlException e)
         {
            Trigger.new[0].adderror(e);
           // Trigger.new[i].adderror(e.getDmlMessage(i));
         }
     }
     /*//commented by Harsha - EF 7/17/2012 
     for(i=0;i<opp.size();i++){           
         if (opp[i].StageName == 'Admissions Endorsed' || opp[i].StageName == 'Admissions Endorsed Confirmed') {
             oppTest = [select id, Planned_Test_Date__c from Exam__c where Application__c=:opp[i].id];
             for(Exam__c t: oppTest){
                 t.Application_Stage_Auto_Update_FLAG__c = TRUE;   
                 }}  
             try{
                 update oppTest;             
             }
             catch(System.DmlException e){
                 Trigger.new[i].adderror(e.getDmlMessage(i));
             }
     }*/
}