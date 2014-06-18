/************************************************************************
Trigger    : unlockStudentInfromation
written By : Anil.B
Purpose    : To update a field(Unlock_Student_Financial_Information__c) .
Both on Contact and Opportunity when the related finance record field
(Unlock_Student_Financial_Information__c)get update .
Modified   : Just Commented lines 41,46,49 and replaced all this with 51 line.
Enhancement : Removed a Workflow::Set Accommodation Stage to 4 and added that functionality in this trigger
*************************************************************************/

trigger unlockStudentInformation on Opportunity_Finance__c (after update) {

            //Set<id> oppids=new Set<id>();            
            Map<String,Opportunity_Finance__c> varmap=new Map<String,Opportunity_Finance__c>();
            List<Opportunity> opp=new List<Opportunity>();
            List<Contact> cs=new List<Contact>();
           
    
    if(Trigger.isupdate){                    
            for(Opportunity_Finance__c op:Trigger.New){
                if(Trigger.NewMap.get(op.id).Unlock_Student_Financial_Information__c !=Trigger.oldMap.get(op.id).Unlock_Student_Financial_Information__c ||
                    (op.Hult_Financial_Aid__c!=trigger.oldmap.get(op.id).Hult_Financial_Aid__c ||
                     op.Scholarship_Amount__c!=trigger.oldmap.get(op.id).Scholarship_Amount__c)||
                     op.Confirmation_Deposit__c!=trigger.oldmap.get(op.id).Confirmation_Deposit__c||
                     op.Non_BBA_Accommodation_Deposit__c!=trigger.oldmap.get(op.id).Non_BBA_Accommodation_Deposit__c){                 
                    
                    varmap.put(op.Opportunity__c,op);                
                }
            }            
    if(!varmap.IsEMpty()){           
    List<Opportunity> opps=[select id,name,Accom_Stage_4_date_time__c,Accommodation_Status__c,Confirmation_Deposit__c,Hult_Fin_Aid_Merit_of_Tuition__c,Unlock_Student_Financial_Information__c,Contact__r.Unlock_Student_Financial_Information__c,Contact__c from opportunity where Contact__c!=null AND id in:Varmap.keyset()];
      
            if(!opps.isEmpty()){                          
                for(Opportunity o:opps){  
                    Opportunity_Finance__c opfin=varmap.get(o.id);                    
                    If(opfin.Unlock_Student_Financial_Information__c!=trigger.oldmap.get(opfin.id).Unlock_Student_Financial_Information__c){                                  
                        o.Unlock_Student_Financial_Information__c=varmap.get(o.id).Unlock_Student_Financial_Information__c; 
                        
                        Contact c=new contact();                      
                        c.id=o.contact__c;                                   
                        c.Unlock_Student_Financial_Information__c=o.Unlock_Student_Financial_Information__c;                    
                        cs.add(c);                                                             
                       
                    }If(opfin.Hult_Financial_Aid__c!=trigger.oldmap.get(opfin.id).Hult_Financial_Aid__c ||
                        opfin.Scholarship_Amount__c!=trigger.oldmap.get(opfin.id).Scholarship_Amount__c){                       
                           o.Hult_Fin_Aid_Merit_of_Tuition__c=varmap.get(o.id).Hult_Fin_Aid_Merit_of_Tuition__c;
                                                 
                    }if(opfin.Confirmation_Deposit__c!=trigger.oldmap.get(opfin.id).Confirmation_Deposit__c){
                          o.Confirmation_Deposit__c=varmap.get(o.id).Confirmation_Deposit__c;      
                                              
                    }
                    /*Workflow::Set Accommodation Stage to 4*/
                    if(opfin.Non_BBA_Accommodation_Deposit__c!=trigger.oldmap.get(opfin.id).Non_BBA_Accommodation_Deposit__c &&opfin.Non_BBA_Accommodation_Deposit__c>=350 && opfin.OP_Program__c!=Null && opfin.OP_Program__c.Contains('Bachelor of International Business Administration')){
                       // o.Accommodation_Depo__c=varmap.get(o.id).Non_BBA_Accommodation_Deposit__c;
                       o.Accom_Stage_4_date_time__c=System.now();
                       o.Accommodation_Status__c='4. Accom. deposit paid';
                       
                    }
                    opp.add(o);
                    
                }
                System.debug('--->'+cs); 
                if(!opp.IsEmpty()){ 
                    database.update(opp);  
                    System.debug('--->'+opp); 
                }
                if(!cs.IsEmpty()){ 
                    database.update(cs); 
                    System.debug('--->'+cs);  
                }      
            }
           
     }   
   }                               
}