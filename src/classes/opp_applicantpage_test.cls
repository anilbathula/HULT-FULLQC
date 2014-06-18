/* 
 Created by   : Premanath Reddy
 Date         : 19/8/2013
 Test class for opp_applicantpage class*/
@IsTest
public class opp_applicantpage_test {
    static testmethod void methodname(){
        Contact objCon = new Contact();
        objcon.LastName='LastName';
        objcon.Applicant_Email__c='test@test122email.com';
        insert objCon;
        
        Opportunity opp= new Opportunity();
        opp.Name='OpportunityName';
        opp.StageName = 'Confirmed';
        opp.Contact__c=objCon.id;
        opp.CloseDate = System.today();
        insert opp;
        
        Apexpages.currentpage().getparameters().put('id',opp.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(opp);
        opp_applicantpage app=new opp_applicantpage(sc);
        app.custEdit();
        app.custSave();
        app.custCancel();
        
    }
}