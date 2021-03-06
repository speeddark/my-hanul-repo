9장. DDL(Data Definition Language) -- AUTO COMMIT
CREATE, ALTER, DROP, TRUNCATE, RENAME
1. 테이블 생성 --CREATE
CREATE TABLE  테이블명 (
  컬럼명1 테이터타입,
  컬럼명2 테이터타입,
  .....
  컬럼명n 테이터타입
);

* 데이터타입 : 문자, 숫자, 날짜
- 문자 : CHAR, VARCHAR2
  CHAR(n) - 고정문자 : 지정된 크기만큼 메모리를 확보한다.
    CHAR(10) - 저장시 abcd 문자를 저장 -> abcd______
    ☞ 메모리를 10바이트 확보한 후 저장한다.
  VARCHAR2(n) - 가변문자 : 데이터를 저장할때 메모리를 확보한다.
    최대 4000바이트
    VARCHAR2(30) - 저장시 abcd문자를 저장 -> abcd

- 숫자 : NUMBER
  NUMBER(n) - 정수데이터
    NUMBER(8) - 정수 8자리, 즉, 99999999
  NUMBER(n,p) - 부동소숫점 데이터, 정수부 : n-p, 소수부 : p
    NUMBER(8,2) - 정수부 : 8-2=6, 소수부 : 2 즉, 999999.99
    NUMBER(2,2) - 정수부 : 2-2=0, 소수부 : 2 즉, 0.99

- 날짜 : DATE

CREATE TABLE  temp (
  id      NUMBER(4) PRIMARY KEY,
  name    VARCHAR2(30)
);

INSERT INTO temp
VALUES (100, '홍길동');

INSERT INTO temp
VALUES (101, '이순신');

COMMIT;

SELECT  *
FROM    temp;

2. 테이블 구조 변경 --ALTER
1) 컬럼추가 --ADD
ALTER TABLE 테이블명
ADD (컬럼명1 데이터타입(크기), 컬럼명2, 테이터타입(크기),...)

8자리로 salary 필드 추가 --기본값이 NULL
ALTER TABLE temp
ADD (salary NUMBER(8));

SELECT  *
FROM    temp;

UPDATE  temp
SET     salary = 3000
WHERE   id = 101;

SELECT  *
FROM    temp;

2) 데이터타입 크기 변경 --MODIFY
ALTER   TABLE 테이블명
MODIFY  (컬럼명1 데이터타입(크기), 컬럼명2 데이터타입(크기)... )

ALTER TABLE temp
MODIFY  (salary NUMBER(10));

DESC  temp;

3) 컬럼 삭제 --DROP COLUMN
ALTER TABLE 테이블명
DROP COLUMN 컬럼명

ALTER TABLE temp
DROP COLUMN salary;

DESC  temp;
4) 컬럼명 변경 --RENAME COLUM
ALTER TABLE 테이블명
RENAME COLUMN 기존컬럼명 TO 새컬럼명

ALTER TABLE temp
RENAME COLUMN id TO temp_id;

DESC  temp;

3. 테이블 삭제
DROP TABLE 테이블명 [PURGE] -- PURGE : 휴지통 거치지 않고 영원히 삭제
DROP TABLE temp;

* 삭제된 테이블 복원
FLASHBACK TABLE temp TO BEFORE DROP;

SELECT  *
FROM    temp;

4. 구조만 남기고 데이터 모두 삭제
TRUNCATE TABLE 테이블명 -- , 조건절 사용불가, ROLLBACK 사용 불가

5. 테이블명 변경 --RENAME
RENAME 원래테이블명 TO 새테이블명

RENAME temp TO test;

6. 테이블 삭제 --DROP
DROP TABLE 테이블명

10장.
무결성 제약 조건(INTEGRITY CONSTRAINT) - 정확성, 정합성, 무결성 보장 하기 위해
- 테이블에 잘못된 데이터 입력 막기 위해 일정한 규칙 주는것
- 제약조건명은 30자까지 지정 가능

