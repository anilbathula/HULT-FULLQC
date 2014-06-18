/*
Author    :- Premanath Reddy
Date      :- 3/14/2013
Usage     :- Test class for EmailNotification_user Trigger
*/
@isTest
private class EmailNotification_user_Test{
    static testmethod void methodname(){
        string p = RecordTypeHelper.getprofileid('2. HULT Recruiters and Conversion Team');//[select id from profile where name='2. HULT Recruiters and Conversion Team'];
        string p1 =RecordTypeHelper.getprofileid('System Administrator'); //[select id from profile where name='9.2 HULT Outsource Call Center TS'];
        User u = new User(alias = 'standt', email='standarduser9812@testorg.com', 
        lastname='Testing', EmailEncodingKey='UTF-8',IsActive=true,
        languagelocalekey='en_US', 
        localesidkey='en_US', profileid = p,TimeZoneSidKey='America/Los_Angeles',
        username='standarduser9812@testorg.com');
        insert u;
        
        u.profileid=p1;
        update u;
        
        u.IsActive=false;
        //changes
        update u;
    }
}