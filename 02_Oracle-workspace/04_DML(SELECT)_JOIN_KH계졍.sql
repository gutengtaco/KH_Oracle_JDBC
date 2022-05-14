/*
 <JOIN>
 두개 이상의 테이블에서 데이터를 같이 조회하고자 할 때 사용되는 구문
 조회결과는 하나의 결과물(Result set)로 나옴
 
 관계형 데이터베이스에서는 최소한의 데이터로 각각의 테이블에 데이터를 보관하고 있음.
 그 이유는, 중복을 최소화하기 위해서 최대한 쪼개서 보관함.
 => 즉, 하나의 테이블에서 모든 데이터를 관리하는 것 보다(중복의 가능성이 존재함)
 => 최대한 테이블 쪼갠 후, JOIN구문을 이용해서 여러개의 테이블간 "관계"를 맺어서 같이 조회하는 것이 효율적임.
 => 테이블 간에 "연결고리"에 해당하는 컬럼을 매칭시켜서 조회해야 함.
 
 JOIN은 크게 "오라클 전용 구문"과 "ANSI(미국국립표준협회) 구문"으로 나뉨.
 => 용어만 다를 뿐, 개념은 똑같음.
 
 
        오라클 전용 구문                           ANSI (오라클, 다른DBMS)구문
 ===============================================================================
        등가조인(EQUAL JOIN)                     내부조인(INNER JOIN) -> JOIN USING / ON  
                                               외부조인(OUTER JOIN) -> JOIN USING
 -------------------------------------------------------------------------------
        포괄조인                                 왼쪽 외부조인(LEFT OUTER JOIN)  
        (LEFT OUTER JOIN)                      오른쪽 외부조인(RIGHT OUTER JOIN)  
        (RIGHT OUTER JOIN)                     전체 외부조인(FULL OUTER JOIN)
 -------------------------------------------------------------------------------    
        카테시안 곱(CARTESIAN PRODUCT)          교차 조인(CROSS JOIN)
 -------------------------------------------------------------------------------
        자체조인(SELF JOIN)                      JOIN ON 구문을 이용
        비등가조인(NON EQUAL JOIN)
 ===============================================================================       
*/

-- 전체 사원들의 사번, 사원명, 부서코드, 부서명까지 알아내고자 한다면?
-- 부서명은 DEPARTMENT테이블에 존재함.
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE; -- EMPLOYEE테이블의 DEPT_CODE 컬럼

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT; -- DEPARTMENT테이블의 DEPT_ID 컬럼을 조인


-- 전체 사원들의 사번, 사원명, 직급코드, 직급명을 알아내고자 한다면?
-- 직급명은 JOB테이블에 존재함
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE; -- EMPLOYEE 테이블의 JOB_CODE컬럼

SELECT JOB_CODE, JOB_NAME
FROM JOB; -- JOB테이블의 JOB_CODE컬럼을 조인

-------------------------------------------------------------------------------
/*
 1. 등가조인(EQUAL JOIN,오라클) / 내부조인(INNER JOIN,ANSI)
 연결시키는 컬럼의 값이 일치하는 행들만 조인해서 조회
 일치하지 않는 값들은 조회에서 제외
*/


-->> 오라클 전용 구문
-- FROM절에 조회하고자 하는 테이블명들을 나열함
-- WHERE절에 매칭시킬 컬럼명(연결고리)에 대한 조건을 제시함.

