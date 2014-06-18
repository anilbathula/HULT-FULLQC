/*
	Developer : Harsha Simha S
	Date      : 11/7/2012
	To Block the Delete operation from UI
*/
public with sharing class Requirement_blockdelete {
        public Requirement_blockdelete(Apexpages.StandardController ctrlr)
        {
                ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR, 'Record Cannot be deleted!');
                ApexPages.addmessage(myMsg);
                
        }
        public Pagereference back()
        {       
                return new Pagereference('/'+Apexpages.currentPage().getParameters().get('retURL'));
        }
        
       
}