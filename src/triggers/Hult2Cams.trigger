/*
    Trigger	  : Hult2Cams
    Developer : Harsha Simha S
    Date      : 6/10/2014
    Comment   : This trigger fires when ever there is a change in the contact First Name,Last Name, Date of birth, 
    			country of citizen ship,NickName for 2014 start term and confirmed/.. stages. 
    			And checks if any records exist then pass the values to HultAPI_calls_from_trigger.CreateApplicant_inCAMS class.
    TestClass : contact2opportunity_test(100%)
                
             
*/ 
trigger Hult2Cams on Contact (after update) 
{
    list<string> conids=new list<string>();
    for(Contact con:Trigger.New)
    {
        Contact oldcon=Trigger.oldmap.get(con.id); 
        
        System.debug(con.Start_Term__c+'========'+oldcon.LastName+'!='+con.LastName); 
         
        if(con.OP_Start_Term__c=='September 2014' || con.Start_Term__c=='September 2014')
        {
            if(oldcon.FirstName!=con.FirstName || oldcon.LastName!=con.LastName || 
                con.Date_of_Birth_c__c!=oldcon.Date_of_Birth_c__c || con.Nickname__c!=oldcon.Nickname__c ||
                con.Country_Of_Citizenship__c!=oldcon.Country_Of_Citizenship__c)
                {
                    conids.add(con.Id);
                }
        }
    }
    System.debug(conids.IsEmpty()+'=========='+conids);
    if(!conids.IsEmpty())
    {
        System.debug(conids.IsEmpty()+'=========='+conids);
        HultAPI_calls_from_trigger.CreateApplicant_inCAMS(conids);    
    }
}