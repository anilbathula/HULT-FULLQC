/*
    Trigger   : Opportunity2Contact
    Events    : After insert & Update on Opportunity  
    Developer : Harsha Simha S
    Date      : 8/10/2013
    Comment   : This Trigger will sync some of the Opportunity fields with Contact
                fields: Program, Start Term, Stage, Substage, Owner, Percent Complete, Partial Application Date, Linked In Status.
    Test Class:      
*/ 

trigger Opportunity2Contact on Opportunity (after insert, after update) 
{	
	list<string> sync_opps=new list<string>();
	map<string,string> opp_cons=new map<string,string>();
	for(Opportunity newopp:Trigger.new)
	{
		if(newopp.Contact__c==null)
        	continue;
		
		boolean createmsg=false;
        Opportunity oldopp=new Opportunity();
        if(Trigger.isAfter)
        	oldopp=Trigger.oldMap.get(newopp.Id);
        if(newopp.Contact__c!=oldopp.Contact__c)
        	createmsg=true;	
        if(newopp.Linked_In_Status_New__c!=oldopp.Linked_In_Status_New__c)	
        	createmsg=true;
        if(newopp.Application_Substage__c!=oldopp.Application_Substage__c)	
        	createmsg=true;
        if(newopp.Percent_Complete__c!=oldopp.Percent_Complete__c)	
        	createmsg=true;
        if(newopp.Partial_Application_Date__c!=oldopp.Partial_Application_Date__c)	
        	createmsg=true;	
        if(newopp.StageName!=oldopp.StageName)
        	createmsg=true;
        if(newopp.Start_Term__c!=oldopp.Start_Term__c)
        	createmsg=true;
        if(newopp.Program__c!=oldopp.Program__c)
        	createmsg=true;
        if(Trigger.isUpdate && newopp.OwnerId!=oldopp.OwnerId)
        	createmsg=true;
        			
        if(createmsg)
        {
        	sync_opps.add(newopp.Contact__c);
        	opp_cons.put(newopp.Contact__c,newopp.Id);
        }			
	}
	
	if(!sync_opps.IsEmpty())
	{
		List<Contact> updcons=new List<Contact>();
		List<Opportunity> opps=[select id,Name,Contact__c,Contact__r.Stage__c,Contact__r.OwnerId,Contact__r.Start_Term__c,Contact__r.Program_Primary__c,Contact__r.Linked_In_Status__c,Contact__r.Application_Sub_Stage__c,Contact__r.Partial_Application_Date__c,Contact__r.Percentage_Completed__c from Opportunity where id IN: sync_opps];
		if(!opps.IsEmpty())
		{
			for(Opportunity o:opps)
			{
				boolean addopp=false;
				Contact c=new Contact(Id=o.Contact__c);			
				if(o.Contact__r.Linked_In_Status__c!=Trigger.newMap.get(o.Id).Linked_In_Status_New__c)
				{
					c.Linked_In_Status__c=Trigger.newMap.get(o.Id).Linked_In_Status_New__c;
					addopp=true;
				}
				if(o.Contact__r.Application_Sub_Stage__c!=Trigger.newMap.get(o.Id).Application_Substage__c)
				{
					c.Application_Sub_Stage__c=Trigger.newMap.get(o.Id).Application_Substage__c;
					addopp=true;
				}
				if(o.Contact__r.Partial_Application_Date__c!=Trigger.newMap.get(o.Id).Partial_Application_Date__c)
				{
					c.Partial_Application_Date__c=Trigger.newMap.get(o.Id).Partial_Application_Date__c;
					addopp=true;
				}
				if(o.Contact__r.Percentage_Completed__c!=Trigger.newMap.get(o.Id).Percent_Complete__c)
				{
					c.Percentage_Completed__c=Trigger.newMap.get(o.Id).Percent_Complete__c==null?0:Trigger.newMap.get(o.Id).Percent_Complete__c;  
					addopp=true;
				}
				if(o.Contact__r.Stage__c!=Trigger.newMap.get(o.Id).StageName)
				{
					c.Stage__c=Trigger.isInsert?'Qualified Lead':Trigger.newMap.get(o.Id).StageName;  
					addopp=true;
				}
				if(o.Contact__r.Start_Term__c!=Trigger.newMap.get(o.Id).Start_Term__c)
				{
					c.Start_Term__c=Trigger.newMap.get(o.Id).Start_Term__c;  
					addopp=true;
				}
				if(o.Contact__r.Program_Primary__c!=Trigger.newMap.get(o.Id).Program__c)
				{
					c.Program_Primary__c=Trigger.newMap.get(o.Id).Program__c;  
					addopp=true;
				}
				if(Trigger.isUpdate && o.Contact__r.OwnerId!=Trigger.newMap.get(o.Id).OwnerId)
				{
					c.OwnerId=Trigger.newMap.get(o.Id).OwnerId;  
					addopp=true;
				}
					
				if(addopp)
				{
					updcons.add(c);
				}
			}
			if(updcons.IsEmpty())
			{
				try
				{
					update updcons;
				}
				catch(Exception e)
				{
					System.debug(e);
				}
			}
		}		
	}
}