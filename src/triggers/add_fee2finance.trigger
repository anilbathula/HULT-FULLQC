/*
      Developer : Harsha Simha
        Date    : 11/09/2012                  
                   This trigger will set the new Fee value for the finance based on the Start term and Programid (both - Crossobject_formulas)    
      Test class: mapping_Finwithfee_test
      coverage  : 95%         
      Modified  :Anil.B for jira 702 added if condition written a method to populate values in annual_accomidation_fee__c with values from fee object.
      Modified : 20/3/2014  prem :: connects BBA Finanace Record type fields with Fee by calling the mapping_Finwithfeevalues class for field mapping.
      
*/
trigger add_fee2finance on Opportunity_Finance__c (before insert, before update) 
{
    list<string> finids=new list<string>();
    set<string> setsterms=new set<string>();
    set<string> setpgms=new set<string>();
    map<opportunity_finance__c,id>opfin_ids=new map<opportunity_finance__c,id>();
    String bba_rectype=RecordTypeHelper.getRecordTypeId('Opportunity_Finance__c','BBA Finance');
    String nonbba_rectype=RecordTypeHelper.getRecordTypeId('Opportunity_Finance__c','Non-BBA Finance');
    
    for(Opportunity_Finance__c fin:Trigger.new)
    {
        //SHS :: set Finance record type to 'BBA Finance' if the Program__c value starts with 'Bachelor' else 'non-BBA Finance'
       /* if(trigger.isinsert && trigger.isbefore)
        {            
             if(fin.OP_Program__c!=null && fin.OP_Program__c.startsWith('Bachelor')){
                 fin.recordtypeid=bba_rectype;
             }else{
                 fin.recordtypeid=nonbba_rectype;
             }            
        }*/
        system.debug(fin.Id+'======================='+fin.OP_Program__c+'========'+fin.Start_Term__c+'========='+fin.OP_Programid__c);
        /*For each triggered finance record checks startterm,Programid should not be null and Fees should be null and extracts last 4 digits of start term*/
        if(fin.fees__c==null && fin.Start_Term__c!=null && fin.OP_Programid__c!=null )
        {
            string sterm=fin.Start_Term__c;
            sterm=sterm.trim();
            sterm=sterm.contains(' ')?sterm.replace(' ',''):sterm;
            if(sterm!=null && sterm!='' && sterm.length()>=4 && (fin.OP_Programid__c.length()>=15))
            {
                sterm=sterm.substring(sterm.length()-4,sterm.length());
                setsterms.add(sterm);
                setpgms.add(fin.OP_Programid__c);
            }
              
        }else if(trigger.Isupdate && Fin.fees__c!=null && trigger.oldmap.get(fin.id).Housing_Accommodation__c!=fin.Housing_Accommodation__c ){
            opfin_ids.put(fin,fin.fees__c);
        }      
    }
    /*Extract Fees based on programs and check start term and program if matches assign fee to finance*/
    if(!setsterms.IsEmpty() && !setpgms.IsEmpty())
    {
        List<Fees__c> fees=[select id,Name,CurrencyIsoCode,year__c,Application_Fee__c,Program_Name__c,Single_Annual__c, Shared_Twin_Annual__c,
                            Hult_House_East_12_Months__c,Accommodation_with_dependent_for_8_mths__c,Accommodation_for_12_months__c,
                            Accommodation_for_8_months__c,Free_accommodation_with_dependent_8mth__c
                            
                            ,BBA_Program_Fee_Year_1_BBA__c,BBA_Program_Fee_Year_2__c,BBA_Program_Fee_Year_3_BBA__c,BBA_Program_Fee_Year_4_BBA__c
                            ,BBA_Erika_Insurance_Year_1_Single_BBA__c,BBA_Erika_Insurnce_Year_2_Single_BBA__c,BBA_Erika_Insurance_Year_3_Single_BBA__c,BBA_Erika_Insurance_Year_4_Single_BBA__c
                            ,BBA_Aetna_Insurance_Year_1__c,BBA_Aetna_Insurance_Year_2__c,BBA_Aetna_Insurance_Year_3__c,BBA_Aetna_Insurance_Year_4__c
                            ,BBA_Installment_Plan_Year_1_BBA__c,BBA_Installment_Plan_Year_2_BBA__c,BBA_Installment_Plan_Year_3_BBA__c,BBA_Installment_Plan_Year_4_BBA__c
                            ,BBA_Solo_36_Weeks_Year_1__c,BBA_Solo_36_Weeks_Year_2__c,BBA_Solo_36_Weeks_Year_3__c,BBA_Solo_36_Weeks_Year_4__c
                            ,BBA_Solo_43_Weeks_Year_1__c,BBA_Solo_43_Weeks_Year_2__c,BBA_Solo_43_Weeks_Year_3__c,BBA_Solo_43_Weeks_Year_4__c
                            ,BBA_Solo_51_Weeks_Year_1__c,BBA_Solo_51_Weeks_Year_2__c,BBA_Solo_51_Weeks_Year_3__c,BBA_Solo_51_Weeks_Year_4__c
                            ,BBA_Solo_Deluxe_36_Weeks_Year_1__c,BBA_Solo_Deluxe_36_Weeks_Year_2__c,BBA_Solo_Deluxe_36_Weeks_Year_3__c,BBA_Solo_Deluxe_36_Weeks_Year_4__c
                            ,BBA_Solo_Deluxe_43_Weeks_Year_1__c,BBA_Solo_Deluxe_43_Weeks_Year_2__c,BBA_Solo_Deluxe_43_Weeks_Year_3__c,BBA_Solo_Deluxe_43_Weeks_Year_4__c
                            ,BBA_Solo_Deluxe_51_Weeks_Year_1__c,BBA_Solo_Deluxe_51_Weeks_Year_2__c,BBA_Solo_Deluxe_51_Weeks_Year_3__c,BBA_Solo_Deluxe_51_Weeks_Year_4__c
                            ,BBA_Studio_36_Weeks_Year_1__c,BBA_Studio_36_Weeks_Year_2__c,BBA_Studio_36_Weeks_Year_3__c,BBA_Studio_36_Weeks_Year_4__c
                            ,BBA_Studio_43_Weeks_Year_1__c,BBA_Studio_43_Weeks_Year_2__c,BBA_Studio_43_Weeks_Year_3__c,BBA_Studio_43_Weeks_Year_4__c
                            ,BBA_Studio_51_Weeks_Year_1__c,BBA_Studio_51_Weeks_Year_2__c,BBA_Studio_51_Weeks_Year_3__c,BBA_Studio_51_Weeks_Year_4__c
                            ,BBA_Studio_Vista_36_Weeks_Year_1__c,BBA_Studio_Vista_36_Weeks_Year_2__c,BBA_Studio_Vista_36_Weeks_Year_3__c,BBA_Studio_Vista_36_Weeks_Year_4__c
                            ,BBA_Studio_Vista_43_Weeks_Year_1__c,BBA_Studio_Vista_43_Weeks_Year_2__c,BBA_Studio_Vista_43_Weeks_Year_3__c,BBA_Studio_Vista_43_Weeks_Year_4__c
                            ,BBA_Studio_Vista_51_Weeks_Year_1__c,BBA_Studio_Vista_51_Weeks_Year_2__c,BBA_Studio_Vista_51_Weeks_Year_3__c,BBA_Studio_Vista_51_Weeks_Year_4__c
                            ,BBA_Twin_36_Weeks_Year_1__c,BBA_Twin_36_Weeks_Year_2__c,BBA_Twin_36_Weeks_Year_3__c,BBA_Twin_36_Weeks_Year_4__c
                            ,BBA_Twin_43_Weeks_Year_1__c,BBA_Twin_43_Weeks_Year_2__c,BBA_Twin_43_Weeks_Year_3__c,BBA_Twin_43_Weeks_Year_4__c
                            ,BBA_Twin_51_Weeks_Year_1__c,BBA_Twin_51_Weeks_Year_2__c,BBA_Twin_51_Weeks_Year_3__c,BBA_Twin_51_Weeks_Year_4__c
                            ,BBA_Twin_Deluxe_36_Weeks_Year_1__c,BBA_Twin_Deluxe_36_Weeks_Year_2__c,BBA_Twin_Deluxe_36_Weeks_Year_3__c,BBA_Twin_Deluxe_36_Weeks_Year_4__c
                            ,BBA_Twin_Deluxe_43_Weeks_Year_1__c,BBA_Twin_Deluxe_43_Weeks_Year_2__c,BBA_Twin_Deluxe_43_Weeks_Year_3__c,BBA_Twin_Deluxe_43_Weeks_Year_4__c
                            ,BBA_Twin_Deluxe_51_Weeks_Year_1__c,BBA_Twin_Deluxe_51_weeks_Year_2__c,BBA_Twin_Deluxe_51_Weeks_Year_3__c,BBA_Twin_Deluxe_51_Weeks_Year_4__c
                            ,BBA_Apartment_36_Weeks_Year_1__c,BBA_Apartment_36_Weeks_Year_2__c,BBA_Apartment_36_Weeks_Year_3__c,BBA_Apartment_36_Weeks_Year_4__c
                            ,BBA_Apartment_43_Weeks_Year_1__c,BBA_Apartment_43_Weeks_Year_2__c,BBA_Apartment_43_Weeks_Year_3__c,BBA_Apartment_43_Weeks_Year_4__c
                            ,BBA_Apartment_51_Weeks_Year_1__c,BBA_Apartment_51_Weeks_Year_2__c,BBA_Apartment_51_Weeks_Year_3__c,BBA_Apartment_51_Weeks_Year_4__c
                            ,BBA_Apartment_Vista_36_Weeks_Year_1__c,BBA_Apartment_Vista_36_Weeks_Year_2__c,BBA_Apartment_Vista_36_Weeks_Year_3__c,BBA_Apartment_Vista_36_Weeks_Year_4__c
                            ,BBA_Apartment_Vista_43_Weeks_Year_1__c,BBA_Apartment_Vista_43_Weeks_Year_2__c,BBA_Apartment_Vista_43_Weeks_Year_3__c,BBA_Apartment_Vista_43_Weeks_Year_4__c
                            ,BBA_Apartment_Vista_51_Weeks_Year_1__c,BBA_Apartment_Vista_51_Weeks_Year_2__c,BBA_Apartment_Vista_51_Weeks_Year_3__c,BBA_Apartment_Vista_51_Weeks_Year_4__c
                            ,BBA_Deluxe_Studio_Apart_36_Weeks_Year_1__c,BBA_Deluxe_Studio_Apart_36_Weeks_Year_2__c,BBA_Deluxe_Studio_Apart_36_Weeks_Year_3__c,BBA_Deluxe_Studio_Apart_36_Weeks_Year_4__c
                            ,BBA_Deluxe_Studio_Apart_43_Weeks_Year_1__c,BBA_Deluxe_Studio_Apart_43_Weeks_Year_2__c,BBA_Deluxe_Studio_Apart_43_Weeks_Year_3__c,BBA_Deluxe_Studio_Apart_43_Weeks_Year_4__c
                            ,BBA_Deluxe_Studio_Apart_51_Weeks_Year_1__c,BBA_Deluxe_Studio_Apart_51_Weeks_Year_2__c,BBA_Deluxe_Studio_Apart_51_Weeks_Year_3__c,BBA_Deluxe_Studio_Apart_51_Weeks_Year_4__c
                            ,BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_1__c,BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_2__c,BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_3__c,BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_4__c
                            ,BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_1__c,BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_2__c,BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_3__c,BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_4__c
                            ,BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_1__c,BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_2__c,BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_3__c,BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_4__c
                            ,BBA_PH_Luxury_Studio_36_Weeks_Year_1__c,BBA_PH_Luxury_Studio_36_Weeks_Year_2__c,BBA_PH_Luxury_Studio_36_Weeks_Year_3__c,BBA_PH_Luxury_Studio_36_Weeks_Year_4__c
                            ,BBA_PH_Luxury_Studio_43_Weeks_Year_1__c,BBA_PH_Luxury_Studio_43_Weeks_Year_2__c,BBA_PH_Luxury_Studio_43_Weeks_Year_3__c,BBA_PH_Luxury_Studio_43_Weeks_Year_4__c
                            ,BBA_PH_Luxury_Studio_51_Weeks_Year_1__c,BBA_PH_Luxury_Studio_51_Weeks_Year_2__c,BBA_PH_Luxury_Studio_51_Weeks_Year_3__c,BBA_PH_Luxury_Studio_51_Weeks_Year_4__c
                            ,BBA_SHA_Housing_BBA_Accomm_Mod_D__c,BBA_SHA_Housing_BBA_Accomm_Mod_E__c,BBA_SHA_Housing_Suite_Mod_D__c,BBA_SHA_Housing_Suite_Mod_E__c,BBA_SHA_Housing_Dependent_Mod_D__c
                            ,BBA_SHA_Housing_Dependent_Mod_E__c,BBA_SHA_Visa_JW_202__c,BBA_Insurance_Erika_Mod_D__c,BBA_Insurance_Erika_Mod_E__c
                            ,BBA_DUB_Visa_Visit__c,BBA_DUB_Visa_Residence__c,BBA_DUB_Visa_Transit__c
                            ,Standard_Double_Room__c,Standard_Double_Room_43_Weeks__c,Standard_Double_Room_51_Weeks__c
                            ,Premium_Double__c,Premium_Double_Room_43_Weeks__c,Premium_Double_Room_51_Weeks__c
                            ,Premium_Single_Room_36_Weeks__c,Premium_Single_Room_43_Weeks__c,Premium_Single_Room_51_Weeks__c
                            
                            from Fees__c where Program_Name__c IN: setpgms and year__c IN: setsterms];
        for(Fees__c f:fees)
        {
            string fid=f.Program_Name__c ;
            for(Opportunity_Finance__c opfin:Trigger.new)
            {   
                if(opfin.OP_ProgramId__c==null || opfin.Start_term__c ==null)
                { 
                    continue;
                }
                string finpid=opfin.OP_ProgramId__c;
                if(fid.substring(0,15)==finpid.substring(0,15)&& opfin.Start_term__c.contains(f.year__c))
                {
                    opfin.Fees__c=f.Id;
                    opfin.CurrencyIsoCode=f.CurrencyIsoCode;
                    //shs :: if bacheclor program map bba related fields from fee to finance.
                    if(opfin.OP_Program__c.startsWith('Bachelor'))
                    {
                        mapping_Finwithfeevalues.linking_BBA_Finance(f,opfin);
                    }
                    system.debug('=----'+opfin.Fees__c);                    
                   // opportunity_finances(f,opfin);
                    break;
                }   
                
            }
        }
             
    }if(!opfin_ids.isempty()){
        List<Fees__c> fees=[select id,Name,CurrencyIsoCode,year__c,Application_Fee__c,Program_Name__c,Single_Annual__c, Shared_Twin_Annual__c,
                            Hult_House_East_12_Months__c,Accommodation_with_dependent_for_8_mths__c,Accommodation_for_12_months__c,
                            Accommodation_for_8_months__c,Free_accommodation_with_dependent_8mth__c,Shanghai_Single_Room_8_Months_Free__c,
                            Dubai_Housing_Bursary__c,EMBA_Hotel__c,Shanghai_Accommodation_Family__c,HH_Twin_Studios_Double__c,HH_Super_Twin_Double__c,
                            HH_Study_Twin_Double__c,HH_Twin_Plus_Double__c,HH_Assam_Studio_Single__c,HH_Studios_Vista_Single__c,
                            HH_Studios_Premium_15_16_Single__c,HH_Studios_Premium_11_14_Single__c,HH_Club_Studio_Deluxe_Single__c,
                            HH_Classic_Studio_Deluxe_Single__c,Accommodation_with_dependent_for_12_mths__c,HH_Club_Studio_Single__c,HH_Classic_Studio_Single__c,HH_Solo_Single__c
                            
                            ,Solo_36_Weeks__c,Solo_43_Weeks__c,Solo_51_Weeks__c
                            ,Solo_Deluxe_36_Weeks__c,Solo_Deluxe_43_Weeks__c,Solo_Deluxe_51_weeks__c
                            ,Twin_36_Weeks__c,Twin_43_Weeks__c,Twin_51_Weeks__c,Twin_Deluxe_36_weeks__c
                            ,Twin_Deluxe_43_weeks__c,Twin_Deluxe_51_weeks__c,Studio_36_weeks__c,Studio_43_weeks__c
                            ,Studio_51_weeks__c,Studio_Vista_36_weeks__c,Studio_Vista_43_weeks__c,Studio_Visa_51_weeks__c
                            ,Apartment_36_weeks__c,Apartment_43__c,Apartment_51_weeks__c,Apartment_Vista_36_weeks__c
                            ,Apartment_Vista_43_weeks__c,Apartment_Visa_51_weeks__c,Deluxe_Studio_Apartment_36_weeks__c
                            ,Deluxe_Studio_Apartment_43_weeks__c,Deluxe_Studio_Apartment_51_weeks__c,Deluxe_Studio_Apartment_Extra_36_weeks__c
                            ,Deluxe_Studio_Apartment_Extra_43_weeks__c,Deluxe_Studio_Apartment_Extra_51_weeks__c
                            
                            ,NYC_Housing_Single_Mod_E__c,NYC_Housing_Single_Mod_D__c,NYC_Housing_Large_Single_Mod_D__c
                            ,NYC_Housing_Twin_Mod_D__c,NYC_Housing_Twin_Mod_D_E__c,NYC_Housing_Twin_Mod_E__c,NYC_Housing_Large_Single_Mod_E__c
                            ,SHA_Housing_Dependent_E__c,SHA_Housing_Dependent__c,SHA_H__c,SHA_Housing_Suite_Mod_E__c
                            ,SHA_Housing_Type_A_Mod_D__c,SHA_Housing_Type_A_Mod_E__c,SHA_Housing_Type_B_Mod_D__c
                            ,SHA_Housing_Type_B_Mod_E__c,SHA_Housing_Type_C1_Mod_D__c,SHA_Housing_Type_C1_Mod_E__c
                            ,SHA_Housing_Type_C_Mod_D__c,SHA_Housing_Type_C_Mod_E__c,SHA_Housing_Type_D1_Mod_D__c
                            ,SHA_Housing_Type_D1_Mod_E__c,SHA_Housing_Type_D_Mod_D__c,SHA_Housing_Type_D_Mod_E__c
                            ,SHA_Housing_Type_E_Mod_D__c,SHA_Housing_Type_E_Mod_E__c,SHA_Housing_Type_F_Mod_D__c
                            ,SHA_Housing_Type_F_Mod_E__c,SHA_Visa_JW_202__c
                            ,DUB_Visa_Residence__c,DUB_Visa_Transit__c,DUB_Visa_Visit__c
                            ,Insurance_Erika_Mod_D__c,Insurance_Erika_Mod_E__c
                            ,Penthouse_Luxury_Studio_36_weeks__c
                            ,Penthouse_Luxury_Studio_43_weeks__c
                            ,Penthouse_Luxury_Studio_51_weeks__c
                            
                            ,Standard_Double_Room__c,Standard_Double_Room_43_Weeks__c,Standard_Double_Room_51_Weeks__c
                            ,Premium_Double__c,Premium_Double_Room_43_Weeks__c,Premium_Double_Room_51_Weeks__c
                            ,Premium_Single_Room_36_Weeks__c,Premium_Single_Room_43_Weeks__c,Premium_Single_Room_51_Weeks__c
                            
                            from Fees__c where ID In:opfin_ids.values()];
        for(opportunity_finance__c opf:opfin_ids.keyset()){ 
            for(fees__c fee:fees){
                 if(fee.id==opfin_ids.get(opf)) { 
                    // opportunity_finances(fee,opf); 
                    //mapping_Finwithfeevalues.housingaccomodationvals(fee,opf);
                    opportunity_finance__c old_fin=Trigger.isInsert?new opportunity_finance__c():Trigger.OldMap.get(opf.id);
                    mapping_Finwithfeevalues.financefieldsvals(fee,opf,old_fin);
                 }
            }
        }
    }
   /*
    public void opportunity_finances(fees__c f,Opportunity_Finance__c opfin){  
    
        If(opfin.Housing_Accommodation__c=='Shanghai - Single Room - 8 Months - Free'){        
            opfin.Annual_Accommodation_Fee__c=f.Shanghai_Single_Room_8_Months_Free__c;            
        }if(Opfin.Housing_Accommodation__c=='No accommodation' ){ 
            opfin.Annual_Accommodation_Fee__c=Null;
        }if(Opfin.Housing_Accommodation__c=='Dubai Housing Bursary' ){ 
            opfin.Annual_Accommodation_Fee__c=f.Dubai_Housing_Bursary__c;
        }if(opfin.Housing_Accommodation__c=='EMBA Hotel' ){
            opfin.Annual_Accommodation_Fee__c=f.EMBA_Hotel__c;
        }if(Opfin.Housing_Accommodation__c=='Shanghai Hult Accommodation – 8 Months' ){ 
            opfin.Annual_Accommodation_Fee__c=f.Accommodation_for_8_months__c;
        }if(Opfin.Housing_Accommodation__c=='Shanghai Hult Accommodation – 12 Months' ){ 
            opfin.Annual_Accommodation_Fee__c=f.Accommodation_for_12_months__c;
        }if(Opfin.Housing_Accommodation__c=='Shanghai Accommodation with dependent for 8 months' ){
            opfin.Annual_Accommodation_Fee__c=f.Accommodation_with_dependent_for_8_mths__c;
        }if(Opfin.Housing_Accommodation__c=='Shanghai Accommodation with dependent for 12 months' ){
            opfin.Annual_Accommodation_Fee__c=f.Accommodation_with_dependent_for_12_mths__c;
        }if(Opfin.Housing_Accommodation__c=='Free accommodation with dependent – 8 months' ){ 
            opfin.Annual_Accommodation_Fee__c=f.Free_accommodation_with_dependent_8mth__c;
        }if(Opfin.Housing_Accommodation__c=='Shanghai Accommodation Family'){
            opfin.Annual_Accommodation_Fee__c=f.Shanghai_Accommodation_Family__c; 
        }if(Opfin.Housing_Accommodation__c=='HH East – 12 Months'){
            opfin.Annual_Accommodation_Fee__c=f.Hult_House_East_12_Months__c; 
        }if(Opfin.Housing_Accommodation__c=='HH - Twin Studios - Double'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Twin_Studios_Double__c; 
        }if(Opfin.Housing_Accommodation__c=='HH - Super Twin - Double'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Super_Twin_Double__c;  
        }if(Opfin.Housing_Accommodation__c=='HH - Twin Plus - Double'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Twin_Plus_Double__c; 
        }if(Opfin.Housing_Accommodation__c=='HH - Study Twin - Double'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Study_Twin_Double__c; 
        }if(Opfin.Housing_Accommodation__c=='HH - Assam Studio - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Assam_Studio_Single__c;
        }if(Opfin.Housing_Accommodation__c=='HH - Studios Vista - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Studios_Vista_Single__c;  
        }if(Opfin.Housing_Accommodation__c=='HH - Studios Vista - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Studios_Vista_Single__c; 
        }if(Opfin.Housing_Accommodation__c=='HH - Studios Premium 15 -16 - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Studios_Premium_15_16_Single__c;
        }if(Opfin.Housing_Accommodation__c=='HH - Studios Premium 11-14 - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Studios_Premium_11_14_Single__c; 
        }if(Opfin.Housing_Accommodation__c=='HH - Club Studio Deluxe - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Club_Studio_Deluxe_Single__c;  
        }if(Opfin.Housing_Accommodation__c=='HH - Classic Studio Deluxe - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Classic_Studio_Deluxe_Single__c;
        }if(Opfin.Housing_Accommodation__c=='HH - Club Studio - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Club_Studio_Single__c;  
        }if(Opfin.Housing_Accommodation__c=='HH - Classic Studio - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Classic_Studio_Single__c;  
        }if(Opfin.Housing_Accommodation__c=='HH - Solo - Single'){
            opfin.Annual_Accommodation_Fee__c=f.HH_Solo_Single__c;                  
        }
    }
    */
}