---1. EMPLOYEE 테이블에서 12월 생일자에게 축하 메세지 보내기
--결과: OOO님 12월 OO일 생일을 축하합니다! 
SELECT *
FROM EMPLOYEE;

SELECT EMP_NAME||'님 12월'||SUBSTR(EMP_NO,5,2)||'일 생일을 축하합니다!' "축하메세지"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,3,2) = 12;

--2. EMP 테이블의 부서코드와 DEPT 테이블을 조인하여 각 부서별 근무지 위치를 조회
--사원명, 부서코드, 부서명, 근무지 위치 출력
SELECT *
FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

--3. EMPLOYEE 테이블에서 월급 200만원 이상 300만원 이하인 사원의 
--사번, 사원명, 입사일, 부서코드, 연봉 조회 (단, 연봉은 BONUS 적용 및 \999,999,999로 조회)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE, SALARY,
TO_CHAR((SALARY+(SALARY*BONUS)*12),'999,999,999')
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;

--4. EMPLOYEE 테이블을 통해 PHONE 번호가 011으로 시작하는 사원의
--이름, 사번, PHONE, 부서코드를 조회
SELECT EMP_NAME, EMP_ID, PHONE, DEPT_CODE
FROM EMPLOYEE
WHERE SUBSTR(PHONE,1,3) = '011';

--5. 80년대생인 남자 직원들 중 성이 '김'씨인 사람의 주민번호, 직원명 조회
--단, 주민번호는 [888888-2******] 형태로 조회 및 직원명으로 오름차순 정렬
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE
WHERE EMP_NAME LIKE '김%' AND SUBSTR(EMP_NO,1,2)>=80 AND SUBSTR(EMP_NO,1,2)<=89
ORDER BY EMP_NAME ASC;

--6. EMPLOYEE 테이블에서 직급코드를 중복 없이, "직급 종류" 라는 별칭을 부여하고
--"직급 종류" 오름차순으로 정렬해서 조회
SELECT DISTINCT JOB_CODE "직급 종류"
FROM EMPLOYEE
ORDER BY JOB_CODE ASC;

--7. 부서별 급여 합계가 부서 급여 총합의 10%보다 많은 부서의 부서명과, 부서급여 합계 조회
--일반 단일행 서브쿼리 방식
-- 1) 부서 급여 총합
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 70096240

-- 2) 부서별 급여 합계
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > 70096240*0.1; 

-- 3) 합치기
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)
                     FROM EMPLOYEE)*0.1;

--8. EMPLOYEE 테이블에서 부서 인원이 3명 이상인 부서의 
--부서 코드, 평균, 최고 급여, 최저 급여, 인원 수 조회 
--(단, 부서코드로 오름차순 조회 및 \999,999,999로 조회)
SELECT DEPT_CODE "부서코드", 
TO_CHAR(ROUND(AVG(SALARY)),'999,999,999')"평균급여", 
TO_CHAR(MAX(SALARY),'999,999,999')"최고급여", 
TO_CHAR(MIN(SALARY),'999,999,999')"최저급여", 
COUNT(*)"인원수"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(DEPT_CODE) >=3
ORDER BY DEPT_CODE ASC;

--9. EMPLOYEE 테이블에서 
--직원 중 '이'씨 성을 가지면서, 
--급여가 200만원 이상 250만원 이하인 
--직원의 이름과 급여를 조회하시오
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '이%' AND SALARY BETWEEN 2000000 AND 2500000;

--*10. 자신의 매니저보다 급여(SALARY)를 많이 받는 직원들의
--이름(EMP_NAME),급여(SALARY),MANAGER_ID,매니저 이름(EMP_NAME)을
--급여의 내림차순으로 조회하시오.
SELECT EMP_NAME, EMP_ID, MANAGER_ID
FROM EMPLOYEE;

SELECT E.EMP_NAME, E.SALARY, M.MANAGER_ID, M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M

;

--11. EMPLOYEE 테이블에서 부서별 그룹을 편성하여
--부서별 급여 합계, 제일 낮게 받는 부서와, 제일 높게 받는부서, 인원수를 조회
--단, 조회결과는 인원수 오름차순하여 출력하여라.
SELECT DEPT_CODE, SUM(SALARY), MAX(SALARY), MIN(SALARY), COUNT(*) 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY COUNT(*) ASC;

--12. EMPLOYEE 테이블에서 직급별
--그룹을 편성하여 직급코드, 급여평균, 급여합계, 인원 수를 조회
--단, 조회 결과는 급여평균 오름차순하여 출력, 인원수는 3명을 초과하는 직급만 조회
SELECT JOB_CODE, ROUND(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) > 3
ORDER BY ROUND(AVG(SALARY)) ASC;

