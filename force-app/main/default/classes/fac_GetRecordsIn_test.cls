/**
 * @description       : fac_GetRecordsIn_test
 * @author            : Jack D. Pond
 * @group             : 
 * @last modified on  : 06-04-2021
 * @last modified by  : Jack D. Pond
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   06-01-2021   Jack D. Pond   Initial Version
**/
@isTest
private class fac_GetRecordsIn_test{
	private Static Final Integer TEST_ACCOUNTS_COUNT = 1;
	private Static Final Integer BULK_TEST_COUNT = 6;

//	Create an Account to test email field merge
	private static List<Account> createTestAccounts(integer howMany){
		List<Account> accountList = new List<Account>();
		for (Integer i = 0; i < howMany; i++){
			accountList.add(new Account(
					Name    	= 'Test Account '+ ('0000'+i).right(4)	
				)
			);
		}
		insert AccountList;
		return AccountList;
	}

	@testSetup static void setup(){
		
	}

	@isTest static void t001_Coverage() {
		fac_GetRecordsIn.Request thisRequest = new fac_GetRecordsIn.Request();
        List<Account> testAccounts = createTestAccounts(TEST_ACCOUNTS_COUNT);
        thisRequest.objectName = 'Account';
		thisRequest.inFieldName = 'Id';
        thisRequest.inList = new List<Id>{testAccounts[0].Id};
        thisRequest.fieldsList= new List<String>{'Id','Name'};
		List<fac_GetRecordsIn.Request> theseRequests = new List<fac_GetRecordsIn.Request>{thisRequest};
		list<fac_GetRecordsIn.Response> testResponseList = fac_GetRecordsIn.fac_GetRecordsIn(theseRequests);
		system.assertEquals('Test Account '+ ('0000'+0).right(4),testResponseList[0].retObjects[0].get('Name'));
		system.assertEquals(TEST_ACCOUNTS_COUNT,testResponseList[0].retObjects.size());
	}
}