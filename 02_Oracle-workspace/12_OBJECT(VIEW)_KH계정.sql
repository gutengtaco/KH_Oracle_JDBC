/*
 < VIEW 뷰 >
 SELECT(조회용 쿼리문)을 저장해둘 수 있는 표 형태의 객체
 (자주 쓰일법한 긴 SELECT문을 저장해두면 매번 긴 SELECT문을 작성할 필요가 없어짐.)
 임시테이블 같은 존재(실제 데이터가 담겨있는 것은 아님.)
*/

----- 실습문제 ------
-- '한국'에서 근무하는 사원들의 
-- 사번, 이름, 부서명, 급여, 근무국가명, 직급명을 조회하시오
-->> 오라클 전용 구문
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE ORDER BY DEPT_CODE ASC; 

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID(+) 
      -- NULL인 경우 / DEPARTMENT테이블의 D3, D4, D7이 EMPLOYEE테이블에 없는 경우가 존재
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND L.NATIONAL_CODE = N.NATIONAL_CODE(+)
  AND N.NATIONAL_NAME = '한국';

-->> ANSI구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N USING(NATIONAL_CODE)
     JOIN JOB J USING(JOB_CODE)
WHERE N.NATIONAL_NAME = '한국';

--------------------------------------------------------------------------------


/*
 1. VIEW 생성 
 
 [표현법]
 CREATE VIEW 뷰명
 AS(서브쿼리);
 
 CREATE OR REPLACE VIEW 뷰명
 AS(서브쿼리);
 => 뷰 생성시, 기존에 중복된 이름의 뷰가 없다면, 해당 뷰명의 VIEW를 생성(CREATE)
    뷰 생성시, 기존에 중복된 이름의 뷰가 있다면, 해당 VIEW를 변경하는 옵션(OR REPLACE)
*/

-- 위의 복잡한 SELECT문을 서브쿼리 삼아 뷰 생성
DROP VIEW VW_EMPLOYEE;
CREATE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N USING(NATIONAL_CODE)
     JOIN JOB J USING(JOB_CODE));
-- [오류]insufficient privileges
-- 권한을 생성하지 않아서 발생하는 오류
-- RESOURCE라는 ROLE에는 CREATE VIEW에 대한 권한이 없음.

-- [참고]
-- 인라인뷰로 구성하면 다음과 같음.
SELECT *
FROM(SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N USING(NATIONAL_CODE)
     JOIN JOB J USING(JOB_CODE)); 

-- 이 부분만 관리자계정으로 접속해서 실행
GRANT CREATE VIEW TO KH;
----------------------------------------------------------------------------
SELECT * FROM VW_EMPLOYEE;
-- 위와 같이, 복잡한 서브쿼리를 이용하여, 그때그때 필요한 데이터들만 조회하는 것보다
-- 한번 서브쿼리로 뷰를 생성 후, 해당 뷰명으로 SELECT문을 이용하여 간단하게 조회 가능

-- '한국'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명, 직급명 조회
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '한국';

-- '러시아'에서 근무하는 사원
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

-- '러시아'에서 근무하는 사원들의 사번, 이름, 부서명, 급여, 근무국가명, 직급명, 보너스
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';
-- [오류] "BONUS": invalid identifier
-- VIEW에 BONUS라는 컬럼이 존재하지 않기 때문에 조회가 되지 않음.

-- 보너스 컬럼이 없는 뷰에서 보너스도 조회하고 싶은 경우
-- CREATE OR REPLACE VIEW 뷰명를 사용
-- 기존의 해당 뷰명의 내용을 덮어써서 새로 뷰를 만드는 옵션임.
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID(+) 
      -- NULL인 경우 / DEPARTMENT테이블의 D3, D4, D7이 EMPLOYEE테이블에 없는 경우가 존재
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND L.NATIONAL_CODE = N.NATIONAL_CODE(+));

-- 기존의 뷰에 보너스를 추가하여 뷰를 변경함.  
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '러시아';

