trigger Opportunity_UpdateFTN on Opportunity (after update) 
{
    if(Trigger.isUpdate)
    {
        SET<ID> oppids = new SET<ID>();
        for(Opportunity objOpp : trigger.new)
        {
            Opportunity objOldOpp = trigger.OldMap.get(objOpp.Id);
            if((objOpp.Primary_Program_Choice__c != objOldOpp.Primary_Program_Choice__c)|| (objOpp.Primary_Campus__c != objOldOpp.Primary_Campus__c) ) 
            {
                oppids.add(objOpp.id);
                
                if(oppids.size()>0)
                {
                    try{
                    Opportunity_Finance__c financeObj=[select id,Opportunity__c from  Opportunity_Finance__c where Opportunity__c IN :oppids];
                    List <Finance_Transactions__c> financeTn=[select id,Finance__c from Finance_Transactions__c where Finance__c=:financeObj.id];
                    update financeTn;
                }catch(Exception e){}
                }
            }
        }
        
    }
}