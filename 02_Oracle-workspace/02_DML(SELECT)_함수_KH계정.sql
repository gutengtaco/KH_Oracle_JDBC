/*
 함수(FUNCTION)
 자바의 메소드와 같은 존재
 전달된 값들을 읽어서 계산한 결과를 반환
 - 단일행 : N개의 값을 읽어서 N개의 결과를 리턴(매 행마다 반복적으로 함수를 실행 후 결과를 반환함.)
 - 그룹함수 : N개의 값을 읽어서 1개의 결과를 리턴(하나의 그룹별로 함수를 실행 후 결과를 반환함.) => 집계, 통계에 많이 씀.
 
 주의사항
 단일행함수는 단일행함수끼리, 그룹함수는 그룹함수끼리 사용함.(결과행의 개수가 다르기 때문)
*/

-- <단일행 함수> --
/*
 문자열과 관련된 함수
 LENGTH / LENGTHB
  - LENGTH(STR) : 해당 전달된 문자열의 글자 수를 반환
  - LENGTHB(STR): 해당 전달되나 문자열의 바이트 수 반환
  결과값은 NUMBER타입으로 반환
  STR : '문자열 리터럴' / 문자열에 해당하는 컬럼
  한글 : 'ㄱ', 'ㅣ', 'ㅁ', '김', ... => 한글자당 3BYTE
  숫자, 영문, 특수문자 : '!', '~', 'a', 'A', '1' => 한글자당 1BYTE
*/

SELECT LENGTH('오라클!'), LENGTHB('오라클 !')
FROM DUAL; 
--가상테이블(DUMMY TABLE) : 산술 연산이나 가상 컬럼 등의 값을 한번만 출력하고 싶을때 사용하는 테이블

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL),
       EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
       --EMAIL은 LENGTH와 LENGTHB가 일치함.
       --NAME은 한글이기때문에 LENGTH와 LENGTHB가 차이남(3배)
FROM EMPLOYEE;

/*
    INSTR(STR,'특정문자',찾을위치의시작값,순번) : 문자열로부터 특정 문자의 위치값 반환
    결과값은 NUMBER타입으로 반환
    찾을위치의시작값, 순번은 생략 가능
    
    찾을 위치의 시작값 
    1 : '특정문자'를 앞에서부터 찾겠다(생략시 기본값)
    -1 : '특정문자'를 뒤에서부터 찾겠다.
    
    순번(생략시 기본값은 1)
*/

SELECT INSTR('AABAACAABBAA', 'B' /*, 1*/)
FROM DUAL; -- 3: 앞에서부터 해당 '특정문자'의 첫번째 글자의 위치를 반환

SELECT INSTR('AABAACAABBAA', 'B', -1)
FROM DUAL; -- 10 : 뒤에서부터 첫번째에 위치하는 'B'의 위치값을 앞에서부터 세서 알려줌

SELECT INSTR('AABAACAABBAA', 'B', 1,2)
FROM DUAL; -- 9 : 앞에서부터 두번째에 위치하는 'B'의 위치값을 앞에서부터 세서 알려줌.

SELECT INSTR('AABAACAABBAA', 'B', -1, 2)
FROM DUAL; -- 9 : 뒤에서부터 두번째에 위치하는 'B'의 위치값을 앞에서부터 세서 알려줌.

-- EMAIL 컬럼에서 '@'의 위치를 찾아보자
SELECT EMAIL,INSTR(EMAIL, '@',1 ,2) AS "@의 위치"
FROM EMPLOYEE;
-- 없는 순번을 제시하면 0이라는 결과가 나옴

------------------------------------------------------------------
/*
   SUBSTR
   SUBSTR(STR, POSITION, LENGTH) : 문자열로부터 특정 문자열을 추출하여 반환
                                   자바에서는 문자열.substring()과 유사
   결과값은 CHARACTER형으로 반환함.
   LENGTH는 생략 가능(생략시, 끝까지 잘라냄)
   
    - STR : '문자열'리터럴' / 문자열 타입의 컬럼명
    - POSITION : 문자열 추출을 시작할 위치값
    - LENGTH : 추출할 문자 개수
*/
SELECT SUBSTR('SHOWMETHEMONEY',7)
FROM DUAL; -- 'THEMONEY' : 7번째 문자부터 끝까지 추출.
SELECT SUBSTR('SHOWMETHEMONEY',5,2)
FROM DUAL; -- 'ME' : 5번째 문자부터 2개의 문자를 추출
SELECT SUBSTR('SHOWMETHEMONEY',1,6)
FROM DUAL; -- 'SHOWME' : 1번째 문자부터 6개의 문자를 추출(1부터 셈)
SELECT SUBSTR('SHOWMETHEMONEY',-8,3)
FROM DUAL; -- 'THE' : 뒤에서부터 8번째 문자부터 3개의 문자를 추출

