/*
 <GROUP BY절>
 그룹을 묶어줄 기준을 제시할 수 있는 구문
 => 해당 제시된 기준별로 그룹을 묶을 수 있음
 
 여러개의 컬럼값들을 하나의 그룹으로 묶어서 처리할 목적으로 사용
*/

-- 전체 사원의 총 급여합
SELECT SUM(SALARY)
FROM EMPLOYEE;
-- 현재 조회된 전체 사원들을 하나로 묶어서 총 합을 구한 결과

-- 각 부서별 총 급여합
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- SELECT절의 결과값이 각각 23개, 1개의 결과가 나와서 오류가 뜸.
-- DEPT_CODE를 기준으로 하여 GROUP BY절로 제시하여
-- 제시된 DEPT_CODE에 따른 각 부서별 총 급여합을 반환할 수 있음.

-- 전체사원수
SELECT COUNT(*)
FROM EMPLOYEE;

-- 각 부서별 사원수
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 각 부서별 총 급여합을 부서별로 오름차순해서 보여줌
-- 실행순서 : FROM > GROUP BY > SELECT > ORDER BY
SELECT DEPT_CODE, SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC NULLS FIRST;

-- 각 직급별 직급코드, 총 급여의 합, 사원 수, 보너스를 받는 사원의 수, 사수가 있는 사원의 수 조회
SELECT JOB_CODE, SUM(SALARY) "급여 합", COUNT(*)"사원수", COUNT(BONUS)"보너스 받는 사원 수", COUNT(MANAGER_ID) "사수가 있는 사원 수"
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- 각 부서별 부서코드, 사원 수,총급여합, 평균급여, 최고급여, 최소급여
SELECT 
        DEPT_CODE"부서코드", 
        COUNT(*)"사원 수",
        SUM(SALARY)"총급여합", 
        ROUND(AVG(SALARY))"평균급여", 
        MAX(SALARY)"최고급여", 
        MIN(SALARY)"최소급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- 성별 별 사원수
SELECT SUBSTR(EMP_NO, 8, 1) "성별", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);
-- GROUP BY "성별";
-- 실행순서가 GROUP BY가 SELECT절보다 우선하기 때문에 사용불가
-- 함수식이나 연산식은 사용 가능
SELECT DECODE(SUBSTR(EMP_NO, 8, 1),'1','남','2','여')"성별", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);
----------------------------------------------------------------------------------

/*
 < HAVING 절>
 "그룹함수"에 대한 조건을 제시하고자 할 때 사용하는 구문
 (주로 그룹함수를 가지고 조건을 제시함)
*/
-- 각 부서별 평균 급여가 300만원 이상인 부서들만 조회
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
-- WHERE AVG(SALARY) >= 3000000
-- [오류] 그룹함수인 AVG()에는 WHERE이 아닌 HAVING을 사용해줌
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY))>=3000000;
-- 그룹함수인 AVG()를 사용했기에 HAVING절을 사용함!

-- 각 직급별 총 급여 합이 1000만원 이상인 직급코드, 급여 합을 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- 각 부서별 보너스를 받는 사원이 한명도 없는 부서만을 조회
--(BONUS컬럼을 기준으로 명수를 셌을 때, 0이 나와야 함.)
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

------------------------------------------------------------------------------
/*
 <실행 순서>
 각 절의 작성 순서대로 필기
 5. SELECT * / 조회하고자하는컬럼명 / 리터럴 / 산술연산식 / 함수식 AS "별칭"
 1. FROM 조회하고자하는테이블명 / DUAL(가상테이블)
 2. WHERE 조건식(주의사항 : 조건식에 그룹함수는 포함하면 안됨)
 3. GROUP BY 그룹기준에맞는컬럼명 / 함수식
 4. HAVING 그룹함수식을포함한조건식
 6. ORDER BY 정렬기준에맞는컬럼명 / 별칭 / 순번 [ASC/DESC] [NULLS FIRST/ NULLS LAST]
*/
------------------------------------------------------------------------------
/*
 <집합 연산자 SET OPERATOR>
 여러 개의 쿼리문을 가지고, 하나의 쿼리문으로 만드는 연산자 
 수학에서 사용하는 집합의 개념과 같음.
 - UNION : 합집합(두 쿼리문을 수행한 결과값을 모두 더한 후, 중복된 부분은 한번 뺀 개념) => OR
 - INTERSECT : 교집합(두 쿼리문을 수행한 결과값의 중복된 결과값 부분) => AND
 - UNION ALL : 합집합 결과에 교집합이 더해진 개념 (두 쿼리문을 합치고 중복제거를 하지 않음)
 - MINUS : 차집합(선행 쿼리문 결과값 - 후행 쿼리문 결과값의 결과)
 특이사항 : UNION보다 UNION ALL이 속도가 더 빠름
 주의사항 : 항상 SELECT절이 동일해야 함.
*/

-- 1. UNION(합집합)
-- 두 쿼리문을 수행한 결과값을 더하지만, 중복된 결과는 한번만 조회

-- 부서코드가 D5이거나 급여가 300만원 초과인 사원들을 조회
-- 사번, 사원명, 부서코드, 급여

-- 부서코드가 D5인 사원들만 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'; -- 6명 조회

-- 급여가 300만원 초과인 사원들을 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8명 조회

-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원
-- 두 쿼리문의 SELECT절이 같아야 함.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 12명 조회(두 쿼리문을 더하고, 중복을 한번만)
                        -- 12 : 6+8-2(중복)

-- 부서코드가 D5인 사원 또는 급여가 300만원 초과인 사원들을 조회
-- 사원, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >3000000;
-- OR연산자로 두개의 조건을 엮어서 조회하면 결과는 같음.

-- 2. UNION ALL 
-- 두 쿼리문을 수행한 결과값을 더하지만, 중복된 결과를 두번 조회함.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 14명 조회(두 쿼리문을 더하고, 중복을 두번)
-- 중복되는 심봉선과 대북혼이 2번씩 나와 14명이 된 것을 볼 수 있음.

-- 3. INTERSECT(교집합)
-- 여러 쿼리 결과의 중복된 결과만을 조회

-- 부서코드가 D5이면서 급여가 300만원 초과인 사원들을 조회
-- 사번, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 2명(두 쿼리문에서 중복된 값을 출력)

-- 아래의 방법도 가능함
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' AND SALARY > 3000000;

-- 4. MINUS(차집합)
-- 선행쿼리문의 결과값에서 후행쿼리문의 결과값을 쳐냄
-- 부서코드가 D5인 사원 중에서 급여가 300만원 초과인 사람들을 제외하고 조회
-- 사번, 사원명, 부서코드, 급여

-- 부서코드가 D5인 사람들(선행쿼리)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'  -- 6명
MINUS
-- 급여가 300만원 초과인 사람들(후행쿼리)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8명
-- 결과 : 4명 (심봉선, 대북혼을 제외)
-- (선행쿼리 6명 중에서 후행쿼리에 동일하게 존재하는 2명을 제외하고 출력함)

-- 선행, 후행을 바꿔서 테스트
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 -- 8명
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6명
-- 결과 : 6명(심봉선, 대북혼을 제외)
-- 선행쿼리 8명 중에서 후행쿼리에 동일하게 존재하는 2명을 제외하고 출력함.

-- 아래처럼도 가능
-- 부서코드가 D5인 사원들 중에서 급여가 300만원 초과인 사람들을 제외해서 조회
-- =>                             300만원 이하인
-- 사번, 사원명, 부서코드, 급여
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <=3000000;

