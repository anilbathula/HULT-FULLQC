public with sharing class new_oppty_attachments_ctlr {
/*
      Developer : Harsha Simha
      Extension for new_oppty_attachments VF page.  
*/
    public string currctctid{get;set;}
    public Opportunity currctct_rec{get;set;}
    public boolean editctct{get;set;}
    public boolean addatach{get;set;}
    public string flagurl{get;set;}
     public blob body{get;set;}
     public string ctype{get;set;}
     public string fname{get;set;}
     public integer fsize{get;set;}
     Id Usrid=UserInfo.getUserId();
     
    /*attachment section variables*/
    public boolean showattchtable{get;set;} 
    public List<Attachment> currecattachmnts{get;set;}
    public map<string,Attachment> mapattch=new map<string,Attachment>();
    public string editattchid{get;set;}
    public Attachment attchmnt{get;set;}
    
    public new_oppty_attachments_ctlr(ApexPages.StandardController controller) {
        
        currctctid=Apexpages.currentPage().getparameters().get('id');        
        currctct_rec=new Opportunity();
        if(currctctid!=null)
        {//Lead.
            editctct=false;
                currctct_rec=[select id,Name,Interview_Status__c,Interview_Date__c,Interview_Date_Booked__c,
                Program_Parsed__c,Region__c ,Country_Of_Residence__c,
               Owner.Name,Telesales_Caller__c,
                LeadSource,Start_Term__c from Opportunity where id=:currctctid];
                   initattachments();
        }
    } 
    
    /*init method for attachments, extracts attachments for current record*/ 
    public void initattachments()
    {             
        attchmnt= new Attachment();
        currecattachmnts=new List<Attachment>();
        if(currctctid==null||currctctid.trim()=='')
        {
        }
        else
        {
            currecattachmnts=[Select ParentId, Name, Id, Description, ContentType,createddate From Attachment where ParentId=:currctctid];
            for(Attachment a:currecattachmnts)
            {
                mapattch.put(a.Id,a);    
            }
        }
        showattchtable=true;    
        addatach=false;
    }
    
    
     /*upload attachment under current record*/
    public void upattach()
    {
        if(ApexPages.hasMessages() )
        {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error : '+Apexpages.getMessages()));
        }
        else
        {
            attchmnt.ParentId=currctct_rec.Id;
            try
            {
                    upsert attchmnt;
                    initattachments();
            }
            catch(Exception e)
            {
                    ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'Error : '+e));
            }
        }      
    }
     
      /*displays File upload sections*/
    public void newattach()
    {
        showattchtable=true;    
        addatach=true;
        /*system.debug(Url.getCurrentRequestUrl());
        system.debug(Apexpages.currentPage());
        string redurl='/p/attach/NoteAttach?pid='+currctctid+'&parentname='+currctct_rec.Name+'&retURL=/'+currctctid;
        Pagereference p=new Pagereference(redurl);
        p.setRedirect(true);
        return p;  */      
    }
   
    /*Displays Edit Attachment section*/
    public void editattach()
    {    system.debug(editattchid);
        if(editattchid!=null && mapattch.containskey(editattchid))
        {
            attchmnt=mapattch.get(editattchid);  
            showattchtable=false;      
        }
    }
    
    /*Saves Changes to Attachment*/
    public void saveattach()
    {    
        if(attchmnt!=null)
        {
            update attchmnt;
            showattchtable=true;
           initattachments();
        }
    }
    /*section to display on cancel button click in New or Edit mode*/
    public void cancelattach()
    {   
        attchmnt=new Attachment();
        showattchtable=true;
         initattachments();
    }
    /*Delete Selected Attachment*/
    /*Delete Selected Attachment*/
    public void delattach()
    {    
        if(editattchid!=null && mapattch.containskey(editattchid))
        {
            attchmnt=mapattch.get(editattchid);            
            Delete attchmnt;
            showattchtable=true;
            initattachments();
           
            
        }
    }

}