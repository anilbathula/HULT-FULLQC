/*
Author          : Premanath Reddy
created Date    : 12/14/2012    
Purpouse        : To prevent users who don’t have a profile 9.1 HULTIndirect Agent Manager and 6. HULT Global and Regional Heads
                  and System Admin from select/deselect Lead Source = Agent on the Applicant object when the Stage on related Opportunity is
                  not "Qualified Lead" or "In Progress".
                  And 6. HULT Global and Regional Heads (or) 9.1 HULT Indirect (or ) System Administrator --
                  can only select Lead Source=Agent if the checkbox  ‘I confirm proof of Agent relationship’ is checked.
Test Class      : prevent_AgentLeadSource_Test
code coverage   : 100%

Modified by : Premanath Reddy
purpouse    : Because profile 6. HULT Global and Regional Heads split into two parts '6. HULT Global Heads' and '6.1 HULT Regional Heads'
       
Last Modified : Prem 28/10/2013 updated the code for changing the profile Name from 9.1 HULT Indirect Agent Manager to 9.1 HULT Indirect   
*/
trigger prevent_AgentLeadSource on Contact (before update) {
    set<String> accepted_profiles=new set<String>{'6. HULT Global Heads','6.1 HULT Regional Heads','9.1 HULT Indirect','System Administrator'}; 
    List<ID> conids=new List<ID>();
    for(Contact con:Trigger.New){
        if(Trigger.NewMap.get(con.id).LeadSource!=Trigger.oldMap.get(con.id).LeadSource
           && (Trigger.NewMap.get(con.id).LeadSource=='Agent' || Trigger.OldMap.get(con.id).LeadSource=='Agent')){
           conids.add(con.id);
        }
    }
    if(!conids.isEmpty()){
        String s = RecordTypeHelper.getprofilename(userinfo.getProfileId());
        List<Opportunity> opp=[select id,Name,StageName,Contact__c from Opportunity where Contact__c in:conids];
        
        Map<ID,Opportunity> varmap=new Map<ID,Opportunity>();
        for(integer i=0;i<opp.size();i++){
            varmap.put(opp[i].Contact__c,opp[i]);
        }
        Integer i=0;
        for(string c:conids)
        {  //System.Debug('******************************'+Trigger.NewMap.get(c).LeadSource);
            if(varmap.containsKey(c)){
                Opportunity o=varmap.get(c); 
                if(accepted_profiles.contains(s) && o.StageName!='Qualified Lead' && o.StageName!='In Progress') 
                {
                   if(!Trigger.NewMap.get(c).I_confirm_proof_of_Agent_relationship__c)
                   {
                       if(Trigger.NewMap.get(c).LeadSource=='Agent'){
                           Trigger.New[i].addError('In order to select Agent as Lead Source you must contact your Regional or Global Head and confirm the relationship with the agent.');
                           i++;
                       }
                   }
                }
                else if(o.StageName!='Qualified Lead' && o.StageName!='In Progress')
                {
                   if(Trigger.NewMap.get(c).LeadSource=='Agent'){
                       Trigger.New[i].addError('In order to select Agent as Lead Source you must contact your Regional or Global Head and confirm the relationship with the agent.');
                       i++;
                   }
                   else if(Trigger.OldMap.get(c).LeadSource=='Agent'){
                       Trigger.New[i].addError('You cannot unselect Lead Source = Agent.  Please contact your Regional or Global Head.');
                       i++;
                   }
                }
            }
        }
    }
}