-- 전체 사원들의 사번, 사원명, 부서코드, 부서명을 같이 조회
-- 1) 연결할 두 컬럼명이 다른 경우 ( EMPLOYEE테이블의 DEPT_CODE == DEPARTMENT테이블의 DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; 
-- EMPLOYEE테이블의 사원수는 23명이지만, 결과는 21명만 출력됨.
-- EMPLOYEE테이블의 DEPT_CODE가 NULL인 사람이 2명이 존재함.
-- DEPT_CODE와 DEPT_ID가 일치하지 않는 값(NULL)은 조회에서 제외됨.
-- 이는 DEPT_ID컬럼에 NULL이 존재하지 않기 때문에
-- 추가적으로 EMPLOYEE테이블의 DEPT_CODE에 D3,D4,D7에 해당되는 사원들이 존재하지 않기 때문에
-- DEPARTMENT테이블의 DEPT_ID가 D3,D4,D7에 해당하는 DEPT_TITLE을 출력하지 않음.

-- 전체 사원들의 사번, 사원명, 직급코드, 직급명을 같이 조회
-- 2) 연결할 두 컬럼명이 같은 경우(EMPLOYEE테이블의 JOB_CODE == DEPARTMENT테이블의 JOB_CODE)
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
*/
-- [오류메세지] "column ambiguously defined" => 컬럼을 애매모호하게 정의함.
-- 컬럼마다 어느 테이블에 왔는지를 명시해주어야 함.

-- 방법 1. 테이블명을 명시해주는 방법
-- 테이블명.컬럼명
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- 부서와는 다르게 직급은 모두 존재하기 때문에, J1~J7의 모든 컬럼값이 출력됨.

-- 방법2. 테이블에 별칭을 붙여 그 별칭을 명시해주는 방법
-- 테이블별칭.컬럼명
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J -- 테이블명 별칭
WHERE E.JOB_CODE = J.JOB_CODE;
--FROM절이 WHERE, SELECT절보다 우선하기 때문에, WHERE, SELECT절에도 별칭으로 작성함.



-->> ANSI구문
-- FROM절에 테이블명은 단 하나만 작성(기준 테이블을 정해서 작성)
-- FROM절 뒤에 JOIN절을 작성하여 같이 조회하고자 하는 테이블명을 기술
-- 또한, 매칭시킬 컬럼(연결고리)에 대한 조건도 같이 기술
-- JOIN절에는 ON구문 또는 USING구문으로 연결고리에 대한 조건을 기술함.

-- 사번, 사원명, 부서코드, 부서명
-- 1) 연결할 두 컬럼명이 다를 경우(EMPLOYEE테이블의 DEPT_CODE == DEPARTMENT테이블의 DEPT_ID)
-- => 두 컬럼명이 다른 경우, 무조건 ON 구문만 사용 가능
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE  -- 기준테이블
/*INNER*/JOIN DEPARTMENT  -- JOIN하고자 하는 테이블, INNER는 생략 가능
ON (DEPT_CODE = DEPT_ID); -- 연결고리에 대한 조건

-- 사번, 사원명, 직급코드, 직급명
-- 2) 연결할 두 컬럼명이 같은 경우(EMPLOYEE테이블의 JOB_CODE == DEPARTMENT테이블의 JOB_CODE)
-- => 두 컬럼명이 같은 경우, ON구문 USING구문 둘다 사용 가능
-- 2-1. ON구문 버전 
SELECT EMP_ID, EMP_NAME, EMPLOYEE/*E*/.JOB_CODE, JOB_NAME -- AMBIGUOUSLY 오류 발생 가능
FROM EMPLOYEE /*E*/ 
JOIN JOB /*J*/
ON (EMPLOYEE /*E*/.JOB_CODE = JOB /*J*/.JOB_CODE); -- AMBIGUOUSLY 오류 발생 가능
-- 정확하게 테이블명(별칭)을 명시해줌

-- 2-2. USING구문 버전 : 컬럼명만 제시하는 구조
-- 애초에 컬럼명이 동일한 경우에만 사용 가능
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB
USING (JOB_CODE); -- 동일한 컬럼명만 USING구문에 써주면 AMBIGUOUSLY가 발생하지 않음.

