/*
    Class     : ALL_API
    Developer : Harsha Simha S
    Date      : 6/10/2013
    Comment   : This class has innerclass of values to be passed to API and response captured from api.
                 createApplicant method Makes api callout and response is returned back. 
                 If error error response is sent back and those values are stored in HULT_API_Log__c object.   
    TestClass : contact2opportunity_test(87%)
              
    Note      : We can make only 10 callouts in 1 run and only 1 record fires in a trigger.                 
*/
public with sharing class ALL_API 
{
 
   /*Inner class for CreateApplicant Parameters to be passed.*/ 
    public class SFImporterDeclaration
    {
        public string ApplicantId{get;set;}
        public string FirstName{get;set;}
        public string LastName{get;set;}
        public string PreferredName{get;set;}
        public string Gender{get;set;}
        public date BirthDate{get;set;}
        public string Campus{get;set;}
        public string ProgramPreParsed{get;set;}
        public string StartTerm{get;set;}
        public string GpaGroup{get;set;}
        public string Degree{get;set;}
        public string CountryOfOrigin{get;set;}
        public string AttendanceType{get;set;}
        public string MailingStreet{get;set;}
        public string MailingCountry{get;set;}
        public string MailingCity{get;set;}
        public string MailingPostalCode{get;set;}
        public string ApplicantEmail{get;set;}
        public string AdmissionTestType{get;set;}
        public string LanguageType{get;set;}
        public string AdmissionTestWaiver{get;set;}
        public string AdmissionTestScore{get;set;}
        public string LanguageTestScore{get;set;}
        public string LanguageTestWaiver{get;set;}
        public string IndustrySector{get;set;}
        public double WorkExperience{get;set;}
        public string HighestDegreeAttained{get;set;}
        public string RecruiterName{get;set;}
        public string RecruiterEmail{get;set;}
        public string CountryOfCitizenship{get;set;}      
    }
    
    /*Inner class for common response to be passed back for all api callouts*/
    public class apiresponse
    {
        public boolean iserror{get;set;}
        public integer statuscode{get;set;}
        public string status{get;set;}
        public string recid{get;set;}
        public string endpointurl{get;set;}
        public datetime reqtime{get;set;}
    }
    
    /*This method Creates/updates student information in CAMS DB basedon APP_ID(student ID) */
    public static apiresponse createApplicant(SFImporterDeclaration impd,string recid)
    {
        /*list<Opportunity> opp=[select id,Admission_Test_Waiver__c,App_ID__c,Applicant_Email__c,Birthdate_from_Contact__c,Country_Of_Citizenship__c,Country_Of_Origin__c,
                            First_Name_from_Contact__c,Gender__c,Highest_Degree_Attained__c,Industry_Sector__c,Language_Test_Waived__c,Language_Test_Waiver__c,
                            Last_Name_from_Contact__c,Mailing_Address_Application__c,Mailing_Address__c,Mailing_City_from_Contact__c,Mailing_Country_from_contact__c,
                            Mailing_Postal_Code_from_Contact__c,Mailing_State_from_Contact__c,Mailing_Street_from_Contact__c,Matriculated__c,Name,Owner_Email__c,
                            Owner_Name__c,Primary_Campus__c,Program_pre_Parsed__c,Start_Term__c,Type_of_Validated_Admission_Test__c,Type_of_Validated_Language__c,
                            Validated_Admission_Test_Score__c,Validated_Language_Test_Score__c,Work_Experience_Total__c from Opportunity where id=:oppid];
        */
        apiresponse returnval=new apiresponse(); 
        
        string bdy=Json.serialize(impd);    
        system.debug(bdy); 
         
         
        Http h=new Http();
        Httprequest req=new Httprequest();
        req.setEndpoint('http://54.86.247.117/apis/student');
        req.setMethod('POST');
        req.setTimeout(60000 );
        req.setHeader('Content-Type', 'application/Json'); 
        req.setBody(bdy);
        Httpresponse res=new Httpresponse();
        
        try
        {
            if(!test.isRunningTest())
            {
                res =h.send(req);
            }
            else
            {
                res.setStatusCode(330);
                res.setStatus('Testing from Test class');
            }
            System.debug(res+'---'+res.getBody());
            
            returnval.iserror=res.getStatusCode()!=200?true:false;
            returnval.recid=recid;
            returnval.status=res.getStatus();
            returnval.statuscode=res.getStatusCode();
            returnval.endpointurl=req.getEndpoint();
            returnval.reqtime=System.now();
            
            
        }
        catch(Exception e)
        {
            String err=''+e;
            system.debug(e);
            
            returnval.iserror=true;
            returnval.recid=recid;
            returnval.status=''+e;
            //returnval.statuscode=res.getStatusCode();
            returnval.endpointurl=req.getEndpoint();
            returnval.reqtime=System.now();
        }
        
        return returnval;
    }
    
    public static apiresponse ActivateMyHult(string oppid)
    {
        list<Opportunity> opp=[select id,Admission_Test_Waiver__c,App_ID__c,Applicant_Email__c,Birthdate_from_Contact__c,Country_Of_Citizenship__c,Country_Of_Origin__c,
                            First_Name_from_Contact__c,Gender__c,Highest_Degree_Attained__c,Industry_Sector__c,Language_Test_Waived__c,Language_Test_Waiver__c,
                            Last_Name_from_Contact__c,Mailing_Address_Application__c,Mailing_Address__c,Mailing_City_from_Contact__c,Mailing_Country_from_contact__c,
                            Mailing_Postal_Code_from_Contact__c,Mailing_State_from_Contact__c,Mailing_Street_from_Contact__c,Matriculated__c,Name,Owner_Email__c,
                            Owner_Name__c,Primary_Campus__c,Program_pre_Parsed__c,Start_Term__c,Type_of_Validated_Admission_Test__c,Type_of_Validated_Language__c,
                            Validated_Admission_Test_Score__c,Validated_Language_Test_Score__c,Work_Experience_Total__c from Opportunity where id=:oppid];
        
        apiresponse returnval=new apiresponse(); 
        
        string bdy=Json.serialize(opp[0]+',ActivateMyHult');    
        system.debug(bdy); 
         
         
        Http h=new Http();
        Httprequest req=new Httprequest();
        req.setEndpoint('http://myhultdevservices.hult.edu/apis/RestApi');
        req.setMethod('POST');
        req.setTimeout(60000 );
        req.setHeader('Content-Type', 'application/Json'); 
        req.setBody(bdy);
        Httpresponse res=new Httpresponse();
        
        try
        {
            if(!test.isRunningTest())
            {
                res =h.send(req);
            }
            else
            {
                res.setStatusCode(330);
                res.setStatus('Testing from Test class');
            }
            System.debug(res+'---'+res.getBody());
            
            returnval.iserror=res.getStatusCode()!=200?true:false;
            returnval.recid=oppid;
            returnval.status=res.getStatus();
            returnval.statuscode=res.getStatusCode();
            returnval.endpointurl=req.getEndpoint();
            returnval.reqtime=System.now();
            
            
        }
        catch(Exception e)
        {
            String err=''+e;
            system.debug(e);
            
            returnval.iserror=true;
            returnval.recid=oppid;
            returnval.status=''+e;
            //returnval.statuscode=res.getStatusCode();
            returnval.endpointurl=req.getEndpoint();
            returnval.reqtime=System.now();
        }
        
        return returnval;
    }
}