@isTest
public class unlockStudentInformation_Test{

public static testmethod void methodname() {
        Contact c=new Contact();
            c.LastName='Hult';  
            c.Applicant_Email__c='test@mail444.com';          
            insert c;
            
            
        Opportunity os=new opportunity();
            os.Name='Hult';
            os.StageName='Confirmed';
            os.Contact__c=c.id;
            os.CloseDate=system.today();
            os.Unlock_Student_Financial_Information__c=false;
            insert os;
            
                     
        
        Opportunity_Finance__c fss=new Opportunity_Finance__c();
           fss.opportunity__c=os.id;
           fss.Unlock_Student_Financial_Information__c=false;
           insert fss; 
           fss.Unlock_Student_Financial_Information__c=True;  
           update fss; 
           
           os.Unlock_Student_Financial_Information__c=os.Unlock_Student_Financial_Information__c;
           update os;  
           
         
           
       }
       }