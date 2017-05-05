-- Oracle 12c in docker:
-- docker run -it --rm -p 8080:8080 -p 1521:1521 sath89/oracle-12c:latest


-- TABLE
CREATE TABLE TEST_TBL(ID NUMBER NOT NULL,JSON_COL VARCHAR2(4000));

-- DATA
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(0,'{"user":0000,"data":{"age":22, "name":"Franta","surname":"Mrkvicka"}}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(1,'{"user":1111,"data":{"age":22, "name": "Pepa","surname":"Novak"}}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(2,'{"user":2222,"data":{"age":22, "name": "Olda","surname":"Starak"},"roles":[{"name":"Admin","expire":"12.2.2018"},{"name":"SuperAdmin","expire":"12.3.2018"}]}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(3,'{user:0000}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(4,'user:0000}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(5,'{"user":1111,"data":{"age":22, "name":"Josef","name": "Pepa","surname":"Novak"}}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(2,'{"user":2222,"data":{"age":22, "name": "Olda","surname":"Starak"},"roles":[{"name":"Admin","expire":"12.2.2018"},{"name":"SuperAdmin","expire":"12.3.2018"},{"name":"Supervisor","expire":"12.3.2018"}]}');

-- FULL-SEARCH CONTEXT INDEX:
CREATE INDEX ix
  ON TEST_TBL(JSON_COL)
  INDEXTYPE IS CTXSYS.CONTEXT
  PARAMETERS ('SECTION GROUP CTXSYS.JSON_SECTION_GROUP SYNC (ON COMMIT)');



-- IS JSON/IS NOT JSON:
SELECT ID FROM test_tbl WHERE JSON_COL IS JSON;
select * from TEST_TBL where JSON_COL IS NOT JSON STRICT;
select * from TEST_TBL where JSON_COL IS NOT JSON LAX;

-- JSON_EXISTS:
select * from test_tbl where JSON_EXISTS(JSON_COL,'$.roles')
select * from test_tbl where JSON_EXISTS(JSON_COL,'$.roles[1]')

-- JSON_TEXTCONTAINS:
select * from test_tbl where JSON_TEXTCONTAINS(JSON_COL,'$.roles.name','Supervisor')
select * from test_tbl where JSON_TEXTCONTAINS(JSON_COL,'$.data.surname','Novak');

-- Query value:
SELECT json_value(json_col, '$.data.name') FROM test_tbl;
SELECT ID  FROM test_tbl WHERE json_value(json_col, '$.data.name') = 'Pepa';


-- JSON_QUERY:
select json_query(JSON_COL,    '$.roles.name'   pretty with conditional wrapper) from TEST_TBL;


-- JSON_TABLE:
select ID,json_data.* from TEST_TBL, json_table(JSON_COL,'$'
            columns (usr varchar2(15) path '$.user'
            ,nested path '$.roles[*]'
              columns (name varchar2(20) path '$.name'
              ,expire varchar2(20) path '$.expire'
              )
)) json_data
where JSON_COL IS JSON STRICT;
