/**
 * @description       : fac_GetPicklistFromObjects - Returns a list of strings from designated Field value in object collection
 *                      given the object collection and name of the field to be added to list
 * @author            : Jack D. Pond
 * @group             :
 * @last modified on  : 2021-09-26
 * @last modified by  : Jack D. Pond
 * Modifications Log
 * Ver   Date         Author         Modification
 * 1.0   06-01-2021   Jack D. Pond   Initial Version
 * 1.0   2021-09-25   Jack D. Pond   Bug correction for empty "fromObjects" parameter
 **/

public with sharing class fac_GetPicklistFromObjects {
  @invocableMethod(
    label='fac_GetPicklistStringFromObjects'
    description='Returns a list of strings from designated Field value in object collection'
    category='FAC Utilities'
  )
  public static List<Response> fac_GetPicklistFromObjects(
    List<Request> requests
  ) {
    List<Response> responseList = new List<Response>();
    for (Request curRequest : requests) {
      List<String> thisResponseList = new List<String>();
      if (curRequest.fromObjects != null) {
        for (SObject thisObject : curRequest.fromObjects) {
          thisResponseList.add((String) thisObject.get(curRequest.fromField));
        }
      }
      Response thisResponse = new Response();
      thisResponse.retPicklist = thisResponseList;
      responseList.add(thisResponse);
    }
    return responseList;
  }
  public class Request {
    @invocableVariable(
      label='Object Collection'
      description='The source collection of objects to build the list'
    )
    public List<sObject> fromObjects;
    @invocableVariable(
      label='Field Name'
      description='The DeveloperName of the Field whose values appear in returned list'
    )
    public String fromField;
  }
  public class Response {
    @invocableVariable(
      label='Returned List'
      description='The collection list returned'
    )
    public List<String> retPicklist;
  }
}
