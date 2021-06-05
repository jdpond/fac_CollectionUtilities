/**
 * @description       : fac_FilterCollection - An "IN"-like query to filter a collection of objects
 * @author            : Jack D. Pond
 * @group             : 
 * @last modified on  : 06-04-2021
 * @last modified by  : Jack D. Pond
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   06-01-2021   Jack D. Pond   Initial Version
**/
public with sharing class fac_FilterCollection {
    @invocableMethod(label='fac_FilterCollection' description='An "IN"-like query to filter a collection of objects')
    public static List<Response> fac_FilterCollection(List<Request> requests) {
        List<Response> thisResponseList = new List<Response>();
        for (Request curRequest : requests) {
            Boolean thisisNot = curRequest.isNot != null ? curRequest.isNot : false;
            Response thisResponse = new Response();
            if (curRequest.inList != null && curRequest.inList.size()>0)
            {
                thisResponse.retObjects = new List<SObject>();
                for (SObject thisObject: curRequest.fromCollection){
                    if (!curRequest.inList.contains((String)thisObject.get(curRequest.inFieldName)) == thisisNot ){
                        thisResponse.retObjects.add((SObject) thisObject);
                    }
                }
                thisResponse.retObjects = thisResponse.retObjects.size() > 0 ? thisResponse.retObjects : null;
                thisResponseList.add(thisResponse);
            }   
        }
        return thisResponseList;
    }
    public class Request {
        @invocableVariable(label='IN Field Name' description='The field DeveloperName used to compare that field value to a list of values that have been specified')
        public String inFieldName;
        @invocableVariable(label='Value Collection' description='A collection of values to be compared to the value in the specified IN field' )
        public List<String> inList;
        @invocableVariable(label='Collection to Filter' description='The collection to be filtered' )
        public List<SObject> fromCollection;
        @invocableVariable(label='Is Not In' description='Set this to TRUE if you wish the returned collection to be those NOT found in the value collection')
        public Boolean isNot;
    }
    public class Response {
        @invocableVariable(label='Object Collection Returned' description='The collection of objects matched in the Values Collection')
        public List<SObject> retObjects;
    }
}