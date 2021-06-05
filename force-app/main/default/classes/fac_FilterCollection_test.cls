/**
 * @description       : fac_FilterCollection_test
 * @author            : Jack D. Pond
 * @group             : 
 * @last modified on  : 06-04-2021
 * @last modified by  : Jack D. Pond
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   06-01-2021   Jack D. Pond   Initial Version
**/
@isTest
private class fac_FilterCollection_test{
	private Static Final Integer TEST_ACCOUNTS_COUNT = 3;
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
		fac_FilterCollection.Request thisRequest = new fac_FilterCollection.Request();
		thisRequest.inFieldName = 'Name';
		thisRequest.fromCollection = (List<SObject>) createTestAccounts(TEST_ACCOUNTS_COUNT);
		thisRequest.inList = new List<String>{'Test Account 0000','Test Account 0002'};
		List<fac_FilterCollection.Request> theseRequests = new List<fac_FilterCollection.Request>{thisRequest};
		theseRequests.add(thisRequest);
		list<fac_FilterCollection.Response> testResponseList = fac_FilterCollection.fac_FilterCollection(theseRequests);
		system.assertEquals(2,testResponseList[0].retObjects.size());
		system.assertEquals('Test Account 0002',testResponseList[0].retObjects[1].get('Name'));
	}
}