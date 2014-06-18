@isTest(SeeAllData=true)
    private class UpdateInstallmentPlan_TestClass {

       // public static final Program__c program1 = [select Id from Program__c where Name='EMBA-UK-London' limit 1]; 
       // public static final Program__c program2 = [select Id from Program__c Where Name='MSE-China-Shanghai' limit 1]; 
        
        public static testMethod void validate_UpdateInstallmentPlan() {
        
        Test.Starttest();
        Program__c objPgm = new Program__c(Name = 'MBA-UK-London',Campus__c='London');
        insert objPgm;
        
        Program__c objPgm2 = new Program__c(Name = 'MSE-China-Shanghai',Campus__c='Boston');
        insert objPgm2;
    
        Contact contact = new Contact();
        contact.FirstName = 'FirstName';
        contact.Start_Term__c = 'Jan 2011';
        contact.LastName = 'LastName';
        contact.Program_Primary__c = objPgm.Id;        
        insert contact;      
        
        Opportunity opportunity = new Opportunity();
        opportunity.Contact__c = contact.Id;
        opportunity.Name = 'OpportunityName';
        opportunity.StageName = 'StageName';
        opportunity.CloseDate = Date.today();
        opportunity.Program__c =objPgm.Id;
        system.debug('}}}}}}}}}}}})00000>'+opportunity.Program__c);
        insert opportunity;  
        
        opportunity.StageName ='Admissions Endorsed';
        opportunity.Program__c=objPgm2.Id; 
        system.debug('}}}}}}}}}}}}---->'+opportunity.Program__c);
        update opportunity;
       
        
        Opportunity_Finance__c fin = new Opportunity_Finance__c();
        fin.Opportunity__c = opportunity.id;                
        insert fin;      
        
      
          
        update fin;
        test.stopTest();
        
        }
    }