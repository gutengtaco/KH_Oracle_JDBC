/*
 복습
 DDL(DATA DEFINITION LANGUAGE)
 데이터 정의 언어
 데이터가 들어가있는 구조 자체를 정의하는 언어임.
 
 객체들을 새로이 생성(CREATE), 수정(ALTER), 삭제(DROP)하는 구문
 
 DML : SELECT INSERT UPDATE DELETE
 DDL : CREATE ALTER DROP
 DCL : GRANT REVOKE
 TCL : COMMIT ROLLBACK SAVEPOINT
---------------------------------------------------------------------
 1. ALTER
 객체 구조를 수정하는 구문
 
 <테이블 수정>
 ALTER TABLE 테이블명 수정할내용;
 
 - 수정할 내용
 1) 컬럼(자료형, DEFAULT)을 추가 / 수정 / 삭제
 2) 제약조건 추가 / 삭제 (수정하고 싶으면 삭제 후 추가)
 3) 테이블명 / 컬럼명 / 제약조건명 변경
*/

-- 1) 컬럼 추가 / 수정 / 삭제
-- 1_1) 컬럼추가 : ADD 추가할컬럼명 데이터타입 [DEFAULT 기본값]
--               DEFAULT 기본값 부분은 생략 가능

/*
CREATE TABLE DEPT_COPY
AS(SELECT *
   FROM DEPARTMENT);
*/
SELECT * FROM DEPT_COPY;
DROP TABLE DEPT_COPY;

UPDATE DEPT_COPY
   SET DEPT_TITLE = '총무부';
   
 

-- CNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- LOCATION_ID 오른쪽에 기본값으로 NULL이 들어있는 CNAME컬럼을 추가

-- LNAME 컬럼 추가
ALTER TABLE DEPT_COPY ADD LANAME VARCHAR2(20) DEFAULT '한국';
-- 기본값인 '한국'으로 채워진 LNAME컬럼을 추가

-- [맛보기] 컬럼명 바꾸기
ALTER TABLE DEPT_COPY RENAME COLUMN LANAME TO LNAME; 

-- 1_2) 컬럼 수정(MODIFY)
--      데이터 타입 수정 : MODIFY 수정할컬럼명 바꾸고자하는데이터타입
--      DEFAULT 값 수정 : MODIFY 수정할컬럼명 DEFAULT 바꾸고자하는기본값

-- DEPT_ID 컬럼의 데이터타입을 CHAR(2)에서 CHAR(3)으로 변경
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
-- 주의사항 : 현재 변경하고자 하는 컬럼에 이미 담겨있는 값과 완전히 다른 자료형으로는 변경 불가
-- EX) 문자 -> 숫자(X) / 문자열 사이즈 축소도 X / 문자열 사이지 확대는 O

ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- [오류] column to be modified must be empty to change datatype
-- 완전히 다른 데이터타입으로 변경하고자 할 경우에는 값이 비어있어야 한다는 오류

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(8);
-- [오류] cannot decrease column length because some value is too big
-- 실제 들어있는 값의 사이즈가 더 큰 경우 축소 불가

-- DEPT_TITLE 컬럼의 데이터타입을 VARCHAR2(40)으로
-- LOCATION_ID 컬럼의 데이터타입을 VARCHAR2(2)로
-- LNAME 컬럼의 기본값을 '미국'으로
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '미국';
-- 기본값은 실제 '한국'이 들어간 상태에서 '미국'으로 바꾸어주어서
-- 담겨있는 값이 '한국'인 상태로 유지가 됨. 이후의 값의 기본값이 '미국'으로 설정된 것임.

-- 컬럼 삭제를 위한 복사본 테이블 만들기
CREATE TABLE DEPT_COPY2 
AS (SELECT *
    FROM DEPT_COPY);
    
SELECT * FROM DEPT_COPY2;

-- 1_3) 컬럼 삭제(DROP COLUMN) : DROP COLUMN 삭제하고자하는컬럼명

-- DEPT_COPY2로부터 DEPT_ID 컬럼 지우기
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
-- DEPT_ID만 사라짐.
ROLLBACK DEPT_COPY2;
-- 복구 안됨. DDL구문 자체는 ROLLBACK으로 복구가 안됨.

-- 모든 컬럼 없애기
/*
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE
DROP COLUMN LOCATION_ID
DROP COLUMN CNAME
DROP COLUMN LNAME; 
-- [오류] SQL command not properly ended
-- 여러개 한꺼번에 삭제 불가
*/

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- [오류] cannot drop all columns in a table
-- 테이블에 있는 모든 컬럼들을 삭제할 수는 없다는 오류
-- LNAME만 삭제가 안되있는 것을 볼 수 있음.
-- 테이블에 최소 1개의 컬럼은 남기고 삭제해야 함.

-- 컬럼 추가 / 수정 / 삭제 시 주의사항
-- 1. 컬럼명 중복 불가
-- 2. 수정 시 데이터타입 잘 신경써서 변경
-- 3. ROLLBACK불가
-- 4. 테이블당 적어도 한 개의 컬럼은 있어야 함.

