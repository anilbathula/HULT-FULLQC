/*
      Developer : Harsha Simha
        Date    : 11/20/2012
                  When Program or Start Term Changes in Opportunity then Fee(lookup field in finance) is set to null,
                   so that Add_fee2finance trigger (before update) will set the new Fee value for the finance!   
      Test class: Fees_Test
      coverage  : 100%  
      Modified By: Prem 30/10/2013 :: When the program field is changed and the following conditions are met then the running trigger should follow the logic:
                                        1- PREVIOUS VALUE contains 'Dubai'
                                        2- NEW VALUE does not contain 'Dubai'
                                        then the field 'Visa Type Picklist' should become NULL in the Finance object.
*/
trigger Opp_changeFees_inFin on Opportunity (after update) 
{
    set<string> slctdopps=new set<string>(); 
    set<string> updtfin=new set<string>(); 
    for(Opportunity opp:Trigger.new)
    {
        if(opp.Program__c!=TRigger.oldMap.get(opp.Id).Program__c || opp.Start_Term__c !=TRigger.oldMap.get(opp.Id).Start_Term__c)
        {
            slctdopps.add(opp.Id);          
        }
        if(opp.Program__c!=Trigger.oldMap.get(opp.Id).Program__c && opp.Primary_Campus__c !='Dubai' && Trigger.oldMap.get(opp.Id).Primary_Campus__c=='Dubai')
        {
            updtfin.add(opp.Id);          
        }
        
    }
    if(!(slctdopps.IsEmpty() && updtfin.IsEmpty()))
    {
        List<Opportunity_Finance__c> oppfin=new List<Opportunity_Finance__c>();
        oppfin=[select id,Name,Fees__c,Opportunity__c,Visa_Type_Picklist__c from Opportunity_Finance__c where Opportunity__c IN:slctdopps or Opportunity__c IN:updtfin];
        if(!oppfin.IsEmpty())
        {
            for(integer i=0;i<oppfin.size();i++)
            {
                if(slctdopps.Contains(oppfin[0].Opportunity__c))
                    oppfin[i].Fees__c=null;
                if(updtfin.Contains(oppfin[0].Opportunity__c))   
                    oppfin[i].Visa_Type_Picklist__c=null; 
            }
            
            Database.update(oppfin);
        }
    }
    /*
    if(!updtfin.IsEmpty())
    {
        List<Opportunity_Finance__c> fin=new List<Opportunity_Finance__c>();
        List<Opportunity_Finance__c> oppfin=[select id,Name,Opportunity__c,Visa_Type_Picklist__c from Opportunity_Finance__c where Opportunity__c IN:updtfin];
        if(!oppfin.IsEmpty())
        {
            for(Opportunity_Finance__c f:oppfin)
            {
                f.Visa_Type_Picklist__c=null;
                fin.add(f);
            }
            Database.update(fin);
        }
    }*/
}