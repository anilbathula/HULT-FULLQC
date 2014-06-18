@isTest
public class lcomments_Test{
    public static testmethod void methodname(){
        
        Country__c ctry=new Country__c();
        ctry.name='India';
        ctry.Calling_Code__c=91;
        ctry.MSN__c=10;
        ctry.Prefix_011_not_required_for_five9__c=false;
        ctry.Calling_Code_secondary__c=1;
        ctry.Flags__c='richtext<img src="asdfsafd"/>';
        insert ctry;
        
        Program__c pro =new Program__c();
        pro.name='MBA';
        insert pro;
        
        Setting_Disabled__c obj=new Setting_Disabled__c();
        obj.Lead_OverrideCountries__c=false;
        insert obj;
       
        Lead led = new Lead();
        led.Company = 'Company';
        led.FirstName = 'FirstName';
        led.LastName = 'LastName';
        led.Status='Open';
        led.Email = 'lead11123@testmail.com';
        led.Applicant_Email__c = 'lead11123@testmail.com';
        led.Phone='123456';
        led.MobilePhone='+91-(0)-9874506789';
        led.Country_Of_Residence__c = ctry.Id;
        led.LeadSource = 'GMASS';
        led.Program_Primary__c = pro.id;
        insert led;
        
        Id currleadid=led.id;      
        
        Comments__c c=new Comments__c();        
        c.Lead__c=led.id;
        insert c;
        
        
        PageReference pageRef = Page.leadcomments;
        Test.setCurrentPage(pageRef);
        Apexpages.currentPage().getparameters().put('id',led.id);
        
        ApexPages.StandardController ctrlr=new ApexPages.StandardController(led);
        lcomments ld=new lcomments(ctrlr);
        ld.CustNew();
        ld.CustSave();
        ld.CustEdit();
        ld.custDel();
        ld.CustCancel();        
      
    }
}