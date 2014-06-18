@IsTest 
public class Event_for_telesales_Test {   
  
      public static testmethod void Testevnt() {
        Country__c ctry=TestDataUtil.createCountry();
        insert ctry;
        
        Department__c dep=TestDataUtil.createDepartment();
        insert dep;
        
        Program__c pgm=TestDataUtil.createProgram(ctry.Id, dep.Id);
        insert pgm; 
        
        Lead led=TestDataUtil.createLead(ctry.Id,pgm.Id);
        led.Applicant_Email__c='testerdasdfasdf@test.com';
        led.LeadSource='GMASS';
        insert led;
        led.Lead_Stage__c='Interested';
        update led;
      }
}