-- 주민등록번호에서 성별부분을 추출해서 남자, 여자를 체크하기
SELECT EMP_NAME, SUBSTR(EMP_NO, 8,1)AS "성별"
FROM EMPLOYEE;

-- 남자사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8,1)='1' OR SUBSTR(EMP_NO, 8,3)='3';
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

-- 여자사원들만 조회
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8,1)='2' OR SUBSTR(EMP_NO, 8,3)='4';
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');
-- 오라클에서 자동형변환을 잘해주기때문에, 따옴표를 안붙여도 같은 결과가 나옴.

-- 중첩해서 함수를 사용
-- 이메일에서 ID부분만 추출해서 조회
SELECT EMP_NAME, EMAIL,SUBSTR(EMAIL,1, INSTR(EMAIL,'@')-1) AS "ID" 
FROM EMPLOYEE;
---------------------------------------------------------------------

/*
 LPAD/ RPAD()
  - LPAD/RPAD(STR, 최종적으로 반환할 문자열의 길이(바이트), 덧붙이고자하는 문자) 
  : 제시한 문자열에 임의의 문자를 왼쪽 또는 오른쪽에 덧붙여서 최종 N길이만큼의 문자열을 반환
  : STR : '문자열 리터럴', 문자열 타입의 컬럼명
  : 결과값은 CHARACTER타입으로 나옴.(문자열 형태)
  : 덧붙이고자하는 문자 부분은 생략 가능함.
*/
--SELECT LPAD(EMAIL,16) -- 덧붙이고자하는 문자를 생략할 경우, 공백을 기본값으로 덧붙임.
SELECT LPAD(EMAIL,16,'#') -- 총16(BYTE)글자짜리 문자열을 반환함.
                      -- 단, 부족한 내용물은 왼쪽에 추가하여 덧붙임.                    
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850918-2****** => 마스킹 처리된 상태로 주민등록번호(총 14글자) 보여주기
SELECT RPAD('850918-2',14,'*')
FROM DUAL;

SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;

-----------------------------------------------------------------

/*
 LTRIM, RTRIM
  - LTRIM/RTRIM(STR, '제거시키고자하는문자')
  결과값은 CHARACTER타입으로 반환(문자열 형태)
  '제거시키고자하는문자'는 생략 가능
  
  - STR : '문자열리터럴' / 문자열이 담긴 컬럼명
  
*/
SELECT LTRIM('          K        H')
FROM DUAL; -- '제거시키고자하는문자'를 생략 시, 공백을 절삭함.

SELECT RTRIM('K         H         ')
FROM DUAL;

SELECT LTRIM('000123456000','0')
FROM DUAL; -- 123456000

SELECT RTRIM('000123456000','0')
FROM DUAL; -- 000123456

SELECT LTRIM('123123KH123', '123')
FROM DUAL; -- KH123

SELECT LTRIM('ACABACCKH','ABC')
FROM DUAL; -- KH
SELECT LTRIM('ACABACCKH','D')
FROM DUAL; -- ACABACCKH
-- '제거시키고자하는문자열'에 한개라도 포함된 문자열을 지워줌.
-- '제거시키고자하는문자열'에 포함되지 않은 문자열과 만날시, 이전까지의 결과를 반환함.

------------------------------------------------------------------

/*
 TRIM
 
 -TRIM(BOTH/LEADING/TRAILING '제거시키고자하는문자' FROM STR)
 : 문자열의 양쪽/ 앞쪽/ 뒤쪽에 있는 특정문자를 제거한 나머지 문자열을 반환
 
 결과값은 CHARACTER타입으로 반환(문자열 형태)
 BOTH : 양쪽에 있는 해당 문자를 제거함. 
 LEADING : 앞쪽에 있는 해당 문자를 제거함.(LTRIM과 동일)
 TRAILING : 뒤쪽에 있는 해당 문자를 제거함.(RTRIM과 동일)
 BOTH, LEADING, TRAILING은 생략 가능(BOTH가 기본값)
 '제거시키고자하는문자' FROM 생략 가능 
 
 - STR : '문자열 리터럴' / 문자열 형식의 컬럼명
*/
-- 기본적으로 양쪽에 있는 공백 제거
SELECT TRIM('   K   H   ')
FROM DUAL; -- K    H

--BOTH, LEADING, TRAILING 생략시 기본은 BOTH
SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- KH

