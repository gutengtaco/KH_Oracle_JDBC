-- CREATE TABLE 권한을 부여받기 전
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- [오류] insufficient privileges
-- 테이블을 생성할 수 있는 권한이 없기 때문에 오류가 발생함.

-- 3.1 CREATE TABLE 권한을 부여한 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- [오류] no privileges on tablespace 'SYSTEM'
-- TABLE SPACE(테이블들이 모여있는 공간)가 할당되지 않아서 생기는 오류임.

-- 3.2 TABLE SPACE를 할당 받은 후
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- 테이블 생성 완료

-- 위의 테이블 생성 권한(CREATE TABLE)을 부여받게 되면
-- 해당 계정이 가지고 있는 테이블들을 조작(DML)하는 것도 가능해짐.
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- 4. 뷰 만들어보기
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
-- [오류] "insufficient privileges"
-- 뷰 객체를 생성할 수 있는 CREATE VIEW 권한이 없기 때문에 오류가 발생함.

-- CREATE VIEW 권한을 부여받은 후
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
-- 뷰 생성완료

-- SAMPLE 계정에서 KH계정에 있는 테이블에 접근
SELECT * 
FROM KH.EMPLOYEE;
-- [오류] table or view does not exist
-- 5. KH계정의 테이블에 접근해서 조회할 수 있는 권한이 없기 때문에 오류 발생
-- SAMPLE계정 입장에서 "KH.EMPLOYEE"라는 이름의 테이블이 존재하지 않음.

-- SELECT ON 권한 부여 후
SELECT * 
FROM KH.EMPLOYEE;
-- EMPLOYEE 테이블 조회 성공

SELECT *
FROM KH.DEPARTMENT;
-- KH.EMPLOYEE테이블에만 접근권한을 주어서 DEPARTMENT에는 적용이 안됨. 

-- SAMPLE 계정에서 KH계정의 테이블에 접근해서 행 삽입해보기
INSERT INTO KH.DEPARTMENT VALUES('D0','회계부','L2');
-- [오류] table or view does not exist
-- 6. KH계정의 테이블에 접근해서 삽입할 수 있는 권한이 없기 때문에 오류 발생

-- INSERT ON 권한 부여 후
INSERT INTO KH.DEPARTMENT VALUES('D0','회계부','L2');
COMMIT;
-- 커밋까지 해줘야 새로운 행이 삽입됨.