정합성 : 어떤 사람들의 언어 혹은 논변이 그것을 포함하는 전제들의 체계를 무너뜨리지 않고 잘 어울린다.
무결성 : 데이터의 정확성과 일관성을 유지하고, 데이터에 결손과 부정합이 없음을 보증하는것
       : 학년을 입력할때 1,2,3,4 학년까지만 존재하는데 5학년이 입력되는 무결성이 어긋낫다라고 표현
       
--제약조건
--NOT NULL, CHECK, UNIQE, PRIMARY KEY, FOREIGN KEY, DEFAULT(DEFAULT 는 제약조건은 아님)

※ 테이블 생성시 제약 조건
--------------------------------------------------------------------------------------------
제약조건                      | 기능
--------------------------------------------------------------------------------------------
- NOT NULL(컬럼레벨에서만,    | 테이블 생성시 컬럼레벨 정의 방식으로만 정의 
NULL 값 입력 금지)            | 컬럼레벨만 ☞ id VARCHAR2(20) NOT NULL
--------------------------------------------------------------------------------------------
- DEFAULT(컬럼레벨에서만,     | 데이터 입력(수정) 시 값 미지정시 기본값 지정 
기본값, 제약조건은 아님       | 테이블 생성시 컬럼 레벨 정의 방식으로만 정의
                              | 컬럼레벨만 ☞ gender CHAR(3) DEFAULT '남'
--------------------------------------------------------------------------------------------
- CHECK(입력값의 제한,        | 조건으로 설정된 값만 입력 허용
설정값만 허용                 | 컬럼레벨 ☞ gender CHAR(3) CHECK (gener IN ('남','여'))
(도메인 무결성 제약조건)      | 테이블레벨 ☞ CHECK (gener IN ('남','여'))
--------------------------------------------------------------------------------------------
- UINQUE(개체무결성,          | 중복값 입력 금지(NULL은 입력가능), NOT NULL과 함께 사용도 가능 
중복값 입력 금지)             | 컬럼레벨 ☞ job VARCHAR2(15) UNIQUE,
                              | 테이블레벨 ☞ UNIQUE(job)
                              | 2개 이상의 컬럼을 이용하여 기본키 지정(복합키)
--------------------------------------------------------------------------------------------
-PRIMARY KEY(개체무결성,      | NOT NULL + UNIQUE, 2개 이상의 컬럼을 이용하여 기본키지정(복합키) 
NOT NULL + UNIQUE             | 컬럼레벨 ☞ id NUMBER(8) PRIMARY KEY
                              | 테이블레벨 ☞ PRIMARY KEY(id)
--------------------------------------------------------------------------------------------
FOREIGN KEY(참조무결성,       | 다른 테이블의 컬럼을 조회해서 무결성 검사
다른테이블의 컬럼 참조        | 컬럼레벨 ☞ deptno NUMBER(4) REFERENCES dept(deptno)
(부모테이블의 PK, UK만 참조   | 테이블레벨 ☞ FOREIGN KEY (deptno) REFERENCES dept(deptno)
--------------------------------------------------------------------------------------------
※ 제약조건의 이름 지정하기 (테이블 관리 목적으로 생성)
- 이름을 지정하지 않으면 자동으로 생성됨(SYS.....로 생성)
- 나중에 제약조건을 비활성하거나 삭제하는 등의 관리를 위해서는
  반드시 제약조건 이름을 지정해주는것이 좋다

--제약 조건 선언 - COLUMN 레벨 정의 방식, TABLE 레벨 정의 방식
--------------------------------------------------------------------------------------------
--1.1 컬럼레벨의 제약조건 기술방법(컬럼 정의시 그 라인 안에서 정의하는것)
--------------------------------------------------------------------------------------------
☞ 컬럼명 데이터타입(크기) [CONTSTRAINT 제약조건명(테이블명약어_컬럼명약어_제약조건명약어) 제약조건]
                                       예 : EMP_EMP_ID_PK
--------------------------------------------------------------------------------------------
CREATE TABLE 테이블명(
  컬럼명 데이터타입(크기) [CONTSTRAINT 제약조건명(테이블명약어_컬럼명약어_제약조건명약어) 제약조건]
  ...
);
--------------------------------------------------------------------------------------------
CREATE TABLE emp000 (
  empno   NUMBER(4)     PRIMARY KEY,
  ename   VARCHAR2(15)  NOT NULL,
  job     VARCHAR2(15)  UNIQUE,
  deptno  NUMBER(2)     REFERENCES  dept(deptno),
  gender  VARCHAR(3)    DEFAULT '남' CHECK( gender IN ('남','여') )
);
--------------------------------------------------------------------------------------------
- '관계'에 대한 제약조건이 복잡
- 참조하는 테이블(기본키가 있는 테이블)이 먼저 생성이 되어 있어야 함
- 외래키가 참조하는 컬럼은 참조하는 테이블의 기본키 이어야 함
--------------------------------------------------------------------------------------------
* CTAS로 departments 테이블을 이용하여 dept 테이블 생성하기
derpartment_id      ☞ deptno 로 ALIAS
derpartment_name    ☞ deptname 로 ALIAS
manager_id          ☞ 그대로
location_id         ☞ 그대로

CTAS - NOT NULL 이외의 조건은 복사되지 않는다. PRIMARY KEY 는 복사되지 않는다
CREATE TABLE  dept  AS
  SELECT  department_id deptno, department_name deptname, manager_id, location_id
  FROM    departments;

DESC dept;

dept 테이블의 deptno를 PRIMARY KEY 로 지정하기
ALTER TABLE dept
MODIFY  (deptno PRIMARY KEY);

DESC dept;

DROP TABLE emp000;
--------------------------------------------------------------------------------
컬럼레벨 정의방식(제약조건)
--------------------------------------------------------------------------------
CREATE TABLE emp000 (
  empno   NUMBER(4)     CONSTRAINT emp000_empno_pk  PRIMARY KEY,
  ename   VARCHAR2(15)  CONSTRAINT emp000_ename_nn  NOT NULL,
  job     VARCHAR2(15)  CONSTRAINT emp000_job_uk    UNIQUE,
  deptno  NUMBER(2)     CONSTRAINT emp000_deptno_fk REFERENCES  dept(deptno),
  gender  VARCHAR(3)    DEFAULT '남' CONSTRAINT emp000_gender_ck CHECK( gender IN ('남','여') )
);
--DEFAULT는 테이터타입(크기) 바로 옆에 입력해야됨
--------------------------------------------------------------------------------


--------------------------------------------------------------------------------
테이블레벨 정의방식(제약조건)--컬럼 정의 후 다시 아래에서 제약조건 정의하는것
--------------------------------------------------------------------------------
CREATE TABLE emp000 (
  empno   NUMBER(4),
  ename   VARCHAR2(15)  NOT NULL,
  job     VARCHAR2(15),
  deptno  NUMBER(2),
  gender  VARCHAR(3)    DEFAULT '남',
  
  CONSTRAINT emp000_empno_pk   PRIMARY KEY(empno),
  CONSTRAINT emp000_job_uk     UNIQUE(job),
  CONSTRAINT emp000_deptno_fk  FOREIGN KEY(deptno)   REFERENCES dept(deptno),
  CONSTRAINT emp000_gender_ck  CHECK( gender IN ('남','여') )
);
--------------------------------------------------------------------------------

emp000 테이블에서 제약 조건
--------------------------------------------------------------------------------
1. empno 의 PRIMARY KEY 삭제
1.1 제약조건명 없을때 empno의 PRIMARY KEY 삭제
ALTER TABLE emp000
DROP PRIMARY KEY;

1.2 제약조건명 있을때 empno의 PRIMARY KEY 삭제
ALTER TABLE emp000
DROP CONSTRAINT  emp000_empno_pk;

2. empno 의 PRIMARY KEY 추가
2.1 제약조건명 없이 empno의 PRIMARY KEY 추가
ALTER TABLE emp000
ADD PRIMARY KEY (empno);

2.2 제약조건명 주고 empno의 PRIMARY KEY 추가
ALTER TABLE emp000
ADD CONSTRAINT  emp000_empno_pk PRIMARY KEY(empno);
--------------------------------------------------------------------------------

3. ename 의 NOT NULL 삭제
3.1 제약조건명 없을때 ename의 NOT NULL 을 NULL로 변경 --이미 기본값은 NULL이기 때문에 ADD가 아니라 MODIFY
ALTER TABLE emp000
MODIFY (ename NULL); 

3.2 제약조건명 있을때 ename의 NOT NULL 을 NULL로 변경
ALTER TABLE emp000
DROP CONSTRAINT emp000_ename_nn;

4. ename 의 NOT NULL 추가
4.1 제약조건명 없이 ename의 NOT NULL 추가
ALTER TABLE emp000
MODIFY (ename NOT NULL);

4.2 제약조건명 주고 ename의 NOT NULL 추가
ALTER TABLE emp000
ADD CONSTRAINT emp000_ename_nn NOT NULL(ename); --만들고 나서는 NOT NULL 이름을 줄 수가 없음
그래서, 제약조건명 없이 NOT NULL 지정
그리고 SYS로 시작하는 제약조건명을 RENAME

ALTER TABLE emp000
RENAME CONSTRAINT SYS_C0011212 TO emp000_ename_nn;


5. job 의 UNIQUE 삭제
5.1 제약조건명 없을때 job의 UINQUE 삭제
ALTER TABLE emp000
DROP  UNIQUE; --XXX, 자동으로 생성된 SYS...이름 찾아서 제약조건명 삭제

5.2 제약조건명 있을때 job의 UINQUE 삭제
ALTER TABLE emp000
--DROP CONSTRAINT SYS...;
DROP CONSTRAINT emp000_ename_uk;

6. job 의 UINQUE 추가
6.1 제약조건명 없이 job의 UINQUE 추가
ALTER TABLE emp000
ADD UNIQUE (job);

6.2 제약조건명 주고 job의 UINQUE 추가
ALTER TABLE emp000
ADD CONSTRAINT emp000_job_uk UNIQUE(job);


7. gender 의 CHECK 삭제
7.1 제약조건명 없을때 gender의 CHECK 삭제
ALTER TABLE emp000
DROP  CHECK; --XXX, 자동으로 생성된 SYS.. 된 이름 찾아서 제약조건명 삭제

7.2 제약조건명 있을때 gender의 CHECK 삭제
ALTER TABLE emp000
--DROP CONSTRAINT SYS....
DROP CONSTRAINT emp000_gender_ck;

8. gender 의 CHECK 추가
8.1 제약조건명 없이 gender의 CHECK 추가
ALTER TABLE emp000
ADD CHECK (gender IN ('남','여'));

8.2 제약조건명 주고 gender의 CHECK 추가
ALTER TABLE emp000
ADD CHECK emp000_gender_ck (gender IN ('남','여'));

9. gender 의 DEFAULT 삭제
9.1 제약조건명 없을때 gender의 DEFAULT 삭제 
    --삭제가 아니라 최초에 테이블 삽입시 값이 없으면 NULL 이 들어가서 DEFALUT를 NULL로 주는것
ALTER TABLE emp000
MODIFY gender DEFAULT NULL;

9.2 제약조건명 있을때 gender의 DEFAULT 삭제
--DEFAULT 는 제약조건명이 없으므로 실행불가

10. gender 의 DEFAULT 추가
10.1 제약조건명 없이 gender의 DEFAULT 추가
ALTER TABLE emp000
MODIFY gender VARCHAR(3) DEFAULT '남';

10.2 제약조건명 주고 gender의 DEFAULT 추가
--DEFAULT 는 제약조건명이 없으므로 실행불가

11. deptno 의 FOREIGN KEY 삭제
11.1 제약조건명 없을때 deptno의 FOREIGN KEY 삭제
ALTER TABLE emp000
DROP FOREIGN KEY --XXX, 자동으로 생성된 SYS.. 된 이름 찾아서 제약조건명 삭제

11.2 제약조건명 있을때 deptno의 FOREIGN KEY 삭제
ALTER TABLE emp000
DROP CONSTRAINT 제약조건명
--DROP CONSTRAINT SYS...
DROP CONSTRAINT emp000_deptno_fk;

12. deptno 의 FOREIGN KEY 추가
12.1 제약조건명 없이 deptno의 FOREIGN KEY 추가
ALTER TABLE emp000
ADD FOREIGN KEY (deptno) REFERENCES dept(deptno);

12.2 제약조건명 주고 deptno의 FOREIGN KEY 추가
ALTER TABLE emp000
ADD CONSTRAINT emp000_deptno_fk FOREIGN KEY (deptno) REFERENCES dept(deptno);

11장
VIEW(뷰) : 가상의 테이블
- 실제로 데이터가 존재하는 객체는 아니다.
- 테이블의 데이터를 뷰를 통해 접근한다.
1. 보안 - 접근권한
2. 복잡한 쿼리문을 단순한 쿼리문으로 사용할 수 있다.

뷰를 사용하면 테이블처럼 사용가능하며 SELECT 절에서만 쿼리 가ㅡㄴㅇ
INSERT, DELETE, UPDATE가 불가능하다.

뷰 생성
CREATE OR REPLACE VIEW 뷰명 AS ☜ CVAS
  SELECT 쿼리문

CREATE TABLE 테이블명 AS ☜ CTAS
  SELECT 쿼리문
  
INSERT INTO 테이블명 ☜ ITAS --AS 없음
  SELECT 쿼리문

CREATE  OR  REPLACE VIEW vu_60 AS
  SELECT  employee_id id, first_name || ' ' || last_name name, 
          department_id dep_id, job_id, hire_date
  FROM    employees
  WHERE   department_id = 60;

vu_60 뷰 조회
SELECT  *
FROM    vu_60;

뷰 삭제
DROP VIEW 뷰명
DROP VIEW vu_60;

※ 연속적인 일련번호(중복되지 않는것)를 만들어주는 기능을 가진 객체
: SEQUENCE

CREATE SEQUENCE 시퀀스명
START WITH  시작숫자
INCREMENT BY 증감숫자

SELECT  *
FROM    emp;

TRUNCATE TABLE emp;

SELECT  *
FROM    emp;

CREATE SEQUENCE emp_seq
START WITH  1
INCREMENT BY 1;

시퀀스 값 접근 : CURRVAL, NEXTVAL

현재시퀀스값 조회
SELECT  emp_seq.CURRVAL FROM  dual;
ORA-08002: 시퀀스 EMP_SEQ.CURRVAL은 이 세션에서는 정의 되어 있지 않습니다

SELECT  emp_seq.NEXTVAL FROM  dual;

SELECT  emp_seq.CURRVAL FROM  dual;

이름         널?       유형           
---------- -------- ------------ 
ID                  NUMBER(6)    
FIRST_NAME          VARCHAR2(20) 
LAST_NAME  NOT NULL VARCHAR2(25) 
HIRE_DATE  NOT NULL DATE         
JOB_ID     NOT NULL VARCHAR2(10) 
DEPT_ID             NUMBER(4)

INSERT INTO emp 
VALUES (emp_seq.CURRVAL, '길동', '홍', SYSDATE, 'pro', 50);

INSERT INTO emp 
VALUES (emp_seq.NEXTVAL, '순신', '이', SYSDATE, 'saler', 60);



SELECT * FROM emp;

DESC emp;

DROP SEQUENCE emp_seq;

TRUNCATE TABLE emp;
