SELECT TRIM(BOTH 'Z' FROM 'ZZZBOTHZZZ')
FROM DUAL; -- BOTH : 양쪽(생략시 기본값)

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- KHZZZ : 앞쪽(LTRIM과 동일)

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- ZZZKH : 뒤쪽(RTRIM과 동일)

-- 매개변수가 문장의 형식으로 지정되어서 들어감! (~ FROM ~)

-------------------------------------------------------------------

/*
 LOWER / UPPER / INITCAP
 
  - LOWER(STR) : 다 소문자로 변경
  - UPPER(STR) : 다 대문자로 변경
  - INITCAP(STR) : 각 단어 앞글자만 대문자로 변경(띄어쓰기 기준)
  
  결과값은 CHARACTER 타입으로 변환(문자열 형태)
  - STR : '문자열 리터럴' / 문자열 타입의 컬럼명
*/
SELECT LOWER('WELCOME TO MY WORLD')
FROM DUAL;

SELECT UPPER('welcome to my world')
FROM DUAL;

SELECT INITCAP('welcome to my world')
FROM DUAL;

SELECT INITCAP('welcome to myworld')
FROM DUAL;

------------------------------------------------------
/*
 CONCAT
  - CONCAT(STR1, STR2) : 전달된 두개의 문자열을 하나로 합친 결과를 반환
  결과값은 CHARACTER타입으로 반환(문자열형태)
  - STR1, STR2 : '문자열 리터럴' / 문자열 타입의 컬럼명 
*/
SELECT CONCAT('가나다','ABC')
FROM DUAL;

SELECT '가나다' || 'ABC'
FROM DUAL;

SELECT '가나다'||'ABC'||'DEF'
FROM DUAL;

SELECT CONCAT('가나다','ABC','DEF')
FROM DUAL;
--[오류메세지]
--"invalid number of arguments"
--CONCAT은 2개의 매개변수로만 문자를 합칠 수 있음.

SELECT CONCAT('가나다',CONCAT('ABC','DEF'))
FROM DUAL;
-- 중첩하여 사용할 수 있음.
-----------------------------------------------------
/*
 REPLACE
 - REPLACE(STR,'찾을문자','바꿀문자')
 :STR로 부터 '찾을문자'를 찾아서 '바꿀문자'로 바꾼 문자열을 반환
 
 결과값은 CHARACTER타입으로 반환
 
 -STR : '문자열 리터럴' / 문자열 타입의 컬럼명
*/

SELECT REPLACE('서울시 강남구 역삼동', '역삼동', '논현동')
FROM DUAL;

-- 이메일의 도메인을 KH.OR.KR에서 IEI.COM으로 변경
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL,'kh.or.kr','iei.com')
FROM EMPLOYEE;

--------------------------------------------------------------------

/*
 숫자와 관련된 함수
 ABS
 - ABS(NUMBER) : 절대값을 구해주는 함수
*/
SELECT ABS(-10)
FROM DUAL; -- 10

SELECT ABS(-10.9)
FROM DUAL; -- 10.9

--------------------------------------------------------------------
/*
 MOD
 - MOD(NUMBER1, NUMBER2) : 두 수를 나눈 나머지값을 반환해주는 함수
 
*/
SELECT MOD(10,3)
FROM DUAL; -- 1

SELECT MOD(-10,3)
FROM DUAL; -- -1

SELECT MOD(10.9, 3)
FROM DUAL; -- 1.9

---------------------------------------------------------------
/*
 ROUND
  - ROUND(NUMBER, 위치) : 반올림처리(5이상)를 해주는 함수
  위치 : 소수점 아래 N번째 수에서 반올림함.
  위치는 생략 가능, 생략시 기본값은 0
*/
SELECT ROUND(123.456)
FROM DUAL; -- 123 : 위치생략시, 기본값은 0

SELECT ROUND(123.456, 1)
FROM DUAL; -- 123.5

SELECT ROUND(123.456, 2)
FROM DUAL; -- 123.46

SELECT ROUND(123.456, 3)
FROM DUAL; -- 123.456

SELECT ROUND(123.456, -1)
FROM DUAL; -- 120

SELECT ROUND(123.456, -2)
FROM DUAL; -- 100

SELECT ROUND(123.456, -3)
FROM DUAL; -- 0

SELECT ROUND(123.456, -4)
FROM DUAL; -- 0

----------------------------------------------------------------------

/*
 CEIL 
  - CEIL(NUMBER) : 소수점 아래의 수를 무조건 올림처리해줌.
 */
 
 SELECT CEIL(123.156)
 FROM DUAL; -- 124
 
 ---------------------------------------------------------------------
 
 /*
 FLOOR
  - FLOOR(NUMBER) : 소수점 아래의 수를 무조건 버림처리해줌.
 */
 
 SELECT FLOOR(123.956)
 FROM DUAL; -- 123
 
