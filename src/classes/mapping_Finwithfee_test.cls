/*
Author : Premanath Reddy
pupose : Test class for add_fee2finance and conect_finwithfee Triggers,mapping_Finwithfeevalues class
*/
@isTest(seeAllData=true)
public class mapping_Finwithfee_test{
    static testmethod void methodname(){
        
        Department__c dept=new Department__c();
        dept.Name='BIBA';
        insert dept;
        
        Program__c pro =new Program__c();
        pro.name='Bachelor of International Business Administration-UK-London';
        pro.Campus__c='London';
        pro.Department__c=dept.id;
        insert pro;
        
        fees__c fee=[Select id,Program_Name__r.Name
                    ,BBA_Program_Fee_Year_1_BBA__c,BBA_Program_Fee_Year_2__c,BBA_Program_Fee_Year_3_BBA__c,BBA_Program_Fee_Year_4_BBA__c
                    ,BBA_Erika_Insurance_Year_1_Single_BBA__c,BBA_Erika_Insurnce_Year_2_Single_BBA__c,BBA_Erika_Insurance_Year_3_Single_BBA__c,BBA_Erika_Insurance_Year_4_Single_BBA__c
                    ,BBA_Aetna_Insurance_Year_1__c,BBA_Aetna_Insurance_Year_2__c,BBA_Aetna_Insurance_Year_3__c,BBA_Aetna_Insurance_Year_4__c
                    ,BBA_Installment_Plan_Year_1_BBA__c,BBA_Installment_Plan_Year_2_BBA__c,BBA_Installment_Plan_Year_3_BBA__c,BBA_Installment_Plan_Year_4_BBA__c
                    ,BBA_Solo_36_Weeks_Year_1__c,BBA_Twin_43_Weeks_Year_2__c,BBA_Studio_51_Weeks_Year_3__c,BBA_Apartment_43_Weeks_Year_4__c
                    ,BBA_SHA_Housing_BBA_Accomm_Mod_D__c,BBA_SHA_Housing_BBA_Accomm_Mod_E__c,BBA_SHA_Housing_Suite_Mod_D__c,BBA_SHA_Housing_Suite_Mod_E__c,BBA_SHA_Housing_Dependent_Mod_D__c
                    ,BBA_SHA_Housing_Dependent_Mod_E__c,BBA_SHA_Visa_JW_202__c,BBA_Insurance_Erika_Mod_D__c,BBA_Insurance_Erika_Mod_E__c
                    ,Solo_43_Weeks__c,SHA_Housing_Type_A_Mod_E__c,SHA_Housing_Type_C1_Mod_E__c
                    ,SHA_Housing_Type_E_Mod_E__c,SHA_Housing_Dependent_E__c,Insurance_Erika_Mod_E__c
                    ,NYC_Housing_Single_Mod_D__c,BBA_DUB_Visa_Visit__c,BBA_DUB_Visa_Residence__c,BBA_DUB_Visa_Transit__c
                    from fees__c where Program_Name__r.Name like '%Bachelor%' limit 1];
        /*
        fees__c fee=new fees__c();
        fee.Year__c='2014';
        fee.Program_Name__c=pro.id;
        fee.BBA_Program_Fee_Year_1_BBA__c=10;
        fee.BBA_Program_Fee_Year_2__c=20;
        fee.BBA_Program_Fee_Year_3_BBA__c=30;
        fee.BBA_Program_Fee_Year_4_BBA__c=40;
        fee.BBA_Erika_Insurance_Year_1_Single_BBA__c=50;
        fee.BBA_Erika_Insurnce_Year_2_Single_BBA__c=60;
        fee.BBA_Erika_Insurance_Year_3_Single_BBA__c=70;
        fee.BBA_Erika_Insurance_Year_4_Single_BBA__c=80;
        fee.BBA_Aetna_Insurance_Year_1__c=90;
        fee.BBA_Aetna_Insurance_Year_2__c=100;
        fee.BBA_Aetna_Insurance_Year_3__c=110;
        fee.BBA_Aetna_Insurance_Year_4__c=120;
        fee.BBA_Installment_Plan_Year_1_BBA__c=130;
        fee.BBA_Installment_Plan_Year_2_BBA__c=140;
        fee.BBA_Installment_Plan_Year_3_BBA__c=150;
        fee.BBA_Installment_Plan_Year_4_BBA__c=160;
        fee.BBA_Solo_36_Weeks_Year_1__c=170;
        fee.BBA_Twin_43_Weeks_Year_2__c=180;
        fee.BBA_Studio_51_Weeks_Year_3__c=190;
        fee.BBA_Apartment_43_Weeks_Year_4__c=200;
        fee.BBA_SHA_Housing_BBA_Accomm_Mod_D__c=210;
        fee.BBA_SHA_Housing_BBA_Accomm_Mod_E__c=220;
        fee.BBA_SHA_Housing_Suite_Mod_D__c=230;
        fee.BBA_SHA_Housing_Suite_Mod_E__c=240;
        fee.BBA_SHA_Housing_Dependent_Mod_D__c=250;
        fee.BBA_SHA_Housing_Dependent_Mod_E__c=260;
        fee.BBA_SHA_Visa_JW_202__c=270;
        fee.BBA_UAE_Visa_Visit__c=280;
        fee.BBA_UAE_Visa_Residence__c=290;
        fee.BBA_UAE_Visa_Transit__c=300;
        fee.BBA_Insurance_Erika_Mod_D__c=310;
        fee.Solo_43_Weeks__c=320;
        fee.Housing_Single_Mod_D__c=330;
        fee.SHA_Housing_Type_A_Mod_E__c=340;
        fee.SHA_Housing_Type_C1_Mod_E__c=350;
        fee.SHA_Housing_Type_E_Mod_E__c=360;
        fee.SHA_Housing_Dependent_E__c=370;
        fee.Insurance_Erika_Mod_E__c=380;
        insert fee; */
               
        Opportunity opp= new Opportunity();
        opp.Name = 'OpportunityName';
        opp.StageName = 'Accepted';
        opp.CloseDate = Date.today();
        opp.Program__c = pro.Id;
        opp.Start_Term__c='September 2014';
        opp.Start_Term__c='September'+' '+system.today().year();
        opp.Primary_Campus__c='Boston';
        insert opp;
        
        Opportunity_Finance__c fin=new Opportunity_Finance__c();
        fin.Opportunity__c=opp.id;
        fin.Fees__c=fee.id;
        insert fin;
        test.startTest();
        // points e,f,g,h
        fin.BBA_Insurance_Picklist_Year_1__c='Erika Insurance';
        fin.BBA_Insurance_Picklist_Year_2__c='Erika Insurance';
        fin.BBA_Insurance_Picklist_Year_3__c='Erika Insurance';
        fin.BBA_Insurance_Picklist_Year_4__c='Erika Insurance';
        // points i,j
        fin.BBA_Installment_Plan_Picklist__c='Installment Plan - Year 1';
        fin.BBA_Installment_Plan_Picklist_Year_2__c='Installment Plan - Year 2';
        fin.BBA_Installment_Plan_Picklist_Year_3__c='Installment Plan - Year 3';
        fin.BBA_Installment_Plan_Picklist_Year_4__c='Installment Plan - Year 4';
        //point k
        fin.BBA_Accommodation_Year_1__c='solo';
        fin.BBA_Accommodation_Weeks_Year_1__c='36';
        fin.BBA_Accommodation_Year_2__c='twin';
        fin.BBA_Accommodation_Weeks_Year_2__c='43';
        fin.BBA_Accommodation_Year_3__c='studio';
        fin.BBA_Accommodation_Weeks_Year_3__c='51';
        fin.BBA_Accommodation_Year_4__c='apartment';
        fin.BBA_Accommodation_Weeks_Year_4__c='43';
        // for points m,n
        fin.BBA_Rotation_1_Year_1__c='sha - housing - bba accommodation - mod d';
        fin.BBA_Rotation_1_Year_2__c='sha - housing - bba accommodation - mod e';
        fin.BBA_Rotation_1_Year_3__c='sha - housing - suite - mod d';
        fin.BBA_Rotation_1_Year_4__c='sha - housing - suite - mod e';
        fin.BBA_Rotation_2_Year_1__c='sha - housing - dependent - mod d';
        fin.BBA_Rotation_2_Year_2__c='sha - housing - dependent - mod e';
        fin.BBA_Rotation_2_Year_3__c='sha - visa - jw-202';
        fin.BBA_Rotation_2_Year_4__c='dub - visa - visit';
        fin.BBA_Rotation_3_Year_1__c='dub - visa - residence';
        fin.BBA_Rotation_3_Year_2__c='dub - visa - transit';
        fin.BBA_Rotation_3_Year_3__c='insurance - erika - mod d';
        fin.BBA_Rotation_3_Year_4__c='insurance - erika - mod e';
        fin.BBA_Rotation_4_Year_1__c='dub - visa - residence';
        fin.BBA_Rotation_4_Year_2__c='dub - visa - transit';
        fin.BBA_Rotation_4_Year_3__c='insurance - erika - mod d';
        fin.BBA_Rotation_4_Year_4__c='insurance - erika - mod e';
        fin.BBA_Rotation_5_Year_1__c='dub - visa - residence';
        fin.BBA_Rotation_5_Year_2__c='dub - visa - transit';
        fin.BBA_Rotation_5_Year_3__c='insurance - erika - mod d';
        fin.BBA_Rotation_5_Year_4__c='insurance - erika - mod e';
        
        fin.Housing_Accommodation__c='Solo';
        fin.Accommodation_weeks__c='43';
        fin.Rot_Housing_Module_D__c='NYC - Housing - Single - Mod D';
        fin.Rot_Visa_Module_D__c='SHA - Housing - Type A - Mod E';
        fin.Rot_Insurance_Module_D__c='SHA - Housing - Type C1 - Mod E';
        fin.Rot_Housing_Module_E__c='SHA - Housing - Type E - Mod E';
        fin.Rot_Visa_Module_E__c='SHA - Housing - Dependent - Mod D';
        fin.Rot_Insurance_Module_E__c='Insurance - Erika - Mod E'; 
        
        update fin;
        
        System.assertEquals(fin.BBA_Insurance_Year_1__c,fee.BBA_Erika_Insurance_Year_1_Single_BBA__c);
        System.assertEquals(fin.BBA_Insurance_Year_2__c,fee.BBA_Erika_Insurnce_Year_2_Single_BBA__c);
        System.assertEquals(fin.BBA_Insurance_Year_3__c,fee.BBA_Erika_Insurance_Year_3_Single_BBA__c);
        System.assertEquals(fin.BBA_Insurance_Year_4__c,fee.BBA_Erika_Insurance_Year_4_Single_BBA__c);
        
        System.assertEquals(fin.BBA_Installment_Plan_Year_1__c,fee.BBA_Installment_Plan_Year_1_BBA__c);
        System.assertEquals(fin.BBA_Installment_Plan_Year_2__c,fee.BBA_Installment_Plan_Year_2_BBA__c);
        System.assertEquals(fin.BBA_Installment_Plan_Year_3__c,fee.BBA_Installment_Plan_Year_3_BBA__c);
        System.assertEquals(fin.BBA_Installment_Plan_Year_4__c,fee.BBA_Installment_Plan_Year_4_BBA__c);
        
        System.assertEquals(fin.BBA_Accommodation_Fee_Year_1__c,fee.BBA_Installment_Plan_Year_1_BBA__c);
        System.assertEquals(fin.BBA_Accommodation_Fee_Year_2__c,fee.BBA_Twin_43_Weeks_Year_2__c);
        System.assertEquals(fin.BBA_Accommodation_Fee_Year_3__c,fee.BBA_Studio_51_Weeks_Year_3__c);
        System.assertEquals(fin.BBA_Accommodation_Fee_Year_4__c,fee.BBA_Apartment_43_Weeks_Year_4__c);
        
        System.assertEquals(fin.BBA_Rotation_1_Fee__c,fee.BBA_SHA_Housing_BBA_Accomm_Mod_D__c);
        System.assertEquals(fin.BBA_Rotation_1_Year_2_Fee__c,fee.BBA_SHA_Housing_BBA_Accomm_Mod_E__c);
        System.assertEquals(fin.BBA_Rotation_1_Year_3_Fee__c,fee.BBA_SHA_Housing_Suite_Mod_D__c);
        System.assertEquals(fin.BBA_Rotation_1_Year_4_Fee__c,fee.BBA_SHA_Housing_Suite_Mod_E__c);
        
        System.assertEquals(fin.Annual_Accommodation_Fee__c,fee.Solo_43_Weeks__c);
        
        // updating 2nd time
        fin.BBA_Insurance_Picklist_Year_1__c='Aetna Insurance';
        fin.BBA_Insurance_Picklist_Year_2__c='Aetna Insurance';
        fin.BBA_Insurance_Picklist_Year_3__c='Aetna Insurance';
        fin.BBA_Insurance_Picklist_Year_4__c='Aetna Insurance';
        update fin;
        
        mapping_Finwithfeevalues map_fin=new mapping_Finwithfeevalues();
            
        Fees__c fee1=new Fees__c();
        fee1.Program_Name__c=pro.id;
        fee1.Year__c='2013';
        insert fee1;
        
        Opportunity op=new opportunity();
        op.Name='firstname';
        op.StageName='Confirmed';
        op.Start_Term__c='January 2013';
        op.CloseDate=System.today();
        op.Program__c=pro.id;
        op.Primary_Campus__c=pro.Campus__c;        
        insert op;       
       
        opportunity_Finance__c f=new Opportunity_finance__c();        
        f.Opportunity__c=op.id;
        f.CurrencyIsoCode='USD';
        f.Go_Ed_Loan_Amount__c=200;
        f.Go_Ed_Loan_Amount_First_Rate_USD__c=200;
        f.fees__c=null;
        insert f;
                        
        map_fin=new mapping_Finwithfeevalues();
        test.stopTest();
    }
}