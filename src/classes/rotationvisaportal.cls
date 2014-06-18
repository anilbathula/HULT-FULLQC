public with sharing class rotationvisaportal {

    Public String stuid{get;set;}
    Public Contact con{get;set;}
    Public List<Rotation__c> rot{get;set;}
    Public Rotation__c disp_rot{get;set;}
    Public List<Rotation_Documents__c> rotdoc{get;set;}
    Public Rotation_Documents__c disp_rotdoc{get;set;}
    Public boolean showpage{get;set;}
    Public boolean hidepage{get;set;}
    Public boolean showlink{get;set;}
    Public boolean editmode{get;set;}
    Public boolean personal{get;set;}
    Public boolean rotation{get;set;}
    Public boolean dependent{get;set;}
    Public boolean docs{get;set;}
    Public String dep_back{get;set;}
    public String rotinfo_back{get;set;}
    Public boolean isbacktorot{get;set;}
    public boolean mydeaillink{get;set;}
    public string birthdate{get;set;}
    public boolean camp_bool{get;set;}
    public boolean home_bool{get;set;}
    public boolean displayPopup{get;set;}
    public String visatrack{get;set;}
    public Contact disp_con{get;set;}
    public boolean show_msg{get;set;}
    public boolean show_mydetail{get;set;}
    public String doc_pop{get;set;}
    public boolean disp_rottab{get;set;}
    
    public PageReference init()
    {/*Page load method.*/
        try{
            user usr = [SELECT contact.Total_Login__c,contact.RecordTypeId, contact.Name,contact.Last_Log_In__c FROM User WHERE id = :UserInfo.getUserId() and (profileid='00eU0000000IrdI' or profileid='00eU0000000Uz7Q') and (Contact.RecordTypeId=:RecordTypeHelper.getRecordTypeId('Contact', 'Candidate') or Contact.RecordTypeId=:RecordTypeHelper.getRecordTypeId('Contact', 'Student') )];
            if(usr.ContactId!=null){
                stuid=usr.ContactId;
            }
            else
            {  
                if(Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs10.visual.force.com' || Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs9.visual.force.com' || Test.isRunningtest())
                { 
                    stuid=ApexPages.currentPage().getParameters().get('id');
                    system.debug(stuid);
                }
                //we can do same here
            }
        }
        catch(Exception e)
        {
            PageReference pageRef = new PageReference('/apex/student_login');
            pageRef.setRedirect(true);
            return pageRef;
           //'http://staging2-hult-international-business-school.cs10.force.com/visarotation'
        }
         try{
         
            dep_back=ApexPages.currentPage().getParameters().get('depend');
            rotinfo_back=ApexPages.currentPage().getParameters().get('rotinfo');
            doc_pop=ApexPages.currentPage().getParameters().get('doc_pop');
            if(dep_back=='depend' && !isbacktorot){
                personal=false;
                rotation=false;
                dependent=true;
                docs=false;
                disp_view=true;
                disp_new=false;
                disp_selexist_dep=false;
                showlink=false;
                show_msg=false;
                show_mydetail=false;
                showpage=true;
                isbacktorot=true;
                mydeaillink=false;
                disphplan=false;
                disphplan1=false;
                camp_bool=false;
                ismoredepsexist=false;
                disp_rottab=false;
                dep_viewtext=' ';
                birthdate= ' ';
                visatrack=' ';
                rot=new List<Rotation__c>();
                rotmethod();
                init_dependents();              
                if(ApexPages.currentPage().getParameters().containsKey('depend')){
                ApexPages.currentPage().getParameters().remove('depend');}
                
            }
            else if(rotinfo_back=='rotinfo' && !isbacktorot){
                personal=false;
                rotation=true;
                dependent=false;
                docs=false;
                disp_view=true;
                disp_new=false;
                disp_selexist_dep=false;
                showlink=false;
                show_msg=false;
                show_mydetail=false;
                showpage=true;
                isbacktorot=true;
                mydeaillink=false;
                disp_rottab=false;
                disphplan=false;
                disphplan1=false;
                camp_bool=false;
                ismoredepsexist=false;
                dep_viewtext=' ';
                birthdate= ' ';
                visatrack=' ';
                rot=new List<Rotation__c>();
                rotmethod();
                init_dependents();              
                if(ApexPages.currentPage().getParameters().containsKey('rotinfo')){
                ApexPages.currentPage().getParameters().remove('rotinfo');}
                
            }
            else{
                showlink=true;
                show_msg=true;
                show_mydetail=false;
                disp_rottab=false;
                rot=new List<Rotation__c>();
                isbacktorot=true;
                rotmethod();
            }
            
        }
        Catch(Exception e){}
        
        return null;
    }
    
    public rotationvisaportal (){/*Constructor*/
        isbacktorot=false;
        camp_bool=false;
        disp_rottab=false;
    }
    
    public PageReference detail_rotPage(){
    /*Home page rotation links*/
        PageReference pageRef;
        try{
        if(rot[0].Student__r.Mydetails_Rotation_Tab_Completed__c){
            rotation=true;
            showpage=true;
            showlink=false;
            show_msg=false;
            show_mydetail=false;
            personal=false;
            camp_bool=true;
            rotmethod();
            
            if(disp_rot.Visa_Track_Added__c){
                pageRef = new PageReference('/apex/documentpage');
                if(Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs10.visual.force.com' || Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs9.visual.force.com' || Test.isRunningtest())
                {
                    pageRef.getParameters().put('student_id',stuid);
                    system.debug(stuid);
                }
                pageRef.getParameters().put('id',rot_id);
                //pageRef.getParameters().put('student_id',stuid);
                pageRef.setRedirect(true);
            }
        }
        else{
            displayPopup=true;
        }
        }
        Catch(Exception e){}
        return pageRef;
    }
    public void closePopup() {   // Home page popup     
        displayPopup = false;
        mydetail_pop=false;
        doc_pop='false';
        rotmethod();
    } 
    public void detailPage(){
    /*Home page My Detail link*/
        try{
            showpage=false;
            showlink=true;
            show_msg=false;
            show_mydetail=true;
            personal=true;
            rotmethod();
        }
        Catch(Exception e){}
    }
    
    public void rotmethod(){
        try{
        disp_con=new Contact();
    /*Main method which collects all the rotation information based on student id.*/
        rot=[select id,Name,Student__c,Student__r.Name,Student__r.FirstName,Student__r.LastName,Student__r.MobilePhone,Student__r.Birthdate
                    ,Student__r.Country_Of_Origin__c,Student__r.Country_Of_Citizenship__c,Student__r.Relationship_Status__c
                    ,Student__r.Languages__c,Student__r.City_Of_Birth__c,Student__r.Country_Of_Residence__c
                    ,Student__r.Need_handicap_access_while_rotation__c,Student__r.Details_of_your_Handicap__c
                    ,Student__r.Dietary_needs__c,Student__r.Details_of_your_Diet__c,Student__r.Specific_medical_needs_or_Alergies__c
                    ,Student__r.Details_of_your_condition_alergies__c,Student__r.Have_second_Passport__c    
                    ,Student__r.Rotation_Interests__c,Student__r.Rotation_Interest_Event_Type__c,Student__r.Rotation_Avg_Entrance_Fee_Amount__c
                    ,Student__r.Rotation_Housing_Plans__c,Student__r.Rotation_1_Campus__c,Student__r.Rotation_2_Campus__c
                    ,Student__r.Rotation_Housing_Resources_Plan__c,Student__r.Rotation_Housing_Resources_Plan_Other__c
                    ,student__r.Mydetails_Rotation_Tab_Completed__c,student__r.Student_ID__c
                    ,Student__r.Program_preParsed__c,Student__r.Campus_parsed_from_Program__c
                    ,Home_Campus__c,Need_handicap_access_while_rotation__c
                    ,Details_of_your_Handicap__c,Dietary_needs__c,Details_of_your_Diet__c,Specific_medical_needs_or_Alergies__c
                    ,Details_of_your_condition_alergies__c
                    ,Type__c,Rotation_Campus__c
                    ,Previous_Nationalities__c,Father_Name__c,Mother_Name__c,Religion__c,Is_Rotating__c
                    ,Address_Line1__c,Address_Line2__c,City__c,State__c,Postal_Code__c,Country__c,Visa_Track__r.Name,Visa_Track_Added__c
                    ,Previous_Visa_Refusal_Notes__c,Previously_Studied_in_UK__c,had_treatment_on_the_NHS_Whilst_in_Uk__c
                    ,If_NHS_treatment_recieved_have_you_paid__c,Current_Address__c,Active__c        
                    ,(select id,Name,Passport_issued_country__c,Passport_Number__c,Passport_Issue_Date__c,Passport_Expiration_Date__c
                    ,EXACT_Passport_First_Name__c,EXACT_Passport_Middle_Name__c,EXACT_Passport_Family_Name__c,Passport_Type__c
                    ,Rotation1__c,Rotation2__c 
                    from Rotation_Documents__r)
                    from Rotation__c where Student__c=:stuid and Active__c=true and Is_Rotating__c=true order by Type__c];
                 
        mydeaillink=false;
        if(!rot.ISEmpty())
        {
            mydeaillink=true;
            disp_con=rot[0].Student__r;
        } 
        System.Debug(rot[0].student__r.Mydetails_Rotation_Tab_Completed__c); //Don't Comment it,this is for catch block if there is no rotation.
        home_bool=disp_con.Mydetails_Rotation_Tab_Completed__c; 
/*        Datetime br1= disp_con.BirthDate;
        if(br1!=null)
            birthdate= br1.format('dd/MM/yyyy');*/
        if(disp_con.BirthDate!=null)        
            birthdate=disp_con.BirthDate.day()+'/'+disp_con.BirthDate.month()+'/'+disp_con.BirthDate.year();
        //birthdate=disp_con.BirthDate==null?' ':disp_con.BirthDate.Day()+'/'+disp_con.BirthDate.Month()+'/'+disp_con.BirthDate.Year();
        rot_id=ApexPages.currentPage().getParameters().get('Rec');
        for(Rotation__c r:rot){
            if(r.id==rot_id)
            {
                disp_rot=r;
                if(disp_rot.Visa_Track__r.Name!=null){
                    visatrack=disp_rot.Visa_Track__r.Name.Contains('CAMPUS CHANGED')?'CAMPUS CHANGED - ':disp_rot.Visa_Track__r.Name+' - ';
                }
               // birthdate=r.Student__r.BirthDate==null?' ':r.Student__r.BirthDate.Day()+'/'+r.Student__r.BirthDate.Month()+'/'+r.Student__r.BirthDate.Year();
            }
            for(Rotation_Documents__c d:r.Rotation_Documents__r)
            {            
                if(d.Rotation1__c==rot_id || d.Rotation2__c==rot_id) 
                    disp_rotdoc=d;
            }
        }
        if(camp_bool){
            camp_bool=false;
            if(disp_rot.Rotation_Campus__c!='London' && disp_rot.Rotation_Campus__c!='Dubai' && !disp_rottab){
                personal=false;
                rotation=false;
                dependent=true;
                docs=false;
                disp_view=true;
                disp_new=false;
                disp_selexist_dep=false;
                init_dependents();
            }
        }
        change();
        change1();
        }
        catch(Exception e){
            mydeaillink=true;
            disp_con=new Contact();
            disp_con=[Select id,Name,FirstName,LastName,MobilePhone,Birthdate
                    ,Country_Of_Origin__c,Country_Of_Citizenship__c,Relationship_Status__c
                    ,Languages__c,City_Of_Birth__c,Country_Of_Residence__c
                    ,Need_handicap_access_while_rotation__c,Details_of_your_Handicap__c
                    ,Dietary_needs__c,Details_of_your_Diet__c,Specific_medical_needs_or_Alergies__c
                    ,Details_of_your_condition_alergies__c,Have_second_Passport__c    
                    ,Rotation_Interests__c,Rotation_Interest_Event_Type__c,Rotation_Avg_Entrance_Fee_Amount__c
                    ,Rotation_Housing_Plans__c,Rotation_1_Campus__c,Rotation_2_Campus__c
                    ,Rotation_Housing_Resources_Plan__c,Rotation_Housing_Resources_Plan_Other__c
                    ,Mydetails_Rotation_Tab_Completed__c,Student_ID__c
                    ,Program_preParsed__c,Campus_parsed_from_Program__c from Contact where id=:stuid];
            home_bool=disp_con.Mydetails_Rotation_Tab_Completed__c;
            if(disp_con.BirthDate!=null)        
                birthdate=disp_con.BirthDate.day()+'/'+disp_con.BirthDate.month()+'/'+disp_con.BirthDate.year();
            change();
            change1();
        }
    }
        
    public PageReference tabmethod() {
        String tab1=ApexPages.currentPage().getParameters().get('tab1');
        String tab2=ApexPages.currentPage().getParameters().get('tab2');
        String tab3=ApexPages.currentPage().getParameters().get('tab3');
        String tab4=ApexPages.currentPage().getParameters().get('tab4');
        PageReference pageRef;
        if(tab1=='home'){
            pageRef = new PageReference('/apex/rotationvisaportal');
            if(Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs10.visual.force.com' || Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs9.visual.force.com' || Test.isRunningtest())
            {
                pageRef.getParameters().put('id',stuid);
                system.debug(stuid);
            }
            
            If(pageRef.getParameters().containsKey('Rec')){pageRef.getParameters().remove('Rec');}
            If(pageRef.getParameters().containsKey('Depend')){pageRef.getParameters().remove('Depend');}
            If(pageRef.getParameters().containsKey('rotinfo')){pageRef.getParameters().remove('rotinfo');}
            pageRef.setRedirect(true);
        }
        if(tab2=='Rotationinfo'){
            
            showlink=false;
            show_msg=false;
            show_mydetail=false;
            personal=false;
            rotation=true;
            disp_rottab=true;
            dependent=false;
            docs=false;
            disp_view=false;
            disp_new=false;
            disp_selexist_dep=false;
            ApexPages.currentPage().getParameters().put('Rec',disp_rot.id);
            detail_rotPage();
            
        }
        if(tab3=='dependents'){
            personal=false;
            rotation=false;
            dependent=true;
            docs=false;
            disp_view=true;
            disp_new=false;
            disp_selexist_dep=false;
            init_dependents();            
        }
        if(tab4=='Document'){
            pageRef = new PageReference('/apex/documentpage');
            if(Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs10.visual.force.com' || Url.getSalesforceBaseUrl().toexternalform()=='https://c.cs9.visual.force.com' || Test.isRunningtest())
            {
                pageRef.getParameters().put('student_id',stuid);
                system.debug(stuid);
            }
            pageRef.getParameters().put('id',rot_id);
            //pageRef.getParameters().put('student_id',stuid);
            pageRef.setRedirect(true);
        }
        return pageRef;
    }
    
    public void cancelmethod(){/* Cancel Button for My Detail*/
        showlink=true;
        show_msg=true;
        show_mydetail=false;
        showpage=false;
        personal=false;
        rotation=false;
        dependent=false;
        docs=false;
        disp_view=false;
        disp_new=false;
        disp_selexist_dep=false;
    } 
               
    public List<SelectOption> getclist(){/*Returns Country picklist Values*/
        List<SelectOption> options = new List<SelectOption>();
        List<Country__c> cou=[select id,name from country__c where name != '-Did Not Respond-' order by name asc]; // remove -Did Not Respond- country from picklist
        options.add(new SelectOption('','-Select-'));            
        for(integer i=0;i<cou.size();i++){
            options.add(new SelectOption(cou[i].id,cou[i].name));            
        }
        return options;
    }
    public List<SelectOption> getsec_pass() {/*Return Boolean Values as Yes or no picklist values*/
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('true','Yes'));
        options.add(new SelectOption('false','No'));
        return options;
    }
    public List<SelectOption> getrediovals() {/*disp_rot.Previously_Studied_in_UK__c*/
        List<selectOption> options = new List<selectOption>();
        Schema.DescribeFieldResult dfr = Rotation__c.Previously_Studied_in_UK__c.getDescribe();
        for (Schema.PicklistEntry ple : dfr.getPicklistValues()) {
            options.add(new selectOption(ple.getValue(), ple.getLabel(), !ple.isActive()));
        }
        return options;
    } 
    public List<SelectOption> getrotint() {/*for disp_con.Rotation_Interests__c field*/
        List<selectOption> options = new List<selectOption>();
        Schema.DescribeFieldResult dfr = Contact.Rotation_Interests__c.getDescribe();
        for (Schema.PicklistEntry ple : dfr.getPicklistValues()) {
            options.add(new selectOption(ple.getValue(), ple.getLabel(), !ple.isActive()));
        }
        return options;
    } 
    public List<SelectOption> getrotintevnt() {/*for disp_con.Rotation_Interest_Event_Type__c field*/
        List<selectOption> options = new List<selectOption>();
        Schema.DescribeFieldResult dfr = Contact.Rotation_Interest_Event_Type__c.getDescribe();
        for (Schema.PicklistEntry ple : dfr.getPicklistValues()) {
            options.add(new selectOption(ple.getValue(), ple.getLabel(), !ple.isActive()));
        }
        return options;
    } 
    public List<SelectOption> gethouseplans() {/*for disp_con.Rotation_Housing_Plans__c field*/
        List<selectOption> options = new List<selectOption>();
        Schema.DescribeFieldResult dfr = Contact.Rotation_Housing_Plans__c.getDescribe();
        for (Schema.PicklistEntry ple : dfr.getPicklistValues()) {
            options.add(new selectOption(ple.getValue(), ple.getLabel(), !ple.isActive()));
        }
        return options;
    } 
    
    /*This is for required message in My Detail Page at each field if it is Empty while saving.*/
    Public boolean phone_bool{get;set;}
    Public boolean city_bool{get;set;}
    Public boolean cor_bool{get;set;}
    Public boolean relat_bool{get;set;}
    Public boolean lang_bool{get;set;}
    Public boolean inter_bool{get;set;}
    Public boolean inevnt_bool{get;set;}
    Public boolean avgent_bool{get;set;}
    Public boolean hous_bool{get;set;}
    Public boolean hand_bool{get;set;}
    Public boolean diet_bool{get;set;}
    Public boolean aleg_bool{get;set;}
    Public boolean secpass_bool{get;set;}
    Public boolean cob_bool{get;set;}
    Public boolean cociti_bool{get;set;}
    Public boolean resplan_bool{get;set;}
    Public boolean all_bool{get;set;}
    public boolean bir_date{get;set;}
    public boolean mydetail_pop{get;set;}
   
    public void save_rotcontact() {
    /*My Detail page save functionality*/
        phone_bool=false;
        city_bool=false;
        cor_bool=false;
        relat_bool=false;
        lang_bool=false;
        inter_bool=false;
        inevnt_bool=false;
        avgent_bool=false;
        hous_bool=false;
        hand_bool=false;
        diet_bool=false;
        aleg_bool=false;
        secpass_bool=false;
        cob_bool=false;
        cociti_bool=false;
        resplan_bool=false;
        all_bool=false;
        bir_date=false;
        mydetail_pop=false;
        
        boolean detail_bool=true;
        String myDate=birthdate;
        if(birthdate!=null && birthdate!='' && disp_con.birthdate==null){
            String RE_date= '(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[012])/((19|20)\\d\\d)';
            Pattern MyPattern = Pattern.compile(RE_date);
            Matcher MyMatcher = MyPattern.matcher(myDate);
            if (!MyMatcher.matches()) {
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter the right date format, e.g. 15/07/1998.'));
                return; 
            }
            try{
            if(myDate!=null){
                String stringDate = myDate.substring(6,10) + '-' + 
                            myDate.substring(3,5) + '-' +
                            myDate.substring(0,2);
                stringDate=stringDate;//+' 00:00:00';
                Date dt = date.valueOf(stringDate);
                disp_con.birthdate=dt;
            }
            }
            Catch(Exception e){
                ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter the right date format, e.g. 15/07/1998.'));
                return; 
            }
        }
        //disp_con.Rotation_Housing_Plans__c=mPicklistValue;
        if(disp_con.MobilePhone==null){
            phone_bool=true;
            all_bool=true;
        }
        if(disp_con.City_Of_Birth__c==null){
            city_bool=true;
            all_bool=true;
        }
        if (disp_con.Country_Of_Residence__c==null){
            cor_bool=true;
            all_bool=true;
        }
        if(disp_con.Relationship_Status__c==null){
            relat_bool=true;
            all_bool=true;
        }
        if(disp_con.Languages__c==null){
            lang_bool=true;
            all_bool=true;
        }
        if(disp_con.Rotation_Interests__c==null){
            inter_bool=true;
            all_bool=true;
        }
        if(disp_con.Rotation_Interest_Event_Type__c==null){
            inevnt_bool=true;
            all_bool=true;
        }
        if(disp_con.Rotation_Avg_Entrance_Fee_Amount__c==null){
            avgent_bool=true;
            all_bool=true;
        }
        if(disp_con.Rotation_Housing_Plans__c==null){
            hous_bool=true;
            all_bool=true;
        }
        if(disp_con.Need_handicap_access_while_rotation__c==null){
            hand_bool=true;
            all_bool=true;
        }
        if(disp_con.Dietary_needs__c==null ){
            diet_bool=true;
            all_bool=true;
        }
        if(disp_con.Specific_medical_needs_or_Alergies__c==null){
            aleg_bool=true;
            all_bool=true;
        }
        if(disp_con.Have_second_Passport__c==null){
            secpass_bool=true;
            all_bool=true;
        }
        if(disp_con.Country_Of_Origin__c==null){
            cob_bool=true;
            all_bool=true;
        }
        if(disp_con.Country_Of_Citizenship__c==null){
            cociti_bool=true;
            all_bool=true;
        }
        if(disp_con.birthdate==null){
            bir_date=true;
            all_bool=true;
        }
        if(disphplan && disp_con.Rotation_Housing_Resources_Plan__c==null){
            resplan_bool=true;
            all_bool=true;
        }
        
        if(all_bool){
            detail_bool=false;
            ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Required fields cannot be blank.'));
        }
        if(detail_bool){
            disp_con.Mydetails_Rotation_Tab_Completed__c=true;
            update disp_con;
            showlink=true;
            show_msg=true;
            show_mydetail=false;
            mydetail_pop=true;
        }
    }
    public void save_rot() {
       /* Rotation page save functionality*/
        boolean rot_save=true;
        try{
            if(disp_rot.Rotation_Campus__c=='Dubai' && (disp_rot.Address_Line1__c==null || disp_rot.Postal_Code__c==null || disp_rot.City__c==null
                     || disp_rot.Country__c==null || disp_rot.Father_Name__c==null || disp_rot.Mother_Name__c==null || disp_rot.Religion__c==null)){
                    rot_save=false;
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Required fields cannot be blank.'));
                    return;
                }
                else if(disp_rot.Rotation_Campus__c=='London' && (disp_rot.Previous_Visa_Refusal_Notes__c==null 
                        || disp_rot.Previously_Studied_in_UK__c==null || disp_rot.had_treatment_on_the_NHS_Whilst_in_Uk__c==null)){
                    rot_save=false;
                    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Required fields cannot be blank.'));
                    return;
                }
                if(rot_save){
                    update disp_rot;
                    apexpages.addmessage(new apexpages.message(apexpages.severity.confirm,'Record Saved Succesfully'));
                    return;
                }
        }
        Catch(Exception e){
            apexpages.addmessage(new apexpages.message(apexpages.severity.Error,''+e.getMessage()));
            return;
        }
    }
    
    /*Dependents*/
    public List<Dependent__c> deps{get;set;}
    public string dep_id{get;set;}
    public list<createdeps> create_deps{get;set;}
    public boolean disp_view{get;set;}
    public boolean disp_new{get;set;}
    public boolean disp_selexist_dep{get;set;}
    public String rot_id{get;set;}
    public string dep_viewtext{get;set;}
    public boolean ismoredepsexist{get;set;}
    
    public void init_dependents()
    {/*Displays Existing dependents*/
        disp_view=true;
        disp_new=false;
        disp_selexist_dep=false;
        deps=new List<Dependent__c>();
        dep_viewtext='Travelling Dependents';
        create_deps=new list<createdeps>();
        List<Rotation__c> rots=[select id,Student__c,(select id,Name,Date_of_Birth__c,First_Name__c,Gender__c,Last_Name__c,Relationship__c,
                                Rotation1__c,Rotation2__c,Have_second_Passport__c,Student__c from Dependents__r),Name,(select id,Name,Date_of_Birth__c,
                                First_Name__c,Gender__c,Have_second_Passport__c,Last_Name__c,Relationship__c,Rotation1__c,Rotation2__c,
                                Student__c from Rotation2Dependents__r) from Rotation__c where id=:rot_id];
        
        for(Rotation__c r:rots)
        {
            stuid=r.Student__c;
            for(Dependent__c d:r.Dependents__r)
            {
                deps.add(d);
            }
            for(Dependent__c d:r.Rotation2Dependents__r)
            {
                deps.add(d);
            }
        }
        ismoredepsexist=false;
        for(Dependent__c d:[select id,Name,Rotation1__c,Rotation2__c,
                        Student__c from Dependent__c where Rotation1__c!=:rot_id and Rotation2__c!=:rot_id and Student__c=:stuid])
        {
            if(d.Rotation1__c!=null && d.Rotation2__c!=null)
                continue;
            if(d.Rotation1__c!=rot_id  && d.Rotation1__c==null)
                ismoredepsexist=true; 
            else if(d.Rotation2__c!=rot_id  && d.Rotation2__c==null)
                ismoredepsexist=true;            
        }
        
    } 
    public class createdeps
    {/*DEpendents inner class*/
        public boolean isselected{get;set;}
        public Dependent__c depend{get;set;}
        public boolean remove_btn{get;set;}
        public string has2passport{get;set;}
        public String dep_dob{get;set;}
        createdeps(string depid,string studid)
        {
            isselected=true;
            depend=new Dependent__c();
            depend.Rotation1__c=depid;
            depend.student__c=studid;   
            has2passport='false';
            remove_btn=true;
        }
        createdeps(boolean sel,Dependent__c dependents)
        {
            isselected=sel;
            depend=dependents;
            /*Datetime br2= dependents.Date_of_Birth__c;
            if(br2!=null)
                dep_dob= br2.format('dd/MM/yyyy');*/
             if(dependents.Date_of_Birth__c!=null)    
                 dep_dob=dependents.Date_of_Birth__c.day()+'/'+dependents.Date_of_Birth__c.month()+'/'+dependents.Date_of_Birth__c.year();
            
            if(dependents.Have_second_Passport__c)
                has2passport='true';
            else
                has2passport='false';    
            remove_btn=false;
        }
    }
    
    public PageReference delete_dep()
    {/*Removes dependents from a rotation*/
        system.debug('------'+ApexPages.CurrentPage().getParameters().get('depsid'));
        if(ApexPages.CurrentPage().getParameters().get('depsid')!=null)
        {
            integer i=0;
            for(Dependent__c d : deps)
            {
                 
                if(d.Id==ApexPages.CurrentPage().getParameters().get('depsid'))
                {
                    if(d.Rotation1__c==rot_id)
                    {
                        d.Rotation1__c=null;
                    }
                    if(d.Rotation2__c==rot_id)
                    {
                        d.Rotation2__c=null;
                    }
                    update d;
                    init_dependents();
                }
            }
        }
        return null;
    }
    public void New_dep()
    { /*Displays existing dependents that are not in this rotation*/
    disp_view=false;
    disp_selexist_dep=true;
    disp_new=false;
    dep_viewtext='Add Existing Dependents';
       create_deps=new list<createdeps>();
        List<Dependent__c> dep=[select id,Name,Date_of_Birth__c,First_Name__c,Gender__c,Last_Name__c,Relationship__c,Have_second_Passport__c,
             Rotation1__c,Rotation2__c,Student__c from Dependent__c where Rotation1__c!=:rot_id and Rotation2__c!=:rot_id and Student__c=:stuid];
        boolean isexist=false;
        for(Dependent__c d:dep)
        {
            if(d.Rotation1__c!=null && d.Rotation2__c!=null)
                continue;
            if(d.Rotation1__c!=rot_id  && d.Rotation1__c==null)
            {   d.Rotation1__c=rot_id; isexist=true;}
            else if(d.Rotation2__c!=rot_id  && d.Rotation2__c==null)
            {   d.Rotation2__c=rot_id; isexist=true;}
            
            create_deps.add(new createdeps(false,d));
        }
        if(!isexist)
        {
            apexpages.addmessage(new apexpages.message(apexpages.severity.warning,'No dependents avail for adding to this rotation. Please hit cancel and select Add New Dependent to create new Dependent.'));
        }
    }
    public void add_newdep()
    {/* Display New/fresh Dependent which are not in contact also*/
        disp_view=false;
        disp_new=true;
        disp_selexist_dep=false;
        dep_viewtext='Add New Dependents';
        create_deps=new list<createdeps>();
        create_deps.add(new createdeps(rot_id,stuid));
    }
    public void add_blankdep()
    {
        /* Display New/fresh Dependent which are not in contact to the above method retuned values*/
        create_deps.add(new createdeps(rot_id,stuid));
    }
        
    public void save_deps()
    {/*saves dependent*/
        list<Dependent__c> save_deps=new list<Dependent__c>();
        list<Dependent__c> pasport2_deps=new list<Dependent__c>();
        for(createdeps d:create_deps)
        {
            if(d.isselected)
            {
                if(d.depend.First_Name__c==null ||d.depend.Last_Name__c==null || d.depend.Relationship__c==null || d.depend.Gender__c==null || d.dep_dob=='')
                {
                    apexpages.addmessage(new apexpages.message(apexpages.severity.Error,'FirstName, LastName, RelationShip, Gender, Dateof Birth are Required. '));
                    return;
                }
                //System.debug(d.depend+'********************'+d.has2passport);
                if(d.depend.Date_of_Birth__c==null)
                {
                    String myDate1=d.dep_dob;
                    String RE_date1= '(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[012])/((19|20)\\d\\d)';
                    Pattern MyPattern1 = Pattern.compile(RE_date1);
                    Matcher MyMatcher1 = MyPattern1.matcher(myDate1);
                    if (!MyMatcher1.matches()) {
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter the right date format, e.g. 15/07/1998.'));
                        return; 
                    }System.Debug(d.dep_dob+'*********************'+myDate1);
                    try{
                        if(myDate1!=null){
                            String stringDate1 = myDate1.substring(6,10) + '-' + 
                                        myDate1.substring(3,5) + '-' +
                                        myDate1.substring(0,2);
                            stringDate1=stringDate1;//+' 00:00:00';
                            Date dt1 = date.valueOf(stringDate1);
                            d.depend.Date_of_Birth__c=dt1;
                        }
                    }
                    catch(Exception e){
                        ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter the right date format, e.g. 15/07/1998.'));
                        return;
                    }
                }
                if(d.has2passport=='true')
                    d.depend.Have_second_Passport__c=true;
                save_deps.add(d.depend);
                if(d.depend.Have_second_Passport__c)
                {
                    pasport2_deps.add(d.depend);
                }
            }
        }
        if(!save_deps.IsEmpty())
        {
            try
            {
                upsert save_deps;
                apexpages.addmessage(new apexpages.message(apexpages.severity.Confirm,'Records Saved Succesfully'));
                if(!pasport2_deps.ISempty())
                {
                    create2passport(pasport2_deps);
                }
                init_dependents();
            }
            catch(Exception e)
            {
                System.debug(e);
                apexpages.addmessage(new apexpages.message(apexpages.severity.error,'Error : '+e));
            }
        }
        else
        {
            apexpages.addmessage(new apexpages.message(apexpages.severity.warning,'No Records are Selected.'));
        }
    }
    
    public void create2passport(list<Dependent__c> deps)
    {/*create 2 passport for dependent.*/
        List<Rotation_Documents__c> allupdt=new List<Rotation_Documents__c>();
        map<string,Rotation_Documents__c> map_docs=new map<string,Rotation_Documents__c>();
        list<Rotation_Documents__c> rdoc=[select id,Name,dependent__c,Rotation1__c,Rotation2__c from Rotation_Documents__c where dependent__c IN: deps and Name='Second Passport'];
        if(!rdoc.IsEmpty()){
            for(Rotation_Documents__c rd:rdoc){
                map_docs.put(rd.dependent__c,rd);
            }
        }
        for(Dependent__c d:deps){
            Rotation_Documents__c rr=new Rotation_Documents__c();
            rr.Name='Second Passport';
            rr.Dependent__c=d.id;
            if(map_docs.containsKey(d.id))
            {
                rr=map_docs.get(d.id);
            }
            if(d.rotation1__c!=null && d.Rotation1__c!=rr.Rotation1__c)
                rr.Rotation1__c=d.Rotation1__c;
            if(d.rotation2__c!=null && d.Rotation2__c!=rr.Rotation2__c)
                rr.Rotation2__c=d.Rotation2__c;
            
            allupdt.add(rr);    
        }
        if(!allupdt.ISempty()){
            try{
                upsert allupdt;
            }
            Catch(Exception e){}
        }
    }
    public void cancl()
    {/*cancel button code on dependents.*/
        init_dependents();
    }
    public boolean disphplan{get;set;}
    public void change()
    {/*for field Dependency*/
        disphplan=false;
        string pickval=disp_con.Rotation_Housing_Plans__c;
        if(pickval!=null && (pickval.contains('Find independent lease or sub-let') || pickval.contains('Long-term hotel or hostel')))
        {
            disphplan=true;
        }
        return;
    }
    
    public boolean disphplan1{get;set;}
    public void change1()
    {/*for field Dependency*/
        disphplan1=false;
        string pickval1=disp_con.Rotation_Housing_Resources_Plan__c;
        if(pickval1!=null && pickval1.contains('Other'))
        {
            disphplan1=true;
        }
        return;
    }
    
    public List<SelectOption> getrot_values() {// for rotation pick list
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('Yes','Yes'));
        options.add(new SelectOption('No','No'));
        return options;
    }
}