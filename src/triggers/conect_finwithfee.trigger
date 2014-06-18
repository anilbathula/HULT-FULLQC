/*
      Developer : Premanath Reddy
      Date      : 11/03/2014                
      purpose   : This trigger connects a few Finance fields with Fee object fields,it run every time any of these new fields is INSERTED or UPDATED.
                  
      Test class: mapping_Finwithfee_test
      coverage  : 100%
      
      Modified : 20/3/2014  prem :: connects BBA Finanace Record type fields with Fee And calling the mapping_Finwithfeevalues class for field mapping.
*/           

trigger conect_finwithfee on Opportunity_Finance__c (before update,after insert,after update) {
if(trigger.isbefore){
    list<ID> finids=new list<ID>();
    list<ID> feeids=new list<ID>();
    map<string,string> hous_accm=new map<string,string>();
    map<string,string> rot_item=new map<string,string>();
    String bba_rectype=RecordTypeHelper.getRecordTypeId('Opportunity_Finance__c','BBA Finance');
    
    list<id> bba_fieldmap_fins=new list<id>();
    for(Opportunity_Finance__c fin:Trigger.new){
        if(fin.fees__c!=null ){
            Opportunity_Finance__c oldfin=trigger.Isinsert?new Opportunity_Finance__c():Trigger.oldmap.get(fin.id); 
            if(((oldfin.Housing_Accommodation__c!=fin.Housing_Accommodation__c || oldfin.Accommodation_weeks__c!=fin.Accommodation_weeks__c) 
                || oldfin.Rot_Housing_Module_D__c!=fin.Rot_Housing_Module_D__c 
                || oldfin.Rot_Visa_Module_D__c!=fin.Rot_Visa_Module_D__c
                || oldfin.Rot_Insurance_Module_D__c!=fin.Rot_Insurance_Module_D__c
                || oldfin.Rot_Housing_Module_E__c!=fin.Rot_Housing_Module_E__c
                || oldfin.Rot_Visa_Module_E__c!=fin.Rot_Visa_Module_E__c
                || oldfin.Rot_Insurance_Module_E__c!=fin.Rot_Insurance_Module_E__c)||(fin.Housing_Accommodation__c !=null && fin.Annual_Accommodation_Fee__c==null) 
                ||(fin.Rot_Housing_Module_D__c !=null && fin.Rotation_1_Fee__c==null)
                ||(fin.Rot_Visa_Module_D__c !=null && fin.Rotation_2_Fee__c==null)
                ||(fin.Rot_Insurance_Module_D__c !=null && fin.Rotation_3_Fee__c==null)
                ||(fin.Rot_Housing_Module_E__c !=null && fin.Rotation_4_Fee__c==null)
                ||(fin.Rot_Visa_Module_E__c !=null && fin.Rotation_5_Fee__c==null)
                ||(fin.Rot_Insurance_Module_E__c  !=null && fin.Rotation_6_Fee__c==null))
            {                    
                finids.add(fin.id);
                feeids.add(fin.fees__c);
            }
            
            if(fin.OP_Program__c.startsWith('Bachelor')){
                system.debug(oldfin.BBA_Rotation_1_Year_1__c+'--->-->'+fin.BBA_Rotation_1_Year_1__c);
                if(oldfin.BBA_Insurance_Picklist_Year_1__c!=fin.BBA_Insurance_Picklist_Year_1__c || 
                    oldfin.BBA_Insurance_Picklist_Year_2__c!=fin.BBA_Insurance_Picklist_Year_2__c ||
                    oldfin.BBA_Insurance_Picklist_Year_3__c!=fin.BBA_Insurance_Picklist_Year_3__c ||
                    oldfin.BBA_Insurance_Picklist_Year_4__c!=fin.BBA_Insurance_Picklist_Year_4__c ||
                    
                    oldfin.BBA_Installment_Plan_Picklist__c!=fin.BBA_Installment_Plan_Picklist__c|| 
                    oldfin.BBA_Installment_Plan_Picklist_Year_2__c!=fin.BBA_Installment_Plan_Picklist_Year_2__c||
                    oldfin.BBA_Installment_Plan_Picklist_Year_3__c!=fin.BBA_Installment_Plan_Picklist_Year_3__c||
                    oldfin.BBA_Installment_Plan_Picklist_Year_4__c!=fin.BBA_Installment_Plan_Picklist_Year_4__c ||
                    
                    oldfin.BBA_Accommodation_Year_1__c!=fin.BBA_Accommodation_Year_1__c|| 
                    oldfin.BBA_Accommodation_Weeks_Year_1__c!=fin.BBA_Accommodation_Weeks_Year_1__c||
                    oldfin.BBA_Accommodation_Year_2__c!=fin.BBA_Accommodation_Year_2__c||
                    oldfin.BBA_Accommodation_Weeks_Year_2__c!=fin.BBA_Accommodation_Weeks_Year_2__c||
                    oldfin.BBA_Accommodation_Year_3__c!=fin.BBA_Accommodation_Year_3__c|| 
                    oldfin.BBA_Accommodation_Weeks_Year_3__c!=fin.BBA_Accommodation_Weeks_Year_3__c||
                    oldfin.BBA_Accommodation_Year_4__c!=fin.BBA_Accommodation_Year_4__c||
                    oldfin.BBA_Accommodation_Weeks_Year_4__c!=fin.BBA_Accommodation_Weeks_Year_4__c ||
                    
                    oldfin.BBA_Rotation_1_Year_1__c!=fin.BBA_Rotation_1_Year_1__c|| 
                    oldfin.BBA_Rotation_2_Year_1__c!=fin.BBA_Rotation_2_Year_1__c||
                    oldfin.BBA_Rotation_3_Year_1__c!=fin.BBA_Rotation_3_Year_1__c||
                    oldfin.BBA_Rotation_4_Year_1__c!=fin.BBA_Rotation_4_Year_1__c||
                    oldfin.BBA_Rotation_5_Year_1__c!=fin.BBA_Rotation_5_Year_1__c||
                    
                    oldfin.BBA_Rotation_1_Year_2__c!=fin.BBA_Rotation_1_Year_2__c|| 
                    oldfin.BBA_Rotation_2_Year_2__c!=fin.BBA_Rotation_2_Year_2__c||
                    oldfin.BBA_Rotation_3_Year_2__c!=fin.BBA_Rotation_3_Year_2__c||
                    oldfin.BBA_Rotation_4_Year_2__c!=fin.BBA_Rotation_4_Year_2__c||
                    oldfin.BBA_Rotation_5_Year_2__c!=fin.BBA_Rotation_5_Year_2__c||
                    
                    oldfin.BBA_Rotation_1_Year_3__c!=fin.BBA_Rotation_1_Year_3__c|| 
                    oldfin.BBA_Rotation_2_Year_3__c!=fin.BBA_Rotation_2_Year_3__c||
                    oldfin.BBA_Rotation_3_Year_3__c!=fin.BBA_Rotation_3_Year_3__c||
                    oldfin.BBA_Rotation_4_Year_3__c!=fin.BBA_Rotation_4_Year_3__c||
                    oldfin.BBA_Rotation_5_Year_3__c!=fin.BBA_Rotation_5_Year_3__c||
                    
                    oldfin.BBA_Rotation_1_Year_4__c!=fin.BBA_Rotation_1_Year_4__c|| 
                    oldfin.BBA_Rotation_2_Year_4__c!=fin.BBA_Rotation_2_Year_4__c||
                    oldfin.BBA_Rotation_3_Year_4__c!=fin.BBA_Rotation_3_Year_4__c||
                    oldfin.BBA_Rotation_4_Year_4__c!=fin.BBA_Rotation_4_Year_4__c||
                    oldfin.BBA_Rotation_5_Year_4__c!=fin.BBA_Rotation_5_Year_4__c)
                {
                    feeids.add(fin.fees__c);
                    bba_fieldmap_fins.add(fin.id);
                }
            }
        }
        
    }
    if(!feeids.isempty()){
        
        Map<ID,Fees__c> fees=new Map<ID,Fees__c>([select id,Name,CurrencyIsoCode,Solo_36_Weeks__c,Solo_43_Weeks__c,Solo_51_Weeks__c
                            ,Solo_Deluxe_36_Weeks__c,Solo_Deluxe_43_Weeks__c,Solo_Deluxe_51_weeks__c
                            ,Twin_36_Weeks__c,Twin_43_Weeks__c,Twin_51_Weeks__c,Twin_Deluxe_36_weeks__c
                            ,Twin_Deluxe_43_weeks__c,Twin_Deluxe_51_weeks__c,Studio_36_weeks__c,Studio_43_weeks__c
                            ,Studio_51_weeks__c,Studio_Vista_36_weeks__c,Studio_Vista_43_weeks__c,Studio_Visa_51_weeks__c
                            ,Apartment_36_weeks__c,Apartment_43__c,Apartment_51_weeks__c,Apartment_Vista_36_weeks__c
                            ,Apartment_Vista_43_weeks__c,Apartment_Visa_51_weeks__c,Deluxe_Studio_Apartment_36_weeks__c
                            ,Deluxe_Studio_Apartment_43_weeks__c,Deluxe_Studio_Apartment_51_weeks__c,Deluxe_Studio_Apartment_Extra_36_weeks__c
                            ,Deluxe_Studio_Apartment_Extra_43_weeks__c,Deluxe_Studio_Apartment_Extra_51_weeks__c
                            
                            ,NYC_Housing_Single_Mod_E__c,NYC_Housing_Single_Mod_D__c,NYC_Housing_Single_Mod_D_E__c
                            ,NYC_Housing_Twin_Mod_D__c,NYC_Housing_Twin_Mod_D_E__c,NYC_Housing_Twin_Mod_E__c
                            ,NYC_Housing_Large_Single_Mod_D__c,NYC_Housing_Large_Single_Mod_E__c
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
                            
                            ,year__c,Application_Fee__c,Program_Name__c,Single_Annual__c, Shared_Twin_Annual__c
                            ,Hult_House_East_12_Months__c,Accommodation_with_dependent_for_8_mths__c,Accommodation_for_12_months__c
                            ,Accommodation_for_8_months__c,Free_accommodation_with_dependent_8mth__c,Shanghai_Single_Room_8_Months_Free__c
                            ,Dubai_Housing_Bursary__c,EMBA_Hotel__c,Shanghai_Accommodation_Family__c,HH_Twin_Studios_Double__c,HH_Super_Twin_Double__c
                            ,HH_Study_Twin_Double__c,HH_Twin_Plus_Double__c,HH_Assam_Studio_Single__c,HH_Studios_Vista_Single__c
                            ,HH_Studios_Premium_15_16_Single__c,HH_Studios_Premium_11_14_Single__c,HH_Club_Studio_Deluxe_Single__c
                            ,HH_Classic_Studio_Deluxe_Single__c,Accommodation_with_dependent_for_12_mths__c,HH_Club_Studio_Single__c,HH_Classic_Studio_Single__c,HH_Solo_Single__c
                            
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
                            from Fees__c where ID In: feeids]);
        
        /*shs :: bba field map code*/
           if(!bba_fieldmap_fins.IsEmpty()) 
           { 
               for(id fins:bba_fieldmap_fins)
               {
                   Opportunity_Finance__c new_fin=trigger.newMap.get(fins);
                   if(fees.containskey(new_fin.Fees__c))
                   {                       
                       mapping_Finwithfeevalues.linking_BBA_Finance(fees.get(new_fin.Fees__c),new_fin);                       
                   }
               }
           }
        /*end of bba field map code*/
        
        for(ID fid: finids){
            Opportunity_Finance__c old_fin=trigger.Isinsert?new Opportunity_Finance__c():Trigger.oldmap.get(fid);
            Opportunity_Finance__c new_fin=Trigger.newmap.get(fid);
            Fees__c fee=new Fees__c();
            fee=fees.get(new_fin.fees__c);
            mapping_Finwithfeevalues.financefieldsvals(fee,new_fin,old_fin);
           /* 
            if((old_fin.Housing_Accommodation__c!=new_fin.Housing_Accommodation__c || old_fin.Accommodation_weeks__c!=new_fin.Accommodation_weeks__c) )//|| (new_fin.Housing_Accommodation__c !=null && new_fin.Annual_Accommodation_Fee__c==null ))
            {
                string fieldlabel,feeapiname;  
                System.debug('==========>'+new_fin.Housing_Accommodation__c +' - '+new_fin.Accommodation_weeks__c );                
                fieldlabel=new_fin.Housing_Accommodation__c +' - '+new_fin.Accommodation_weeks__c+' weeks'; 
                System.debug('======2====>'+fieldlabel);
                if(hous_accm.containsKey(fieldlabel.tolowercase()))    
                    feeapiname=hous_accm.get(fieldlabel.tolowercase());                    
                if(feeapiname!=null)
                {
                    if(new_fin.Housing_Accommodation__c==null || new_fin.Accommodation_weeks__c==null)
                    {
                        new_fin.put('Annual_Accommodation_Fee__c',null);        
                    }
                    if(new_fin.Housing_Accommodation__c!=null && new_fin.Accommodation_weeks__c!=null)
                    {
                        new_fin.put('Annual_Accommodation_Fee__c',fee.get(feeapiname));
                    }
                }
                else
                {
                    new_fin.put('Annual_Accommodation_Fee__c',null);     
                }
            }
            if(old_fin.Rot_Housing_Module_D__c!=new_fin.Rot_Housing_Module_D__c||(new_fin.Rot_Housing_Module_D__c !=null && new_fin.Rotation_1_Fee__c==null)){
                string fieldlabel,feeapiname;
                fieldlabel=new_fin.Rot_Housing_Module_D__c!=null?new_fin.Rot_Housing_Module_D__c:'noval';
                if(rot_item.containsKey(fieldlabel.tolowercase()))    
                    feeapiname=rot_item.get(fieldlabel.tolowercase());
                if(feeapiname!=null)
                {
                    if(new_fin.Rot_Housing_Module_D__c==null)
                    {
                        new_fin.put('Rotation_1_Fee__c',null);        
                    }
                    if(new_fin.Rot_Housing_Module_D__c!=null)
                    {
                        new_fin.put('Rotation_1_Fee__c',fee.get(feeapiname));
                    }
                }
                else
                {
                    new_fin.put('Rotation_1_Fee__c',null);     
                }
            }
            if(old_fin.Rot_Visa_Module_D__c!=new_fin.Rot_Visa_Module_D__c||(new_fin.Rot_Visa_Module_D__c !=null && new_fin.Rotation_2_Fee__c==null)){
                string fieldlabel,feeapiname;                  
                fieldlabel=new_fin.Rot_Visa_Module_D__c!=null?new_fin.Rot_Visa_Module_D__c:'noval';
                if(rot_item.containsKey(fieldlabel.tolowercase()))    
                    feeapiname=rot_item.get(fieldlabel.tolowercase());
                if(feeapiname!=null)
                {
                    if(new_fin.Rot_Visa_Module_D__c==null)
                    {
                        new_fin.put('Rotation_2_Fee__c',null);        
                    }
                    if(new_fin.Rot_Visa_Module_D__c!=null)
                    {
                        new_fin.put('Rotation_2_Fee__c',fee.get(feeapiname));
                    }
                }
                else
                {
                    new_fin.put('Rotation_2_Fee__c',null);     
                }
            }
            if(old_fin.Rot_Insurance_Module_D__c!=new_fin.Rot_Insurance_Module_D__c ||(new_fin.Rot_Insurance_Module_D__c !=null && new_fin.Rotation_3_Fee__c==null)){
                string fieldlabel,feeapiname;                  
                fieldlabel=new_fin.Rot_Insurance_Module_D__c!=null?new_fin.Rot_Insurance_Module_D__c:'noval';
                if(rot_item.containsKey(fieldlabel.tolowercase()))    
                    feeapiname=rot_item.get(fieldlabel.tolowercase());
                if(feeapiname!=null)
                {
                    if(new_fin.Rot_Insurance_Module_D__c==null)
                    {
                        new_fin.put('Rotation_3_Fee__c',null);        
                    }
                    if(new_fin.Rot_Insurance_Module_D__c!=null)
                    {
                        new_fin.put('Rotation_3_Fee__c',fee.get(feeapiname));
                    }
                }
                else
                {
                    new_fin.put('Rotation_3_Fee__c',null);     
                }
            }
            if(old_fin.Rot_Housing_Module_E__c!=new_fin.Rot_Housing_Module_E__c ||(new_fin.Rot_Housing_Module_E__c !=null && new_fin.Rotation_4_Fee__c==null)){
                string fieldlabel,feeapiname;                  
                fieldlabel=new_fin.Rot_Housing_Module_E__c!=null?new_fin.Rot_Housing_Module_E__c:'noval';
                if(rot_item.containsKey(fieldlabel.tolowercase()))    
                    feeapiname=rot_item.get(fieldlabel.tolowercase());
                if(feeapiname!=null)
                {
                    if(new_fin.Rot_Housing_Module_E__c==null)
                    {
                        new_fin.put('Rotation_4_Fee__c',null);        
                    }
                    if(new_fin.Rot_Housing_Module_E__c!=null)
                    {
                        new_fin.put('Rotation_4_Fee__c',fee.get(feeapiname));
                    }
                }
                else
                {
                    new_fin.put('Rotation_4_Fee__c',null);     
                }
            }
            if(old_fin.Rot_Visa_Module_E__c!=new_fin.Rot_Visa_Module_E__c ||(new_fin.Rot_Visa_Module_E__c !=null && new_fin.Rotation_5_Fee__c==null)){
                string fieldlabel,feeapiname;                  
                fieldlabel=new_fin.Rot_Visa_Module_E__c!=null?new_fin.Rot_Visa_Module_E__c:'noval';
                if(rot_item.containsKey(fieldlabel.tolowercase()))    
                    feeapiname=rot_item.get(fieldlabel.tolowercase());
                if(feeapiname!=null)
                {
                    if(new_fin.Rot_Visa_Module_E__c==null)
                    {
                        new_fin.put('Rotation_5_Fee__c',null);        
                    }
                    if(new_fin.Rot_Visa_Module_E__c!=null)
                    {
                        new_fin.put('Rotation_5_Fee__c',fee.get(feeapiname));
                    }
                }
                else
                {
                    new_fin.put('Rotation_5_Fee__c',null);     
                }
            }
            if(old_fin.Rot_Insurance_Module_E__c!=new_fin.Rot_Insurance_Module_E__c ||(new_fin.Rot_Insurance_Module_E__c  !=null && new_fin.Rotation_6_Fee__c==null)){
                string fieldlabel,feeapiname;                  
                fieldlabel=new_fin.Rot_Insurance_Module_E__c!=null?new_fin.Rot_Insurance_Module_E__c:'noval';
                if(rot_item.containsKey(fieldlabel.tolowercase()))    
                    feeapiname=rot_item.get(fieldlabel.tolowercase());
                if(feeapiname!=null)
                {
                    if(new_fin.Rot_Insurance_Module_E__c==null)
                    {
                        new_fin.put('Rotation_6_Fee__c',null);        
                    }
                    if(new_fin.Rot_Insurance_Module_E__c!=null)
                    {
                        new_fin.put('Rotation_6_Fee__c',fee.get(feeapiname));
                    }
                }
                else
                {
                    new_fin.put('Rotation_6_Fee__c',null);     
                }
            }*/
        }
        
    }
}
    if(trigger.isafter)
    {
        list<Opportunity_Finance__c > updfins=new list<Opportunity_Finance__c >();
        for(Opportunity_Finance__c fin:Trigger.new)
        {
            Opportunity_Finance__c oldfin=trigger.isinsert?new Opportunity_Finance__c():trigger.oldmap.get(fin.id);
            if(fin.Fees__c!=null && oldfin.Fees__c==null)
            {
                updfins.add(fin);
            }
        }
        if(!updfins.IsEmpty())
        {
            try{
                update updfins;
                }
                catch(Exception e){system.debug(e);}
        }
    }
}