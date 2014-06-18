@isTest 
private class Contact_UpdateOpportunitiesTest
{
      
       static testmethod void test()
         {
           User[] newUser = [
            select Id, Name
              from User
              where Id != :UserInfo.getUserId()
              and IsActive = true
               and ContactId = null // no portal users
             limit 3
                             ];
        System.debug(':::::: Contact_UpdateOpportunitiesTest::newUser 1::===>' +newUser[0].Name);
        System.debug(':::::: Contact_UpdateOpportunitiesTest::newUser 2::===>' +newUser[1].Name);
        
        Country__c[] country = [
          Select Id 
          FROM Country__c
          WHERE Name = 'United States'
          limit 1
          ];
        
        if (newUser.size() == 0 || country.size() == 0)
          return; 
       
        Account account = new Account();
        account.Name = 'Account';
        insert account;
        
        Contact contact1 = new Contact();
        contact1.FirstName = 'FirstName1';
        contact1.LastName = 'LastName1';
        contact1.OwnerId = newUser[0].Id;
        contact1.Country_Of_Residence__c = country[0].Id;
        contact1.MailingCity = 'Holmdel';
        insert contact1;
        
        Opportunity opportunity = new Opportunity();
        opportunity.Name = 'Opportunity';
        opportunity.StageName = 'StageName';
        opportunity.AccountId = account.Id;
        opportunity.Contact__c = contact1.Id;
        opportunity.CloseDate = Date.today();
        opportunity.OwnerId = newUser[2].Id;
        insert opportunity;
        
        contact1.OwnerId = newUser[1].Id;
        update contact1;
        
        list<contact> lstc=new list<contact>();
        lstc.add(contact1);
        
        new Contact_UpdateOpportunities(new list<contact>(),lstc).execute();
            
                                    
        }
}