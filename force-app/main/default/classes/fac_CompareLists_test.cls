/**
 * @description       : fac_CompareLists_test - Compare two string lists (for Multi-Select)
 * @author            : Jack D. Pond
 * @group             : 
 * @last modified on  : 06-02-2021
 * @last modified by  : Jack D. Pond
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   06-02-2021   Jack D. Pond   Initial Version
**/
@isTest
private class fac_CompareLists_test{

	@testSetup static void setup(){
	}

	@isTest static void t001_coverage() {
		fac_CompareLists.Request thisRequest = new fac_CompareLists.Request();
		thisRequest.stringList1 = new List<String> {'StringSame','StringDeleted'};
		thisRequest.stringList2 = new List<String> {'StringSame','StringAdded'};
		list<fac_CompareLists.Response> testResponseList = fac_CompareLists.fac_CompareLists(new List<fac_CompareLists.Request>{thisRequest});
		system.assertEquals(1,testResponseList[0].stringListAdded.size());
		system.assertEquals(1,testResponseList[0].stringListDeleted.size());
		system.assertEquals('StringAdded',testResponseList[0].stringListAdded[0]);
		system.assertEquals('StringDeleted',testResponseList[0].stringListDeleted[0]);
	}
}