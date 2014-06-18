public with sharing class RecordTypeHelper 
{
	/*
		Class     : RecordTypeHelper	    
	    Developer : Harsha Simha S
	    Date      : 03/04/2013
	    Comment   : Helper class which will extracts all the record types and its names,
	    			passing the object name and Record type name returns record typeid,
	    			passing the Record type id returns record type name.
	    Test Class: RecordTypeHelper.cls(94%)	
	
		Addons	  : Enhancement for getting profile id orprofile names
		
	*/
  // internal static variables and methods
  private static Map<String, RecordType> m_rt = null;
  private static void fillRecordTypeMap() {
    m_rt = new Map<String, RecordType>();
        RecordType[] rtList = [Select Id, sObjectType, Name From RecordType];
        for(RecordType rt : rtList) {
          m_rt.put(rt.sObjectType + '|' + rt.Name, rt);
          m_rt.put(rt.Id, rt);
        }
  }
  //RecordTypeHelper.getRecordTypeId('Contact','Applicant')
  // public methods
    public static Id getRecordTypeId(String sobject_type, String recordtype_name) 
    {
       RecordType rt = getRecordType(sobject_type, recordtype_name);
       return (rt!=null?rt.Id:null);
    }
    public static RecordType getRecordType(String sobject_type, String recordtype_name) {
       if(m_rt==null || m_rt.size()==0) 
          fillRecordTypeMap();
        RecordType rt = m_rt.get(sobject_type + '|' + recordtype_name);
        return (rt!=null?rt:null);
    }
    public static String getRecordTypeName(Id recordtype_id) {
      if(m_rt==null || m_rt.size()==0)
        fillRecordTypeMap();
      RecordType rt = m_rt.get(recordtype_id);
      return (rt!=null?rt.Name:null);
    }
    
    
    //for profiles
    private static Map<String, Profile> m_prof = null;
	private static void fillProfileTypeMap() {
	    m_prof = new Map<String, Profile>();
	        Profile[] profList = [Select Id, Name From Profile];
	        for(Profile rt : profList) {
	          m_prof.put(rt.Name, rt);
	          m_prof.put(rt.Id, rt);
	        }
	}
	
    public static string getprofileid(String profile_name) {
       if(m_prof==null || m_prof.size()==0) 
          fillprofileTypeMap();
        profile pr = m_prof.get(profile_name);
        return (pr!=null?pr.Id:null);
    }
    public static string getprofilename(String profile_id) {
       if(m_prof==null || m_prof.size()==0) 
          fillprofileTypeMap();
        profile pr = m_prof.get(profile_id);
        return (pr!=null?pr.Name:null);
    }
    
    // for test coverage
    @istest(SeeAllData=true)
    private static void RecordTypeHelper_TEST() {
	    //test Record type
	    System.assertEquals(getRecordType('Contact','c'),null);
	    System.assertEquals(getRecordType('Contact','Applicant'),[Select r.SobjectType, r.Name From RecordType r where Name='Applicant' and SObjectType='Contact']);    
	    System.assertEquals(getRecordTypeId('Contact','c'),null);
	    System.assertEquals(getRecordTypeId('Contact','Applicant'),[Select r.SobjectType, r.Name From RecordType r where Name='Applicant' and SObjectType='Contact'].Id);
	    System.assertEquals(getRecordTypeName(getRecordTypeId('Contact','c')),null);
	    System.assertEquals('Applicant',getRecordTypeName([Select r.SobjectType, r.Name From RecordType r where Name='Applicant' and SObjectType='Contact'].Id));
    	
    	List<Profile> pro=[Select id,Name From Profile where Name='System Administrator'];
    	System.assertEquals(getprofileid('c'),null);
	    System.assertEquals(getprofileid('System Administrator'),pro[0].Id);    
	    System.assertEquals(getprofileName('c'),null);
	    System.assertEquals(getprofileNAme(pro[0].Id),'System Administrator');	    
    }
}