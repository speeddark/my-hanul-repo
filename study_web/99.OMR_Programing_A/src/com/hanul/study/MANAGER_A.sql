CREATE TABLE MANAGER_A (
  MANAGER_ID NUMBER(5) PRIMARY KEY NOT NULL,
  MANAGER_NAME VARCHAR2(20)
);

INSERT INTO MANAGER_A VALUES(99999, '관리자');
COMMIT;