/*
 2_1) 제약조건 추가(ADD / MODIFY)
      => 어느 컬럼에 어느 제약조건을 추가할 지 명시
 - PRIMARY KEY : ADD PRIMARY KEY (컬럼명)
 - FOREIGN KEY : ADD FOREIGN KEY (컬럼명) REFERENCES 참조할테이블명([참조할컬럼명])
                => 참조할 컬럼명 생략가능(생략 시, 자동으로 PRIMARY KEY가 참조할컬럼명으로 잡힘)
 - UNIQUE : ADD UNIQUE (컬럼명) 
 - CHECK : ADD CHECK(컬럼에대한조건) 
 - NOT NULL : MODIFY 컬럼명 NOT NULL
 
 나만의 제약조건명을 부여하고자 한다면 : CONSTRAINT 제약조건명을 제약조건종류 앞에 쓰면 됨.
 제약조건명 부여부분인 CONSTRAINT 제약조건명은 생략 가능(SYS_C~)
 주의사항 : 현재 계정 내에 고유한 값으로 부여해야함(아무리 다른 테이블이어도 제약조건명 중복 불가)
*/

-- DEPT_COPY테이블에
-- DEPT_ID 컬럼에 PRIMARY KEY 제약조건 추가
-- DEPT_TITLE 컬럼에 UNIQUE 제약조건 추가
-- LNAME 컬럼에 NOT NULL 제약조건 추가
SELECT * FROM DEPT_COPY;
DROP TABLE DEPT_COPY;
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE);
-- [오류] cannot validate (KH.DCOPY_UQ) - duplicate keys found
-- 이미 DEPT_TITLE에 '총무부'라는 중복된 값이 들어가 있음.
ALTER TABLE DEPT_COPY MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

SELECT * 
FROM USER_CONSTRAINTS; 
-- 현재 계정의 제약조건들을 볼 수 있는 데이터 딕셔너리

-- EMP_DEPT 테이블로 연습
-- EMP_ID 컬럼에 PRIMARY KEY 부여
-- EMP_NAME 컬럼에 NOT NULL 제약조건 부여
-- EMP_NAME 컬럼에 UNIQUE 제약조건 부여
ALTER TABLE EMP_DEPT
ADD CONSTRAINT EDEPT_PK PRIMARY KEY (EMP_ID)
ADD CONSTRAINT EDEPT_UQ UNIQUE (EMP_NAME)
MODIFY EMP_NAME CONSTRAINT EDEPT_NN NOT NULL;

-- 컬럼 추가시 주의사항
-- 1. 제약조건명 중복 불가
-- 2. 이미 담긴 값들이 해당 변경할 제약조건을 만족해야 함.
-- 3. ALTER문 하나로 묶어서 한번에 변경 가능

/*
 2_2) 제약조건 삭제(DROP CONSTRAINT / MODIFY)
 - PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT 제약조건명
 - NOT NULL : MODIFY 컬럼명 NULL 
*/

-- EDEPT_PK 제약조건 지우기
ALTER TABLE EMP_DEPT DROP CONSTRAINT EDEPT_PK;

-- EDEPT_UQ, EDEPT_NN 제약조건 지우기
ALTER TABLE EMP_DEPT 
DROP CONSTRAINT EDEPT_UQ
MODIFY EMP_NAME NULL;

-----------------------------------------------------------------------------
-- 3)컬럼명 / 제약조건명 / 테이블명 변경

-- 3-1) 컬럼명 변경 : RENAME COLUMN 기존컬럼명 TO 바꿀컬럼명
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY;


-- 3-2) 제약조건명 변경 : RENAME CONSTRAINT 기존제약조건명 TO 바꿀제약조건명
-- DEPT_ID_NN : SYS_C007311
-- LOCATION_ID_NN : SYS_C007312
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007311 TO DEPT_ID_NN;
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007312 TO LOCATION_ID_NN;

-- 3-3) 테이블명 변경 : RENAME [기존테이블명] TO 바꿀테이블명
-- 기존테이블명은 ALTER TABLE 테이블명에서 기술하기 때문에 생략 가능
-- 기존테이블명을 쓰려면 ALTER TABLE 테이블명을 빼고 
-- RENAME 기존테이블명 TO 바꿀테이블명 으로 써줌.
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
RENAME EMP_SALARY TO SALARY_EMP;


SELECT * FROM DEPT_TEST;
SELECT * FROM SALARY_EMP;

----------------------------------------------------------------------------
/*
 DROP
 객체를 삭제하는 구문
 
 [표현법]
 < 테이블 >
 DROP TABLE 테이블명;
 
 <사용자 계정>
 DROP USER 유저명; -- 해당 유저가 현재 접속중이면 삭제 안됨.
*/

DROP TABLE DEPT_TEST;
-- DELETE 또는 TRUNCATE 구문으로 모든 행을 삭제하는 것이랑은 다름
-- DROP은 테이블 자체를 지우는 것임.

DROP TABLE DEPARTMENT;
-- [오류] unique/primary keys in table referenced by foreign keys
-- 현재 EMPLOYEE테이블(자식)이 DEPARTMENT테이블(부모)을 외래키로 참조하고 있어 삭제가 불가함.

-- 만약에 부모테이블을 삭제하고 싶다면?
-- 1. 자식테이블을 먼저 지우고, 그 다음에 부모테이블을 지움.
DROP TABLE 자식테이블명;
DROP TABLE 부모테이블명;

-- 2. 부모테이블만 삭제, 맞물려있는 제약조건을 함께 지움.
DROP TABLE 부모테이블명 CASCADE CONSTRAINT;





