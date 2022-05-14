/*
 SELECT
 데이터를 조회하거나, 검색할 때 사용하는 명령어
 -ResultSet : SELECT구문으로, 조회된 데이터(행)들의 결과물
                            
 [표현법]
 SELECT 조회하고자하는컬럼명1, 컬럼명2, 컬럼명3,... 
 FROM 테이블명;
 =>실제로 존재하는 컬럼명을 제시해주어야 함.
*/
--EMPLOYEE테이블의 전체 사원들의 사번, 이름, 급여 컬럼만을 조회
--EMP_ID, EMP_NAME,SALARY
SELECT EMP_ID, EMP_NAME,SALARY 
FROM employee;
-- 명령어나 키워드, 테이블명, 컬럼명 등은 대소문자를 구별하지 않음.

--EMPLOYEE 테이블의 전체 사원들의 모든 컬럼을 조회
/*
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE,JOB_CODE,SAL_LEVEL,
       SALARY, BONUS, MANAGER_ID, HIRE_DATE,ENT_DATE,ENT_YN
FROM EMPLOYEE;
*/
SELECT *
FROM EMPLOYEE;

--JOB 테이블의 모든 컬럼을 조회
SELECT *
FROM JOB;

--JOB 테이블의 직급명 컬럼을 조회
SELECT JOB_NAME
FROM JOB;


--1. DEPARTMENT테이블의 모든 컬럼 조회
SELECT *
FROM department;
--2. EMPLOYEE테이블의 직원명, 이메일, 전화번호, 입사일 컬럼만 조회
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;
--3. EMPLOYEE테이블의 입사일, 직원명, 급여 컬럼만 조회
SELECT HIDE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;
--[오류메세지]
--00904. 00000 -  "%s: invalid identifier"
--잘못된 식별자를 입력하면 발생함.(컬럼명과 테이블명을 잘못 입력)
--------------------------------------------------------
/*
 컬럼 값을 통한 산술 연산
 조회하고자 하는 컬럼들을 나열하는 SELECT절에 
 산술연산을 곁들여 볼 것임.(+,-,/,*)
 => 모듈러연산은 오라클에서 따로 제공함.
*/
--EMPLOYEE 테이블로부터 직원명, 월급, 연봉(월급*12)
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;
--EMPLOYEE 테이블로부터 직원명, 월급,보너스, 보너스가 포함된 연봉
SELECT EMP_NAME, SALARY,BONUS,(SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;
--산술연산 과정에 NULL이 존재한다면, 산술연산 결과도 NULL이 나옴!!

--EMPLOYEE테이블로부터 직원명, 입사일, 근무일수(오늘날짜-입사일)를 조회
--오늘날짜 : SYSDATE
--DATE끼리도 연산이 가능 => 년,월,일,시,분,초
SELECT EMP_NAME, HIRE_DATE, (SYSDATE-HIRE_DATE)
FROM EMPLOYEE;
--결과값은 일수단위로 나옴(정수부분)
--문제는 소수점이하의 값이 나와 지저분해 보임.
--이는, DATE타입에 포함되어있는 시/분/초에 대한 연산까지 수행하기 때문에.
-----------------------------------------------------------------

/*
 컬럼명에 별칭 부여하기
 [표현법]
 컬럼명 AS 별칭
 컬럼명 AS "별칭"
 컬럼명 별칭
 컬럼명 "별칭"
 
 별칭에 특수문자나 띄어쓰기가 포함될 경우, 반드시 ""로 묶어서 표기해야 함.
*/

--EMPLOYEE 테이블로부터 이름, 월 급여, 보너스가 포함된 총 소득을 조회
SELECT EMP_NAME AS 이름, SALARY AS "월 급여" , 
       BONUS 보너스, (SALARY+(BONUS*SALARY))*12 "총 소득(보너스포함)"
FROM EMPLOYEE;
--[오류메세지]
--"FROM keyword not found where expected"
--별칭에 띄어쓰기가 포함됐는데 쌍따옴표("")를 쓰지않으면 발생.
--------------------------------------------------------------
/*
 리터럴
 임의로 지정한 문자열(''), 숫자, 날짜를 SELECT절에 기술하면
 실제 그 테이블에 존재하는 데이터처럼 ResultSet으로 조회가 가능
*/

--employee테이블에 사번, 사원명, 급여, 화폐단위 조회하기 
SELECT EMP_ID AS 사번, EMP_NAME AS "사원 명", SALARY 급여, '원' AS "단위!"
FROM EMPLOYEE;
--SELECT절에 제시한 리터럴은 조회결과인 ResultSet의 모든 행에 반복적으로 출력
-------------------------------------------------------------------
/*
 DISTINCT
 조회하고자 하는 컬럼에 중복된 값을 딱 한번씩만 조회하고 싶을 때 사용
 EX) 부서코드 - 개발팀, 회계팀, 인사팀 ...
 해당 컬럼명 앞에 DISTINCT를 기술해주면 됨.
 [표현법]
 DISTINCT 컬럼명 
 => 단,
 SELECT절에 DISTINCT구문은 단 한개만 작성 가능함.
*/
--EMPLOYEE 테이블로부터 부서코드를 조회
/*
SELECT DEPT_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

--EMPLOYEE 테이블로부터 직급코드를 조회
/*
SELECT JOB_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

--DEPT_CODE JOB_CODE컬럼의 값을 세트로 묶어서 중복을 판별
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

--------------------------------------------------
/*
 WHERE
 조회를 하고자 하는 테이블의 특정한 조건을 제시해서, 
 조건에 만족하는 데이터만을 조회하고자할 때 기술하는 구문
 
 [표현법]
 SELECT 컬럼명 FROM 테이블명 WHERE 조건식;
 실행순서 : FROM > WHERE > SELECT
 
 조건식에 다양한 연산자들을 사용 가능함
 비교연산자 : 대소비교(>,<,>=,<=)
            동등비교( = / != 또는 ^= 또는 <>)
*/
-- EMPLOYEE테이블로부터 급여가 400만원 이상인 사원들의 모든 컬럼 조회
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 4000000;

--EMPLOYEE테이블로부터 부서코드가 D9인 사원들의 사원명, 부서코드, 급여를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE='D9';
--3명이 나옴

--EMPLOYEE테이블로부터 부서코드가 D9가 아닌 사원들의 사원명, 부서코드, 급여를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE !=/*<>,^=*/'D9'; 
-- 23명 중 20명이 나와야 함
-- NULL이 2명 있어서 18명이 나옴
-- 산술연산때와 같이, NULL이 있으면 조건의 결과도 NULL로 제외가 됨.
--------------------------------------------------------------
-- 실습문제
-- 1. EMPLOYEE테이블로부터 급여가 300만원 이상인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME AS 이름,SALARY AS 급여, HIRE_DATE AS 입사일 
FROM EMPLOYEE
WHERE SALARY >= 3000000;
-- 2. EMPLOYEE테이블로부터 직급코드가 J2인 사원들의 이름, 급여, 보너스 조회
SELECT EMP_NAME AS 이름, SALARY AS 급여, BONUS AS 보너스
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';
-- 3. EMPLOYEE테이블로부터 현재 재직중인 사원들의 사번, 이름, 입사일 조회
SELECT EMP_ID AS 사번, EMP_NAME AS 이름, HIRE_DATE AS 입사일
FROM EMPLOYEE
WHERE ENT_YN = 'N';
-- 4. EMPLOYEE테이블로부터 연봉(급여*12)이 5천만원 이상인 사원들의 이름, 급여,연봉, 입사일 조회  
SELECT EMP_NAME AS 이름, SALARY AS 급여,(SALARY*12) AS 연봉, HIRE_DATE AS 입사일
FROM EMPLOYEE
WHERE (SALARY*12)/*연봉*/ >= 50000000;
--WHERE절에서는 별칭이 적용이 안됨.
--순서가 FROM > WHERE > SELECT순서이기 때문에 별칭이 적용 안됨.
--------------------------------------------------------
/*
 논리연산자 
 여러 개의 조건을 엮을 때 사용
 JAVA에서는
 -이면서, 그리고 : AND(&&)
 -이거나, 또는 : OR(||)
 ORACLE에서는
 -이면서, 그리고 : AND
 -이거나, 또는 : OR
*/
-- EMPLOYEE테이블로부터 부서코드가 "D9"이면서 급여가 500만원 이상인
-- 사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D9' AND SALARY >= 5000000;

--EMPLOYEE테이블로부터 부서코드가 'D6'이거나 급여가 300만원 이상인
--사원들의 이름, 부서코드, 급여 조회
SELECT EMP_NAME AS 이름, DEPT_CODE AS 부서코드, SALARY AS 급여
FROM EMPLOYEE
WHERE DEPT_CODE ='D6' OR SALARY >= 3000000

-- EMPLOYEE테이블로부터 급여가 350만원 이상이고, 600만원 이하인 
-- 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY<=6000000;
      /* 3500000 <= SALARY <= 6000000
      -- 오라클도 마찬가지로 부등호를 연달아서 사용X
-----------------------------------------------------
/*
 BETWEEN AND 연산자
 몇 이상, 몇 이하의 범위에 대한 조건을 제시할 수 있는 연산자
 [표현법]
 비교대상 컬럼 BETWEEN 하한가 AND 상한가
 (비교대상에 들은 값이 하한가 이상 상한가 이하를 만족하는 경우)
*/
-- EMPLOYEE테이블로부터 급여가 350만원 초과, 600만원 미만인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--EMPLOYEE 테이블로부터 급여가 350만원 미만이고, 600만원 초과인 사원들의 이름, 사번, 급여, 직급코드 조회
SELECT EMP_NAME, EMP_ID, SALARY,JOB_CODE
FROM EMPLOYEE
--WHERE SALARY <35000000 OR SALARY > 6000000;
WHERE NOT SALARY /*NOT*/BETWEEN 3500000 AND 6000000;
--NOT은 논리부정연산자와 같은 역할을 수행함.
--NOT의 위치는 컬럼명 앞 혹은 BETWEEN앞에 붙여줌

--BETWEEN AND 연산자는 DATE형식에서도 사용 가능함.
--비교연산자도 DATE형식에서 사용 가능
--하한값은 과거, 상한값은 미래임.
--입사일이 '90/01/01' ~ '03/01/01'인 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

--EMPLOYEE테이블로부터 입사일이 90/01/01 ~ 03/01/01이 아닌 사원들의 모든 컬럼 조회
SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE /*NOT*/BETWEEN '90/01/01' AND '03/01/01';

/*
 LIKE '특정패턴'
 JAVA의 CONTAINS()와 비슷함
 => 비교하려는 컬럼 값이 내가 지정한 특정 패턴에 만족될 경우 조회
 [표현법] 비교대상컬럼명 LIKE '특정패턴'
 - 특정패턴을 제시할 때, 와일드카드인 '%', '_'를 가지고 제시할 수 있음.
 '%'(퍼센트) : 0글자 이상
 비교대상컬럼명 LIKE '문자%' => 컬럼값 중에 해당 '문자'로 시작되는 것을 조회
 비교대상컬럼명 LIKE '%문자' => 컬럼값 중에 해당 '문자'로 끝나는 것을 조회
 비교대상컬럼명 LIKE '%문자%' => 컬럼값 중에 해당 '문자'가 포함되는 것을 조회
 '_' : 딱 1글자
 비교대상컬럼명 LIKE '_문자' => 해당 컬럼값 중에 '문자'앞에 무조건 1글자가 존재할경우 조회
 비교대상컬럼명 LIKE '__문자' => 해당 컬럼값 중에 '문자'앞에 무조건 2글자가 존재할 경우 조회
*/

--EMPLOYEE테이블로부터 성이 전씨인 사원들의 이름, 급여, 입사일 조회
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '전%';

--EMPLOYEE테이블로부터 이름 중에 '하'가 포함된 사원들의 이름, 주민번호, 부서코드 조회
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%하%';

--EMPLOYEE테이블로부터 전화번호 4번째자리가 9로 시작하는 사원들의 사번, 사원명, 전화번호, 이메일 조회
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--EMPLOYEE테이블로부터 이름 가운데글자가 '지'인 사원들의 모든 컬럼(이름이 3글자인 경우)
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_지_';

--그이외의 사원
SELECT *
FROM EMPLOYEE
WHERE NOT EMP_NAME /*NOT*/ LIKE '_지_';

--------실습문제-------
--1. 이름이 '연'으로 끝나는 사원들의 이름, 입사일 조회
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%연'/*또는 __연*/;
--2. 전화번호 처음 3글자가 010이 아닌 사원들의 이름, 전화번호를 조회
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';
--3. DEPARTMENT테이블로부터 해외영업과 관련된 부서들의 모든 컬럼을 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%해외영업%';

/*
 IS NULL
 NULL인지 아닌지 판별함.
 [표현법]
 비교대상컬럼 IS NULL : 컬럼 값이 NULL인 경우를 조회함.
 비교대상컬럼 IS NOT NULL : 컬럼 값이 NULL이 아닌 경우를 조회함.
 
 주의사항 : 오라클에서 NULL과 동등비교할때는 =을 쓰지 않고 IS NULL을 씀!!
*/
-- EMPLOYEE테이블의 전체 컬럼
SELECT *
FROM EMPLOYEE;

--보너스를 받지 않는 사원들의 사번, 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--보너스를 받는 사원드르이 사번, 이름, 급여, 보너스
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

--사수가 없는 사원들의 사원명, 사수사번, 부서코드 조회
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--사수도 없고, 부서코드도 없는 사원들의 모든 컬럼을 조회
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--부서코드는 없지만, 보너스는 받는 사원들의 사원명, 부서코드, 보너스
SELECT EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
 IN
 비교대상컬럼 값에 내가 제시한 목록들 중에서 일치하는 값이 하나라도 있는지 체크함.
 [표현법]
 비교대상컬럼 IN (값1, 값2, 값3,....)
*/

--부서코드가 D6이거나 또는 D8이거나 또는 D5인 사원들의 이름, 부서코드, 급여를 조회
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');

--그 이외의 사원들
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6','D8','D5');

/*
 연결연산자 : ||
 여러 컬럼값을 마치 하나의 컬럼인 듯 연결시켜주는 연산자
 컬럼과 리터럴, 임의의 문자열을 연결시킬수 있음.
 
 자바에서
 문자열 + 문자열 = 합쳐진 문자열
 문자열 + 숫자 = 합쳐진 문자열
*/
SELECT EMP_ID || EMP_NAME || SALARY "연결됨"
FROM EMPLOYEE;

-- XX번 XXX의 월급은 XXXX원입니다. 형식으로 출력
SELECT EMP_ID || '번 ' ||EMP_NAME || '의 월급은 ' ||SALARY || '원 입니다' AS "급여정보"
FROM EMPLOYEE;

/*
 연산자 우선순위 
 0. 소괄호() : 우선순위를 높여주는 역할
 1. 산술연산자(*+-/) : 수학 산술연산을 해줌
 2. 연결연산자(||): 컬럼과 리터럴 또는 컬럼과 컬럼을 연결
 3. 비교연산자(>,<,>=,<=) : 대소비교 또는 동등비교를 해줌
 {
 4. IS NULL, NOT NULL : NULL인지 아닌지를 판별
 5. LIKE(%,_) : 패턴을 제시해서 패턴에 부합하는지 판별
 6. IN : 제시한 목록 중 하나라도 일치하는지를 판별(동등비교 + OR) 
 } => 4,5,6번은 우선순위가 같음.
 7. BETWEEN AND : 특정 범위에 해당되는지 체크(하한값<= 비교대상 <= 상한값)
 8. NOT : 조건을 반전시키는 역할.
 9. AND : 조건을 "그리고" 라는 키워드로 연결
 10. OR : 조건을 "또는"이라는 키워드로 연결
*/
------------------------------------------------------------------
/*
 ORDER BY 절
 SELECT문 가장 마지막에 기입하는 구문 
 뿐만 아니라, 실행 순서 또한 가장 마지막임.
 조회된 데이터를 기준으로 정렬을 해주는 역할(정렬기준 + 오름차순/ 내림차순 )
 
 [표현법]
 SELECT 조회할컬럼명 
 FROM 테이블명
 WHERE 조건
 ORDER BY 정렬기준으로세우고자하는컬럼명/별칭/컬럼순번 [ASC/DESC] [NULLS FIRST/NULLS LAST];
  - ASC : 오름차순(생략시 기본값)
  - DESC : 내림차순
  - NULL FIRST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우, 해당 NULL값들을 앞으로 배치하고 정렬
    (내림차순 정렬 시, 기본값임)
  - NULL LAST : 정렬하고자 하는 컬럼값에 NULL이 있을 경우, 해당 NULL값들을 뒤로 배치하고 정렬
    (오름차순 정렬 시, 기본값임)
=> WHERE절과 ORDER BY절은 생략 가능함.
*/

-- 모든 사원들의 컬럼을 조회(단, 연봉이 가장 높은 순서대로 나열)
SELECT * 
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- ORDER BY절을 생략하면, 기본키를 기준으로 오름차순으로 정렬됨.

-- 모든 사원들의 컬럼을 조회(단, 이름 가나다순)
SELECT * 
FROM EMPLOYEE
ORDER BY EMP_NAME ASC;

SELECT *
FROM EMPLOYEE
/*ORDER BY BONUS */ -- ASC 또는 DESC를 생략 시, 기본값이 ASC임(오름차순)
/*ORDER BY BONUS ASC*/ -- 결과를 봤을 때, ASC는 기본적으로 NULL값들이 밑에 깔려있음(NULLS LAST)
/*ORDER BY BONUS ASC NULLS FIRST;*/ -- 오름차순이어도 NULLS FIRST 설정 가능

/*ORDER BY BONUS DESC*/-- 결과를 봤을 때, DESC는 기본적으로 NULL값들이 위에 있음(NULLS FIRST)
/*ORDER BY BONUS DESC NULLS LAST;*/ -- 내림차순이어도 NULLS LAST 설정 가능

ORDER BY BONUS DESC, SALARY ASC;
-- 첫번째로 제시한 정렬기준의 컬럼값이 일치할 경우, 두번째 정렬기준을 가지고 다시 정렬

-- 연봉 순서대로 줄세우기(이름, 월급, 연봉 컬럼 출력)
SELECT EMP_NAME, SALARY, SALARY*12 "연봉"
FROM EMPLOYEE
--ORDER BY SALARY*12 DESC;
--ORDER BY "연봉" DESC;
ORDER BY 3 DESC; -- SELECT절에 제시한 컬럼 순서(1부터 시작)