SELECT FLOOR(207.68)
FROM DUAL; -- 207
 
 -- 각 직원별로 고용일로부터 오늘까지 근무일수(오늘날짜 - 입사일)를 조회
 -- 근무일수 뒤에 '일'이라는 날짜의 단위를 붙여줌
 SELECT EMP_NAME AS "이름", LPAD(CONCAT(FLOOR(SYSDATE - HIRE_DATE),'일'),6) AS "근무일수"
 FROM EMPLOYEE;
 
 -----------------------------------------------------------------------------
 /*
 TRUNC(NUMBER, 위치) : 위치 지정가능한 버림처리를 해주는 함수
 위치는 생략 가능, 생략시 기본값은 0(FLOOR와 같음)
 소수점 아래의 위치까지만 남겨놓고 버림처리함.
 */
 SELECT TRUNC(123.756)
 FROM DUAL; -- 123
 
 SELECT TRUNC(123.756, 1)
 FROM DUAL; -- 123.7
 
 SELECT TRUNC(123.756, -1)
 FROM DUAL; -- 120
 
 -----------------------------------------------------------------------------
 /*
  날짜 관련 함수
  DATE 타입 : 년, 월, 일, 시, 분, 초
 */
 
 --SYSDATE : 오늘날짜, 현재 내 컴퓨터의 시스템날짜
 SELECT SYSDATE
 FROM DUAL; -- 22/03/14
 -- 결과를 더블클릭하면 '값보기'가 나옴.
 
 -- MONTHS_BETWEEN(DATE1, DATE2) : 두 날짜 사이의 개월수 반환
 -- 결과값이 NUMBER타입으로 반환(일,시,분,초가 소수점으로 나옴!)
 -- 날짜는 미래, 과거 순서로 해줌(반대로 하면 음수가 나옴)
 -- 각 직원별로 고용일로부터 오늘까지의 근무일수, 근무개월수를 조회
 SELECT EMP_NAME,
 FLOOR(SYSDATE - HIRE_DATE)||'일' AS "근무일수",
 FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))||'개월' AS "근무개월수"
 FROM EMPLOYEE;
 
 -- ADD_MONTHS(DATE, NUMBER) : 특정 날짜에 해당 숫자만큼의 개월수를 더한 날짜를 반환함.
 -- 결과값이 DATE타입으로 반환
 SELECT ADD_MONTHS(SYSDATE,5)
 FROM DUAL; -- 22/08/14
 
 -- 전체 사원들의 직원명, 입사일, 입사후 6개월이 흘렀을 때의 날짜 조회
 SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6)
 FROM EMPLOYEE;
 
 
-- 음수로 지정하면?(시간 역행함)
SELECT ADD_MONTHS(SYSDATE,-5)
FROM DUAL; -- 21/10/14

-- NEXT_DAY(DATE,요일) : 특정 날짜에서 가장 가까운 해당 요일을 찾아서 그 날짜를 반환
SELECT NEXT_DAY(SYSDATE, '일요일')
FROM DUAL;
-- 2022/03/14기준 2022/03/20
 
 SELECT NEXT_DAY(SYSDATE,'일')
 FROM DUAL; 
 
 
 -- 1: 일요일, 2:월요일, 3: 화요일, ... , 6:금요일, 7:토요일
 SELECT NEXT_DAY(SYSDATE,1)
 FROM DUAL;
 -- 현재 언어가 KOREAN이기 때문에 에러가 남
 SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
 FROM DUAL;
 
 -- 언어 변경
 ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
 
 SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
 FROM DUAL;
 
 ALTER SESSION SET NLS_LANGUAGE = KOREAN;
 -- 항상 요일을 문자 형식으로 나타내고자 할 때는, 현재 언어 형식에 맞게 제시를 해야 함.
 
-- LAST_DAY(DATE) : 특정 날짜가 속한 달의 마지막 날짜를 구해서 반환
SELECT LAST_DAY(SYSDATE)
FROM DUAL; -- 22/03/31

-- 이름, 입사일, 입사한 달의 마지막 날짜 조회
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

/*
 EXTRACT : 년도 또느 월 또는 일 정보를 추출해서 반환 
 결과값으로 NUMBER타입을 반환함
  - EXTRACT(YEAR FROM DATE) : 특정 날짜로부터 년도만 추출
  - EXTRACT(MONTH FROM DATE) : 특정 날짜로부터 월만 추출
  - EXTRACT(DAY FROM DATE) : 특정 날짜로부터 일만 추출
  
*/