-- VIEW는 논리적인 가상테이블 => 실질적으로 데이터를 저장하고 있지 않음.
-- VIEW의 정의 자체가 SELECT문을 저장 == 단순히 쿼리문이 TEXT문구로 저장되어있음.
-- VIEW를 확인할 수 있는 데이터 딕셔너리
-- USER_VIEWS 데이터 딕셔너리 : 해당 계정이 가지고 있는 VIEW들에 대한 정보들을 가지고 있는 관리용 테이블
SELECT * FROM USER_VIEWS;

-----------------------------------------------------------------------------------------
/*
 VIEW 컬럼에 별칭 부여
 서브쿼리의 SELECT절에 함수나 산술연산식이 사용될 경우, 반드시 별칭을 부여해주어야 함.
*/
-- 사원의 사번, 이름, 직급명, 성별, 근무년수를 조회할 수 있는 SELECT문을 VIEW로 조회
CREATE OR REPLACE VIEW VW_EMP_JOB
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
           DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여'),
           EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE));
-- [오류] must name this expression with a column alias   
-- 반드시 함수식이나 산술연산식에는 별칭(column alias)을 붙여주어야 함.

CREATE OR REPLACE VIEW VW_EMP_JOB
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
           DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여')"성별",
           EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)"근무년수"
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE));        
-- 함수식과 산술연산식에 별칭을 붙여주니 VIEW가 잘 생성된 것을 볼 수 있음.

SELECT * FROM VW_EMP_JOB;
    
-- 또 다른 방법으로 별칭부여 가능(단, 모든 컬럼에 대한 별칭을 다 기술해야 함)
CREATE OR REPLACE VIEW VW_EMP_JOB (사번,이름,직급명,성별,근속년수)
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
           DECODE(SUBSTR(EMP_NO,8,1),'1','남','2','여'),
           EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE));
-- [오류] invalid number of column names specified
-- 모든 컬럼에 별칭을 기술하지 않으면 다음과 같은 오류가 뜸.

SELECT * FROM VW_EMP_JOB;   

SELECT 사번, 근속년수
FROM VW_EMP_JOB;
-- 별칭을 이용하여 SELECT문을 작성할 수도 있음.

SELECT 사번, 이름, 직급명
FROM VW_EMP_JOB
WHERE 성별 = '남';
-- 별칭을 이용하여 WHERE절에도 작성할 수도 있음.
-- (보통의 SELECT문은 실행순서때문에 WHERE절에 별칭을 사용할 수 없음.)

SELECT *
FROM VW_EMP_JOB
WHERE 근속년수 >=20;

-- 뷰를 삭제하고 싶다면?
DROP VIEW VW_EMP_JOB;

---------------------------------------------------------------------

/*
 생성된 뷰를 이용해서 DML(INSERT, UPDATE, DELETE)구문 사용하기
 단, 뷰를 통해서 DML을 사용하면, 실제 데이터가 담겨있는 원본테이블의 데이터도 바뀜.(얕은복사와 비슷함.)
*/

CREATE OR REPLACE VIEW VW_JOB
AS(SELECT * FROM JOB);

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- 뷰에 INSERT
INSERT INTO VW_JOB 
VALUES('J8','인턴');
-- 뷰와 원본테이블에 모두 값이 삽입됨.

-- 뷰에 UPDATE
UPDATE VW_JOB 
   SET JOB_NAME = '알바'
 WHERE JOB_CODE = 'J8' ;
-- 마찬가지로, 뷰와 원본테이블 모두 값이 변경됨.

-- 뷰에 DELETE
DELETE FROM VW_JOB
 WHERE JOB_CODE = 'J8';
-- 마찬가지로, 뷰와 원본테이블 모두 값이 삭제됨.

------------------------------------------------------------------------------
/*
 뷰를 가지고 DML이 불가능한 경우가 더 많음.
 1) 뷰에 정의되어있지 않은 컬럼을 조작하는 경우
 2) 뷰에 정의되어있지 않은 컬럼 중에, 원본테이블상에 NOT NULL제약조건이 지정된 경우
 3) 산술연산식 또는 함수를 통해서 정의되어 있는 경우
 4) 그룹함수나 GROUP BY절이 포함되어있는 경우
 5) DISTINCT 구문이 있을 경우
 6) JOIN을 이용해서 여러 테이블을 매칭시켜놓은 경우
 => 대부분 원본테이블과 관련하여 생각해보면 됨.
*/

