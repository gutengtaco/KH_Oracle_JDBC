/*
 < DML : DATA MANIPULATION LANGUAGE>
 데이터 조작 언어

 테이블의 새로운 데이터를 삽입(INSERT)하거나, 기존의 데이터를 수정(UPDATE)하거나
 , 기존의 데이터를 삭제(DELETE)하는 구문
 
 추가적으로 SELECT문도 DML에 포함시킬 수 있음.
*/

/*
 1. INSERT : 테이블에 새로운 행을 추가하는 구문
 
 [표현법]
 1) INSERT INTO 테이블명 VALUES(값, 값, 값,...); 
 => 해당 테이블에 모든 컬럼에 대하여 추가하고자 하는 값을 직접 한 행의 값을 모두 제시하여 추가함.
 => 컬럼 순번을 지켜서 VALUES 괄호 안에 값을 나열해야 함.
 => 부족한 개수로 값을 나열할 경우 : NOT ENOUGH VALUE 오류
 => 넘치는 개수로 값을 나열할 경우 : TOO MANY VALUES 오류
*/

-- EMPLOYEE 테이블에 INSERT
INSERT INTO EMPLOYEE 
VALUES('900','김말똥','870215-2000000', 'kim_md@kh.or.kr',
       '01011112222','D1','J7','S3',4000000, 0.2,'200',SYSDATE,NULL,'N');
       
SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE WHERE EMP_ID = '900';

/*
 2) INSERT INTO 테이블명(컬럼명, 컬럼명,..) VALUES(값, 값,...)
 => 해당 테이블에 특정 컬럼만 선택해서, 그 컬럼에 추가할 값만 부분적으로 제시하고자할 때 사용
 => 그래도 한 행 단위로 추가되기 때문에, 선택이 안된 컬럼에 대해서는 기본적으로 NULL이 들어감
 => 단, DEFAULT설정을 한 경우에는, DEFAULT의 값이 추가됨.
 => NOT NULL 제약조건이 걸려있는 컬럼은 반드시 선택해서 값을 제시해주어야 함.
 => PRIMARY KEY 제약조건이 걸려있는 컬럼도 반드시 선택해서 값을 제시해주어야 함.
 => 단, NOT NULL 제약조건이 걸려있는 컬럼이라고 하더라도, DEFAULT설정이 걸려있으면 값 제시 안해도 됨.
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE,JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(901, '박말순', '990101-1234567', 'D1', 'J2','S1',SYSDATE);

SELECT * FROM EMPLOYEE WHERE EMP_ID='901';
-- ENT_YN은 DEFAULT가 설정되어 있어 N이라는 값이 들어가 있음.

/*
 3) INSERT INTO 테이블명(서브쿼리);
 => VALUES로 값을 일일이 기입하는 것 대신에, 서브쿼리로 조회한 결과물들을
 => 통째로 INSERT하는 구문
 => 여러행을 INSERT 시킬 수 있음.
*/

-- 새로운 테이블 만들기
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- 전체 사원들의 사번, 이름, 부서명을 조회한 결과를 EMP_01 테이블에 추가
INSERT INTO EMP_01
(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE, DEPARTMENT
    WHERE DEPT_CODE = DEPT_ID(+)
);
SELECT * FROM EMP_01;
-- 25개 행이(가) 삽입되었습니다.

/*
 2. INSERT ALL
 두 개 이상의 테이블에 각각 INSERT 하고 싶을 때 사용.
 단, 사용되는 서브쿼리가 동일한 경우 사용
 
 INSERT ALL
 INTO 테이블명1 VALUES(컬럼명, 컬럼명,...)
 INTO 테이블명2 VALUES(컬럼명, 컬럼명,...)
 (서브쿼리);
*/

-- 새로운 테이블을 먼저 만들기
-- 첫번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 직급명을 보관할 테이블
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);

SELECT * FROM EMP_JOB;

-- 두번째 테이블 : 급여가 300만원 이상인 사원들의 사번, 사원명, 부서명을 보관할 테이블
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_DEPT;

-- 급여가 300만원 이상인 사원들의 사번, 이름, 직급명, 부서명 조회
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;

INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
(SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
 FROM EMPLOYEE 
 JOIN JOB USING(JOB_CODE)
 LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE SALARY >= 3000000);