-- 오늘 날짜 기준으로 EXTRACT함수 적용
SELECT EXTRACT(YEAR FROM SYSDATE), -- 2022
       EXTRACT(MONTH FROM SYSDATE), -- 3
       EXTRACT(DAY FROM SYSDATE) -- 21
FROM DUAL;

-- 사원명, 입사년도, 입사월, 입사일 조회
SELECT EMP_NAME,
       EXTRACT(YEAR FROM HIRE_DATE)"입사년도",
       EXTRACT(MONTH FROM HIRE_DATE)"입사월",
       EXTRACT(DAY FROM HIRE_DATE)"입사일"
FROM EMPLOYEE
ORDER BY "입사년도", "입사월", "입사일";

---------------------------------------------------------------------------
/*
 형변환 함수
 NUMBER / DATE => CHARACTER
 - TO_CHAR(NUMBER/ DATE, '포맷')
 : 숫자형 또는 날짜형 데이터를 문자형 타입으로 변환해줌.
 : 반환값이 CHARACTER타입임.
*/

SELECT 1234, TO_CHAR(1234)
FROM DUAL; -- '1234'
-- 문자열은 왼쪽정렬, 숫자는 오른쪽정렬됨.

-- 엑세스에서 사용했던 포맷(형식)을 쓰는 방법과 유사함
SELECT TO_CHAR(1234,'00000')
FROM DUAL; -- '01234' : 빈칸을 0으로 채워줌

SELECT TO_CHAR(1234,'99999')
FROM DUAL; -- ' 1234' : 빈칸을 공백으로 채움

SELECT TO_CHAR(1234,'L00000')
FROM DUAL; --'￦01234' : L은 현재 설정된 나라의 화폐 단위가 붙음

SELECT TO_CHAR(1234,'L99999')
FROM DUAL; -- '￦1234' : 기호와 9를 사용하면 붙어서 결과가 반환됨.

SELECT TO_CHAR(1234,'$99999')
FROM DUAL; -- '$1234'

SELECT TO_CHAR(1234, 'L99,999')
FROM DUAL; -- '￦1,234'  : 3자리마다 콤마(,)로 구분

-- 급여정보를 3자리마다 콤마(,)로 구분하여 출력 + 화폐단위
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999') AS "급여정보"
FROM EMPLOYEE;

-- DATE(년월일시분초) => CHARACTER
SELECT SYSDATE
FROM DUAL; -- 달력형식으로 나옴

SELECT TO_CHAR(SYSDATE)
FROM DUAL; -- '22/03/14'
-- 포맷을 지정하지 않으면 'YY/MM/DD'형식으로 나옴

-- 'YYYY-MM-DD'형식으로 지정
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')
FROM DUAL; -- '22-03-14'

-- 시, 분, 초만 표현해보기
-- 12시간 => 오전/ 오후
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS')
FROM DUAL; -- PM은 오전/오후를 출력해줌

-- 24시간 => 오전/오후
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS')
FROM DUAL; -- HH24는 시간을 24시간 형식으로 출력해줌.

SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM DUAL; -- 3월 월, 2022  
-- MON=>'x월' 형식 / DY =>'요일' 키워드를 뺀 요일 형태 / YYYY => 4자리 년도

-- 사용할 수 있는 포맷들 --
-- 년도로써 쓸 수 있는 포맷 
SELECT 
TO_CHAR(SYSDATE, 'YYYY'), -- 2022
TO_CHAR(SYSDATE, 'RRRR'), -- 2022(반올림)
TO_CHAR(SYSDATE, 'YY'), -- 22
TO_CHAR(SYSDATE, 'RR'), -- 22(반올림)
TO_CHAR(SYSDATE, 'YEAR') -- 'TWENTY TWENTY-TWO'
FROM DUAL;
-- YEAR는 영어로 년도수를 출력해주는 포맷임.

-- 월로서 쓸 수 있는 포맷
SELECT
TO_CHAR(SYSDATE, 'MM'), -- 03
TO_CHAR(SYSDATE, 'MON'), -- 3월
TO_CHAR(SYSDATE, 'MONTH'), -- 3월
TO_CHAR(SYSDATE, 'RM') -- III
FROM DUAL;
-- RM은 로마숫자를 의미함.

-- 일로써 쓸 수 있는 포맷
SELECT
TO_CHAR(SYSDATE,'D'), -- 2 : 일주일 기준으로 며칠째인지 알려줌(일~월)
TO_CHAR(SYSDATE,'DD'), -- 21 : 월 기준으로 며칠째인지 알려줌(오늘날짜)
TO_CHAR(SYSDATE,'DDD') -- 080 : 년도 기준으로 며칠째인지 알려줌(80일이 지남)
FROM DUAL;