-- 1) 뷰에 정의되어 있지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW VW_JOB
AS(SELECT JOB_CODE FROM JOB);

SELECT * FROM VW_JOB;

-- INSERT
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME)
VALUES('J8','인턴');
-- [오류] "JOB_NAME": invalid identifier
-- VIEW에 없는 컬럼에 값을 삽입하려는 경우 발생하는 오류

-- UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '인턴'
 WHERE JOB_CODE = 'J7';
-- [오류] "JOB_NAME": invalid identifier
-- 마찬가지로 VIEW에 없는 컬럼의 값을 수정하려는 경우 발생하는 오류

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '사원';
-- [오류] "JOB_NAME": invalid identifier
-- 마찬가지로 VIEW에 없는 컬럼의 값을 삭제하려는 경우 발생하는 오류
 
------------------------------------------------------------------------------
-- 2) 뷰에 정의되어 있지 않은 컬럼 중에서 원본테이블상에 NOT NULL제약조건이 지정된 경우
CREATE OR REPLACE VIEW VW_JOB
AS(SELECT JOB_NAME FROM JOB);

SELECT * FROM JOB;
SELECT * FROM VW_JOB;

-- INSERT
INSERT INTO VW_JOB VALUES('인턴'); 
-- [오류] cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- 'INSERT INTO 뷰명 VALUES()'구문에는 행의 모든 값을 제시해야 해서 
-- 비록 JOB_NAME에 해당하는 '인턴'만 제시했지만, (NULL,'인턴')을 삽입한 것으로 판단함.
-- JOB_CODE가 NOT NULL제약조건이 걸려있기 때문에, NOT NULL제약조건을 위배해서 오류가 발생함.

-- UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '알바'
 WHERE JOB_NAME = '사원';  
-- VIEW에 있는 컬럼을 바꾼 것이기 때문에, 제대로 작동함.

-- UPDATE
UPDATE VW_JOB
   SET JOB_CODE = NULL
 WHERE JOB_NAME = '알바';
-- [오류] "JOB_CODE": invalid identifier
-- JOB_CODE가 VIEW에 없는 컬럼이라 오류가 발생함.
-- 또한, JOB_CODE가 NOT NULL제약조건인데 NULL을 넣으려고 해서 오류가 발생함.

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '대리';
-- [오류] integrity constraint (KH.SYS_C007239) violated - child record found
-- '대리'인 J6 직급에 해당하는 직급코드를 사용하고 있는 자식 데이터가 있어서 발생하는 오류

DELETE FROM VW_JOB
WHERE JOB_NAME = '알바';
-- 마찬가지로, '알바'인 J7직급에 해당하는 직급코드를 사용하고 있는 자식데이터가 있어서 오류 발생

-------------------------------------------------------------------

-- 3) 산술연산식 또는 함수식을 통해서 정의되어 있는 경우
-- 사원의 사번, 이름, 급여, 연봉에 대하여 조회하는 뷰
CREATE OR REPLACE VIEW VW_EMP_SAL
AS (SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "연봉"
      FROM EMPLOYEE);

SELECT * FROM VW_EMP_SAL;      
SELECT * FROM EMPLOYEE;

-- INSERT
INSERT INTO VW_EMP_SAL
VALUES(400,'정진훈', 3000000, 36000000);
-- [오류] virtual column not allowed here
-- 원본테이블에 SALARY*12라는 컬럼이 없어 들어갈 수 없음.

-- UPDATE
UPDATE VW_EMP_SAL
   SET "연봉" = 80000000
 WHERE EMP_ID = 200;
-- [오류] virtual column not allowed here
-- 원본테이블에 연봉 이라는 컬럼이 없어 들어갈 수 없음.

-- UPDATE 
UPDATE VW_EMP_SAL
   SET SALARY = 7000000
 WHERE EMP_ID = 200;  
