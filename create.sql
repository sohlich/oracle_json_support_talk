-- TABLE
CREATE TABLE TEST_TBL(ID NUMBER NOT NULL,JSON_COL VARCHAR2(4000));

-- DATA
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(0,'{"user":0000,"data":{"age":22, "name":"Franta","surname":"Mrkvicka"}}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(1,'{"user":1111,"data":{"age":22, "name": "Pepa","surname":"Novak"}}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(2,'{"user":2222,"data":{"age":22, "name": "Olda","surname":"Starak"},"roles":[{"name":"Admin","expire":"12.2.2018"},{"name":"SuperAdmin","expire":"12.3.2018"}]}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(3,'{user:0000}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(4,'user:0000}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(5,'{"user":1111,"data":{"age":22, "name":"Josef","name": "Pepa","surname":"Novak"}}');
INSERT INTO TEST_TBL(ID,JSON_COL) VALUES(6,'{"user":2222,"data":{"age":22, "name": "Olda","surname":"Starak"},"roles":[{"name":"Admin","expire":"12.2.2018"},{"name":"SuperAdmin","expire":"12.3.2018"},{"name":"Supervisor","expire":"12.3.2018"}]}');


CREATE INDEX ix
  ON TEST_TBL(JSON_COL)
  INDEXTYPE IS CTXSYS.CONTEXT
  PARAMETERS ('SECTION GROUP CTXSYS.JSON_SECTION_GROUP SYNC (ON COMMIT)');