-- 요일로써 쓸 수 있는 포맷
SELECT
TO_CHAR(SYSDATE, 'DY'), -- 월 : '요일'을 뺀 요일을 출력함.
TO_CHAR(SYSDATE, 'DAY') -- 월요일 : '요일'을 합쳐서 출력함.
FROM DUAL;

-- 2022년 03월 21일 (월)
SELECT
TO_CHAR(SYSDATE,'YYYY"년" MM"월" DD"일" (DY)')
FROM DUAL;
-- 한글을 같이 쓰고 싶으면, 쌍따옴표로 감싸줌.

-- 사원명, 입사일(위의 포맷 적용)
SELECT EMP_NAME "사원명", TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)')AS "입사일"
FROM EMPLOYEE;

-- "2010년 이후에 입사한" 사원명, 입사일(위의 포맷 적용)
SELECT EMP_NAME "사원명", TO_CHAR(HIRE_DATE, 'YYYY"년" MM"월" DD"일" (DY)')  "입사일"
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE)>=2010
-- WHERE SUBSTR(HIRE_DATE, 1,2) > 10
ORDER BY "입사일" ASC;

/*
 NUMBER/CHARACTER => DATE
 - TO_DATE(NUMBER 또는 CHARACTER, '포맷'): 숫자형 또는 문자형 데이터를 날짜형으로 변환
*/
SELECT TO_DATE(20220321) -- 숫자, 22/03/21(달력형태)
FROM DUAL;
-- 기본 포맷은 YY/MM/DD로 지정됨

SELECT TO_DATE('20220321')-- 문자, 22/03/21(달력형태)
FROM DUAL;

SELECT TO_DATE('000101')
FROM DUAL;
-- [오류] Literals in the input must be the same length
-- 000101은 0으로 시작하는 숫자로 인식하여 에러가 발생함.
-- 마찬가지로, DATE의 포맷에 알맞게 숫자를 작성해야 함.(YYYY MM DD)
-- 굳이 00/01/01으로 작성하고 싶으면, 000101을 문자열로 작성해줌

SELECT TO_DATE('20100101','YYYYMMDD')
FROM DUAL;
-- YY/MM/DD 형식으로 나오지만, 값 보기 창을 보면 달력형태로 잘 지정됨!

SELECT TO_DATE('041030 143021', 'YYMMDD HH24MISS')
FROM DUAL;
-- 값보기 창에 날짜와 시간에 값이 들어가있는 것을 볼 수 있음.

SELECT TO_DATE('140630', 'YYMMDD')
FROM DUAL;
-- 2014년 06월 30일

SELECT TO_DATE('980630', 'YYMMDD')
FROM DUAL;
-- 2098년 06월 30일으로 지정됨.
-- 두자리년도에 대해서 YY포맷을 적용시켰을 경우,
-- 현재 세기로 나타남(98을 제시했을 때, 현재 세기인 2098년으로 나옴)

SELECT TO_DATE('140630', 'RRMMDD')
FROM DUAL;
-- 2014년 06월 30일(변화없음)

SELECT TO_DATE('980630', 'RRMMDD')
FROM DUAL;
-- 1998년 06월 30일
-- 두자리 년도에 대해서 RR(ROUND)포맷을 적용시켰을 경우,
-- 50이상이면 이전 세기, 50미만이면 현재 세기로 나타냄.

/*
 CHARACTER => NUMBER
 자바의 parseXXX(파싱)과 같음
 TO_NUMBER(CHARACTER, '포맷') : 문자형 데이터를 숫자형으로 변환, 반환형은 NUMBER타입
*/

SELECT '123' + '123' 
FROM DUAL; -- 246 : 오라클에서는 자동형변환이 한번 일어나고 산술연산이 됨.

SELECT '10,000,000' + '550,000'
FROM DUAL;
-- [오류] "invalid number"
-- 숫자 중간마다 쉼표라는 문자가 포함되어 있어, 자동형변환이 진행이 되지 않음.

SELECT TO_NUMBER('10,000,000', '999,999,999') + TO_NUMBER('550,000','999,999,999')
FROM DUAL; -- 10550000

SELECT TO_NUMBER('0123')
FROM DUAL; -- 123 : 앞의 0은 제외하고 숫자로 출력됨

----------------------------------------------------------------------------------------

/*
 <NULL 처리 함수>
*/

