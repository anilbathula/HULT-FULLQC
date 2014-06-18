/*
Author           : Premanath Reddy
Created Date     : 13/03/2014
Usage            : This trigger prevents user from creating duplicate records in Account 
                    if Same Name,Street and City already existing in Contact. 
Test class       : Account_rectype_Test (94% covered) 
*/
trigger set_uniqname on Account (before insert, before update) {
    
    Map<String,String> rectpmap=new Map<String,String>();
    List<String> rectype_lst=new List<String>{'Educational Institution','Partner'};
    for(integer i=0;i<rectype_lst.size();i++){
        rectpmap.put(RecordTypeHelper.getRecordTypeId('Account',rectype_lst[i]),rectype_lst[i]);
    }
    Map<id,id> accrectype=new Map<id,id>();
    Map<String,Account> uniqsmap=new Map<String,Account>();
    
    for(Account acc:Trigger.New){
        if(rectpmap.containsKey(acc.RecordTypeId)){
            if((acc.Duplicate_Prevent__c!= null) &&
                (System.Trigger.isInsert ||
                (acc.Duplicate_Prevent__c!=System.Trigger.oldMap.get(acc.Id).Duplicate_Prevent__c))) {
                //if we have Duplicate Emails among inserting records
                if(uniqsmap.containsKey(acc.Duplicate_Prevent__c)) {
                    acc.addError('Duplicate value on record,Account');
                }
                else{
                    uniqsmap.put(acc.Duplicate_Prevent__c, acc);
                }
            }
        }
    }
    
    if(!uniqsmap.isEmpty()){
        List<Account> acc=[SELECT id,Duplicate_Prevent__c,Name,Street__c,City__c,City__r.Name
                      FROM Account WHERE Duplicate_Prevent__c IN :uniqsmap.KeySet()
                      and recordtype.Name IN :rectype_lst];
        if(!acc.isEmpty()){
            for(Account Account :acc){
                Account newAccount = uniqsmap.get(Account.Duplicate_Prevent__c);
                newAccount.addError('Duplicate value on record'
                                                        +','+Account.ID
                                                        +','+Account.Name
                                                        +','+Account.Street__c
                                                        +','+Account.City__r.Name
                                                        +',Account');
                
            }
        }
    }
}