--13. 2001년에 입사한 여자 직원이 있다.
--해당 직원과 같은 부서, 같은 직급에 해당하는 사원들을 조회하시오.
--사번, 사원명, 직급, 부서, 입사일
-- 1) 2001년에 입사한 여자 직원의 부서, 직급
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE 
WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2001
  AND SUBSTR(EMP_NO,8,1) = '2' ; -- D5, J7

-- 2) D5, J7에 해당하는 사원 조회
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
  AND JOB_CODE = 'J7';
 
-- 3) 합치기
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE 
                               WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2001
                               AND SUBSTR(EMP_NO,8,1) = '2')
AND EMP_NAME != '윤은해';

--14. EMPLOYEE 테이블에서 '하이유'와 같은 부서에서 일하는 사원들의 
--사원번호, 사원명, 부서코드 직급코드, 급여 조회
--직급코드 내림차순 조회
-- 1) 하이유의 부서
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '하이유'; -- D5

-- 2) D5에서 일하는 사원 조회
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 3) 합치기
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '하이유')
  AND EMP_NAME != '하이유'  
ORDER BY JOB_CODE DESC;  

-- 15.EMPLOYEE 테이블에서?입사일이?2000년?1월?1일?이전인?사원에?대해 
-- 사원의?이름, ?입사일,? 부서코드, 급여를?입사일순으로?조회하시오
-- (문제에 있는 이름대로 컬럼명을 따로 붙여주세요)
SELECT EMP_NAME "사원이름", HIRE_DATE "입사일", DEPT_CODE "부서코드", SALARY "급여"
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) < 2000
  AND EXTRACT(MONTH FROM HIRE_DATE) < 1
  AND EXTRACT(DAY FROM HIRE_DATE) < 1;

--16. EMPLOYEE 테이블에서 해외영업 부서(DEPT_TITLE) 소속인 사원들의
--이름(EMP_NAME), 직급(JOB_TITLE), 부서명(DEPT_TITLE), 근무국가(NATIONAL_CODE)를 조회하시오
--단, 오라클 조인 구문으로 작성하고 별칭을 반드시 입력
SELECT *
FROM DEPARTMENT;
SELECT *
FROM location;
SELECT *
FROM NATIONAL;

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, N.NATIONAL_CODE
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND L.NATIONAL_CODE = N.NATIONAL_CODE(+);

--17. EMPLOYEE 테이블에서
--'이태림'사원의 근속 년수를 조회하시오 (현재는 퇴사상태)
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)||'년' "근속년수" 
FROM EMPLOYEE
WHERE EMP_NAME ='이태림';

--18. 자신이 속한 직급의 평균 급여보다 많이 받는 사원의
--사원번호,직급명, 사원명,부서명, 급여정보 조회

SELECT EMP_NAME, JOB_CODE,SALARY
FROM EMPLOYEE;

-- 1) 직급의 평균 급여
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE;
-- (J2, 4850000),(J7, 2017500), (J3, 3600000), (J6, 2624373), (J5, 2820000),
-- (J1, 8000000),(J4, 2330000)
-- 2) 직급의 평균 급여보다 많이 받는 사원
SELECT EMP_ID, JOB_CODE, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
  AND SALARY  > ANY( (SELECT FLOOR(AVG(SALARY))
                   FROM EMPLOYEE
                   GROUP BY JOB_CODE))   
                ;          

--19. 부서별로 근무하는 사원의 수가 3명 이하인 경우, 사원이 적은 부서별로 오름차순 정렬 조회
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*)<=3
ORDER BY COUNT(*) ASC;

--20. EMPLOYEE 테이블에서
--직급 별로 급여평균을 조회하고 급여평균 내림차순으로 정렬하시오
--(급여평균은 TRUNC 함수 사용하여 만원단위 이하는 버림 하시오)
SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY AVG(SALARY) DESC;

-- *21. 
-- 해외영업2부(DEPT_CODE: D6)의 평균 급여보다 많이 받고, 
-- 해외영업2부에 속하지 않으며 
-- 관리자가 없는 사원의 사번(EMP_ID), 이름(EMP_NAME), 직급(JOB_NAME), 부서이름(DEPT_TITLE), 급여(SALARY)를 조회하시오.
-- 단,FROM 절에 서브쿼리 사용, JOIN은 오라클 구문 사용, 셀프 조인 
-- 1) 해외영업2부의 평균 급여
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
GROUP BY DEPT_CODE; -- 3,366,666

-- 2) 해외영업2부에 속하지 않으며, 관리자가 없는 사원의 사번
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, JOB, DEPARTMENT
WHERE ;

-- 22. EMP에서 직급이름으로 그룹을 만들고 월급이 5000이상인 그룹 찾기
-- JOB이름과, 급여 합계를 조회하시오
SELECT JOB_NAME, SUM(SALARY)
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
GROUP BY JOB_NAME;