-- NVL(컬럼명, 해당컬럼값이 NULL인경우 반환할 반환값)
-- 해당 컬럼값이 존재할 경우(NULL이 아닌경우), 기존의 컬럼값을 반환해줌
-- 해당 컬럼값이 존재하지 않을 경우(NULL인 경우), 반환할 값을 지정해주어 반환해줌.

-- 사원명, 보너스(보너스가 없는 경우는 0으로 출력)
SELECT EMP_NAME, BONUS, NVL(BONUS,0)
FROM EMPLOYEE;

-- 사원명, 보너스를 포함한 연봉 조회
SELECT EMP_NAME, (SALARY+(SALARY*NVL(BONUS,0)))*12
FROM EMPLOYEE;

-- 사원명, 부서코드(부서코드가 없을 경우, '없음') 조회
SELECT EMP_NAME, NVL(DEPT_CODE,'없음')
FROM EMPLOYEE;

-- NVL2(컬럼명, 결과값1, 결과값2)
-- 해당 컬럼값이 존재할 경우(NULL이 아닌 경우), 결과값 1을 반환
-- 해당 컬럼값이 존재하지 않는 경우(NULL인 경우), 결과값 2를 반환

-- 보너스가 있는 경우에는 '있음' 없는 경우에는 '없음' 출력
SELECT EMP_NAME, BONUS, NVL2(BONUS, '있음', '없음')
FROM EMPLOYEE;

-- 사원명, 부서코드 (부서코드가 있는 경우에는 '배치완료', 없는 경우에는 '배치미정')
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '배치완료', '배치미정')
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2)
-- 비교대상1이랑 비교대상2가 동일할 경우, NULL을 반환함.
-- 값이 동일하지 않을 경우, 비교대상1을 반환
SELECT NULLIF('123','123')
FROM DUAL; -- NULL

SELECT NULLIF('123','456')
FROM DUAL; -- 123(문자)

SELECT NULLIF(123,456)
FROM DUAL; -- 123(숫자)

---------------------------------------------------------------------------------
/*
 <선택 함수>
 DECODE(비교대상, 조건값1, 결과값1, 조건값2, 결과값2,...,조건값N, 결과값N, 결과값)
 비교대상과 조건값을 비교하여, 조건에 부합하면 결과값을 반환함.
 자바에서 동등비교를 수행하는 SWITCH문과 유사함.
 SWITCH(비교대상){
 CASE 조건값1 : 결과값1;
 CASE 조건값2 : 결과값2;
 ...
 CASE 조건값N : 결과값N;
 (DEFAULT : 결과값;) => 생략 가능
 }
*/

-- 사번, 사원명, 주민등록번호로부터 성별 자리를 추출
-- 단, 주민등록번호의 성별자리를 추출하여 '1','3'은 남자 / '2','4'는 여자로 출력
SELECT EMP_ID, EMP_NAME, EMP_NO,
DECODE(SUBSTR(EMP_NO,8,1),'1','남자','2','여자','3','남자','4','여자') "성별"
FROM EMPLOYEE;

-- 직원들의 급여를 인상시켜서 조회
-- 직급코드가 'J7'인 사원은 급여를 10프로 인상
-- 직급코드가 'J6'인 사원은 급여를 15프로 인상
-- 직급코드가 'J5'인 사원은 급여를 20프로 인상
-- 그외의 직급코드인 사원은 급여를 5프로 인상
SELECT EMP_NAME,
JOB_CODE,
SALARY "인상 전",
DECODE(JOB_CODE, 'J7', SALARY+(SALARY*0.1),
                 'J6', SALARY+(SALARY*0.15),
                 'J5', SALARY+(SALARY*0.2),
                       SALARY+(SALARY*0.05)) "인상 후"
FROM EMPLOYEE;
-- 월급올리는 공식(N프로 인상) : SALARY+(SALARY*0.N) == SALARY*1.N
-- 원본값은 바뀌지 않음.

----------------------------------------------------------------------------------

/*
 CASE WHEN THEN 구문
 DECODE선택함수와 비교하면 
 DECODE는 해당조건 검사시 동등비교만을 수행한다면(조건값)
 CASE WHEN THEN구문은 특정조건 제시시 내맘대로 조건식을 기술 가능함.
 자바에서의 IF-ELSE IF문과 같은 느낌
 
 [표현법]
 CASE WHEN 조건식1 THEN 결과값1
      WHEN 조건식2 THEN 결과값2
      ...
      WHEN 조건식N THEN 결과값N
      ELSE 결과값
 END
*/

-- 사번, 사원명, 주민등록번호로부터 성별자리를 추출하여 보여지게끔
-- DECODE 함수 버전
SELECT EMP_ID, EMP_NAME,EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','남자',
                                                   '2','여자',
                                                   '3','남자',
                                                   '4','여자') "성별"