-- 서브쿼리를 통해서 조회된 행의 개수 : 9개
-- 이 행을 2개의 테이블로 나누어서 삽입하기 때문에, 총 18개의 행을 추가함.
SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- INSERT ALL시에 조건을 사용해서 각 테이블에 값을 INSERT 가능
-- 사번, 사원명, 입사일, 급여(EMP_OLD테이블에 저장) 
-- 단, 2010년 이전에 입사한 사원
CREATE TABLE EMP_OLD
AS(SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1=0);
    
 -- 사번, 사원명, 입사일, 급여(EMP_NEW테이블에 저장)
 -- 단, 2010년 부터 입사한 사원
CREATE TABLE EMP_NEW
AS(SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1=0);

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- 각 범위에 맞는 사원들을 조회
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
--WHERE HIRE_DATE <'2010/01/01'; -- 2010년 이전 입사자들(9명)
WHERE HIRE_DATE >='2010/01/01'; -- 2010년 이후 입사자들(16명)

/*
 2) INSERT ALL
 WHEN 조건식1 THEN
      INTO 테이블명1 VALUES(컬럼명,...)
 WHEN 조건식2 THEN   
      INTO 테이블명2 VALUES(컬럼명,...)
 (공통적으로 사용할 서브쿼리)
*/

INSERT ALL
WHEN HIRE_DATE <'2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 9개 행
WHEN HIRE_DATE >='2010/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 16개 행
(SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
 FROM EMPLOYEE);    

SELECT * FROM EMP_OLD; 
SELECT * FROM EMP_NEW;
-- 총 25개의 행 추가됨.

-------------------------------------------------------------------------------

/*
 3. UPDATE
 테이블에 기록된 기존의 데이터를 수정하는 구문
 
 [표현법]
 UPDATE 테이블명
    SET 컬럼명 = 바꿀값
      , 컬럼명 = 바꿀값
      , 컬럼명 = 바꿀값
      ... => 여러개의 컬럼값을 동시에 수정 가능(AND가 아닌 콤마로 나열)
  WHERE 조건; => WHERE절은 생략 가능, 단, 생략 시 전체 모든 행의 데이터가 다 변경되어버림.
*/

-- 테스트용 복사본 테이블
CREATE TABLE DEPT_COPY
AS(SELECT *
   FROM DEPARTMENT);
 
 SELECT * FROM DEPT_COPY;
 
 -- DEPT_COPY테이블의 D9부서의 부서명을 '전략기획팀'으로 수정
 UPDATE DEPT_COPY
    SET DEPT_TITLE = '전략기획팀'
  WHERE DEPT_ID = 'D9';
  
 SELECT * FROM DEPT_COPY;
 
 -- 주의 : WHERE절을 생략하면 모든 행에 대하여 수정이 적용됨.
 UPDATE DEPT_COPY
    SET DEPT_TITLE = '전략기획팀';
    -- 전체 행의 DEPT_TITLE이 모두 '전략기획팀'으로 바뀜.
 SELECT * FROM DEPT_COPY;
 
 -- 복사본 테이블
 CREATE TABLE EMP_SALARY
 AS(SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
      FROM EMPLOYEE);
      
 SELECT * FROM EMP_SALARY;
 
 -- EMP_SALARY 테이블에 노옹철 사원의 급여를 1000만원으로 변경
 UPDATE EMP_SALARY
    SET SALARY = 10000000
  WHERE EMP_NAME = '노옹철';
  
  SELECT * FROM EMP_SALARY;
 
 -- EMP_SALARY 테이블에 선동일 사원의 급여를 700만원으로, 보너스를 0.2로 변경 
 UPDATE EMP_SALARY
    SET SALARY = 7000000
      , BONUS = 0.2
  WHERE EMP_NAME = '선동일';   
  
  SELECT * FROM EMP_SALARY WHERE EMP_NAME = '선동일';
 
 -- 전체 사원의 급여를 기존 급여에 20프로 인상한 금액으로 변경
 UPDATE EMP_SALARY
    SET SALARY = SALARY*1.2;
  
 SELECT * FROM EMP_SALARY;   
   
