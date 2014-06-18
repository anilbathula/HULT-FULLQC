/*
Author    :- Premanath Reddy
Date      :- 01/14/2013
Usage     :- Test class for lead_ApplicantEmail_Dup_prevent Trigger
*/
@IsTest 
public class lead_ApplicantEmail_Dup_prevent_Test{
    public static testmethod void methodname(){
    
        Country__c ctry=new Country__c();
        ctry.name='India';
        ctry.Calling_Code__c=91;
        insert ctry;
        
        Program__c pro =new Program__c();
        pro.name='MBA';
        insert pro;
        
        Setting_Disabled__c obj=new Setting_Disabled__c();
        obj.Lead_OverrideCountries__c=false;
        insert obj;
        
        Lead lead1 = new Lead();
        lead1.FirstName = 'FirstName1';
        lead1.LastName = 'LastName1';
        lead1.Company = 'Company1';
        lead1.Email = 'testlead577@test2.com';
        lead1.Applicant_Email__c = 'testlead577@test2.com';
        lead1.LeadSource = 'Alumni';
        lead1.Status = 'Contacted';
        lead1.Country_Of_Citizenship__c = ctry.id;
        lead1.Country_Of_Residence__c = ctry.id;
        lead1.Program_Primary__c = pro.id;
        insert lead1;
        
        try{ 
            Lead lead2 = new Lead();
            lead2.FirstName = 'sachin';
            lead2.LastName = 'namw';
            lead2.Company = 'Compa123';
            lead2.Email = 'testlead577@test2.com';
            lead2.Applicant_Email__c = 'testlead577@test2.com';
            lead2.LeadSource = 'Alu123';
            lead2.Status = 'Con123';
            lead2.Country_Of_Citizenship__c = ctry.id;
            lead2.Country_Of_Residence__c = ctry.id;
            lead2.Program_Primary__c = pro.id;
            insert lead2;
        }
        catch(Exception e){
        } 
    }
}