FROM EMPLOYEE;    

-- CASE WHEN THEN구문 버전
SELECT EMP_ID, EMP_NAME, EMP_NO,
CASE WHEN SUBSTR(EMP_NO,8,1)='1' OR SUBSTR(EMP_NO,8,1)='3' THEN '남자'
     -- WHEN SUBSTR(EMP_NO,8,1)='2' OR SUBSTR(EMP_NO,8,1)='4' THEN '여자'
     ELSE '여자'
     END "성별"
FROM EMPLOYEE;

-- 사원명, 급여, 급여등급(고급, 중급, 초급)
-- SALARY 컬럼값 기준으로 월급이 500만원 초반일 경우에는 '고급'
-- 월급이 500만원이하 ~ 350만원 초과일 경우에는 '중급'
-- 월급이 350만원 이하일 경우에는 '초급'
SELECT EMP_NAME, SALARY, 
CASE WHEN SALARY > 5000000 THEN '고급'
     WHEN SALARY > 3500000 AND SALARY <= 5000000 THEN '중급'
     WHEN SALARY <= 3500000 THEN '초급'
  -- ELSE '초급'
     END  "급여 등급"
FROM EMPLOYEE;   

------------------------------------------------------------------------------------

----------<그룹함수>-----------

/*
 N개의 값을 읽어서 1개의 결과를 반환(하나의 그룹별로 함수 실행 결과를 반환함)
*/

-- 1. SUM(숫자타입의컬럼명) : 해당 컬럼값들의 합계를 구해서 반환
-- 전체 사원들의 총 급여 합계
SELECT SALARY
FROM EMPLOYEE;
-- 단일행함수는 단일행함수끼리
SELECT SUM(SALARY)
FROM EMPLOYEE;
-- 그룹함수는 그룹함수끼리

-- 부서코드가 'D5'인 사원들의 총 급여 합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
    
-- 남자사원들의 총 급여 합
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

-- 2. AVG(숫자타입의컬럼명) : 해당 컬럼값들의 평균값을 구해서 반환
-- 전체사원들의 평균 급여
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- 전체사원들의 평균 급여
SELECT '대략 ' || ROUND(AVG(SALARY),-4) || '원' "평균 급여"
FROM EMPLOYEE;

-- 3. MIN(아무타입컬럼명) : 해당 컬럼값 중에서 가장 작은 값을 반환
-- 전체 사원들 중 최저급여, 가장작은 이름값, 가장작은 이메일값, 가장예전에 입사한 날짜
SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT SALARY, EMP_NAME, EMAIL, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE;
-- MIN함수 자체가 오름차순을 했을 때, 가장 위의 값을 보여줌.

-- 4. MAX(아무타입컬럼명) : 해당 컬럼값 중에서 가장 큰 값을 반환
SELECT MAX(SALARY), MAX(EMP_NAME), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

SELECT SALARY, EMP_NAME, EMAIL, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;
-- MAX함수 자체가 내림차순을 했을 때, 가장 위의 값을 보여줌.

-- 5. COUNT(*/컬럼명 / DISTINCT 컬럼명) : 조회된 행의 개수를 세서 반환함.
-- COUNT(*) : 조회 결과에 해당하는 모든 행의 개수를 세서 반환
-- COUNT(컬럼명) : 내가 제시한 해당 컬럼값의 행의 개수로 세서 반환(NULL 포함 X)
-- COUNT(DISTINCT 컬럼명) : 내가 제시한 컬럼값이 중복인 경우, 하나로만 세서 행의 개수로 반환
--                         (NULL 포함 X)

-- 전체 사원수에 대해 조회
SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT(EMP_ID)
FROM EMPLOYEE;
-- NULL값이 없는 컬럼을 제시하여, 전체 사원수를 알아낼 수 있음.

-- 여자 사원수만 조회
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('2','4');

-- 부서배치가 된 사원수만 조회
-- 방법1 : WHERE절에 조건을 사용
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

-- 방법2 : 애초에 COUNT에 컬럼몀을 제시해서 NULL이 아닌 개수만 세는 방법
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- 부서배치가 된 여자사원 수
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL AND SUBSTR(EMP_NO,8,1) IN('2','4');

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

-- 사수가 있는 사원의 수(MANAGER_ID 컬럼)
SELECT COUNT(*)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

-- 현재 사원들이 속해있는 부서의 개수
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM DEPARTMENT;
-- DEPARTMENT테이블에 부서들의 내용이 적혀있음.
-- 다만, 한명도 속해있지 않은 부서가 있을 수 있기 때문에 이 방법은 비추천
