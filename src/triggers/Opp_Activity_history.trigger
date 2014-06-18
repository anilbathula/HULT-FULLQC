/*
Created By   :- Premanath Reddy
Created Date :- 2/19/13
Pupose       :- creates an Activity History of the record type ‘Visa Process’ whenever the ‘Visa Related Sub-Stages’
                 picklist is changed to a value (different than none/blank).
Test class   :- AdmissionsEndorsedConf_Test
Code coverage:- 100 %
Last Modified : Prem 28/10/2013 Replaced with RecordTypeHelper class instead of using the Query for Record Type for getting id.
*/
trigger Opp_Activity_history on Opportunity (after update) {
    // it is calling staticFlag class
    if(staticFlag.Opp_Activity_hist){
        staticFlag.Opp_Activity_hist = false;
        List<Task> tsk=New List<Task>();
        List<String> ids=new List<String>();
                
        for(Opportunity opp:Trigger.New){
            //System.Debug(Trigger.NewMap.get(opp.id).Visa_Related_Sub_Stages__c+'=============='+Trigger.oldMap.get(opp.id).Visa_Related_Sub_Stages__c);
            if(Trigger.NewMap.get(opp.id).Visa_Related_Sub_Stages__c!=Trigger.oldMap.get(opp.id).Visa_Related_Sub_Stages__c 
               && Trigger.NewMap.get(opp.id).Visa_Related_Sub_Stages__c!=null){
                ids.add(opp.id);
            }
            
        }
        system.debug(ids);
        if(!ids.isEmpty()){
            //RecordType Rec = [Select id, name From RecordType where Name='Visa Process'];
            String rec=RecordTypeHelper.getRecordTypeId('Task','Visa Process');
            for(integer i=0;i<ids.size();i++){
                Task t=New Task();
                t.RecordTypeid=rec;
                t.OwnerID=userInfo.getUserId();
                t.Status='Completed';
                t.WhatId=Trigger.NewMap.get(ids[i]).id;
                t.whoId=Trigger.NewMap.get(ids[i]).contact__c;
                t.Priority='Normal';
                t.subject=Trigger.NewMap.get(ids[i]).Visa_Related_Sub_Stages__c;
                tsk.add(t);
                system.debug(t);
            }
            system.debug(tsk);
            try{
                insert tsk;
            }
            catch(Exception e){}
       }         
           
    }
}