/*
 UPDATE 시에 서브쿼리를 사용하기
 서브쿼리를 수행한 결과값으로 변경하겠다.
 (= 변경할 값 부분에 서브쿼리를 넣겠다)
 
 [표현법]
 UPDATE 테이블명
    SET 컬럼명 = (서브쿼리) -- 단일행, 단일열 서브쿼리
  WHERE 조건;   
*/ 

-- EMP_SALARY 테이블에 김말똥 사원의 부서코드를 선동일 사원의 부서코드로 변경
-- 1) 선동일 사원의 부서코드
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '선동일';

-- 2) 김말똥 사원의 부서코드를 D9으로 바꿈
UPDATE EMP_SALARY
   SET DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '선동일')  
  WHERE EMP_NAME = '김말똥';
  
SELECT * FROM EMP_SALARY;
-- 김말똥의 부서코드가 D1에서 D9으로 바뀜.

DROP TABLE EMP_SALARY;
-- 방명수 사원의 급여와 보너스를 유재식 사원의 급여와 보너스로 변경
-- 1) 유재식 사원의 급여, 보너스
SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '유재식';

-- 2) 방명수 사원의 급여와 보너스를 유재식사원의 급여, 보너스로 변경
UPDATE EMP_SALARY
   SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMP_SALARY
                           WHERE EMP_NAME = '유재식')                       
 WHERE EMP_NAME = '방명수';  
 
SELECT * FROM EMP_SALARY WHERE EMP_NAME = '방명수'; 
-- [참고] UPDATE시에도 변경할 값에 있어서 해당 컬럼에 대한 제약조건에 위배되면 안됨.
-- 송중기 사원의 사번을 200번으로 변경
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE
   SET EMP_ID = '200'
 WHERE EMP_NAME = '송종기';  
-- [오류] unique constraint (KH.EMPLOYEE_PK) violated
-- PRIMARY KEY의 제약조건을 위배했기 때문에 발생함.


-- 사번이 200번인 사원의 이름을 NULL로 변경
UPDATE EMPLOYEE
   SET EMP_NAME = NULL
 WHERE EMP_ID = '200';
-- [오류] cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL이 제약조건으로 걸려있는 것을 NULL로 바꾸려고 해서 오류가 남.


-- 여태까지 연습했던 내용들을 확정짓겠다.
COMMIT;

-----------------------------------------------------------------------------

/*
 DELETE
 테이블에 기록된 데이터를 삭제하는 구문
 
 [표현법]
 DELETE FROM 테이블명
 WHERE 조건;
 
 단, WHERE절을 빼면 모든 행을 삭제하게 됨.
*/

-- EMPLOYEE 테이블의 모든 행들을 삭제
SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE;

ROLLBACK; -- 마지막 커밋 시점까지 복원함.

-- 김말똥, 박말순의 행을 삭제함.
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '김말똥' OR EMP_NAME = '박말순';
COMMIT;

-- DEPARTMENT테이블로부터 DEPT_ID가 D1인 부서 삭제
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- [오류] integrity constraint (KH.SYS_C007238) violated - child record found
-- 자식의 외래키로 부모테이블의 컬럼값을 참조하고 있을 때 발생
-- ON DELETE RESTRICTED이라서 값을 삭제할 수 없음.
-- 현재 EMPLOYEE테이블의 DEPT_CODE가 DEPARTMENT테이블의 DEPT_ID를 참조하고 있음.

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';
-- D3을 부서코드로 갖는 사원이 없기 때문에 잘 삭제됨.

SELECT * FROM DEPARTMENT;

ROLLBACK;
-- DEPARTMENT 테이블을 DELETE이전으로 돌림.

-------------------------------------------------------------------------------
/*
 TRUNCATE 
 테이블의 전체 행을 삭제할 때 사용하는 구문(절삭)
 DELETE FROM 테이블명;과 같은 역할
 단, DELETE보다 수행속도가 빠름
 별도의 조건을 제시할 수 없음. 
 ROLLBACK이 불가함.
 
 [표현법]
 TRUNCATE TABLE 테이블명;         |     DELETE FROM 테이블명;
 별도의 조건제시 X                        별도의 조건제시 O
 수행속도 빠름                            수행속도 느림
 ROLLBACK이 불가함                        ROLLBACK이 가능
 
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;
ROLLBACK;
-- ROLLBACK으로 복구가 됨.

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;
-- 가차없음. ROLLBACK으로 복구가 안됨.