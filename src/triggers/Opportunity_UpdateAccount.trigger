trigger Opportunity_UpdateAccount on Opportunity (before insert, before update) {
//shs:: added to test opportunity stage before and after values  ( only for testing)
		for(Opportunity o:Trigger.New)
		{
			if(Trigger.isUpdate)
				System.debug(o.StageName+'====>>>>+++++'+Trigger.oldMap.get(o.id).stageName);
		}
		

//shs : added code to update recruiter field with owner Name
    new Opportunity_UpdateAccount(trigger.old, trigger.new).execute();    
}