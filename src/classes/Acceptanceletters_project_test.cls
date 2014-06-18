/*
Create By    :- Premanath Reddy
Created Date :- 08/01/14
Purpose      :- Test class for Acceptanceletters_project class
*/
@isTest
public class Acceptanceletters_project_test{
    // This Test method is for BIBA
    static testmethod void biba_method(){
        
        Department__c dept=new Department__c();
        dept.Name='BIBA';
        insert dept;
        
        Program__c pro =new Program__c();
        pro.name='Bachelor of International Business Administration-UK-London';
        pro.Department__c=dept.id;
        insert pro;
        
        Opportunity opp= new Opportunity();
        opp.Name = 'OpportunityName';
        opp.StageName = 'Accepted';
        opp.CloseDate = Date.today();
        opp.Program__c = pro.Id;
        opp.Start_Term__c='September'+' '+system.today().year();
        opp.Primary_Campus__c='Boston';
        insert opp;
        
        Opportunity_Finance__c fin=new Opportunity_Finance__c();
        fin.Opportunity__c=opp.id;
        insert fin;
        
        Apexpages.Currentpage().getParameters().put('id',opp.id);
        Acceptanceletters_project o=new Acceptanceletters_project();
        o.donothing();
        
        opp.StageName='Accepted';
        opp.Primary_Campus__c='Dubai';
        opp.BBA_Student_Type__c='First Year Advanced';
        update opp;
        Apexpages.Currentpage().getParameters().put('type','pdf');
        o=new Acceptanceletters_project();
        
        test.startTest();
        
        opp.StageName='Accepted';
        opp.Primary_Campus__c='London';
        opp.Conditionally_Accepted_Reasons__c='Official HS trans/ diploma;Official University trans/diploma;Ofcl English translat of transcr/degree;Official Inst/School TOEFL/ IELTS score;Official Inst/School GMAT/ GRE score;Cert of successful compl 3 mo IEMA prog;Cert of successful compl 6 mo IEMA prog;Additional prof/ academic reference;';
        update opp;
        Apexpages.Currentpage().getParameters().put('type','word');
        o=new Acceptanceletters_project();
        
        opp.StageName='Accepted';
        opp.Primary_Campus__c='San Francisco';
        opp.BBA_Student_Type__c='First Year';
        update opp;
        o=new Acceptanceletters_project();
        
        opp.StageName='Conditionally Accepted';
        opp.Admission_Endorsed_reasons__c='Officl Inst/School cop TOEFL/IELTS score;Officl Inst/School copy of GMAT/GRE;Cert IEMA 3 mo. Intensive English Prog;Cert IEMA 6 mo. Intensive English Prog;Cert of the EF Pre-Master’s Prog;Cert of UPiBT with 60-63;Official copy of SHL score report;Official copy of BEST score report;Transcripts with GPA of at least 2.5;Offcl University Foundation Year Diploma;Officl Diploma in Business Management;Additional academic/prof ref letter;';
        opp.Primary_Campus__c='Shanghai';
        update opp;
        o=new Acceptanceletters_project();
        
        opp.StageName='Conditionally Accepted';
        opp.Admission_Endorsed_reasons__c='Officl Inst/School cop TOEFL/IELTS score;Cert IEMA 6 mo. Intensive English Prog;Cert of the EF Pre-Master’s Prog;Official copy of SHL score report;Official copy of BEST score report;Transcripts with GPA of at least 2.5;Additional academic/prof ref letter;';
        opp.Primary_Campus__c='Undecided';
        update opp;
        o=new Acceptanceletters_project();
        
        opp.StageName='Rejected';
        opp.Rejected_Reason__c='Insufficient work experience;No Bachelor degree;';
        update opp;
        o=new Acceptanceletters_project();
        
        opp.StageName='Confirmed';
        update opp;
        o=new Acceptanceletters_project();
        
        List<Document> doclst = new List<Document>();
        Document document = new Document();
        document.AuthorId = UserInfo.getUserId();
        document.FolderId = UserInfo.getUserId();
        document.Name='Hult Logo for Web';
        doclst.add(document);
        
        Document document1 = new Document();
        document1.AuthorId = UserInfo.getUserId();
        document1.FolderId = UserInfo.getUserId();
        document1.Name='Henrik sign';
        doclst.add(document1);
        
        Document document2 = new Document();
        document2.AuthorId = UserInfo.getUserId();
        document2.FolderId = UserInfo.getUserId();
        document2.Name='London_footer';
        doclst.add(document2);
        
        Document document3 = new Document();
        document3.AuthorId = UserInfo.getUserId();
        document3.FolderId = UserInfo.getUserId();
        document3.Name='Dubai_footer';
        doclst.add(document3);
        
        Document document4 = new Document();
        document4.AuthorId = UserInfo.getUserId();
        document4.FolderId = UserInfo.getUserId();
        document4.Name='Ian Dougal sign';
        doclst.add(document4);
        
        insert doclst;
        o=new Acceptanceletters_project();
        test.stopTest();
    }
    // This test method is for Non-BIBA
    static testmethod void nonbiba_method(){
        Department__c dept=new Department__c();
        dept.Name='MBA';
        insert dept;
        
        Program__c pro =new Program__c();
        pro.name='MBA-US-Boston';
        pro.Department__c=dept.id;
        insert pro;
        
        Opportunity opp= new Opportunity();
        opp.Name = 'OpportunityName';
        opp.StageName = 'Accepted';
        opp.CloseDate = Date.today();
        opp.Program__c = pro.Id;
        opp.Start_Term__c='September'+' '+system.today().year();
        opp.Primary_Campus__c='Boston';
        insert opp;
        
        Opportunity_Finance__c fin=new Opportunity_Finance__c();
        fin.Opportunity__c=opp.id;
        insert fin;
        
        Apexpages.Currentpage().getParameters().put('id',opp.id);
        Acceptanceletters_project o=new Acceptanceletters_project();
        o.donothing();
        
        opp.StageName='Accepted';
        opp.Primary_Campus__c='London';
        opp.Conditionally_Accepted_Reasons__c='Official HS trans/ diploma;Official University trans/diploma;Ofcl English translat of transcr/degree;Official Inst/School TOEFL/ IELTS score;Official Inst/School GMAT/ GRE score;Cert of successful compl 3 mo IEMA prog;Cert of successful compl 6 mo IEMA prog;Additional prof/ academic reference;';
        update opp;
        Apexpages.Currentpage().getParameters().put('type','word');
        o=new Acceptanceletters_project();
        
        opp.StageName='Accepted';
        opp.Primary_Campus__c='Dubai';
        opp.BBA_Student_Type__c='First Year Advanced';
        update opp;
        Apexpages.Currentpage().getParameters().put('type','pdf');
        o=new Acceptanceletters_project();
        
        opp.StageName='Conditionally Accepted';
        opp.Admission_Endorsed_reasons__c='Officl Inst/School cop TOEFL/IELTS score;Officl Inst/School copy of GMAT/GRE;Cert IEMA 3 mo. Intensive English Prog';
        opp.Primary_Campus__c='Shanghai';
        update opp;
        o=new Acceptanceletters_project();
        
        opp.StageName='Conditionally Accepted';
        opp.Admission_Endorsed_reasons__c='Officl Inst/School cop TOEFL/IELTS score;Cert IEMA 6 mo. Intensive English Prog;Cert of the EF Pre-Master’s Prog;Official copy of SHL score report;Official copy of BEST score report;Transcripts with GPA of at least 2.5;Additional academic/prof ref letter;';
        opp.Primary_Campus__c='Shanghai';
        update opp;
        o=new Acceptanceletters_project();
        
        opp.StageName='Soft Rejected';
        opp.Rejected_Reason__c='Insufficient work experience;No Bachelor degree;';
        opp.Primary_Campus__c='San Francisco';
        opp.BBA_Student_Type__c='First Year';
        update opp;
        o=new Acceptanceletters_project();
        
        test.startTest();
        
        opp.StageName='Rejected';
        update opp;
        o=new Acceptanceletters_project();
        
        opp.Program__c = pro.Id;
        opp.StageName='Confirmed';
        update opp;
        o=new Acceptanceletters_project();
        
        Department__c dept1=new Department__c();
        dept1.Name='Undecided';
        insert dept1;
        
        Program__c pro1 =new Program__c();
        pro1.name='Undecided-US-San Francisco';
        pro1.Department__c=dept1.id;
        insert pro1;
        
        opp.Program__c = pro1.Id;
        opp.StageName='Undecided';
        update opp;
        o=new Acceptanceletters_project();
        test.stopTest();
    } 
}