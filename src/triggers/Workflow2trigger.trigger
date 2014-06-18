/*******************************************************
Trigger   : workflow2trigger
Developer : Anil.B
Purpose   : To deactivate some workflows and use those 
workflow functionality in this trigger becoz of workflow
limits reached to maximum.
Test Class :workflow2trigger_Test(100%)

Ammendments : 
    
    Developer : Harsha Simha S
    Date      : 6/10/2014
    Comment   : This trigger fires when ever there is a change in the opportunity Campus,program,Start Term,Stage for 2014 start term and confirmed/.. stages. 
                And checks if any records exist then pass the values to HultAPI_calls_from_trigger.CreateApplicant_inCAMS class.(added after update to trigger )
    TestClass : contact2opportunity_test(75%)
    
********************************************************/


trigger Workflow2trigger on Opportunity (before update,after update) {
    
    list<string> oppids=new list<string>();
     for(Opportunity opp:Trigger.New){

            Opportunity oldopp=Trigger.oldmap.get(opp.id); 
            if(trigger.Isbefore)
            {
                System.debug('--->'+opp.Program_Parsed__c +'---->'+opp.Accommodation_Status__c+'--->'+oldopp.Confirmation_Activity__c);
                /*Workflow::Set Accommodation Stage to 1*/
                if( opp.Confirmation_Activity__c!=oldopp.Confirmation_Activity__c&&opp.Program_Parsed__c =='BIBA' && (opp.Confirmation_Activity__c=='LDN BBA accomodation booking form for Confirmed'||opp.Confirmation_Activity__c=='SFO BBA accomodation booking form for Confirmed') ){
                    opp.Accommodation_Status__c='1. Recruiter presented Hult accom.';
                    opp.Accom_Stage_1_date_time__c=system.now();            
                }
                 /*Workflow::Set Accommodation Stage to 3 */
                if(opp.Accommodation_Student_Status__c!=Null && opp.Accommodation_Student_Status__c!=oldopp.Accommodation_Student_Status__c && opp.Program_Parsed__c =='BIBA'){
                    opp.Accommodation_Status__c='3. Accom. booked (not paid yet)'; 
                    opp.Accom_Stage_3_date_time__c=system.now();  
                }
            }
            /*6/10/2014 by shs Start Hult cams APIcallout Logic*/
            if(trigger.Isafter)
            {
                if(opp.Start_Term__c=='September 2014' && (opp.StageName=='Confirmed'||opp.StageName=='Conditionally Confirmed'||opp.StageName=='Soft Rejected Confirmed'))
                {
                    if(opp.Primary_Campus__c!=oldopp.Primary_Campus__c || opp.StageName!=oldopp.StageName || opp.Start_Term__c!=oldopp.Start_Term__c 
                       || opp.Program__c!=oldopp.Program__c)
                    oppids.add(opp.Id);
                }
            }    /*End Hult cams APIcallout Logic*/                
     }
     
    if(!oppids.IsEmpty())
    {
        HultAPI_calls_from_trigger.CreateApplicant_inCAMS(oppids);    
    }
}