// Trigger for update Currency of Finance Object when the campus changed.
/*************************************************************************
Trigger  : UpdateCurrency
Purpose  :To send Email to 3 users when a primary program is changed and 
stage name is confirmed and Admissions Endorsed Confirmed and Go_Ed_Loan_Amount__c>0
And also update isocurrency code of opportunity on finance record.
Developer :Anil.B
Modified by: Anil.B on 15/11/2013---JIRA No:::SFSUP-672.
Test class:Fees_Test
*************************************************************************/
trigger updateCurrency on Opportunity (after update) {

    List<Opportunity_Finance__c> oppFinNew = new List<Opportunity_Finance__c>();        
    map<id,String>smap=new map<id,string>();
    Set<Id> sobjectSetOfIds = new Set<Id>();
    
    for(Opportunity opp:trigger.new){
        System.debug(trigger.oldmap.get(opp.id).Primary_Campus__c+'===============================>'+opp.Primary_Campus__c);
        if(opp.Primary_Campus__c!=trigger.oldmap.get(opp.id).Primary_Campus__c){              
            smap.put(opp.id,opp.Program_Currency__c); 
            If(opp.StageName=='Confirmed'||opp.StageName=='Admissions Endorsed Confirmed'||opp.StageName=='Conditionally Confirmed'||opp.StageName=='Soft Rejected Confirmed'){
            sobjectSetOfIds.add(opp.id);            
            }         
        }         
    }   
    System.debug('****'+sobjectSetOfIds);
       
    if(!smap.IsEmpty()){
        List<Opportunity_Finance__c> oppFin = [select id,CurrencyIsoCode,Opportunity__c from Opportunity_Finance__c where Opportunity__c in:trigger.newmap.keyset()];
        for(Opportunity_Finance__c opf : oppFin){
            if(smap.containsKey(opf.Opportunity__c)){
                opf.CurrencyIsoCode =smap.get(opf.Opportunity__c);
                System.debug('********>'+smap.get(opf.Opportunity__c));
                oppFinNew.add(opf); 
            }
        }
        update oppFinNew;
    }
    
    if(!sobjectSetOfIds.IsEmpty()){
        List<Opportunity_Finance__c> opfin=[select id,Name,Go_Ed_Loan_Amount__c,opportunity__r.id,Program__c,Opportunity__c,Applicant__c,Student_ID__c from Opportunity_Finance__c where Go_Ed_Loan_Amount__c >0 and Opportunity__c in:sobjectSetOfIds ];
        if(!opfin.isEmpty()){
            List<EmailTemplate> et = [SELECT id FROM EmailTemplate WHERE Name = 'GoEd Loan Status Confirmed Campus Change'];
            System.debug(et+'<--((((((((->'+et.size());
            List<messaging.Singleemailmessage> lstMail=new list<messaging.Singleemailmessage>();
            if(et.IsEmpty())
            {
                String str='Some One has Changed or Deleted the email template with name : GoEd Loan Status Confirmed Campus Change'+'<br></br>'+
                'Please Check this template and correct it'+'<br></br>'+
                +'<br></br><br></br><br></br>'+
                'Thanks'+'<br></br>'+'\n'+
                'Hult';
                
                messaging.Singleemailmessage mail=new messaging.Singleemailmessage();            
                mail.setToAddresses(new String[] {'anil.bathula@hult.edu','Harsha.Simha@hult.edu','meghan.shoemaker@hult.edu','daniel.mora@ef.com'});
                mail.setSenderDisplayName('Hult');
                mail.setSubject('Changed or Deleted The Email Template with name:GoEd Loan Status Confirmed Campus Change' );
                mail.setHtmlBody(str);
                lstMail.add(mail);
            }
            else
            {
                for(integer i=0;i<opfin.size();i++){  
                
                    /*List<string>s =new List<String>{'anil.bathula@hult.edu','Premanath.reddy@hult.edu'};                   
                    String Subject='Campus Change ' + opfin[i].Student_ID__c +','+ opfin[i].Applicant__c;
                    String str='The campus program has changed to '+opfin[i].Program__c+'<br></br>'+
                    'Please review the Application '+opfin[i].Opportunity__c + ' and Finance Page'+'<br></br> '+
                    +'<br></br><br></br><br></br>'+
                    'Thanks'+'<br></br>'+'\n'+
                    'Hult';*/
                    
                    messaging.Singleemailmessage mail=new messaging.Singleemailmessage();                 
                    mail.setSenderDisplayName('Hult');
                    mail.setToAddresses(new String[] {'Elias.Abrahamsson@goed.com','Ambjorn.Wigg@goed.com','Chris.Kwanwu@goed.com'});                     
                    mail.setTargetObjectId('003U000000Qaw0f');
                    mail.setSaveAsActivity(false);                       
                    mail.setTemplateId(et[0].Id);
                    mail.setWhatId(opfin[i].Id);
                    lstMail.add(mail);  
                }
            }
            If(staticFlag.Update_Currency)
            {
                staticFlag.Update_Currency = false;
                if(!lstmail.IsEmpty()){
                    try{ 
                        messaging.sendEmail(lstmail);
                    }
                    catch(DMLException e){ 
                        system.debug('ERROR SENDING EMAIL:'+e); 
                    } 
                }
            } 
                
        } 
    }   
}