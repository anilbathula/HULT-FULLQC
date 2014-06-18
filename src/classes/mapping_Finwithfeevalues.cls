/*
    Developer : Premanath Reddy
    Date      : 20/03/2014                
    purpose   : This class connects a Finance fields with Fee object fields,it run every time any of these fields is INSERTED or UPDATED.
                This class is calling from conect_finwithfee and add_fee2finance triggers
              
    Test class: mapping_Finwithfee_test
    coverage  : 92%
*/
public class mapping_Finwithfeevalues{
   public static Map<string,string> bba_accm=new Map<string,string>();
    public static Map<string,string> bba_rot=new Map<string,string>();
    public static Map<string,string> hous_accm=new Map<string,string>();    
    public static Map<string,string> rot_item=new Map<string,string>();
    /*This method will set all the  picklist values and its related API name in a map.*/
    public static void field_maps()
    {
        if(bba_accm==null || bba_accm.IsEmpty())
        {
            //for Accommodation - Year 1
            bba_accm.put('solo - 36 weeks_y1','BBA_Solo_36_Weeks_Year_1__c');
            bba_accm.put('solo - 43 weeks_y1','BBA_Solo_43_Weeks_Year_1__c');
            bba_accm.put('solo - 51 weeks_y1','BBA_Solo_51_Weeks_Year_1__c');
            bba_accm.put('solo deluxe - 36 weeks_y1','BBA_Solo_Deluxe_36_Weeks_Year_1__c');
            bba_accm.put('solo deluxe - 43 weeks_y1','BBA_Solo_Deluxe_43_Weeks_Year_1__c');
            bba_accm.put('solo deluxe - 51 weeks_y1','BBA_Solo_Deluxe_51_Weeks_Year_1__c');
            bba_accm.put('twin - 36 weeks_y1','BBA_Twin_36_Weeks_Year_1__c');
            bba_accm.put('twin - 43 weeks_y1','BBA_Twin_43_Weeks_Year_1__c');
            bba_accm.put('twin - 51 weeks_y1','BBA_Twin_51_Weeks_Year_1__c');
            bba_accm.put('twin deluxe - 36 weeks_y1','BBA_Twin_Deluxe_36_Weeks_Year_1__c');
            bba_accm.put('twin deluxe - 43 weeks_y1','BBA_Twin_Deluxe_43_Weeks_Year_1__c');
            bba_accm.put('twin deluxe - 51 weeks_y1','BBA_Twin_Deluxe_51_Weeks_Year_1__c');
            bba_accm.put('studio - 36 weeks_y1','BBA_Studio_36_Weeks_Year_1__c');
            bba_accm.put('studio - 43 weeks_y1','BBA_Studio_43_Weeks_Year_1__c');
            bba_accm.put('studio - 51 weeks_y1','BBA_Studio_51_Weeks_Year_1__c');
            bba_accm.put('studio vista - 36 weeks_y1','BBA_Studio_Vista_36_Weeks_Year_1__c');
            bba_accm.put('studio vista - 43 weeks_y1','BBA_Studio_Vista_43_Weeks_Year_1__c');
            bba_accm.put('studio vista - 51 weeks_y1','BBA_Studio_Vista_51_Weeks_Year_1__c');
            bba_accm.put('apartment - 36 weeks_y1','BBA_Apartment_36_Weeks_Year_1__c');
            bba_accm.put('apartment - 43 weeks_y1','BBA_Apartment_43_Weeks_Year_1__c');
            bba_accm.put('apartment - 51 weeks_y1','BBA_Apartment_51_Weeks_Year_1__c');
            bba_accm.put('apartment vista - 36 weeks_y1','BBA_Apartment_Vista_36_Weeks_Year_1__c');
            bba_accm.put('apartment vista - 43 weeks_y1','BBA_Apartment_Vista_43_Weeks_Year_1__c');
            bba_accm.put('apartment vista - 51 weeks_y1','BBA_Apartment_Vista_51_Weeks_Year_1__c');
            bba_accm.put('deluxe studio apartment - 36 weeks_y1','BBA_Deluxe_Studio_Apart_36_Weeks_Year_1__c');
            bba_accm.put('deluxe studio apartment - 43 weeks_y1','BBA_Deluxe_Studio_Apart_43_Weeks_Year_1__c');
            bba_accm.put('deluxe studio apartment - 51 weeks_y1','BBA_Deluxe_Studio_Apart_51_Weeks_Year_1__c');
            bba_accm.put('deluxe studio apartment extra - 36 weeks_y1','BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_1__c');
            bba_accm.put('deluxe studio apartment extra - 43 weeks_y1','BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_1__c');
            bba_accm.put('deluxe studio apartment extra - 51 weeks_y1','BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_1__c');
            bba_accm.put('penthouse luxury studio - 36 weeks_y1','BBA_PH_Luxury_Studio_36_Weeks_Year_1__c');
            bba_accm.put('penthouse luxury studio - 43 weeks_y1','BBA_PH_Luxury_Studio_43_Weeks_Year_1__c');
            bba_accm.put('penthouse luxury studio - 51 weeks_y1','BBA_PH_Luxury_Studio_51_Weeks_Year_1__c');
            
            //for Accommodation - Year 2
            bba_accm.put('solo - 36 weeks_y2','BBA_Solo_36_Weeks_Year_2__c');
            bba_accm.put('solo - 43 weeks_y2','BBA_Solo_43_Weeks_Year_2__c');
            bba_accm.put('solo - 51 weeks_y2','BBA_Solo_51_Weeks_Year_2__c');
            bba_accm.put('solo deluxe - 36 weeks_y2','BBA_Solo_Deluxe_36_Weeks_Year_2__c');
            bba_accm.put('solo deluxe - 43 weeks_y2','BBA_Solo_Deluxe_43_Weeks_Year_2__c');
            bba_accm.put('solo deluxe - 51 weeks_y2','BBA_Solo_Deluxe_51_Weeks_Year_2__c');
            bba_accm.put('twin - 36 weeks_y2','BBA_Twin_36_Weeks_Year_2__c');
            bba_accm.put('twin - 43 weeks_y2','BBA_Twin_43_Weeks_Year_2__c');
            bba_accm.put('twin - 51 weeks_y2','BBA_Twin_51_Weeks_Year_2__c');
            bba_accm.put('twin deluxe - 36 weeks_y2','BBA_Twin_Deluxe_36_Weeks_Year_2__c');
            bba_accm.put('twin deluxe - 43 weeks_y2','BBA_Twin_Deluxe_43_Weeks_Year_2__c');
            bba_accm.put('twin deluxe - 51 weeks_y2','BBA_Twin_Deluxe_51_Weeks_Year_2__c');
            bba_accm.put('studio - 36 weeks_y2','BBA_Studio_36_Weeks_Year_2__c');
            bba_accm.put('studio - 43 weeks_y2','BBA_Studio_43_Weeks_Year_2__c');
            bba_accm.put('studio - 51 weeks_y2','BBA_Studio_51_Weeks_Year_2__c');
            bba_accm.put('studio vista - 36 weeks_y2','BBA_Studio_Vista_36_Weeks_Year_2__c');
            bba_accm.put('studio vista - 43 weeks_y2','BBA_Studio_Vista_43_Weeks_Year_2__c');
            bba_accm.put('studio vista - 51 weeks_y2','BBA_Studio_Vista_51_Weeks_Year_2__c');
            bba_accm.put('apartment - 36 weeks_y2','BBA_Apartment_36_Weeks_Year_2__c');
            bba_accm.put('apartment - 43 weeks_y2','BBA_Apartment_43_Weeks_Year_2__c');
            bba_accm.put('apartment - 51 weeks_y2','BBA_Apartment_51_Weeks_Year_2__c');
            bba_accm.put('apartment vista - 36 weeks_y2','BBA_Apartment_Vista_36_Weeks_Year_2__c');
            bba_accm.put('apartment vista - 43 weeks_y2','BBA_Apartment_Vista_43_Weeks_Year_2__c');
            bba_accm.put('apartment vista - 51 weeks_y2','BBA_Apartment_Vista_51_Weeks_Year_2__c');
            bba_accm.put('deluxe studio apartment - 36 weeks_y2','BBA_Deluxe_Studio_Apart_36_Weeks_Year_2__c');
            bba_accm.put('deluxe studio apartment - 43 weeks_y2','BBA_Deluxe_Studio_Apart_43_Weeks_Year_2__c');
            bba_accm.put('deluxe studio apartment - 51 weeks_y2','BBA_Deluxe_Studio_Apart_51_Weeks_Year_2__c');
            bba_accm.put('deluxe studio apartment extra - 36 weeks_y2','BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_2__c');
            bba_accm.put('deluxe studio apartment extra - 43 weeks_y2','BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_2__c');
            bba_accm.put('deluxe studio apartment extra - 51 weeks_y2','BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_2__c');
            bba_accm.put('penthouse luxury studio - 36 weeks_y2','BBA_PH_Luxury_Studio_36_Weeks_Year_2__c');
            bba_accm.put('penthouse luxury studio - 43 weeks_y2','BBA_PH_Luxury_Studio_43_Weeks_Year_2__c');
            bba_accm.put('penthouse luxury studio - 51 weeks_y2','BBA_PH_Luxury_Studio_51_Weeks_Year_2__c');
            
            //for Accommodation - Year 3
            bba_accm.put('solo - 36 weeks_y3','BBA_Solo_36_Weeks_Year_3__c');
            bba_accm.put('solo - 43 weeks_y3','BBA_Solo_43_Weeks_Year_3__c');
            bba_accm.put('solo - 51 weeks_y3','BBA_Solo_51_Weeks_Year_3__c');
            bba_accm.put('solo deluxe - 36 weeks_y3','BBA_Solo_Deluxe_36_Weeks_Year_3__c');
            bba_accm.put('solo deluxe - 43 weeks_y3','BBA_Solo_Deluxe_43_Weeks_Year_3__c');
            bba_accm.put('solo deluxe - 51 weeks_y3','BBA_Solo_Deluxe_51_Weeks_Year_3__c');
            bba_accm.put('twin - 36 weeks_y3','BBA_Twin_36_Weeks_Year_3__c');
            bba_accm.put('twin - 43 weeks_y3','BBA_Twin_43_Weeks_Year_3__c');
            bba_accm.put('twin - 51 weeks_y3','BBA_Twin_51_Weeks_Year_3__c');
            bba_accm.put('twin deluxe - 36 weeks_y3','BBA_Twin_Deluxe_36_Weeks_Year_3__c');
            bba_accm.put('twin deluxe - 43 weeks_y3','BBA_Twin_Deluxe_43_Weeks_Year_3__c');
            bba_accm.put('twin deluxe - 51 weeks_y3','BBA_Twin_Deluxe_51_Weeks_Year_3__c');
            bba_accm.put('studio - 36 weeks_y3','BBA_Studio_36_Weeks_Year_3__c');
            bba_accm.put('studio - 43 weeks_y3','BBA_Studio_43_Weeks_Year_3__c');
            bba_accm.put('studio - 51 weeks_y3','BBA_Studio_51_Weeks_Year_3__c');
            bba_accm.put('studio vista - 36 weeks_y3','BBA_Studio_Vista_36_Weeks_Year_3__c');
            bba_accm.put('studio vista - 43 weeks_y3','BBA_Studio_Vista_43_Weeks_Year_3__c');
            bba_accm.put('studio vista - 51 weeks_y3','BBA_Studio_Vista_51_Weeks_Year_3__c');
            bba_accm.put('apartment - 36 weeks_y3','BBA_Apartment_36_Weeks_Year_3__c');
            bba_accm.put('apartment - 43 weeks_y3','BBA_Apartment_43_Weeks_Year_3__c');
            bba_accm.put('apartment - 51 weeks_y3','BBA_Apartment_51_Weeks_Year_3__c');
            bba_accm.put('apartment vista - 36 weeks_y3','BBA_Apartment_Vista_36_Weeks_Year_3__c');
            bba_accm.put('apartment vista - 43 weeks_y3','BBA_Apartment_Vista_43_Weeks_Year_3__c');
            bba_accm.put('apartment vista - 51 weeks_y3','BBA_Apartment_Vista_51_Weeks_Year_3__c');
            bba_accm.put('deluxe studio apartment - 36 weeks_y3','BBA_Deluxe_Studio_Apart_36_Weeks_Year_3__c');
            bba_accm.put('deluxe studio apartment - 43 weeks_y3','BBA_Deluxe_Studio_Apart_43_Weeks_Year_3__c');
            bba_accm.put('deluxe studio apartment - 51 weeks_y3','BBA_Deluxe_Studio_Apart_51_Weeks_Year_3__c');
            bba_accm.put('deluxe studio apartment extra - 36 weeks_y3','BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_3__c');
            bba_accm.put('deluxe studio apartment extra - 43 weeks_y3','BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_3__c');
            bba_accm.put('deluxe studio apartment extra - 51 weeks_y3','BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_3__c');
            bba_accm.put('penthouse luxury studio - 36 weeks_y3','BBA_PH_Luxury_Studio_36_Weeks_Year_3__c');
            bba_accm.put('penthouse luxury studio - 43 weeks_y3','BBA_PH_Luxury_Studio_43_Weeks_Year_3__c');
            bba_accm.put('penthouse luxury studio - 51 weeks_y3','BBA_PH_Luxury_Studio_51_Weeks_Year_3__c');
            
            //For Accommodation - Year 4
            bba_accm.put('solo - 36 weeks_y4','BBA_Solo_36_Weeks_Year_4__c');
            bba_accm.put('solo - 43 weeks_y4','BBA_Solo_43_Weeks_Year_4__c');
            bba_accm.put('solo - 51 weeks_y4','BBA_Solo_51_Weeks_Year_4__c');
            bba_accm.put('solo deluxe - 36 weeks_y4','BBA_Solo_Deluxe_36_Weeks_Year_4__c');
            bba_accm.put('solo deluxe - 43 weeks_y4','BBA_Solo_Deluxe_43_Weeks_Year_4__c');
            bba_accm.put('solo deluxe - 51 weeks_y4','BBA_Solo_Deluxe_51_Weeks_Year_4__c');
            bba_accm.put('twin - 36 weeks_y4','BBA_Twin_36_Weeks_Year_4__c');
            bba_accm.put('twin - 43 weeks_y4','BBA_Twin_43_Weeks_Year_4__c');
            bba_accm.put('twin - 51 weeks_y4','BBA_Twin_51_Weeks_Year_4__c');
            bba_accm.put('twin deluxe - 36 weeks_y4','BBA_Twin_Deluxe_36_Weeks_Year_4__c');
            bba_accm.put('twin deluxe - 43 weeks_y4','BBA_Twin_Deluxe_43_Weeks_Year_4__c');
            bba_accm.put('twin deluxe - 51 weeks_y4','BBA_Twin_Deluxe_51_Weeks_Year_4__c');
            bba_accm.put('studio - 36 weeks_y4','BBA_Studio_36_Weeks_Year_4__c');
            bba_accm.put('studio - 43 weeks_y4','BBA_Studio_43_Weeks_Year_4__c');
            bba_accm.put('studio - 51 weeks_y4','BBA_Studio_51_Weeks_Year_4__c');
            bba_accm.put('studio vista - 36 weeks_y4','BBA_Studio_Vista_36_Weeks_Year_4__c');
            bba_accm.put('studio vista - 43 weeks_y4','BBA_Studio_Vista_43_Weeks_Year_4__c');
            bba_accm.put('studio vista - 51 weeks_y4','BBA_Studio_Vista_51_Weeks_Year_4__c');
            bba_accm.put('apartment - 36 weeks_y4','BBA_Apartment_36_Weeks_Year_4__c');
            bba_accm.put('apartment - 43 weeks_y4','BBA_Apartment_43_Weeks_Year_4__c');
            bba_accm.put('apartment - 51 weeks_y4','BBA_Apartment_51_Weeks_Year_4__c');
            bba_accm.put('apartment vista - 36 weeks_y4','BBA_Apartment_Vista_36_Weeks_Year_4__c');
            bba_accm.put('apartment vista - 43 weeks_y4','BBA_Apartment_Vista_43_Weeks_Year_4__c');
            bba_accm.put('apartment vista - 51 weeks_y4','BBA_Apartment_Vista_51_Weeks_Year_4__c');
            bba_accm.put('deluxe studio apartment - 36 weeks_y4','BBA_Deluxe_Studio_Apart_36_Weeks_Year_4__c');
            bba_accm.put('deluxe studio apartment - 43 weeks_y4','BBA_Deluxe_Studio_Apart_43_Weeks_Year_4__c');
            bba_accm.put('deluxe studio apartment - 51 weeks_y4','BBA_Deluxe_Studio_Apart_51_Weeks_Year_4__c');
            bba_accm.put('deluxe studio apartment extra - 36 weeks_y4','BBA_Deluxe_Studio_Apt_E_36_Weeks_Year_4__c');
            bba_accm.put('deluxe studio apartment extra - 43 weeks_y4','BBA_Deluxe_Studio_Apt_E_43_Weeks_Year_4__c');
            bba_accm.put('deluxe studio apartment extra - 51 weeks_y4','BBA_Deluxe_Studio_Apt_E_51_Weeks_Year_4__c');
            bba_accm.put('penthouse luxury studio - 36 weeks_y4','BBA_PH_Luxury_Studio_36_Weeks_Year_4__c');
            bba_accm.put('penthouse luxury studio - 43 weeks_y4','BBA_PH_Luxury_Studio_43_Weeks_Year_4__c');
            bba_accm.put('penthouse luxury studio - 51 weeks_y4','BBA_PH_Luxury_Studio_51_Weeks_Year_4__c');
          }
          if(bba_rot==null || bba_rot.IsEmpty())
          {  
              //for Rotation 1,2,3,4 and 5 - Year 1,2,3 and 4
                bba_rot.put('sha - housing - bba accommodation - mod d','BBA_SHA_Housing_BBA_Accomm_Mod_D__c');
                bba_rot.put('sha - housing - bba accommodation - mod e','BBA_SHA_Housing_BBA_Accomm_Mod_E__c');
                bba_rot.put('sha - housing - suite - mod d','BBA_SHA_Housing_Suite_Mod_D__c');
                bba_rot.put('sha - housing - suite - mod e','BBA_SHA_Housing_Suite_Mod_E__c');
                bba_rot.put('sha - housing - dependent - mod d','BBA_SHA_Housing_Dependent_Mod_D__c');
                bba_rot.put('sha - housing - dependent - mod e','BBA_SHA_Housing_Dependent_Mod_E__c');
                bba_rot.put('sha - visa - jw-202','BBA_SHA_Visa_JW_202__c');
                bba_rot.put('dub - visa - visit','BBA_DUB_Visa_Visit__c');
                bba_rot.put('dub - visa - residence','BBA_DUB_Visa_Residence__c');
                bba_rot.put('dub - visa - transit','BBA_DUB_Visa_Transit__c');
                bba_rot.put('insurance - erika - mod d','BBA_Insurance_Erika_Mod_D__c');
                bba_rot.put('insurance - erika - mod e','BBA_Insurance_Erika_Mod_E__c');
         }
         
         if(hous_accm==null||hous_accm.IsEmpty())     
         {
            // for Housing Accomadation
            hous_accm.put('solo - 36 weeks','Solo_36_Weeks__c');
            hous_accm.put('solo - 43 weeks','Solo_43_Weeks__c');
            hous_accm.put('solo - 51 weeks','Solo_51_Weeks__c');
            hous_accm.put('solo deluxe - 36 weeks','Solo_Deluxe_36_Weeks__c');
            hous_accm.put('solo deluxe - 43 weeks','Solo_Deluxe_43_Weeks__c');
            hous_accm.put('solo deluxe - 51 weeks','Solo_Deluxe_51_weeks__c');
            hous_accm.put('twin - 36 weeks','Twin_36_Weeks__c');
            hous_accm.put('twin - 43 weeks','Twin_43_Weeks__c');
            hous_accm.put('twin - 51 weeks','Twin_51_Weeks__c');
            hous_accm.put('twin deluxe - 36 weeks','Twin_Deluxe_36_weeks__c');
            hous_accm.put('twin deluxe - 43 weeks','Twin_Deluxe_43_weeks__c');
            hous_accm.put('twin deluxe - 51 weeks','Twin_Deluxe_51_weeks__c');
            hous_accm.put('studio - 36 weeks','Studio_36_weeks__c');
            hous_accm.put('studio - 43 weeks','Studio_43_weeks__c');
            hous_accm.put('studio - 51 weeks','Studio_51_weeks__c');
            hous_accm.put('studio vista - 36 weeks','Studio_Vista_36_weeks__c');
            hous_accm.put('studio vista - 43 weeks','Studio_Vista_43_weeks__c');
            hous_accm.put('studio vista - 51 weeks','Studio_Visa_51_weeks__c');
            hous_accm.put('apartment - 36 weeks','Apartment_36_weeks__c');
            hous_accm.put('apartment - 43 weeks','Apartment_43__c');
            hous_accm.put('apartment - 51 weeks','Apartment_51_weeks__c');
            hous_accm.put('apartment vista - 36 weeks','Apartment_Vista_36_weeks__c');
            hous_accm.put('apartment vista - 43 weeks','Apartment_Vista_43_weeks__c');
            hous_accm.put('apartment vista - 51 weeks','Apartment_Visa_51_weeks__c');
            hous_accm.put('deluxe studio apartment - 36 weeks','Deluxe_Studio_Apartment_36_weeks__c');
            hous_accm.put('deluxe studio apartment - 43 weeks','Deluxe_Studio_Apartment_43_weeks__c');
            hous_accm.put('deluxe studio apartment - 51 weeks','Deluxe_Studio_Apartment_51_weeks__c');
            hous_accm.put('deluxe studio apartment extra - 36 weeks','Deluxe_Studio_Apartment_Extra_36_weeks__c');
            hous_accm.put('deluxe studio apartment extra - 43 weeks','Deluxe_Studio_Apartment_Extra_43_weeks__c');
            hous_accm.put('deluxe studio apartment extra - 51 weeks','Deluxe_Studio_Apartment_Extra_51_weeks__c');
            hous_accm.put('penthouse luxury studio - 36 weeks','Penthouse_Luxury_Studio_36_weeks__c');
            hous_accm.put('penthouse luxury studio - 43 weeks','Penthouse_Luxury_Studio_43_weeks__c');
            hous_accm.put('penthouse luxury studio - 51 weeks','Penthouse_Luxury_Studio_51_weeks__c');
            hous_accm.put('standard double - 36 weeks','Standard_Double_Room__c');
            hous_accm.put('standard double - 43 weeks','Standard_Double_Room_43_Weeks__c');
            hous_accm.put('standard double - 51 weeks','Standard_Double_Room_51_Weeks__c');
            hous_accm.put('premium double - 36 weeks','Premium_Double__c');
            hous_accm.put('premium double - 43 weeks','Premium_Double_Room_43_Weeks__c');
            hous_accm.put('premium double - 51 weeks','Premium_Double_Room_51_Weeks__c');
            hous_accm.put('premium single - 36 weeks','Premium_Single_Room_36_Weeks__c');
            hous_accm.put('premium single - 43 weeks','Premium_Single_Room_43_Weeks__c');
            hous_accm.put('premium single - 51 weeks','Premium_Single_Room_51_Weeks__c');
            
            // below map contains values with out having weeks specified.
            hous_accm.put('shanghai - single room - 8 months - free','shanghai_single_room_8_months_free__c');  
            hous_accm.put('dubai housing bursary' ,'dubai_housing_bursary__c');
            hous_accm.put('emba hotel' ,'emba_hotel__c');
            hous_accm.put('shanghai hult accommodation – 8 months' ,'accommodation_for_8_months__c');
            hous_accm.put('shanghai hult accommodation – 12 months' ,'accommodation_for_12_months__c');
            hous_accm.put('shanghai accommodation with dependent for 8 months','accommodation_with_dependent_for_8_mths__c');
            hous_accm.put('shanghai accommodation with dependent for 12 months','accommodation_with_dependent_for_12_mths__c');
            hous_accm.put('free accommodation with dependent – 8 months','free_accommodation_with_dependent_8mth__c');
            hous_accm.put('shanghai accommodation family','shanghai_accommodation_family__c'); 
            hous_accm.put('hh east – 12 months','hult_house_east_12_months__c'); 
            hous_accm.put('hh - twin studios - double','hh_twin_studios_double__c'); 
            hous_accm.put('hh - super twin - double','hh_super_twin_double__c');  
            hous_accm.put('hh - twin plus - double','hh_twin_plus_double__c'); 
            hous_accm.put('hh - study twin - double','hh_study_twin_double__c'); 
            hous_accm.put('hh - assam studio - single','hh_assam_studio_single__c');
            hous_accm.put('hh - studios vista - single','hh_studios_vista_single__c');  
            hous_accm.put('hh - studios vista - single','hh_studios_vista_single__c'); 
            hous_accm.put('hh - studios premium 15 -16 - single','hh_studios_premium_15_16_single__c');
            hous_accm.put('hh - studios premium 11-14 - single','hh_studios_premium_11_14_single__c'); 
            hous_accm.put('hh - club studio deluxe - single','hh_club_studio_deluxe_single__c');  
            hous_accm.put('hh - classic studio deluxe - single','hh_classic_studio_deluxe_single__c');
            hous_accm.put('hh - club studio - single','hh_club_studio_single__c');  
            hous_accm.put('hh - classic studio - single','hh_classic_studio_single__c');  
            hous_accm.put('hh - solo - single','hh_solo_single__c');       
            
         }
         
         if(rot_item==null || rot_item.IsEmpty())
         {
            rot_item.put('nyc - housing - single - mod d','NYC_Housing_Single_Mod_D__c');
            rot_item.put('nyc - housing - single - mod e','NYC_Housing_Single_Mod_E__c');
            rot_item.put('nyc - housing - single - mod d&e','NYC_Housing_Single_Mod_D_E__c');
            rot_item.put('nyc - housing - twin - mod d','NYC_Housing_Twin_Mod_D__c');
            rot_item.put('nyc - housing - twin - mod e','NYC_Housing_Twin_Mod_E__c');
            rot_item.put('nyc - housing - twin - mod d&e','NYC_Housing_Twin_Mod_D_E__c');
            rot_item.put('nyc - housing - large single - mod d','NYC_Housing_Large_Single_Mod_D__c');
            rot_item.put('nyc - housing - large single - mod e','NYC_Housing_Large_Single_Mod_E__c');
            rot_item.put('sha - housing - type a - mod d','SHA_Housing_Type_A_Mod_D__c');
            rot_item.put('sha - housing - type a - mod e','SHA_Housing_Type_A_Mod_E__c');
            rot_item.put('sha - housing - type b - mod d','SHA_Housing_Type_B_Mod_D__c');
            rot_item.put('sha - housing - type b - mod e','SHA_Housing_Type_B_Mod_E__c');
            rot_item.put('sha - housing - type c - mod d','SHA_Housing_Type_C_Mod_D__c');
            rot_item.put('sha - housing - type c - mod e','SHA_Housing_Type_C_Mod_E__c');
            rot_item.put('sha - housing - type c1 - mod d','SHA_Housing_Type_C1_Mod_D__c');
            rot_item.put('sha - housing - type c1 - mod e','SHA_Housing_Type_C1_Mod_E__c');
            rot_item.put('sha - housing - type d - mod d','SHA_Housing_Type_D_Mod_D__c');
            rot_item.put('sha - housing - type d - mod e','SHA_Housing_Type_D_Mod_E__c');
            rot_item.put('sha - housing - type d1 - mod d','SHA_Housing_Type_D1_Mod_D__c');
            rot_item.put('sha - housing - type d1 - mod e','SHA_Housing_Type_D1_Mod_E__c');
            rot_item.put('sha - housing - type e - mod d','SHA_Housing_Type_E_Mod_D__c');
            rot_item.put('sha - housing - type e - mod e','SHA_Housing_Type_E_Mod_E__c');
            rot_item.put('sha - housing - type f - mod d','SHA_Housing_Type_F_Mod_D__c');
            rot_item.put('sha - housing - type f - mod e','SHA_Housing_Type_F_Mod_E__c');
            rot_item.put('sha - housing - suite - mod d','SHA_H__c');
            rot_item.put('sha - housing - suite - mod e','SHA_Housing_Suite_Mod_E__c');
            rot_item.put('sha - housing - dependent - mod d','SHA_Housing_Dependent_E__c');
            rot_item.put('sha - housing - dependent - mod e','SHA_Housing_Dependent__c');
            rot_item.put('sha - visa - jw-202','SHA_Visa_JW_202__c');
            rot_item.put('dub - visa - visit','DUB_Visa_Visit__c');
            rot_item.put('dub - visa - residence','DUB_Visa_Residence__c');
            rot_item.put('dub - visa - transit','DUB_Visa_Transit__c');
            rot_item.put('insurance - erika - mod d','Insurance_Erika_Mod_D__c');
            rot_item.put('insurance - erika - mod e','Insurance_Erika_Mod_E__c');
         
         }
    }
    /*
    only for bba program fields mapping. 
    
    For Bachelors program - puts fee values into corresponding finance fields. 
    
    */
    public static void linking_BBA_Finance(fees__c fee,Opportunity_Finance__c opfin){
        field_maps();
        // points a,b,c,d
        opfin.BBA_Program_Fee_Year_1__c=fee.BBA_Program_Fee_Year_1_BBA__c;
        opfin.BBA_Program_Fee_Year_2__c=fee.BBA_Program_Fee_Year_2__c;
        opfin.BBA_Program_Fee_Year_3__c=fee.BBA_Program_Fee_Year_3_BBA__c;
        opfin.BBA_Program_Fee_Year_4__c=fee.BBA_Program_Fee_Year_4_BBA__c;
        
        // points e,f,g,h
        if(Opfin.BBA_Insurance_Picklist_Year_1__c=='Erika Insurance'){
            opfin.BBA_Insurance_Year_1__c=fee.BBA_Erika_Insurance_Year_1_Single_BBA__c;                  
        }else if(Opfin.BBA_Insurance_Picklist_Year_1__c=='Aetna Insurance'){
            opfin.BBA_Insurance_Year_1__c=fee.BBA_Aetna_Insurance_Year_1__c;                  
        }else{
            opfin.BBA_Insurance_Year_1__c=null;
        }
        if(Opfin.BBA_Insurance_Picklist_Year_2__c=='Erika Insurance'){
            opfin.BBA_Insurance_Year_2__c=fee.BBA_Erika_Insurnce_Year_2_Single_BBA__c;                  
        }else if(Opfin.BBA_Insurance_Picklist_Year_2__c=='Aetna Insurance'){
            opfin.BBA_Insurance_Year_2__c=fee.BBA_Aetna_Insurance_Year_2__c;                  
        }else{
            opfin.BBA_Insurance_Year_2__c=null;
        }
        if(Opfin.BBA_Insurance_Picklist_Year_3__c=='Erika Insurance'){
            opfin.BBA_Insurance_Year_3__c=fee.BBA_Erika_Insurance_Year_3_Single_BBA__c;                  
        }else if(Opfin.BBA_Insurance_Picklist_Year_3__c=='Aetna Insurance'){
            opfin.BBA_Insurance_Year_3__c=fee.BBA_Aetna_Insurance_Year_3__c;                  
        }else{
            opfin.BBA_Insurance_Year_3__c=null;
        }
        if(Opfin.BBA_Insurance_Picklist_Year_4__c=='Erika Insurance'){
            opfin.BBA_Insurance_Year_4__c=fee.BBA_Erika_Insurance_Year_4_Single_BBA__c;                  
        }else if(Opfin.BBA_Insurance_Picklist_Year_4__c=='Aetna Insurance'){
            opfin.BBA_Insurance_Year_4__c=fee.BBA_Aetna_Insurance_Year_4__c;                  
        }else{
            opfin.BBA_Insurance_Year_4__c=null;
        }
        
        // points i,j
        if(opfin.BBA_Installment_Plan_Picklist__c=='Installment Plan - Year 1'){
            opfin.BBA_Installment_Plan_Year_1__c=fee.BBA_Installment_Plan_Year_1_BBA__c;
        }else{
            opfin.BBA_Installment_Plan_Year_1__c=null;
        }
        if(opfin.BBA_Installment_Plan_Picklist_Year_2__c=='Installment Plan - Year 2'){
            opfin.BBA_Installment_Plan_Year_2__c=fee.BBA_Installment_Plan_Year_2_BBA__c;
        }else{
            opfin.BBA_Installment_Plan_Year_2__c=null;
        }
        if(opfin.BBA_Installment_Plan_Picklist_Year_3__c=='Installment Plan - Year 3'){
            opfin.BBA_Installment_Plan_Year_3__c=fee.BBA_Installment_Plan_Year_3_BBA__c;
        }else{
            opfin.BBA_Installment_Plan_Year_3__c=null;
        }
        if(opfin.BBA_Installment_Plan_Picklist_Year_4__c=='Installment Plan - Year 4'){
            opfin.BBA_Installment_Plan_Year_4__c=fee.BBA_Installment_Plan_Year_4_BBA__c;
        }else{
            opfin.BBA_Installment_Plan_Year_4__c=null;
        }
        
        //point k
        string fieldlabel,feeapiname;
        //fieldlabel=opfin.BBA_Accommodation_Year_1__c!=null?opfin.BBA_Accommodation_Year_1__c +' - '+opfin.BBA_Accommodation_Weeks_Year_1__c+' weeks_y1':'noval';      
        fieldlabel=opfin.BBA_Accommodation_Year_1__c +' - '+opfin.BBA_Accommodation_Weeks_Year_1__c+' weeks_y1';
        feeapiname=null; 
        if(bba_accm.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_accm.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Accommodation_Year_1__c==null || opfin.BBA_Accommodation_Weeks_Year_1__c==null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_1__c',null);        
            }
            if(opfin.BBA_Accommodation_Year_1__c!=null && opfin.BBA_Accommodation_Weeks_Year_1__c!=null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_1__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Accommodation_Fee_Year_1__c',null);     
        }
        
        //fieldlabel=opfin.BBA_Accommodation_Year_2__c!=null?opfin.BBA_Accommodation_Year_2__c +' - '+opfin.BBA_Accommodation_Weeks_Year_2__c+' weeks_y2':'noval'; 
        fieldlabel=opfin.BBA_Accommodation_Year_2__c +' - '+opfin.BBA_Accommodation_Weeks_Year_2__c+' weeks_y2';
        feeapiname=null;
        if(bba_accm.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_accm.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Accommodation_Year_2__c==null || opfin.BBA_Accommodation_Weeks_Year_2__c==null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_2__c',null);        
            }
            if(opfin.BBA_Accommodation_Year_2__c!=null && opfin.BBA_Accommodation_Weeks_Year_2__c!=null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_2__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Accommodation_Fee_Year_2__c',null);     
        }
        
        //fieldlabel=opfin.BBA_Accommodation_Year_3__c!=null?opfin.BBA_Accommodation_Year_3__c +' - '+opfin.BBA_Accommodation_Weeks_Year_3__c+' weeks_y3':'noval'; 
        fieldlabel=opfin.BBA_Accommodation_Year_3__c +' - '+opfin.BBA_Accommodation_Weeks_Year_3__c+' weeks_y3';
        feeapiname=null;
        if(bba_accm.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_accm.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Accommodation_Year_3__c==null || opfin.BBA_Accommodation_Weeks_Year_3__c==null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_3__c',null);        
            }
            if(opfin.BBA_Accommodation_Year_3__c!=null && opfin.BBA_Accommodation_Weeks_Year_3__c!=null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_3__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Accommodation_Fee_Year_3__c',null);     
        }
        
        //fieldlabel=opfin.BBA_Accommodation_Year_4__c!=null?opfin.BBA_Accommodation_Year_4__c +' - '+opfin.BBA_Accommodation_Weeks_Year_4__c+' weeks_y4':'noval'; 
        fieldlabel=opfin.BBA_Accommodation_Year_4__c +' - '+opfin.BBA_Accommodation_Weeks_Year_4__c+' weeks_y4';
        feeapiname=null;
        if(bba_accm.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_accm.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Accommodation_Year_4__c==null || opfin.BBA_Accommodation_Weeks_Year_4__c==null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_4__c',null);
            }
            if(opfin.BBA_Accommodation_Year_4__c!=null && opfin.BBA_Accommodation_Weeks_Year_4__c!=null)
            {
                opfin.put('BBA_Accommodation_Fee_Year_4__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Accommodation_Fee_Year_4__c',null);
        }
        
        // for points m,n
        // rotation 1 year 1
        fieldlabel=opfin.BBA_Rotation_1_Year_1__c!=null?opfin.BBA_Rotation_1_Year_1__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_1_Year_1__c==null)
            {
                opfin.put('BBA_Rotation_1_Fee__c',null);
            }
            if(opfin.BBA_Rotation_1_Year_1__c!=null)
            {
                opfin.put('BBA_Rotation_1_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_1_Fee__c',null);
        }
        // rotation 1 year 2
        fieldlabel=opfin.BBA_Rotation_1_Year_2__c!=null?opfin.BBA_Rotation_1_Year_2__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_1_Year_2__c==null)
            {
                opfin.put('BBA_Rotation_1_Year_2_Fee__c',null);
            }
            if(opfin.BBA_Rotation_1_Year_2__c!=null)
            {
                opfin.put('BBA_Rotation_1_Year_2_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_1_Year_2_Fee__c',null);
        }
        // rotation 1 year 3
        fieldlabel=opfin.BBA_Rotation_1_Year_3__c!=null?opfin.BBA_Rotation_1_Year_3__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_1_Year_3__c==null)
            {
                opfin.put('BBA_Rotation_1_Year_3_Fee__c',null);
            }
            if(opfin.BBA_Rotation_1_Year_3__c!=null)
            {
                opfin.put('BBA_Rotation_1_Year_3_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_1_Year_3_Fee__c',null);
        }
        // rotation 1 year 4
        fieldlabel=opfin.BBA_Rotation_1_Year_4__c!=null?opfin.BBA_Rotation_1_Year_4__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_1_Year_4__c==null)
            {
                opfin.put('BBA_Rotation_1_Year_4_Fee__c',null);
            }
            if(opfin.BBA_Rotation_1_Year_4__c!=null)
            {
                opfin.put('BBA_Rotation_1_Year_4_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_1_Year_4_Fee__c',null);
        }
        
        // rotation 2 year 1
        fieldlabel=opfin.BBA_Rotation_2_Year_1__c!=null?opfin.BBA_Rotation_2_Year_1__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_2_Year_1__c==null)
            {
                opfin.put('BBA_Rotation_2_Year_1_Fee__c',null);
            }
            if(opfin.BBA_Rotation_2_Year_1__c!=null)
            {
                opfin.put('BBA_Rotation_2_Year_1_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_2_Year_1_Fee__c',null);
        }
        // rotation 2 year 2
        fieldlabel=opfin.BBA_Rotation_2_Year_2__c!=null?opfin.BBA_Rotation_2_Year_2__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_2_Year_2__c==null)
            {
                opfin.put('BBA_Rotation_2_Year_2_Fee__c',null);
            }
            if(opfin.BBA_Rotation_2_Year_2__c!=null)
            {
                opfin.put('BBA_Rotation_2_Year_2_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_2_Year_2_Fee__c',null);
        }
        // rotation 2 year 3
        fieldlabel=opfin.BBA_Rotation_2_Year_3__c!=null?opfin.BBA_Rotation_2_Year_3__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_2_Year_3__c==null)
            {
                opfin.put('BBA_Rotation_2_Year_3_Fee__c',null);
            }
            if(opfin.BBA_Rotation_2_Year_3__c!=null)
            {
                opfin.put('BBA_Rotation_2_Year_3_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_2_Year_3_Fee__c',null);
        }
        // rotation 2 year 4
        fieldlabel=opfin.BBA_Rotation_2_Year_4__c!=null?opfin.BBA_Rotation_2_Year_4__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_2_Year_4__c==null)
            {
                opfin.put('BBA_Rotation_2_Year_4_Fee__c',null);
            }
            if(opfin.BBA_Rotation_2_Year_4__c!=null)
            {
                opfin.put('BBA_Rotation_2_Year_4_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_2_Year_4_Fee__c',null);
        }
        
        // rotation 3 year 1
        fieldlabel=opfin.BBA_Rotation_3_Year_1__c!=null?opfin.BBA_Rotation_3_Year_1__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_3_Year_1__c==null)
            {
                opfin.put('BBA_Rotation_3_Year_1_Fee__c',null);
            }
            if(opfin.BBA_Rotation_3_Year_1__c!=null)
            {
                opfin.put('BBA_Rotation_3_Year_1_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_3_Year_1_Fee__c',null);
        }
        // rotation 3 year 2
        fieldlabel=opfin.BBA_Rotation_3_Year_2__c!=null?opfin.BBA_Rotation_3_Year_2__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_3_Year_2__c==null)
            {
                opfin.put('BBA_Rotation_3_Year_2_Fee__c',null);
            }
            if(opfin.BBA_Rotation_3_Year_2__c!=null)
            {
                opfin.put('BBA_Rotation_3_Year_2_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_3_Year_2_Fee__c',null);
        }
        // rotation 3 year 3
        fieldlabel=opfin.BBA_Rotation_3_Year_3__c!=null?opfin.BBA_Rotation_3_Year_3__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_3_Year_3__c==null)
            {
                opfin.put('BBA_Rotation_3_Year_3_Fee__c',null);
            }
            if(opfin.BBA_Rotation_3_Year_3__c!=null)
            {
                opfin.put('BBA_Rotation_3_Year_3_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_3_Year_3_Fee__c',null);
        }
        // rotation 3 year 4
        fieldlabel=opfin.BBA_Rotation_3_Year_4__c!=null?opfin.BBA_Rotation_3_Year_4__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_3_Year_4__c==null)
            {
                opfin.put('BBA_Rotation_3_Year_4_Fee__c',null);
            }
            if(opfin.BBA_Rotation_3_Year_4__c!=null)
            {
                opfin.put('BBA_Rotation_3_Year_4_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_3_Year_4_Fee__c',null);
        }
        
        // rotation 4 year 1
        fieldlabel=opfin.BBA_Rotation_4_Year_1__c!=null?opfin.BBA_Rotation_4_Year_1__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_4_Year_1__c==null)
            {
                opfin.put('BBA_Rotation_4_Year_1_Fee__c',null);
            }
            if(opfin.BBA_Rotation_4_Year_1__c!=null)
            {
                opfin.put('BBA_Rotation_4_Year_1_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_4_Year_1_Fee__c',null);
        }
        // rotation 4 year 2
        fieldlabel=opfin.BBA_Rotation_4_Year_2__c!=null?opfin.BBA_Rotation_4_Year_2__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_4_Year_2__c==null)
            {
                opfin.put('BBA_Rotation_4_Year_2_Fee__c',null);
            }
            if(opfin.BBA_Rotation_4_Year_2__c!=null)
            {
                opfin.put('BBA_Rotation_4_Year_2_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_4_Year_2_Fee__c',null);
        }
        // rotation 4 year 3
        fieldlabel=opfin.BBA_Rotation_4_Year_3__c!=null?opfin.BBA_Rotation_4_Year_3__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_4_Year_3__c==null)
            {
                opfin.put('BBA_Rotation_4_Year_3_Fee__c',null);
            }
            if(opfin.BBA_Rotation_4_Year_3__c!=null)
            {
                opfin.put('BBA_Rotation_4_Year_3_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_4_Year_3_Fee__c',null);
        }
        // rotation 4 year 4
        fieldlabel=opfin.BBA_Rotation_4_Year_4__c!=null?opfin.BBA_Rotation_4_Year_4__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_4_Year_4__c==null)
            {
                opfin.put('BBA_Rotation_4_Year_4_Fee__c',null);
            }
            if(opfin.BBA_Rotation_4_Year_4__c!=null)
            {
                opfin.put('BBA_Rotation_4_Year_4_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_4_Year_4_Fee__c',null);
        }
        
        // rotation 5 year 1
        fieldlabel=opfin.BBA_Rotation_5_Year_1__c!=null?opfin.BBA_Rotation_5_Year_1__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_5_Year_1__c==null)
            {
                opfin.put('BBA_Rotation_5_Year_1_Fee__c',null);
            }
            if(opfin.BBA_Rotation_5_Year_1__c!=null)
            {
                opfin.put('BBA_Rotation_5_Year_1_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_5_Year_1_Fee__c',null);
        }
        // rotation 5 year 2
        fieldlabel=opfin.BBA_Rotation_5_Year_2__c!=null?opfin.BBA_Rotation_5_Year_2__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_5_Year_2__c==null)
            {
                opfin.put('BBA_Rotation_5_Year_2_Fee__c',null);
            }
            if(opfin.BBA_Rotation_5_Year_2__c!=null)
            {
                opfin.put('BBA_Rotation_5_Year_2_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_5_Year_2_Fee__c',null);
        }
        // rotation 5 year 3
        fieldlabel=opfin.BBA_Rotation_5_Year_3__c!=null?opfin.BBA_Rotation_5_Year_3__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_5_Year_3__c==null)
            {
                opfin.put('BBA_Rotation_5_Year_3_Fee__c',null);
            }
            if(opfin.BBA_Rotation_5_Year_3__c!=null)
            {
                opfin.put('BBA_Rotation_5_Year_3_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_5_Year_3_Fee__c',null);
        }
        // rotation 5 year 4
        fieldlabel=opfin.BBA_Rotation_5_Year_4__c!=null?opfin.BBA_Rotation_5_Year_4__c:'noval'; 
        feeapiname=null;
        if(bba_rot.containsKey(fieldlabel.tolowercase()))    
            feeapiname=bba_rot.get(fieldlabel.tolowercase());
        if(feeapiname!=null)
        {
            if(opfin.BBA_Rotation_5_Year_4__c==null)
            {
                opfin.put('BBA_Rotation_5_Year_4_Fee__c',null);
            }
            if(opfin.BBA_Rotation_5_Year_4__c!=null)
            {
                opfin.put('BBA_Rotation_5_Year_4_Fee__c',fee.get(feeapiname));
            }
        }
        else
        {
            opfin.put('BBA_Rotation_5_Year_4_Fee__c',null);
        }
        
    }
    
    /*
    
    puts fee values into corresponding finance fields. 
    like Housing Accommodation fees,Rotation fees etc.
    */
    
    public static void financefieldsvals(Fees__c fee,Opportunity_Finance__c new_fin,Opportunity_Finance__c old_fin)
    {
        
        field_maps();
        if((old_fin.Housing_Accommodation__c!=new_fin.Housing_Accommodation__c || old_fin.Accommodation_weeks__c!=new_fin.Accommodation_weeks__c) )//|| (new_fin.Housing_Accommodation__c !=null && new_fin.Annual_Accommodation_Fee__c==null ))
            {
                string fieldlabel,feeapiname;  
                System.debug('==========>'+new_fin.Housing_Accommodation__c +' - '+new_fin.Accommodation_weeks__c );                
                fieldlabel=new_fin.Housing_Accommodation__c +' - '+new_fin.Accommodation_weeks__c+' weeks'; 
                //System.debug('======2====>'+new_fin.Rot_Housing_Module_D__c);
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
                    if(new_fin.Housing_Accommodation__c!=null && hous_accm.containsKey(new_fin.Housing_Accommodation__c.tolowercase()))
                    {
                         string temp=hous_accm.get(new_fin.Housing_Accommodation__c.tolowercase());   
                         if(temp!=null)
                         {
                             new_fin.put('Annual_Accommodation_Fee__c',fee.get(temp)); 
                         }
                         else
                         {new_fin.put('Annual_Accommodation_Fee__c',null); }    
                    }
                    else{
                        new_fin.put('Annual_Accommodation_Fee__c',null);     }
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
                System.debug('======2====>'+new_fin.Rot_Housing_Module_D__c);
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
            }
    
    }
    
}