-- [참고] 위의 USING구문버전의 예시는 NATURAL JOIN(자연조인)이라는 구문으로도 표현 가능
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB; 
-- 두개의 테이블명만 제시한 상태
-- 운좋게도 두개의 테이블에 일치하는 컬럼명이 유일하게 한개 존재하는 경우(JOB_CODE)
-- 알아서 매칭됨.

-- 추가적인 조건을 제시 가능
-- 직급이 대리인 사원들의 정보를 조회
--> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE -- 조인이 일어날 경우, 필수적인 조건
     AND JOB_NAME ='대리';
-- 협업시에 가독성을 높이기 위해, 조건 하나당 개행 + 들여쓰기를 해줌.

--> ANSI 구문
-- 자체적으로 JOIN절에 ON, USING구문을 첨가하여
-- WHERE절의 길이기 짧아짐
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E
-- /*INNER*/JOIN JOB USING (JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME='대리';

----------실습문제------------
-- 1. 부서가 '인사관리부'인 사원들의 사번, 사원명, 보너스를 조회
SELECT *
FROM DEPARTMENT;
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
-- 부서가 '인사관리부'인 사원 : 방명수, 차태연, 전지연

--> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
  AND DEPT_TITLE = '인사관리부'; 
--> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID)
WHERE DEPT_TITLE = '인사관리부';

-- 2. 부서가 '총무부'가 아닌 사원들의 사원명, 급여, 입사일을 조회
SELECT *
FROM DEPARTMENT;
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
-- 총무부인 사람 : 선동일, 송중기, 노옹철
-- 부서가 없는 사람 : 하동운, 이오리

--> 오라클 전용 구문
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
    AND DEPARTMENT.DEPT_TITLE != '총무부'; 
    -- 결과 : 18명
--> ANSI구문
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
WHERE DEPARTMENT.DEPT_TITLE != '총무부';

-- 3. 보너스를 받는 사원들의 사번, 사원명, 보너스, 부서명 조회
SELECT EMP_NAME, BONUS
FROM EMPLOYEE;
SELECT DEPT_CODE
FROM EMPLOYEE; 
-- 부서가 없는 사람 조회 : 하동운, 이오리
-- 보너스를 받는 사람 조회 : 선동일, 유재식, 하이유, 심봉선, 장쯔위,(하동운), 차태연, 전지연, 이태림

--> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
    AND EMPLOYEE.BONUS IS NOT NULL; 
    -- 결과 : 8명
    
--> ANSI구문
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID)
WHERE EMPLOYEE.BONUS IS NOT NULL;

-- 4. 아래의 두 테이블을 참고해서 부서코드, 부서명, 지역코드, 지역명(LOCAL_NAME)을 조회
SELECT *
FROM DEPARTMENT;
SELECT *
FROM LOCATION;

--> 오라클 전용 구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE;
--> ANSI구문
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT 
JOIN LOCATION ON(DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE);

-- 다중조인 : 테이블을 3개 이상을 조인함.
-- 사번, 사원명, 부서명, 직급명
SELECT * FROM EMPLOYEE;     -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID
SELECT * FROM JOB;          --            JOB_CODE

--> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE;
--> ANSI구문
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

-- 등가조인 / 내부조인 : 일치하지 않는 행은 애초에 조회가 되지 않음.
-- 예시 : EMPLOYEE테이블에서 DEPT_CODE가 NULL인 하동운, 이오리사원은 제외하고 조회가 됨.
-- => 해당 부서에 소속 사원이 없는 경우는 조인 결과에서 확인이 불가함.

-----------------------------------------------------------------------------
/*
 2. 포괄조인 / 외부조인(OUTER JOIN)
 테이블간의 JOIN시 일치하지 않는 행들도 포함시켜서 조회 가능
 단, LEFT/RIGHT를 지정해야 함(기준이 LEFT/ RIGHT인지를 지정하라는 뜻)
*/

-- "전체" 사원들의 사원명, 급여, 부서명 조회
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- DEPT_CODE가 NULL인 사원의 경우(NULL)
-- 배정된 부서가 없는 사원의 경우(D3,D4,D7), 결과에서 제외됨.

