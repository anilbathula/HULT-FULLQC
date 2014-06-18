/*
    Trigger   : Lead_Duplicate_Email_Checker
    Events    : Before Insert and Update on Opportunity  
    Developer : Harsha Simha S
    Date      : 13/8/2013
    Comment   : This trigger checks If the Applicant Email or Email already exist in another Lead/Contact and prevents duplicates.
                Assigns Lead Applicant Email to Email if Email is empty.     
    Test Class: Lead_Duplicate_Email_Checker_Test(94%)
    Modified By: Anil.B on 12/3/2014 --added try and catch block at 56,64,86 and 94 to catch null pointer exception.
*/     
trigger Lead_Duplicate_Email_Checker on Lead (before insert, before update) {
    Map<String, Lead> leadMap = new Map<String, Lead>();
    Map<String ,Lead> lednames= new Map<String, Lead>();
    for(Lead l:Trigger.new)
    {
        string lemail;      
        if(l.Email!=null && (Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(l.Id).Email!=l.Email)))
        {
            if (leadMap.containsKey(l.Email)) 
            {
                l.Email.addError('Duplicate value on record,Lead');
            } 
            else 
            {
               lemail=l.Email.toLowerCase();
            }
        }
        if(l.Applicant_Email__c!=null &&(Trigger.isInsert || (Trigger.isUpdate && Trigger.oldMap.get(l.Id).Applicant_Email__c!=l.Applicant_Email__c)))
        {
            if (leadMap.containsKey(l.Applicant_Email__c)) 
            {
                l.Applicant_Email__c.addError('Duplicate value on record,Lead');
            } 
            else 
            {
                lemail=l.Applicant_Email__c.toLowerCase();
            }
        }
        if(l.Applicant_Email__c!=null && l.Email==null)
        {
            l.Email=l.Applicant_Email__c;
        }
        if(lemail!=null)
        {
            String str=l.FirstName+' '+l.LastName;
            //System.Debug(l.FirstName+'********************1*'+str);
            leadMap.put(lemail, l);
            lednames.put(str, l);
        }
    }
    if(!leadMap.ISEmpty())
    {
        List<Lead> remaining_leads=new list<lead>();    
        List<Lead> leds=[select id,Name,Email,Program_Primary__c,Program_Primary__r.Name,Applicant_Email__c,Company,Start_Term__c,LeadSource,Phone,MobilePhone,
                            Region__c from Lead where (Email IN:leadmap.Keyset() or Applicant_Email__c IN:leadmap.keyset()) and isconverted=false];
        if(!leds.ISEmpty())
        {
            for(Lead l:leds)
            {
                string email;
                Try{
                    if(leadMap.ContainsKey(l.Email.toLowerCase()) && l.Id!=leadMap.get(l.Email.toLowerCase()).Id)
                    {
                        email=l.Email.toLowerCase();
                    }
                }Catch(Exception e){
                    System.debug('An exception occurred: ' + e.getMessage());
                }
                try{
                    if(leadMap.ContainsKey(l.Applicant_Email__c.toLowerCase()) && l.Id!=leadMap.get(l.Applicant_Email__c.toLowerCase()).Id)
                    {
                        email=l.Applicant_Email__c.toLowerCase();
                    }
                }catch (Exception e){
                    System.debug('An exception occurred: ' + e.getMessage());
                }
                if(email!=null)
                {
                    Lead newLead=leadMap.get(email);
                    newLead.Applicant_Email__c.addError('Duplicate value on record '+','+l.ID+','+l.Program_Primary__r.Name+','+l.LeadSource+','+l.Start_Term__c+','+l.Phone+','+l.MobilePhone+','+l.Region__c+', Lead');
                }
            }
        }        
        List<Contact> cons=[select Id, LeadSource,Phone,MobilePhone, Program_Primary__r.Name, Start_Term__c, Region__c, Email, Applicant_Email__c,
                            Stage__c from Contact where (Email IN:leadmap.Keyset() or Applicant_Email__c IN:leadmap.keyset())];
  
        if(!cons.ISEmpty())
        {
            for(Contact c:cons)
            {
                string email;
                Try{
                    if(c.Email!=null && leadMap.ContainsKey(c.Email.toLowerCase()))
                    {
                        email=c.Email.toLowerCase();
                    }
                }Catch(Exception e){
                    System.debug('An exception occurred: ' + e.getMessage());
                }
                Try{
                    if(c.Applicant_Email__c!=null && leadMap.ContainsKey(c.Applicant_Email__c.toLowerCase()))
                    {
                        email=c.Applicant_Email__c.toLowerCase();
                    }
                }Catch(Exception e){
                    System.debug('An exception occurred: ' + e.getMessage());
                }
                Lead newLead=leadMap.get(email);
                if(email!=null)
                {                    
                    newLead.Applicant_Email__c.addError('Duplicate value on record '+','+c.ID+','+c.Program_Primary__r.Name+','+c.LeadSource+','+c.Start_Term__c+','+c.Phone+','+c.MobilePhone+','+c.Region__c+','+c.Stage__c);
                }
                
                else
                {
                    remaining_leads.add(newLead);
                    //take remaining leads in remaining_leads list
                
                }
            }
        }
        //Prem :: 7/5/2014 ::  Anti-dup Code on Contact Object 
       /* if(!lednames.ISEmpty())
        {//System.Debug('****************2*'+lednames.keyset());
            List<Contact> cons1=[select Id,Name,FirstName,LeadSource,Phone,MobilePhone, Program_Primary__r.Name, Start_Term__c, Region__c, Email, Applicant_Email__c,
                            Stage__c
                            ,(select id,name,Contact__c,Stage_HighLevel__c from opportunities where Stage_HighLevel__c='Partial') from Contact where Name in:lednames.keyset()];
               System.Debug(cons1[0].Name+'****************3*'+cons1.size());             
            if(!cons1.isEmpty()){
                for(Contact c:cons1){
                    Lead newLead=lednames.get(c.Name);
                   
                    if(newLead.FirstName+' '+newLead.LastName==c.Name && c.getSObjects('opportunities').size()>0){
                        System.Debug('************5*');
                        String leadmobile,conmobile,leadph,conph;
                        leadmobile=newLead.MobilePhone!=null && newLead.MobilePhone.length()>7?newLead.MobilePhone.substring(newLead.MobilePhone.length()-7,newLead.MobilePhone.length()):newLead.MobilePhone;
                        conmobile=c.MobilePhone!=null && c.MobilePhone.length()>7?c.MobilePhone.substring(c.MobilePhone.length()-7,c.MobilePhone.length()):c.MobilePhone;
                        leadph=newLead.Phone!=null && newLead.Phone.length()>7?newLead.Phone.substring(newLead.Phone.length()-7,newLead.Phone.length()):newLead.Phone;
                        conph=c.Phone!=null && c.Phone.length()>7?c.Phone.substring(c.Phone.length()-7,c.Phone.length()):c.Phone;
                        if((leadmobile!=null && leadmobile==conmobile) || (leadmobile!=null && leadmobile==conph)
                            || (leadph!=null && leadph==conmobile) || (leadph!=null && leadph==conph))
                        {
                            newLead.addError('my Duplicate value on record '+','+c.ID+','+c.Program_Primary__r.Name+','+c.LeadSource+','+c.Start_Term__c+','+c.Phone+','+c.MobilePhone+','+c.Region__c+','+c.Stage__c);
                        }
                    }
                }
            }
            
        }*/
        
    }
}