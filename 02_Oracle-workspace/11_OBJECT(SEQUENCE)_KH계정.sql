/*
 < 시퀀스 >
 자동으로 번호를 발생시켜주는 역할을 하는 객체
 정수값을 자동으로, 순차적으로 생성해줌.
 
 예) 회원번호, 사번, 게시글번호 등을 채번(번호를 새로 부여)할 때 주로 사용
 
 1. 시퀀스 객체 생성 구문
 [표현법]
 CREATE SEQUENCE 시퀀스명;
 START WITH 시작숫자 : 처음 발생시킬 시작값을 지정     
 INCREMENT BY 증가값 : 한번에 몇씩 증가시킬건지 지정
 MAXVALUE 최대값 : 최대값 지정
 MINVALUE 최소값 : 최소값 지정
 CYCLE / NOCYCLE : 값의 순환여부를 지정
 CACHE 바이트 크기 / NOCACHE : 캐시메모리 사용 여부 지정
                             (CACHE 바이트크기는 바이트크기만큼의 캐시메모리를 사용하겠다는 뜻)

 주의할점 : 모든 설정들은 생략 가능
 * 캐시메모리 : 미리 발생될 값들을 생성해서 저장해두는 임시메모리공간
              매번 호출할때보다 새로이 번호를 생성하는 것보다
              캐시메모리 공간에 미리 생성된 번호들을 저장해뒀다가 쓰는 것이 속도가 더 빠름.
              단, DB접속이 끊기면 기존에 저장되어 있던 값들이 모두 날라감.(임시메모리 공간이라서)          
*/

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM USER_SEQUENCES;
-- USER_SEQUENCES : 현재 접속한 계정이 소유하고 있는 시퀀스들에 대한 정보 조회용 데이터 딕셔너리
-- 기본 설정값
-- MIN VALUE : 1
-- MAX VALUE : 9999999999999999999999999999
-- INCREMENT_BY : 1
-- CYCLE_FLAG : N
-- CACHE_SIZE : 20

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
 2. 시퀀스 사용 구문
 번호를 발생시키는 구문
 
 시퀀스명.CURRVAL : CURRNET VALUE. 현재 시퀀스의 값을 나타냄. 
                  (가장 마지막으로 성공적으로 발생한 NEXTVAL값이 곧 CURRVAL이 됨)
 시퀀스명.NEXTVAL : 시퀀스 값을 증가시키고 그 증가된 시퀀스의 값을 내보내줌
                  기본의 시퀀스 값에서 INCREMENT BY 값만큼 증가된 값
                  (시퀀스명.CURRVAL + INCREMENT BY 설정값 == 시퀀스명.NEXTVAL)
 주의사항
 1) 시퀀스 생성 후 첫 CURRVAL 불가능
 2) 시퀀스 생성 후 첫 NEXTVAL은 START WITH의 시작값으로 잡힘.
 3) CURRVAL은 가장 마지막에 성공적으로 수행한 NEXTVAL을 담아두는 변수의 개념임!
 4) MAXVALUE, MINVALUE 범위를 벗어난 값을 발생시킬수는 없음.
*/

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL;
-- [오류] sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
-- 한번이라도 NEXTVAL을 수행하지 않는 이상, CURRVAL을 수행할 수 없음.
-- (CURRVAL은 마지막으로 성공적으로 수행된 NEXTVAL의 값)

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 300
-- 처음 NEXTVAL을 수행하면, START WITH로 시작한 값이 출력됨.

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL; -- 300
-- 이 시점에서 CURRVAL이 300이라는 값으로 출력됨.

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 305

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL; -- 305

SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER : 다음번호 대기값
-- 현재 상황에서 NEXTVAR을 실행할 경우의 예상값을 담아줌.
-- 다음 NEXTVAL을 수행할 경우, 310이 된다는 뜻임.

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 310

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; 
-- [오류] sequence SEQ_EMPNO.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- 내가 지정한 MAXVALUE를 초과했기 때문에 발생하는 오류임.

/*
 3. 시퀀스 변경 구문
 
 [표현법]
 ALTER SEQUENCE 시퀀스명
 INCREMENT BY 증가값
 MAXVALUE
 MINVALUE
 CYCLE / NOCYCLE
 CACHE 바이트크기 / NOCACHE ; 
 
 * START WITH는 변경 불가 => 이 경우, 그냥 시퀀스를 지우고 다시 만듬.
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

-- 잘 바뀌었나 확인
SELECT * FROM USER_SEQUENCES;
-- LAST NUMBER가 320으로 바뀜.

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL; -- 310

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 320 : 예상값대로 잘 나옴.

-- SEQUENCE 삭제하기
DROP SEQUENCE SEQ_EMPNO;

SELECT * FROM USER_SEQUENCES;

--------- 시퀀스 사용 예시 ------------------

-- 매번 새로운 사번이 발생되는 시퀀스 발생
CREATE SEQUENCE SEQ_EID
START WITH 300;
-- INCREMENT의 기본값이 1이라 1씩 증가함.
-- CURRVAL : 아직 안나옴. NEXTVAL을 수행해야 나옴.
SELECT SEQ_EID.NEXTVAL
FROM DUAL; -- 300

-- 사원이 추가될 때, EMPLOYEE테이블에 INSERT
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '홍길동', '1', 'J2', 'S3',SYSDATE); -- 301

SELECT * FROM EMPLOYEE;

SELECT SEQ_EID.CURRVAL
FROM DUAL; -- 301

SELECT SEQ_EID.NEXTVAL
FROM DUAL; -- 302

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '고길동', '1', 'J2', 'S3',SYSDATE); -- 302

SELECT * FROM EMPLOYEE; 

COMMIT;


