/*
Author          : Premanath Reddy
created Date    : 19/08/2013    
Purpouse        : Chainging the record Type Based on Stage Name.
Modified By     :Anil.B 15/11/2013 ------JIRA No:::SFSUP-672.

*/
trigger opp_recordtype on Opportunity (before insert,before update) {
    Map<String,String> rectypes=new Map<String,String>();
    rectypes.put('Qualified Lead','Qualified Lead');
    rectypes.put('In Progress','In Progress');
    rectypes.put('Partial Application','Partial & W-W');
    rectypes.put('Waiting for Review','Partial & W-W');
    rectypes.put('Withdrawn','Partial & W-W');
    rectypes.put('Accepted','Accepted & R');
    rectypes.put('Admissions Endorsed','Accepted & R');
    rectypes.put('Conditionally Accepted','Accepted & R');
    rectypes.put('Rejected','Accepted & R');
    rectypes.put('Soft Rejected','Accepted & R');
    rectypes.put('Soft Rejected Confirmed','Confirmation & CAX-D');
    rectypes.put('Confirmed','Confirmation & CAX-D');
    rectypes.put('Admissions Endorsed Confirmed','Confirmation & CAX-D');
    rectypes.put('Conditionally Confirmed','Confirmation & CAX-D');
    rectypes.put('Cancellation','Confirmation & CAX-D');
    rectypes.put('Deferral','Confirmation & CAX-D');
    
    for(Opportunity opp:Trigger.New){
        if(rectypes.containsKey(opp.StageName) && (Trigger.isInsert || (Trigger.isUpdate && Trigger.NewMap.get(opp.id).StageName!=Trigger.oldMap.get(opp.id).StageName))){
            String recid=RecordTypeHelper.getRecordTypeId('Opportunity',rectypes.get(opp.StageName));
            //System.Debug(rectypes.get(opp.StageName)+'================>'+recid);
            opp.RecordTypeId=recid;
        }
        
    }
}