-- 1) LEFT OUTER JOIN : 두 테이블 중 왼편에 기술된 테이블을 기준으로 JOIN
--                      즉, 뭐가 되었든 간에, 왼편에 기술된 기준 테이블의 데이터는 무조건 조회함.
--                      (일치하지 않으면 NULL로 대체하여 출력)
-->> ANSI구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE /*기준테이블 (왼쪽)*/ LEFT OUTER JOIN DEPARTMENT 
ON (DEPT_CODE = DEPT_ID);
-- EMPLOYEE테이블을 기준으로 조회를 했기 때문에, 
-- EMPLOYEE테이블에 존재하는 데이터는 뭐가 되었든 간에 한번씩 다 조회되게끔 함.

-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID(+); -- 연결고리에 대한 조건
-- (+) : 왼쪽 포괄조인 
-- 내가 기준으로 삼을 테이블의 컬럼명이 아닌, 반대 테이블의 컬럼명 뒤에 (+)기호를 붙임.

-- 2) RIGHT OUTER JOIN : 두 테이블 중 오른편에 기술된 테이블을 기준으로 JOIN
--                       즉, 뭐가 되었든 간에 오른편에 기술된 기준 테이블의 데이터는 무조건 조회
--                       (일치하지 않으면 NULL로 대체하여 출력)
-->> ANSI 구문
SELECT EMP_NAME, SALARY,DEPT_ID, DEPT_TITLE
FROM EMPLOYEE RIGHT OUTER JOIN DEPARTMENT/*기준테이블(오른쪽)*/
ON (DEPT_CODE = DEPT_ID); 
-- 21번까지는 등가/내부조인 결과임
-- 22, 23, 24번은 DEPARTMENT테이블을 기준으로 D3,D4,D7에 대한 정보가 추가됨.

-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; -- 연결고리에 대한 조건

-- LEFT / RIGHT OUTER JOIN은 
-- 기본적으로 등가/내부조인의 결과 + 기준테이블에서 누락된 정보의 개수까지 보여줌

-- 3) FULL OUTER JOIN : 두 테이블이 가진 모든 행을 조회할 수 있게 JOIN
--                      단, 오라클 전용 구문에서는 불가
-->> ANSI 구문
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- 기본적으로 등가 / 내부조인의 결과 + 왼쪽테이블에서 누락된 정보 + 오른쪽테이블에서 누락된 정보
-- 하동운, 이오리의 정보(LEFT) + D3, D4, D7의 정보(RIGHT)

/*
-->> 오라클 전용 구문
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);
-- [오류] : "a predicate may reference only one outer-joined table"
-- 포괄조인시, 기준이 되는 테이블이 하나만 있어야 함.
-- => FULL OUTER JOIN에서는 오라클 전용 구문이 불가함
*/
--------------------------------------------------------------------------------

/*
 3. 카테시안 곱(CARTESIAN PRODUCT) / 교차조인 (CROSS JOIN)
 모든 테이블의 각 행들이 서로 맵핑된 결과가 조회됨(모든 경우의 수를 다 찍겠다. 곱집합)
 두 테이블의 행들이 모두 곱해진 행들의 조합이 다 출력( 방대함, 과부하)
 
 예) EMPLOYEE 테이블의 총 23개의 행 / DEPARTMENT 테이블 총 9개의 행
 23 * 7 = 207개의 행이 결과로 나옴
*/

-- 사원명, 부서명
-->> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;
-- 카테시안 곱은 주로 WHERE절에 연결고리의 조건을 실수로 누락했을 경우 주로 발생
-- (연결고리에 대한 조건을 누락한 것은, 모든 경우의 수를 다 찍겠다는 것)

-->> ANSI구문
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT; 
--------------------------------------------------------------------------------