-- *23. EMPLOYEE 테이블에서
--입사일로부터 근무년수가 가장 긴 직원 상위 6명을
--RANK()함수를 이용하여 조회하시오
--사번, 사원명, 부서명, 직급명, 입사일을 조회하시오.
SELECT EMP_ID, EMP_NAME, SALARY
RANK() OVER (ORDER BY SALARY DESC) AS RANK
FROM EMPLOYEE;

-- 24.EMPLOYEE 테이블에서 
-- 부서명 별로 급여가 가장 높은 직원들의
-- 부서명, 최대급여를 조회하시오
-- 단, 최대급여가 400만원 이하인 부서들만 조회하시오
-- (부서명은 JOIN 활용)
SELECT DEPT_TITLE, MAX(SALARY)
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+)
GROUP BY DEPT_TITLE
HAVING MAX(SALARY) <= 4000000;

-- 25. EMPLOYEE 테이블에서 부서별 최고 급여를 확인 후, 
-- 사원 중 해당 부서와 최고 급여가 일치하는 사원의
--사번(EMP_ID), 이름(EMP_NAME), 부서이름(DEPT_TITLE), 
--직급(JOB_NAME), 부서코드(DEPT_CODE), 급여(SALARY)
--급여 내림차순으로 정렬, JOIN(ANSI 구문 사용), WHERE 절에서 서브쿼리로 부서별 최고 급여 확인.

-- 1) 부서별 최고 급여
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 해당 부서와 급여가 일치하는 사원을 조회
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID(+)
  AND E.JOB_CODE = J.JOB_CODE(+)
  AND (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE); 
-- 3660000 8000000 3760000 3900000 2490000 2550000    

-- 26. '장쯔위'와 같은 연봉레벨, 같은 직급인 사원들의 
--사원번호, 이름, 부서코드, 직급코드, 연봉레벨(SAL_LEVEL) 조회 (다중열 처리)
-- 1) '장쯔의'의 연봉레벨, 직급
SELECT SAL_LEVEL, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '장쯔위'; -- S5, J6

-- 2) 연봉레벨이 S5이고, 직급이 J6인 사원
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SAL_LEVEL
FROM EMPLOYEE
WHERE (SAL_LEVEL, JOB_CODE) = (SELECT SAL_LEVEL, JOB_CODE
                                 FROM EMPLOYEE
                                WHERE EMP_NAME = '장쯔위');

-- 27. 사원들 중 월급이 5000000 이상이면 'HIGH', 
-- 3000000 이상이면 'MEDIUM', 
-- 2000000 이상이면 'LOW' 로 
-- 나머지는 'OTL'로 출력하고  
-- 사원명, 부서코드, 월급을 조회하시오.
-- 단, 월급이 많은 순으로 정렬하시오.
SELECT EMP_NAME, DEPT_CODE, 
CASE WHEN SALARY >=5000000 THEN 'HIGH'
     WHEN SALARY >= 3000000 THEN 'MEDIUM'
     WHEN SALARY >= 2000000 THEN 'LOW'
     ELSE 'OTL'
 END 
FROM EMPLOYEE
ORDER BY SALARY DESC;

--28. 전형돈과 같은 직급, 같은 부서에 근무하는 
--직원들의 정보를 조회하시오 
-- 1) 전형돈의 직급, 부서
SELECT JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '전형돈'; -- J6	D8
 
-- 2) 직급의 J6이고 부서가 D8인 직원
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE, DEPT_CODE) = (SELECT JOB_CODE, DEPT_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '전형돈')
  AND EMP_NAME != '전형돈';

--29. EMPLOYEE테이블에서
--각 부서 별 입사일이 가장 오래된 사원을 한 명씩 선별해
--사원번호, 사원명, 부서번호, 입사일을 조회하고 
--문제에 있는 명칭대로 컬럼명을 지정하시오
-- 1) 부서별 입사일이 가장 오래된 사원
SELECT DEPT_CODE, MIN(HIRE_DATE)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) 해당 부서와 입사일을 가진 사원을 선발
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, HIRE_DATE) IN (SELECT DEPT_CODE, MIN(HIRE_DATE)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE);

--30. EMPLOYEE테이블에서
--근무년수가 20년 이상 30년 미만인 사원의
--사원번호,사원명,입사일,연봉을 구하시오
--단,연봉은 보너스를 포함한 총합을 구한다.
SELECT EMP_ID, EMP_NAME, HIRE_DATE, (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >=20
  AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) <30;
  
--* 31. EMPLOYEE 테이블에서 근무국가(NATIONAL_CODE)가 'KO'인 사원들의
--이름(EMP_NAME), 연봉순위, 급여(SALARY), 근무국가(NATIONAL_CODE)를 조회하시오
--단, 연봉순위는 DENSE_RANK() 사용, ANSI(JOIN) 구문 사용, 내림차순 정렬(연봉순위) 