-- 원본테이블에 SALARY 컬럼이 존재하여 값이 잘 변경됨.

-- DELETE
DELETE FROM VW_EMP_SAL
WHERE 연봉 = 72000000;
-- 송중기 사원이 사라짐.
-- 원본테이블에 연봉이라는 컬럼이 없지만, 
-- 조건에 따라서 삭제를 하려고 봤더니, 원본에 지울 수 있는 값이 있어서 삭제한 것임.

ROLLBACK;

-----------------------------------------------------------------------------

-- 4) 그룹함수식이나 GROUP BY절이 포함되는 경우
-- 부서별 급여합, 평균급여를 조회하는 뷰
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS(SELECT DEPT_CODE, SUM(SALARY) "급여합", FLOOR(AVG(SALARY)) "평균급여"
   FROM EMPLOYEE
   GROUP BY DEPT_CODE);


SELECT * FROM VW_GROUPDEPT;
-- 잘 생성되고, 잘 조회됨.

-- INSERT
INSERT INTO VW_GROUPDEPT
VALUES('D0', 80000000, 40000000);
-- [오류] "virtual column not allowed here"
-- 해당 함수식이나 산술연산식이 원본테이블의 컬럼에 존재하지 않음.

-- UPDATE
UPDATE VW_GROUPDEPT
   SET 급여합 = 8000000
 WHERE DEPT_CODE = 'D1';
-- [오류] data manipulation operation not legal on this view
-- 데이터를 조작하는 행위는 이 뷰에서 할 수 없다는 뜻의 오류
 
-- UPDATE
UPDATE VW_GROUPDEPT
   SET DEPT_CODE = 'D0'
 WHERE DEPT_CODE = 'D1';
-- [오류] data manipulation operation not legal on this view
-- 마찬가지로, 데이터를 조작하는 행위는 이 뷰에서 할 수 없다는 뜻의 오류

-- DELETE
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';
-- [오류] data manipulation operation not legal on this view
-- 마찬가지로, 데이터를 조작하는 행위는 이 뷰에서 할 수 없다는 뜻의 오류

-- => 이처럼, 그룹함수나 GROUP BY절로 구성된 뷰에서는 DML구문의 작동이 불가함.

-------------------------------------------------------------------

-- 5) DISTINCT 구문이 포함된 경우
CREATE OR REPLACE VIEW VW_DT_JOB
AS(SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE);

SELECT * FROM VW_DT_JOB;

-- INSERT 
INSERT INTO VW_DT_JOB VALUES('J8');
-- [오류]  data manipulation operation not legal on this view

-- UPDATE
UPDATE VW_DT_JOB
   SET JOB_CODE = 'J8'
 WHERE JOB_CODE = 'J7';   
-- [오류]  data manipulation operation not legal on this view

-- DELETE
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J7';
-- [오류]  data manipulation operation not legal on this view

-----------------------------------------------------------------------

-- 6) JOIN을 이용하여 여러 테이블을 매칭시켜놓은 경우
CREATE OR REPLACE VIEW VW_JOINEMP
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE= DEPT_ID));

SELECT * FROM VW_JOINEMP;

--INSERT
INSERT INTO VW_JOINEMP VALUES(888,'조세오','총무부');
-- [오류] cannot modify more than one base table through a join view
-- 한개 이상의 원본테이블이 JOIN되어 있는 뷰의 경우, 수정할 수 없다는 뜻의 오류임. 

-- UPDATE
UPDATE VW_JOINEMP
   SET EMP_NAME = '서동일'
 WHERE EMP_ID = 200;
-- 오류가 안뜸.
-- EMPLOYEE에만 반영 가능한 UPDATE문이라 수행 성공(특이케이스)
SELECT * FROM EMPLOYEE;

-- DELETE
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

SELECT * FROM VW_JOINEMP;
-- 200번에 해당하는 사원이 삭제됨.
SELECT * FROM EMPLOYEE;
-- 200번에 해당하는 사원이 삭제됨.
SELECT * FROM DEPARTMENT;
-- 200번에 해당하는 D9은 삭제되지 않음.
-- 즉, 기준이 되는 테이블(EMPLOYEE)에서만 값이 삭제됨.

DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE = '총무부';

SELECT * FROM VW_JOINEMP;
-- '총무부'에 해당하는 사원이 삭제되었음.
SELECT * FROM VW_JOINEMP;
-- '총무부'에 해당하는 사원이 삭제되었음.
ROLLBACK;
-- 뷰는 위처럼, DML문이 적용됐다가 안됐다가 하기때문에
-- 대부분 실무에서도 조회용으로만 쓰임.
-------------------------------------------------------------
/*
 VIEW 옵션
 
 [상세표현법]
 CREATE OR REPLACE [FORCE / NOFORCE] 뷰명
 AS (서브쿼리)
 WITH CHECK OPTION
 WITH READ ONLY 
 
 1) FORCE / NOFORCE
  - FORCE : 서브쿼리에 기술된 테이블이 존재하지 않더라도 뷰를 생성
  - NOFORCE : 서브쿼리에 기술된 테이블이 반드시 존재해야만 뷰를 생성
              생략시 기본값임.   
 2) WITH CHECK OPTION : 서브쿼리의 조건절에 기술된 내용에 만족하는 값으로만 DML이 가능
                        조건에 부합하지 않는 값으로 수정하는 경우 오류 발생
 3) WITH READ ONLY : 뷰에 대해 조회만 가능.                       
*/

-- 1) FORCE/ NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_TEST
AS(SELECT TCODE, TNAME, TCONTENT
   FROM TT);
-- [오류] table or view does not exist
-- TT라는 테이블과 해당 컬럼이 존재하지 않아 발생하는 오류임.

CREATE OR REPLACE FORCE VIEW VW_TEST
AS(SELECT TCODE, TNAME, TCONTENT
   FROM TT);
-- "컴파일 오류와 함께 뷰가 생성되었습니다."
-- 접속에서 뷰의 VW_TEST를 보면 모두 UNDEFINED라고 설정되어 있음.

SELECT * FROM VW_TEST;
-- 현재 조회도 못하는 상황
-- 단, 해당 TT라는 이름의 테이블이 생성된 이후부터는 해당 뷰를 사용할 수 있음.

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(30),
    TCONTENT VARCHAR2(50)
    );

SELECT * FROM VW_TEST;
-- TT라는 테이블을 생성하고 조회할 수 있게됨.

-- 2) WITH CHECK OPTION
CREATE OR REPLACE VIEW VW_EMP
AS 
(SELECT *
 FROM EMPLOYEE
 WHERE SALARY >= 3000000)
 WITH CHECK OPTION;
 
SELECT * FROM VW_EMP;
-- 현재 뷰의 상황 : 월급이 300만원 이상의 사원들의 정보만 보임

UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 200;  
-- [오류] view WITH CHECK OPTION where-clause violation
-- 서브쿼리에 기술한 조건에 부합하지 않게끔 수정을 시도했기 때문에 변경 불가

UPDATE VW_EMP
   SET SALARY = 4000000
 WHERE EMP_ID = 200;  
-- 300만원 이상인 400만원을 제시했기 때문에 성공적으로 업데이트됨.

SELECT * FROM VW_EMP;
ROLLBACK;

-- 3) WITH READ ONLY
CREATE OR REPLACE VIEW VW_EMPBONUS
AS(SELECT EMP_ID, EMP_NAME, BONUS
   FROM EMPLOYEE
   WHERE BONUS IS NOT NULL)
WITH READ ONLY;

SELECT * FROM VW_EMPBONUS;

DELETE FROM VW_EMPBONUS
WHERE EMP_ID = 204;
-- [오류] cannot perform a DML operation on a read-only view
-- 뷰를 오직 조회만 가능하게 바꿔놔서 DML문을 사용할 수 없음.

/*
 접두사
 보통은 이름을 붙일 때 의미부여를 하는데
 어느 종류의 객체 이름인지 접두사를 붙임
 
 - 테이블명 : TB_XXXX
 - 시퀀스명 : SEQ_XXXX
 - 뷰명 : VW_XXXX
*/