/* 
 Created by   : Premanath Reddy
 Date         : 16/1/2014
 purpose      : Test class for Account_rectype class and set_uniqname Trigger
 Modified     : Prem 9/4/2014 :: Added test class code for set_uniqname trigger
*/
@IsTest
public class Account_rectype_Test{
    static testmethod void methodname(){
        
        String recid=RecordTypeHelper.getRecordTypeId('Account','Educational Institution');
        Apexpages.currentpage().getparameters().put('objname','Task');
        
        City__c cty=new City__c();
        cty.Name='test';
        insert cty;
        
        Account acc=New Account();
        acc.Name='test';
        acc.City__c=cty.id;
        acc.Street__c='test';
        acc.RecordTypeId=recid;
        insert acc;
        
        Apexpages.Currentpage().getParameters().put('retURL','test');
        Apexpages.currentpage().getparameters().put('what_id',acc.id);
        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        Account_rectype act=new Account_rectype(sc);
        act.getrect();        
        act.cusContinue();
        act.cusCancel();
        
        Apexpages.currentpage().getparameters().put('objname','Event');
        act=new Account_rectype(sc);
        act.cusContinue();
        
        try{
            Account acc1=New Account();
            acc1.Name='test';
            acc1.City__c=cty.id;
            acc1.Street__c='test';
            acc1.RecordTypeId=recid;
            insert acc1;
        }
        Catch(Exception e){
        }
        
        
    }
}