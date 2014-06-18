@isTest
    private class workflow2trigger_test{

        
        
        public static testMethod void workflow2trigger() {
        
        Test.Starttest();
        Program__c objPgm = new Program__c(Name = 'Bachelor of International Business Administration-UK-London',Campus__c='London');
        insert objPgm;
        
        
    
        Contact contact = new Contact();
        Contact objCon = new Contact();
        objcon.LastName='LastName';
        objcon.Applicant_Email__c='test@test1234email.com';
        objcon.Program_Primary__c=objPgm.Id;
        insert objCon;      
        
        Opportunity opp= new Opportunity();
        opp.Name='OpportunityName';
        opp.StageName = 'Confirmed';
        opp.Contact__c=objCon.id;
        opp.CloseDate = System.today();
        opp.Primary_Campus__c='London';
        opp.Program__c =objPgm.Id;
        insert opp;
       
        
        
        opp.Confirmation_Activity__c='LDN BBA accomodation booking form for Confirmed';
        opp.Accommodation_Student_Status__c='Hult Prospective Student';        
        update opp;
       
        
        
        test.stopTest();
        
        }
    }