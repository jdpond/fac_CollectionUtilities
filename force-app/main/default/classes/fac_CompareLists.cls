/**
 * @description       : fac_CompareLists - Compare two lists returning A list of those added to the first and a list of those deleted From the first
 * @author            : Jack D. Pond
 * @group             : 
 * @last modified on  : 06-04-2021
 * @last modified by  : Jack D. Pond
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   06-02-2021   Jack D. Pond   Initial Version
**/
public with sharing class fac_CompareLists {
    @invocableMethod(label='fac_CompareLists' description='Compare two lists returning A list of those added to the first and a list of those deleted From the first' category='FAC Utilities')
    public static List<Response> fac_CompareLists(List<Request> requests) {
        List<Response> responseList = new List<Response>();
        for (Request curRequest : requests) {
            Set<String> stringListAdded = new Set<String>(curRequest.stringList2);
            Set<String> stringListDeleted = new Set<String>(curRequest.stringList1);
            for (String thisValue : curRequest.stringList1){
                if (stringListAdded.contains(thisValue)){
                    stringListAdded.remove(thisValue);
                    stringListDeleted.remove(thisValue);
                } else {
                    stringListAdded.remove(thisValue);
                }
            }
            Response thisResponse = new Response();
            thisResponse.stringListAdded = new List<String> (stringListAdded);
            thisResponse.stringListDeleted = new List<String> (stringListDeleted);
            responseList.add(thisResponse);
        }
        return responseList;
    }
    public class Request {
        @invocableVariable(label='Original List' description='The reference list which the changes are compared against')
        public List<string> stringList1;
        @invocableVariable(label='Changed List' description='The changed list to compare against the original list')
        public List<string> stringList2;
    }
    public class Response {
        @invocableVariable(label='Items Added' description='Items which appear in the changed list which are not in the Original List')
        public List<string> stringListAdded;
        @invocableVariable(label='Items Removed' description='Items which appear in the original list which are removed from the changed List')
        public List<string> stringListDeleted;
    }
}