/*
 4. 비등가조인 (NON EQUAL JOIN)
 '='(등호, 동등비교연산자)이 없는 경우, 등호를 사용하지 않는 JOIN
 지정한 컬럼값이 일치하는 경우가 아니라, "범위"에 포함되는 경우는 모두 조회함.
*/
-- 사원명, 급여
SELECT *
FROM EMPLOYEE;

SELECT * 
FROM SAL_GRADE;

-- 사원명, 급여, 급여등급(SAL_LEVEL)
--> 오라클 전용 구문
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL, MIN_SAL, MAX_SAL
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL-- 연결고리에 대한 조건 지정
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

--> ANSI 구문
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL, MIN_SAL, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
-- 비등가조인 : 주로 연결고리에 대한 조건식으로 >, <, >=, <=, BETWEEN AND가 들어감
-- 등호를 쓰지 않기 때문에 ON구문만을 사용함.

--------------------------------------------------------------------------------

/*
 5. 자체조인(SELF JOIN)
 같은 테이블끼리 다시 한번 조인하는 경우
 즉, 자기자신의 테이블과 다시 조인을 하는 경우
*/

SELECT EMP_ID "사번", EMP_NAME "사원명", SALARY "급여", MANAGER_ID "사수의 사번"
FROM EMPLOYEE;

-- 주의사항 : 테이블명이 동일함 => 애매모호함!!
--          항상 테이블명에 별칭을 다르게 부여한 다음에 진행
SELECT * FROM EMPLOYEE E; -- 사원에 대한 정보를 조회할 때는 E라는 테이블
SELECT * FROM EMPLOYEE M; -- 사수에 대한 정보를 조회할 때는 M이라는 테이블

-- 사원의 사번, 사원명, 부서코드, 급여(E)
-- 사수의 사번, 사수명, 부서코드, 급여(M)
-->> 오라클 전용 구문
SELECT E.EMP_ID "사원의 사번", E.EMP_NAME "사원의 사원명", E.DEPT_CODE "사원의 부서코드", E.SALARY "사원의 급여",
M.EMP_ID "사수의 사번", M.EMP_NAME "사수의 사원명", M.DEPT_CODE "사수의 부서코드", M.SALARY "사수의 급여"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-->> ANSI구문      
SELECT E.EMP_ID "사원의 사번", E.EMP_NAME "사원의 사원명", E.DEPT_CODE "사원의 부서코드", E.SALARY "사원의 급여",
M.EMP_ID "사수의 사번", M.EMP_NAME "사수의 사원명", M.DEPT_CODE "사수의 부서코드", M.SALARY "사수의 급여"
FROM EMPLOYEE E
LEFT /*OUTER*/ JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- 사원의 사번, 사원명, 부서코드, 급여, 부서명(E)
-- 사수의 사번, 사수명, 부서코드, 급여, 부서명(M)
SELECT E.EMP_ID "사원의 사번", E.EMP_NAME "사원의 사원명", E.DEPT_CODE "사원의 부서코드",D1.DEPT_TITLE "사원의 부서명", E.SALARY "사원의 급여",
       M.EMP_ID "사수의 사번", M.EMP_NAME "사수의 사원명", M.DEPT_CODE "사수의 부서코드",D2.DEPT_TITLE "사수의 부서명", M.SALARY "사수의 급여"
FROM EMPLOYEE E -- 기준점
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID) -- 연결고리를 수행할 조건
LEFT JOIN DEPARTMENT D1 ON(E.DEPT_CODE = D1.DEPT_ID) -- 사원 : EMPLOYEE E(왼쪽)와 DEPARTMENT를 외부조인
LEFT JOIN DEPARTMENT D2 ON(M.DEPT_CODE = D2.DEPT_ID); -- 사수 : EMPLOYEE M(왼쪽)과 DEPARTMENT를 외부조인

----------------------------------------------------------------------------------------------------------------------------

