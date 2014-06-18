trigger Opportunity_UpdateRequirements on Opportunity (after insert, after update) 
{
    
    /*
        Code Modified By : Niket Chandane
        Modified date    : 4 April 2012
        Summary          : Opportunity_UpdateRequirements trigger executing unnecessary to avoid 
                            extra operation added if condition and condition to check program change
        
        Changes By     : Harsha Simha S
        Change Date     : 19/4/2013
        Summary       : Modified condition on update -- when stage is changed to current year (after october current year = next year ). 
                  old: When update requirements is true trigger fires (every time when checbox is true trigger fires)
                  New: only when   update requirements  is changed to true from false triggger fires                      
    */
    if(Trigger.isAfter && Trigger.isUpdate)
    {
      Integer curr_year=system.today().year();
      if(System.today().month()>9)
        curr_year=system.today().year()+1;
        
        for(Opportunity objOpp : trigger.new)
        {                    
            Opportunity objOldOpp = trigger.OldMap.get(objOpp.Id);
            if(objOpp.Program__c != objOldOpp.Program__c || (objOpp.Update_Requirements__c && objOpp.Update_Requirements__c!=Trigger.oldMap.get(objopp.Id).Update_Requirements__c) ||(objOpp.Start_Term__c!=Trigger.oldMap.get(objopp.Id).Start_Term__c && (objOpp.Start_Term__c.contains(''+curr_year) || objOpp.Start_Term__c.contains(''+(curr_year+1)))) )  //By Sachin Bhadane for Hult#105 ::Added Extra condition "objOpp.Update_Requirements__c == true" 
            {
                // We need to call Update reqirement when program is get updated
                new Opportunity_UpdateRequirements(trigger.old, trigger.new).execute();
            }
        }
        
    }
    else if(Trigger.isAfter && Trigger.isInsert)
        new Opportunity_UpdateRequirements(trigger.old, trigger.new).execute();
}