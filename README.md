# Flow Action Component Collection Utilities

This is a set of utilities that facilitate the creation and use of Salesforce Collections (Lists)

They include:
- **fac_CompareLists** - Compare two lists returning A list of those added to the first and a list of those deleted From the first
- **fac_FilterCollection** - An "IN"-like query to filter a collection of objects
- **fac_GetPicklistFromObjects** - Returns a list of strings from designated Field in object collection given the object collection and name of the field  value to be added to list
- **fac_GetRecordsIn** - Perform a query using the "IN" condition of the WHERE clause


## fac_CompareLists

Compare two lists returning A list of those added to the first and a list of those deleted From the first

Parameters:

* Request
> 1. **Original List** - The reference list which the changes are compared against
> 1. **Changed List** - The changed list to compare against the original list
* Response
> 1. **Items Added** - Items which appear in the changed list which are not in the Original List
> 1. **Items Removed** - Items which appear in the original list which are removed from the changed List

## fac_FilterCollection

An "IN"-like query to filter a collection of objects

* Request
> 1. **IN Field Name** - The field DeveloperName used to compare that field value to a list of values that have been specified
> 1. **Value Collection** - A collection of values to be compared to the value in the specified IN field
> 1. **Collection to Filter** - The collection to be filtered'
> 1. **Is Not In** - Set this to TRUE if you wish the returned collection to be those NOT found in the value collection
* Response
1. > **Object Collection Returned** - The collection of objects matched in the Values Collection

## fac_GetPicklistStringFromObjects

Returns a list of strings from designated Field value in object collection

* Request
> 1. **Object Collection** - The source collection of objects to build the list
> 1. **Field Name** - The DeveloperName of the Field whose values appear in returned list
* Response
1. > **Returned List** - The collection list returned

## fac_GetRecordsIn

Perform a query using the "IN" condition of the WHERE clause

* Request
> 1. **Query Field Collection** - The collection of Developer Field Names to be queried
> 1. **IN Field Name** - The field DeveloperName used to compare that field value to a list of values that have been specified
> 1. **Value Collection** - A collection of values to be compared to the value in the specified IN field
> 1. **Is Not IN** - Set this to TRUE if you wish the returned collection to be those NOT found in the value collection
> 1. **Object Developer Name** - The Object (Developer Name) to be queried
> 1. **Where clause (Post IN)** - Additional conditional clause to appear After the Field IN values
> 1. **Where clause (Pre IN)** - Additional conditional clause to appear Before the Field IN values
* Response
> 1. **Object Collection Returned** - The collection of objects returned from the Select
> 1. **Query Used** - The actual query used - useful for debugging
> 1. **Record Count Found** - The count of records returned - useful for debugging