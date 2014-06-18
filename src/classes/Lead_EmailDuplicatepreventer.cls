/***************************************************************************************
Class Name       : Lead_EmailDuplicatepreventer 
Author           : Mahesh Gaddam
Created Date     : January 09, 2012
Usage            : This triggers is on Lead on Before Insert& Before Update. 
                 : This trigger prevents user from creating duplicate email ids for email ids already existing in Contact.               
Revision History :                 

Last Modified By : Premanath Reddy
purpose          : Modify the Error messages when duplicate is found in CONTACT.
****************************************************************************************/
public without sharing class Lead_EmailDuplicatepreventer extends LeadTrigger {
    public Lead_EmailDuplicatepreventer(Lead[] leadOldList, Lead[] leadNewList) {
        super(leadOldList, leadNewList);
    }
    
    public override void execute() {
        //return; DISABLED TEMPORARILY
        
       
        // Build a list of all emails
        Set<String> leadEmails = new Set<String> {};
        
        
        for(Lead leadNew : leadNewList) {
            Lead leadOld = leadOld(leadNew.Id);
            
            if (leadNew.Email != null && leadNew.Email.equalsIgnoreCase(leadOld.Email) == false)
                leadEmails.add(leadNew.Email.toLowerCase()); 
            if (leadNew.Applicant_Email__c != null && leadNew.Applicant_Email__c.equalsIgnoreCase(leadOld.Applicant_Email__c) == false)
                leadEmails.add(leadNew.Applicant_Email__c.toLowerCase());    
        }
            // Salesforce automatically lower cases emails, but the original data on the lead
            // might not yet be lower case, so we do it here.
         
        // Find all contacts with any of those
        Set<String> contactEmailsFound = new Set<String>(); 
        Set<ID> contactIdsFound = new Set<ID> (); 
        Set<String> contactprogramsFound = new Set<String>();
        Set<String> contactPhonesFound = new Set<String> (); 
        Set<String> contactMobilesFound = new Set<String> (); 
        Set<String> contactStartTermsFound = new Set<String>(); 
        Set<String> contactRegionsFound = new Set<String> ();
        Set<String> contactStageFound = new Set<String>() ;
        
        Contact[] contactList = [select Id, Phone
                                    , MobilePhone
                                    , Program_Primary__r.Name
                                    , Start_Term__c
                                    , Region__c
                                    , Email
                                    , Applicant_Email__c
                                    ,Stage__c
                                      from Contact
             where (Email in :leadEmails and Email != null) // just in case
                or (Applicant_Email__c in :leadEmails and Applicant_Email__c != null)
        ];
        if (contactList.size() == 0)
            return;
        
        for (Contact contact : contactList) { 
            if (contact.Email != null)
                contactEmailsFound.add(contact.Email);
                contactIdsFound.add(contact.Id);
                contactprogramsFound.add(contact.Program_Primary__r.Name);
                contactPhonesFound.add(contact.Phone);
                contactMobilesFound.add(contact.MobilePhone);
                contactStartTermsFound.add(contact.Start_Term__c);
                contactRegionsFound.add(contact.Region__c);
                contactStageFound.add(contact.Stage__c);
            if (contact.Applicant_Email__c != null)
                contactEmailsFound.add(contact.Applicant_Email__c);
        } 
        
        // Reloop and add error messages
        String str;
        for(Lead leadNew : leadNewList) {
            str=contactIdsFound+',' +contactprogramsFound+',' +contactStartTermsFound+',' + contactPhonesFound+',' +contactMobilesFound+',' + contactRegionsFound+',' +contactStageFound;
            String specialChars = '{}';        
            for(integer i=0; i<specialChars.split('|').size(); i++){
                str= str.replace(specialChars.split('|')[i], '');
            }
            if (leadNew.Email != null && contactEmailsFound.contains(leadNew.Email))
                leadNew.Email.addError('Duplicate value on record,'+str);
            if (leadNew.Applicant_Email__c != null && contactEmailsFound.contains(leadNew.Applicant_Email__c))
                leadNew.Applicant_Email__c.addError('Duplicate value on record,'+str);
           
        }
     } 
}