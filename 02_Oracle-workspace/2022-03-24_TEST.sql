-- 전체 사원들의 사번, 사원명, 직급코드, 직급명, 월급
-- column ambiguously defined 오류가 발생
-- 오류 발생 이유, 결과가 조회되지 않은 원인, 결과가 조회되도록 조치 내용, ANSI구문으로

-- 1. 오류 발생 이유 
-- : 해당 오류는 SELECT절 혹은 WHERE절에서 참조하고 있는 
-- : 다른 테이블간, 연결고리가 될 동명의 컬럼명들을 중복으로 작성하여, 
-- : 어느 컬럼을 어느 테이블을 참조해야 할 지 모르겠다는 오류이다.

-- 2. 결과가 조회되지 않는 원인
-- : 오류를 비추어 보았을 때, 해당 쿼리문에서 결과가 조회되지 않는 이유는
-- : WHERE절에 있는 'JOB_CODE = JOB_CODE'로 동명의 컬럼명을 기재한 탓에
-- : 각각 어느 테이블의 어느 컬럼명을 참조해야 할 지 몰라서, 결과가 조회되지 않는다.
-- : 마찬가지로 SELECT절에 있는 JOB_CODE가 어느 테이블을 참조해야 할 지 모르는 탓에 결과가 조회되지 않는다.

-- 3. 결과가 조치되도록 조치 내용
-- : 결과를 도출해내기 위해서는
-- : 1. 중복된 컬럼명에 각각 어느 테이블을 참조할 지 테이블명을 붙여준다.
-- : 2. 중복된 컬럼명에 각각 어느 테이블을 참조할 지 테이블명의 별칭을 붙여준다.
-- : 해당 쿼리문에서는 WHERE절과 SELECT절의 JOB_CODE에 각각 참조할 테이블명을 붙여준 후
-- : ANSI구문으로 전체 사원들의 컬럼명들을 도출할 것이기 때문에
-- : 외부조인을 사용하여 결과값을 도출해준다.
-- : (JOB테이블에는 NULL이 들어있지 않기 때문에, 내부조인으로 해줘도 된다)

-- 4. ANSI구문
-- 1) 테이블명 사용
SELECT EMP_ID, EMP_NAME, EMPLOYEE.JOB_CODE, JOB_NAME, SALARY
FROM EMPLOYEE
LEFT JOIN JOB ON(EMPLOYEE.JOB_CODE = JOB.JOB_CODE);
-- 2) 별칭 사용
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, JOB_NAME, SALARY
FROM EMPLOYEE E
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
-- 3) USING 사용
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME, SALARY
FROM EMPLOYEE 
LEFT JOIN JOB USING(JOB_CODE);