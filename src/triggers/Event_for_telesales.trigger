/**********************************************************************************************
Trigger    : Event_for_telesales
Written By : Anil.B
Purpose    : To insert a event when a lead stage name='interested' or 'Strongly interested'
Test Class : Event_for_telesales_test(100%)
***********************************************************************************************/


trigger Event_for_telesales on Lead (after update) {
   List<Event> lstEvents = new List<Event>();
   //rectype=='1. HULT Telesales'&&
   //String rectype=RecordTypeHelper.getprofilename(Userinfo.getProfileId());
   //system.debug('*************>'+rectype);
    
    for(Lead l:Trigger.new){
    system.debug('****>'+l);
       if(l.Lead_Stage__c!=trigger.oldmap.get(l.id).Lead_Stage__c && (l.Lead_Stage__c=='Interested'||l.Lead_Stage__c=='Strongly Interested')){
            Event e= new event();
            e.Subject='Telesales call from '+' '+l.Telesales_Caller_Name__c;
            e.Campaign__c='Telesales call from  '+' '+ l.Telesales_Caller_Name__c ;
            e.Source__c='Telesales call from'+ ' '+l.Telesales_Caller_Name__c +' ' +  l.leadsource+': Telesales';
            e.Progresser__c='Telesales';
            e.Progression_Type__c='L2QL';            
            e.Source_Category__c='Telesales';
            e.ownerid=userinfo.getuserid();
            e.StartDateTime=system.now();
            e.EndDateTime=system.now();
            e.Interview_Status__c='Completed';
            e.WhoId=l.id;
            system.debug('==3=>'+e.subject);
            lstEvents.add(e);
           
       } 
        
    }insert lstEvents;

}