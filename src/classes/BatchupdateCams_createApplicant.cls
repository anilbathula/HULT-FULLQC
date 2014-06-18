/*
--------------------This is one time run code. ------------------------------
    Class     : BatchupdateCams_createApplicant
    Developer : Harsha Simha S
    Date      : 6/10/2013
    Comment   : This Batch class extracts all the september 2014 applications which are confirmed and update them in CAMS DB.   
    TestClass : contact2opportunity_test(80%)
              
		                
*/
global class BatchupdateCams_createApplicant implements Database.Batchable<sobject>,Database.stateful,Database.AllowsCallouts 
{
	global List<HULT_API_Log__c> logs;
	
	public BatchupdateCams_createApplicant()
	{
		logs=new List<HULT_API_Log__c>();
	}
	
	global Database.QueryLocator start(Database.BatchableContext BC){
	 	
	 	string sterm='September 2014';
	 	list<string> stages=new List<String>{'Confirmed','Conditionally Confirmed','Soft Rejected Confirmed'};
	 	
	 	string query='select id,Admission_Test_Waiver__c,App_ID__c,Applicant_Email__c,Birthdate_from_Contact__c,Country_Of_Citizenship__c,Country_Of_Origin__c,'+
							'First_Name_from_Contact__c,Gender__c,Highest_Degree_Attained__c,Industry_Sector__c,Language_Test_Waived__c,Language_Test_Waiver__c,'+
							'Last_Name_from_Contact__c,Mailing_Address_Application__c,Mailing_Address__c,Mailing_City_from_Contact__c,Mailing_Country_from_contact__c,'+
							'Mailing_Postal_Code_from_Contact__c,Mailing_State_from_Contact__c,Mailing_Street_from_Contact__c,Matriculated__c,Name,Owner_Email__c,'+
							'Owner_Name__c,Primary_Campus__c,Program_pre_Parsed__c,Start_Term__c,Type_of_Validated_Admission_Test__c,Type_of_Validated_Language__c,'+
							'Validated_Admission_Test_Score__c,Validated_Language_Test_Score__c,Work_Experience_Total__c from Opportunity where Start_Term__c=:sterm and StageName IN:stages';
	 	system.debug(query);
      	return Database.getQueryLocator(query);
	}
	global void execute(Database.BatchableContext BC,List<sobject> recs)
   	{   		
        system.debug(recs);
		
		for(sobject s:recs)
		{
			Opportunity opp=(opportunity)s;
			
			ALL_API.SFImporterDeclaration impd=new ALL_API.SFImporterDeclaration();
			impd.ApplicantId=opp.App_ID__c;
			impd.FirstName=opp.First_Name_from_Contact__c;
			impd.LastName=opp.Last_Name_from_Contact__c;
			//impd.PreferredName=opp.Name;//blank
			impd.Campus=opp.Primary_Campus__c;		
			impd.StartTerm=opp.Start_Term__c;//'tb2013';
			impd.Gender=opp.Gender__c;
			//impd.GpaGroup=opp.Program_pre_Parsed__c;//
			//impd.AttendanceType=opp.Program_pre_Parsed__c;
			impd.ProgramPreParsed=opp.Program_pre_Parsed__c;
			//impd.Degree=opp.Program_pre_Parsed__c;
			impd.BirthDate=opp.Birthdate_from_Contact__c;
			impd.CountryOfOrigin=opp.Country_Of_Origin__c	;        
	        impd.MailingStreet=opp.Mailing_Street_from_Contact__c;
	        impd.ApplicantEmail=opp.Applicant_Email__c;
	        impd.MailingCountry=opp.Mailing_Country_from_contact__c;
	        impd.MailingCity=opp.Mailing_City_from_Contact__c;
	        impd.MailingPostalCode=opp.Mailing_Postal_Code_from_Contact__c;
	        impd.AdmissionTestType=opp.Type_of_Validated_Admission_Test__c;
	        impd.LanguageType=opp.Type_of_Validated_Language__c;
	        impd.AdmissionTestScore=opp.Validated_Admission_Test_Score__c;
	        impd.AdmissionTestWaiver=opp.Admission_Test_Waiver__c;
	        impd.LanguageTestScore=opp.Validated_Language_Test_Score__c;
	        impd.LanguageTestWaiver=opp.Language_Test_Waiver__c;
	        impd.HighestDegreeAttained=opp.Highest_Degree_Attained__c;
	        impd.IndustrySector=opp.Industry_Sector__c;
	        impd.WorkExperience=opp.Work_Experience_Total__c;
	        impd.RecruiterName=opp.Owner_Name__c;
	        impd.RecruiterEmail=opp.Owner_Email__c;
	        impd.CountryOfCitizenship=opp.Country_Of_Citizenship__c;
			
			
			ALL_API.apiresponse result=new ALL_API.apiresponse();
	        
	        try
	        {	        	
	        	result=ALL_API.createApplicant(impd,opp.Id+'');	
	        	if(result.statuscode!=200)
	        	{
	        		HULT_API_Log__c log=new HULT_API_Log__c();
	        		
	        		log.Callout_Time__c=result.reqtime;
	        		log.EndPoint_URL__c=result.endpointurl;	        		
	        		log.Opportunity__c=opp.Id;
	        		log.Status__c=result.status;
	        		log.Status_Code__c=''+result.statuscode;
	        		
	        		logs.add(log);
	        	}
	        }
	        catch(Exception e)
	        {
	        	if(result==null || result.statuscode==null )
	        	{
		        	System.debug(e);
		        	
		        	HULT_API_Log__c log=new HULT_API_Log__c();
	        		
	        		log.Callout_Time__c=System.now();
	        		log.EndPoint_URL__c='http://54.86.247.117/apis/student';        		
	        		log.Opportunity__c=opp.Id;
	        		log.Status__c=''+e;
	        		
	        		logs.add(log);		        	
	        	}
	        }
			
			if(logs.size()>9000)
			{
				try
				{
					insert logs;
					logs=new List<HULT_API_Log__c>();
				}
				catch(Exception e)
				{
					system.debug(e);
				}
			
			}
			
			
		}
   	}
   	global void finish(Database.BatchableContext BC)
   	{        
    	if(!logs.IsEmpty())
    	{
    		try
				{
					insert logs;
					logs=new List<HULT_API_Log__c>();
				}
				catch(Exception e)
				{
					system.debug(e);
				}
    	}	 	
    }
    /*@istest
    public static void testthisbatch()
    {
    	string query= 'select id,Admission_Test_Waiver__c,App_ID__c,Applicant_Email__c,Birthdate_from_Contact__c,Country_Of_Citizenship__c,Country_Of_Origin__c,'+
							'First_Name_from_Contact__c,Gender__c,Highest_Degree_Attained__c,Industry_Sector__c,Language_Test_Waived__c,Language_Test_Waiver__c,'+
							'Last_Name_from_Contact__c,Mailing_Address_Application__c,Mailing_Address__c,Mailing_City_from_Contact__c,Mailing_Country_from_contact__c,'+
							'Mailing_Postal_Code_from_Contact__c,Mailing_State_from_Contact__c,Mailing_Street_from_Contact__c,Matriculated__c,Name,Owner_Email__c,'+
							'Owner_Name__c,Primary_Campus__c,Program_pre_Parsed__c,Start_Term__c,Type_of_Validated_Admission_Test__c,Type_of_Validated_Language__c,'+
							'Validated_Admission_Test_Score__c,Validated_Language_Test_Score__c,Work_Experience_Total__c from Opportunity where Start_Term__c=:sterm and StageName IN:stages limit 30';                
		
		
		BatchupdateCams_createApplicant bca=new BatchupdateCams_createApplicant();
		database.executebatch(bca,1);
    }*/
}