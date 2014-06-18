public with sharing class contact2opportunity_servicer {
	//not using this class included every thing in trigger.
	public static void processmessages(rC_Messaging__Message__c[] messageList)
	{
		Map<Id, Contact> contactMap = new Map<Id, Contact> {};        
        for(rC_Messaging__Message__c message : messageList) 
        {
            contactMap.put(message.rC_Messaging__Related_Record__c, null);
        }
        
        List<Opportunity> oppupdatelist=new List<opportunity>();
        Opportunity[] opportunityList = [select Contact__r.Program_Primary__c,Contact__r.OwnerId,Contact__r.Start_Term__c,Contact__r.Linked_In_Status__c, 
        								Program__c,OwnerId,Start_Term__c,Linked_In_Status_New__c from Opportunity where Contact__c in :contactMap.keySet() 
        								and Contact__c != null and IsClosed = false];
		
		for(opportunity opp:opportunityList)
		{
			boolean addopp=false;
			if(opp.Program__c!=opp.Contact__r.Program_Primary__c)
			{	
				opp.Program__c=opp.Contact__r.Program_Primary__c;
				addopp=true;
			}
			if(opp.OwnerId!=opp.Contact__r.OwnerId)
			{	
				opp.OwnerId=opp.Contact__r.OwnerId;
				addopp=true;
			}
			if(opp.Start_Term__c!=opp.Contact__r.Start_Term__c)
			{	
				opp.Start_Term__c=opp.Contact__r.Start_Term__c;
				addopp=true;
			}
			if(opp.Linked_In_Status_New__c!=opp.Contact__r.Linked_In_Status__c)
			{	
				opp.Linked_In_Status_New__c=opp.Contact__r.Linked_In_Status__c;
				addopp=true;
			}
			if(addopp)
				oppupdatelist.add(opp);
		}
		
		if(!oppupdatelist.IsEmpty())
		{
			try
			{
				update oppupdatelist;
			}
			catch(Exception e)
			{
				System.debug(e);
			}
		}
	}
}