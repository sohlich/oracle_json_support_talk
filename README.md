# JSON support in Oracle 12c
Radek Sohlich
5/5/2017

---

## JSON

- JavaScript Object Notation
- data-interchange format
- wide adoption
- http://json.org/
- https://tools.ietf.org/html/rfc7159

---
## JSON Example
```
{
	"user": 2222,
	"data": {
		"age": 22,
		"name": "Olda",
		"surname": "Starak"
	},
	"roles": [
		{
			"name": "Admin",
			"expire": "12.2.2018"
		},
		{
			"name": "SuperAdmin",
			"expire": "12.3.2018"
		}
	]
}
```
---
## Oracle JSON support
- Oracle Database 12c
- storing,querying and indexing
- stored as VARCHAR2, CLOB, or BLOB
- conditionals, functions, operators and functions using JSON PATH

--- 
## JSON Path
- syntax '$.jsonpath'
- '$' is required 
- '.jsonpath' defines path within the JSON object

```
$.property1.property2
```


---
## Conditionals - IS (NOT) JSON
- checks if the expression/column contains JSON
- LAX,STRICT
- WITH/WITHOUT UNIQUE KEYS

---
## Conditionals - JSON_EXISTS
- test whether a specified JSON **property** exists in JSON data
- JSON_EXISTS (COL,'$.path')

---
## Conditionals - JSON_TEXTCONTAINS
- test whether the specified JSON **value** exists in JSON data
- requires index on JSON column
- JSON_TEXTCONTAINS(COL, 'path', 'string')

-- -
## Functions - JSON_VALUE
-  returns scalar values from JSON data
-  JSON_VALUE(COL, '$.jsonpath')

---
## Functions - JSON_QUERY
- finds values in a JSON document and returns a character string
- WITHOUT WRAPPER - if return value is single JSON object
- WITH WRAPPER - if return value is not a JSON object or multiple objects are returned
- WITH CONDITIONAL WRAPPER - wrap if needed :D


---
## Functions - JSON_TABLE
- maps the JSON data to a table
- simplyfies using traditional SQL
```
JSON_TABLE(po_document, '$.jsonpath' 
COLUMNS (phones VARCHAR2(100) FORMAT JSON 
PATH '$.pathwithinobject'))
```










