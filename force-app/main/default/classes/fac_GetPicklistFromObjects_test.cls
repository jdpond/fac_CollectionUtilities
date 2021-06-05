/**
 * @description       : 
 * @author            : Jack D. Pond
 * @group             : 
 * @last modified on  : 06-01-2021
 * @last modified by  : Jack D. Pond
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   06-01-2021   Jack D. Pond   Initial Version
**/
@isTest
private class fac_GetPicklistFromObjects_test{
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
		fac_GetPicklistFromObjects.Request thisRequest = new fac_GetPicklistFromObjects.Request();
		thisRequest.fromField = 'Name';
		thisRequest.fromObjects = createTestAccounts(TEST_ACCOUNTS_COUNT);
		List<fac_GetPicklistFromObjects.Request> theseRequests = new List<fac_GetPicklistFromObjects.Request>{thisRequest};
		list<fac_GetPicklistFromObjects.Response> testResponseList = fac_GetPicklistFromObjects.fac_GetPicklistFromObjects(theseRequests);
		system.assertEquals('Test Account '+ ('0000'+0).right(4),testResponseList[0].retPicklist[0]);
		system.assertEquals(TEST_ACCOUNTS_COUNT,testResponseList[0].retPicklist.size());
	}
}