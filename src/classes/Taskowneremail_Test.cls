/***************************************************************************************
Class Name      : TaskOwneremail_Test
Author          : Anil.B
Usage           : This test class is for TaskOwneremail_Test.  
Code coverage   : 95%
Last Modified : Prem 30/10/2013  Replaced with RecordTypeHelper class instead of using the Query for Profile to get the user Profile Id.        
****************************************************************************************/



@isTest 
private class Taskowneremail_Test  { 

   static testMethod void Taskowneremail() {   
    //Profile p = [Select Id from profile WHERE name='System Administrator']; 
    String p=RecordTypeHelper.getprofileid('System Administrator');
    User usr = new User(alias = 'standt', email = 'test@9876test.com', 
                                  emailencodingkey = 'UTF-8', lastname = 'TestLasName', languagelocalekey = 'en_US', 
                                  localesidkey = 'en_US',
                                  timezonesidkey = 'America/Los_Angeles', Profileid=p, username = 'testUniqudeName@test.com');
                                  insert usr;       
              
                Contact Con = new contact(LastName='Testing1',FirstName='Apex'); 
                insert con; 
        Opportunity opp= new Opportunity();
        opp.Contact__c = con.Id;
        opp.Name='OpportunityName';
        opp.StageName = 'Qualified Lead';
        //opp.Application_Substage__c='AEC Quality - Low - Missing test date/proof of test';
        opp.Test_date_proof_of_test_not_submitted__c=false;
        opp.Accepted_Date__c=System.Today()+5;
        opp.CloseDate = System.today();
        insert opp;
  
       
                Task testTask = new Task(Subject='AD First Mailing General question +email',Whatid=opp.id,Ownerid=usr.id);              
                insert testTask; 
               
  } }