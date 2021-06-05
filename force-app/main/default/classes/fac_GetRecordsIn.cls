/**
 * @description       : fac_GetRecordsIn - Perform an SOQL (getRecord) query using the "IN" condition of the WHERE clause
 * @author            : Jack D. Pond
 * @group             : 
 * @last modified on  : 06-05-2021
 * @last modified by  : Jack D. Pond
 * Modifications Log 
 * Ver   Date         Author         Modification
 * 1.0   06-01-2021   Jack D. Pond   Initial Version
**/
public with sharing class fac_GetRecordsIn {
    @invocableMethod(label='fac_GetRecordsIn' description='Perform an SOQL (getRecord) query using the "IN" condition of the WHERE clause' category='FAC Utilities')
    public static List<Response> fac_GetRecordsIn(List<Request> requests) {
        List<Response> responseList = new List<Response>();
        for (Request curRequest : requests) {
            String inString;
            Boolean thisIsNot = curRequest.IsNot != null ? curRequest.IsNot : false;
            String thisPostInClause = curRequest.postInClause == null ? '' :  ' ' + curRequest.postInClause.replace('\\\'','\'');
            String thisPreInClause = curRequest.preInClause == null ? '' : curRequest.preInClause.replace('\\\'','\'') + ' ';
            List<String> thisResponseList = new List<String>();
            if (curRequest.inList != null && curRequest.inList.size()>0)
            {
// when 'String','ID'
                inString = '(\'' + String.Join(curRequest.inlist,'\',\'')+'\')';
// when 'Integer','Long','Double','Decimal' {
//              inString = '('+ String.Join(curRequest.inlist,',')+')';
                Response thisResponse = new Response();
                thisResponse.queryUsed = 'SELECT '+
                String.Join(curRequest.fieldsList,',') + 
                ' FROM ' + curRequest.objectName + ' WHERE ' + thisPreInClause +
                curRequest.inFieldName + ' ' + (thisIsNot ? 'NOT ':'') + 'IN ' + inString + thisPostInClause;
                thisResponse.retObjects = Database.query(thisResponse.queryUsed);
                thisResponse.recordsFound = thisResponse.retObjects.size();
                responseList.add(thisResponse);
            }   
        }
        return responseList;
    }
    public class Request {
        @invocableVariable(label='Query Field Collection' description='The collection of Developer Field Names to be queried')
        public List<string> fieldsList;
        @invocableVariable(label='IN Field Name' description='The field DeveloperName used to compare that field value to a list of values that have been specified')
        public String inFieldName;
        @invocableVariable(label='Value Collection' description='A collection of values to be compared to the value in the specified IN field' )
        public List<String> inList;
        @invocableVariable(label='Is Not IN' description='Set this to TRUE if you wish the returned collection to be those NOT found in the value collection')
        public Boolean isNot;
        @invocableVariable(label='Object Developer Name' description='The Object (Developer Name) to be queried')
        public String objectName;
        @invocableVariable(label='Where clause (Post IN)' description='Additional conditional clause to appear After the Field IN values')
        public String postInClause;
        @invocableVariable(label='Where clause (Pre IN)' description='Additional conditional clause to appear Before the Field IN values')
        public String preInClause;
    }
    public class Response {
        @invocableVariable(label='Object Collection Returned' description='The collection of objects returned from the Select')
        public List<SObject> retObjects;
        @invocableVariable(label='Query Used' description='The actual query used - useful for debugging')
        public String queryUsed;
        @invocableVariable(label='Record Count Found' description='The count of records returned - useful for debugging')
        public Integer recordsFound;
    }
}