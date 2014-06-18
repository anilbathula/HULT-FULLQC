/*
Last Modified : Prem 28/10/2013  Replaced with RecordTypeHelper class instead of using the Query for Profile to get the Current login user Profile Name. 
*/
trigger Event_Allow_admins_change on Event (before insert, before update) 
{
   
    //list<Profile> prf=[select id,Name from profile where id=:Userinfo.getProfileId()];
    String prf=RecordTypeHelper.getprofilename(userinfo.getProfileId());
    if(prf!=null && prf=='System Administrator')
    {
        for(Event e:Trigger.new)
        {           
            e.Event_RequiredField__c=true;
        }
    }
}