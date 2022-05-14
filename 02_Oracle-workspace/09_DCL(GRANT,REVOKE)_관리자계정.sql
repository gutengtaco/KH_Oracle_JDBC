/*
 < DCL : DATA CONTROL LANGUAGE >
 데이터 제어 언어
 
 계정에게 시스템 권한 또는 객체접근권한을 부여(GRANT)하거나 회수(REVOKE)하는 언어
 
 [표현법]
 * 권한 부여(GRANT)
 GRANT 권한, 권한, .... TO 계정명
 
 * 권한 회수(REVOKE)
 REVOKE 권한, 권한, ... FROM 계정명
*/

/*
 - 시스템 권한
 특정 DB에 접근하는 권한, 객체들을 생성할 수 있는 권한
 
 - 시스템 권한의 종류
 CREATE SESSION : 계정에 접속할 수 있는 권한
 CREATE TABLE : 테이블을 생성할 수 있는 권한
 CREATE VIEW : 뷰(조회용 임시테이블)를 생성할 수 있는 권한
 CREATE SEQUENCE : 시퀀스를 생성할 수 있는 권한
 CREATE USER : 계정을 생성할 수 있는 권한
 ...
*/

-- 1.SAMPLE 계정 생성
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- 계정 생성에 대한 권한은 주었으나, 접속에 대한 권한은 주지 않았음.

-- 2. SAMPLE 계정에 접속하기 위한 CREATE SESSION 권한을 부여
GRANT CREATE SESSION TO SAMPLE;

-- 3.1 SAMPLE계정에 테이블을 생성하기 위한 CREATE TABLE 권한 부여
GRANT CREATE TABLE TO SAMPLE;

-- 3.2 SAMPLE계정에 테이블스페이스를 할당해주기(SAMPLE계정 구조 변경)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-- QUOTA : 몫, 할당
-- 2M : 2 MEGA BYTE

-- 4. SAMPLE계정에 뷰를 생성할 수 있는 CREATE VIEW 권한 부여
GRANT CREATE VIEW TO SAMPLE;

-----------------------------------------------------------------------------------
/*
 - 객체접근권한(객체권한)
 특정 객체들을 조작(DML - SELECT, INSERT, UPDATE, DELETE)할 수 있는 권한
 
 [표현법]
 GRANT 권한종류 ON 특정객체 TO 계정명;
 권한종류       |  특정 객체
 SELECT          TABLE, VIEW, SEQUENCE
 INSERT          TABLE, VIEW
 UPDATE          TABLE, VIEW
 DELETE          TABLE, VIEW
*/

-- 5. SAMPLE 계정에 KH.EMPLOYEE테이블을 조회할 수 있는 권한 부여
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE 계정에 KH.DEPARTMENT테이블에 행을 삽입할 수 있는 권한 부여
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
-- KH.DEPARTMENT테이블에 행 INSERT 성공

--------------------------------------------------------------------------------

-- 최소한의 권한을 부여하고자 할 때, CONNECT, RESOURCE만 부여
-- GRANT CONNECT, RESOURCE TO 계정명;

/*
 < 롤 ROLE >
 특정 권한들을 하나의 집합으로 모아놓은 것 
 
 CONNECT : 접속할 수 있는 권한들을 묶어놓은 ROLE (CREATE SESSION)
 RESOURCE : 특정 객체들을 생성 및 관리할 수 있는 권한들을 묶어놓은 ROLE
 (CREATE TABLE, CREATE SEQUENCE,...)

*/

-- 롤을 확인할 수 있는 데이터 딕셔너리
SELECT * 
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT','RESOURCE');
-- 2개의 ROLE로 9개의 권한을 부여하는 효과

-------------------------------------------------------------------------------

/*
 권한 회수(REVOKE)
 권한을 회수할 때 사용하는 명령어
 
 [표현법]
 REVOKE 권한, 권한, 권한,... FROM 계정명
*/

-- 7. SAMPLE 계정에서 테이블을 생성할 수 없도록 권한을 회수
REVOKE CREATE TABLE FROM SAMPLE;

----- 실습문제 -----