/*
 < 다중 조인 >
 3개 이상의 테이블을 조인
*/
SELECT * FROM EMPLOYEE;     -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID              LOCATION_ID
SELECT * FROM JOB;          --            JOB_CODE
SELECT * FROM LOCATION;     --                      LOCAL_CODE

-- 사번, 사원명, 부서명, 직급명, 지역명(LOCAL_NAME)
--> 오라클 전용 구문
SELECT EMP_ID "사번", EMP_NAME "사원명", DEPT_TITLE "부서명", JOB_NAME "직급명", LOCAL_NAME "근무지역명"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+);
-- 모두 포괄조인을 하지 않으면 21명
-- 모두 포괄조인을 하면 23명 
-- 현재 2명의 인원이 부서가 없는 NULL상태이기 때문에
-- 부서의 영향을 받는 DEPARTMENT테이블의 부서명과 LOCATION테이블 근무지역명에 등가조인을 하게 되면
-- 조건이 모두 AND연산자로 묶여있기 때문에, NULL을 제외하게 되어 21명이라는 결과가 나옴
-- 따라서, 포괄조인으로 묶어주어야만 23명 모두의 결과가 도출됨.

--> ANSI 구문
SELECT EMP_ID "사번", EMP_NAME "사원명", DEPT_TITLE "부서명", JOB_NAME "직급명", LOCAL_NAME "근무지역명"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
/*LEFT*/JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE) -- USING(JOB_CODE) : 포괄조인에서도 USING가능
                                               -- 모든 사원이 직급을 가지고 있기 때문에, 외부조인을 할 필요는 없음.
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

SELECT EMP_ID "사번", EMP_NAME "사원명", DEPT_TITLE "부서명", JOB_NAME "직급명", LOCAL_NAME "근무지역명"
FROM EMPLOYEE E
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
-- LOCATION과 DEPARTMENT의 순서를 바꾸면 오류가 남
-- LOCATION은 DEPARTMENT와 조인이 된 것이기 때문에, 
-- 순서를 바꾸면 안됨.
-- ANSI구문으로 다중조인을 작성할 경우에는 JOIN의 순서가 중요함.

SELECT * FROM EMPLOYEE;     -- DEPT_CODE  JOB_CODE                            SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID              LOCATION_ID
SELECT * FROM JOB;          --            JOB_CODE
SELECT * FROM LOCATION;     --                      LOCAL_CODE  NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                  NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                MIN_SAL / MAX_SAL

--> ANSI구문
-- 사번, 사원, 부서명, 직급명, 근무지역명, 근무국가명, 급여등급(SAL_GRADE테이블)
SELECT 
E.EMP_ID "사번", 
E.EMP_NAME "사원", 
D.DEPT_TITLE "부서명", 
J.JOB_NAME "직급명", 
L.LOCAL_NAME "근무지역명", 
N.NATIONAL_NAME "근무국가명", 
S.SAL_LEVEL "급여등급"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
     JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
;


---------------------- JOIN 종합 실습문제 ----------------------
SELECT * FROM EMPLOYEE;     -- DEPT_CODE  JOB_CODE                            SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID              LOCATION_ID
SELECT * FROM JOB;          --            JOB_CODE
SELECT * FROM LOCATION;     --                      LOCAL_CODE  NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                  NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                MIN_SAL / MAX_SAL

-- 1. 직급이 대리이면서 ASIA 지역에 근무하는 직원들의
--    사번, 사원명, 직급명, 부서명, 근무지역명, 급여를 조회하시오
-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY 
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND JOB_NAME = '대리' 
  AND LOCAL_NAME LIKE 'ASIA%'
;

-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY 
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE JOB_NAME = '대리'
  AND LOCAL_NAME LIKE 'ASIA%';

-- 2. 70년대생이면서 여자이고, 성이 전씨인 직원들의
--   사원명, 주민번호, 부서명, 직급명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND SUBSTR(EMP_NO,1,1) ='7'
AND SUBSTR(EMP_NO,8,1) ='2'
AND EMP_NAME LIKE '전%'
;
-->> ANSI 구문
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE SUBSTR(EMP_NO,8,1) ='2'
AND SUBSTR(EMP_NO,1,1) ='7'
AND EMP_NAME LIKE '전%'
;

-- 3. 이름에 '형'자가 들어있는 직원들의 
--    사번, 사원명, 직급명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND EMP_NAME LIKE '%형%';
;
-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%형%'
;

-- 4. 해외영업팀에 근무하는 직원들의
--    사원명, 직급명, 부서코드, 부서명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND DEPT_TITLE LIKE '해외영업%'
;
-->> ANSI 구문
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE LIKE '해외영업%'
;

-- 5. 보너스를 받는 직원들의
--    사원명, 보너스, 연봉, 부서명, 근무지역명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME, BONUS
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, SALARY*12, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND BONUS IS NOT NULL
;
-->> ANSI 구문
SELECT EMP_NAME, BONUS, SALARY*12, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON( E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L  ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. 부서가 있는 직원들의
--    사원명, 직급명, 부서명, 근무지역명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND E.DEPT_CODE IS NOT NULL;
-->> ANSI 구문
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE E.DEPT_CODE IS NOT NULL;

-- 7. '한국' 과 '일본' 에 근무하는 직원들의
--    사원명, 부서명, 근무지역명, 근무국가명을 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND L.NATIONAL_CODE = N.NATIONAL_CODE
  AND (NATIONAL_NAME = '한국' OR NATIONAL_NAME ='일본')
  ;
-->> ANSI 구문
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE NATIONAL_NAME = '한국' OR NATIONAL_NAME ='일본';

-- 8. 보너스를 받지 않는 직원들 중 직급코드가 J4 또는 J7 인 직원들의
--    사원명, 직급명, 급여를 조회하시오
-->> 오라클 전용 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
  AND BONUS IS NULL
  AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');
-->> ANSI 구문
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE BONUS IS NULL
AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');

-- 9. 사번, 사원명, 직급명, 급여등급, 구분을 조회하는데
--    이 때, 구분에 해당하는 값은
--    급여등급이 S1, S2 인 경우 '고급'
--    급여등급이 S3, S24 인 경우 '중급'
--    급여등급이 S5, S6 인 경우 '초급' 으로 조회되게 하시오
-->> 오라클 전용 구문
SELECT *
FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, JOB_NAME, SAL_LEVEL "급여등급", 
CASE WHEN SAL_LEVEL='S1' OR SAL_LEVEL= 'S2' THEN '고급'
     WHEN SAL_LEVEL='S3' OR SAL_LEVEL= 'S4' THEN '중급'
     ELSE '초급'
     END "구분"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-->> ANSI 구문
SELECT EMP_ID, EMP_NAME, JOB_NAME, SAL_LEVEL "급여등급", 
CASE WHEN SAL_LEVEL='S1' OR SAL_LEVEL= 'S2' THEN '고급'
     WHEN SAL_LEVEL='S3' OR SAL_LEVEL= 'S4' THEN '중급'
     ELSE '초급'
     END "구분"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- 10. 각 부서별 총 급여합을 조회하되
--     이 때, 총 급여합이 1000만원 이상인 부서명, 급여합을 조회하시오
-->> 오라클 전용 구문
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;
-->> ANSI 구문
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- 11. 각 부서별 평균급여를 조회하여 부서명, 평균급여 (정수처리) 로 조회하시오
--     단, 부서배치가 안된 사원들의 평균도 같이 나오게끔 하시오
--> 오라클 전용 구문
SELECT DEPT_TITLE, ROUND(AVG(SALARY))
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE;

-->> ANSI 구문
SELECT DEPT_TITLE, ROUND(AVG(SALARY))
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE;