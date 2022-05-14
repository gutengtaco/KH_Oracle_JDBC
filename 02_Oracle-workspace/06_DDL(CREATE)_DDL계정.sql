/*
 DDL(DATA DEFINITION LANGUAGE)
 데이터 정의 언어
 
 오라클에서 제공하는 객체(OBJECT)를 
 새로이 만들고(CREATE), 구조를 변경하고(ALTER) 구조 자체를 삭제하는(DROP) 명령문
 즉, 구조(테이블)자체를 정의하는 언어로, 주로 DB관리자나 설계자가 사용함.
 
 오라클에서의 객체 : 테이블, 뷰(조회용 테이블), 시퀀스(자동으로 번호 부여, SELECT에서 ROWNUM과 비슷)
                  사용자(USER), 패키지(자바에서의 패키지와 유사함), 
                  트리거(일이 발생했을 때, 자동으로 지정된 일을 수행)
                  프로시저, 함수(자바에서의 메소드와 같음)
                  동의어(SELECT에서의 별칭과 비슷함)                  
*/

/*
 < CREATE TABLE >
 테이블이란, 행(ROW,RECORD,튜플)과 열(COLUMN, FIELDS, ATTRIBUTES)로 구성되는 
 가장 기본적인 데이터베이스 객체
 항상 모든 데이터는 테이블을 통해서 저장됨.
 즉, 데이터를 보관하고자 한다면 테이블을 만들어야 함.
 
 [표현법]
 CREATE TABLE 테이블명 (
     컬럼명1 자료형,
     컬럼명2 자료형,
     ... 
     컬럼명N 자료형
 );
 
 < 자료형 >
 - 문자 (CHAR(사이즈),VARCHAR2(사이즈)) : 사이즈는 BYTE수
                                    (숫자, 영문, 특수문자, 공백 => 1글자당 1BYTE
                                                        한글 => 1글자당 3BYTE)
       CHAR(BYTE) : 고정길이 문자열. 아무리 적은 값이 들어가도, 공백으로 채워서 할당한 크기를 유지함.
                  : BYTE에는 최대 2000까지 지정 가능
                  => 주로 들어올 값의 글자수가 정해져있을 때 사용
                  => 예) 성별(남,여) : 3BYTE / (M,F) : 1BYTE
       VARCHAR2(BYTE) : 가변길이 문자열. 적은 값이 들어가면, 자동으로 공간을 해당 값만큼 조절함.
                      : BYTE에는 최대 4000까지 지정 가능
                      => 주로 들어올 값이 정해지지 않았을 때 사용
                      => 예) 이름(2~3자), 이메일주소, 집주소,...
 - 숫자 (NUMBER) : 정수 / 실수 상관없이 NUMBER임.
 
 - 날짜 (DATE) : 년,월,일,시,분,초의 개념이 들어간 자료형
 
 
*/

-- 회원들의 데이터를 담을 수 있는 테이블 만들기
-- 테이블명 : MEMBER
-- 컬럼종류 : 아이디, 비밀번호, 이름, 회원가입일
CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(20), -- 오라클에서는 대소문자 구분을 하지 않아, 낙타봉표기법 대신 언더바를 사용
    MEMBER_PWD VARCHAR2(16),
    MEMBER_NAME VARCHAR2(15),
    MEMBER_DATE DATE
    );

SELECT * FROM MEMBER; -- 테이블을 값 없이 작성 시, 내용물이 없는 상태로 출력됨.
SELECT * FROM MEMBER2; -- [오류] table or view does not exist  
                       -- 존재하지 않는 테이블을 조회시 오류가 발생함.

/*
 컬럼에 주석 달기(컬럼에 대한 설명)
 '열'탭에 COMMENT를 확인
 
 [표현법]
 COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS '회원 아이디';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS '회원 비밀번호';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS '회원 이름';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS '회원 가입일';

-- 참고) 해당 계정에 어떤 테이블, 컬럼명들이 존재하는지 알 수 있는 방법
-- DATA DICTIONARY : 다양한 객체들의 정보를 저장하고 있는 시스템 테이블(관리용)
SELECT TABLE_NAME FROM USER_TABLES;
-- USER_TABLES : 현재 접속해있는 계정이 가지고 있는 테이블의 전반적인 구조를 확인할 수 있음.
-- TABLE_NAME : 계정이 가지고 있는 테이블의 이름을 확인할 수 있음.

SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : 현재 이 계정이 가지고 있는 테이블들의 모든 컬럼의 정보를 조회할 수 있음.

SELECT * FROM MEMBER;
-- 데이터를 추가할 수 있는 구문 
-- INSERT : 한 행 단위로 추가. 값의 순서를 맞추어서 작성해주어야 함.
-- INSERT INTO 테이블명 VALUES(첫번째컬럼의값, 두번째컬럼의값, 세번째컬럼의값,...)
INSERT INTO MEMBER VALUES('user01','pass01','홍길동','2022-03-25');
INSERT INTO MEMBER VALUES('user02','pass02','김말똥','2022-03-26');
INSERT INTO MEMBER VALUES('user03','pass03','박개똥',SYSDATE);

INSERT INTO MEMBER VALUES('가나다라마바사','pass04','이동동',SYSDATE);
-- [오류] Value too large for column "DDL"."MEMBER"."MEMBER_ID" 
-- (actual: 21, maximum: 20)
-- 최대 20바이트까지 저장 가능한데, 21바이트짜리 값을 넣었을 경우 발생


-- 오류가 발생하지 않음. 단, 유효한 값이 아닌 값들이 들어가는 상황임
INSERT INTO MEMBER VALUES('user04', null, null, sysdate);
INSERT INTO MEMBER VALUES(null, null, null, sysdate);
-- 회원가입시 아이디, 비밀번호, 회원이름이 필수정보라 null이 아닌 값이 들어가야 함.

INSERT INTO MEMBER VALUES('user03', 'pass03', '고길동', sysdate);
-- 회원가입시 아이디, 비밀번호는 이미 사용중인 경우, 가입이 되지 않아 중복된 값이 존재하면 안됨.


-- 위의 null이나, 중복된 값은 유효하지 않은 값들임.
-- 유효한 데이터값을 유지하기 위해서는 '제약조건'을 걸어주어야 함.

----------------------------------------------------------------------------------
/*
 < 제약조건 CONSTRAINTS >
 - 원하는 데이터 값만 유지하기 위해서, 특정 컬럼마다 설정하는 제약
 - 유효한 값들만 보관하기 위해서, 해당 제약조건을 수행함.
 - 최대목적 : 데이터의 무결성(정확성)을 보장하기 위한 목적으로 사용
 -        : 구체적으로는 중복과 NULL에 대한 대비임.
 - 애초에 제약조건이 부여된 컬럼에 들어올 데이터의 문제가 있는지 없는지를 검사함. 
 
 - 종류 : NOT NULL, UNIQUE, CHECK, PRIMARY KEY(기본키), FOREIGN KEY(외래키)
 - 컬럼에 제약조건을 부여하는 방식 : 컬럼레벨방식, 테이블레벨방식
*/

/*
 1. NOT NULL 제약조건
 해당 컬럼(열)에 반드시 값이 존재해야 할 경우에만 사용함.
 NULL이 절대로 들어와서는 안되는 컬럼에 부여
 INSERT할때 / UPDATE할때도 마찬가지로 NULL을 허용하지 않도록 제한
 '열'탭의 NALLABLE을 확인
 '제약조건'탭의 SEARCH_CONDITION을 확인

 단, NOT NULL 제약조건은 컬럼레벨방식으로만 할 수 있음.
*/

-- NOT NULL 제약조건만 설정한 테이블 만들기
-- 컬럼레벨방식 : 컬럼명 자료형 제약조건
-- 회원번호, 아이디, 비밀번호, 이름
CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01','pass01','홍길동','남','010-1111-2222','aaa@naver.com');
INSERT INTO MEM_NOTNULL VALUES(2, null, null, null, null, null, null);
-- [오류] cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_ID")
-- NOT NULL 제약조건이 들어갔기 때문에, NULL은 들어갈 수 없음.

INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02', '김말똥', null, null, null);
INSERT INTO MEM_NOTNULL VALUES(3, 'user03', 'pass03', '박개똥', '여',null, null); 
-- NOT NULL 제약조건이 들어가지 않은 부분에는, NULL이 들어갈 수 있음.

---------------------------------------------------------------------------------------------
/*
 2. UNIQUE 제약조건
 컬럼에 중복값을 제한하는 제약조건
 INSERT(삽입) / UPDATE(수정)시, 기존 해당 컬럼값 중  중복값이 있을 경우
 추가 또는 수정이 되지 않게끔 제약
 '제약조건'탭에 CONSTRAINT_TYPE획인 
 
 컬럼레벨 / 테이블레벨 방식 둘다 가능
*/

-- UNIQUE 제약조건을 추가한 테이블 생성
-- 컬럼 레벨 방식
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);    

SELECT * FROM MEM_UNIQUE;

-- 테이블 레벨 방식
CREATE TABLE MEM_UNIQUE( -- [오류] name is already used by an existing object
                         -- 테이블명 중복시 다음과 같은 오류가 발생함.
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEM_ID) -- 테이블 레벨 방식의 제약 조건
);

SELECT * FROM MEM_UNIQUE;

-- 테이블을 삭제시킬 수 있는 구문
DROP TABLE MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','홍길동','남','010-1234-1234','abc@gmail.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02','pass02','김말똥',null,null,null);

INSERT INTO MEM_UNIQUE VALUES(3, 'user02','pass02','고영희',null,null,null);
-- [오류] unique constraint (DDL.SYS_C007089) violated
-- UNIQUE 제약조건이 걸려있을 경우, 중복값을 입력 시 오류 발생
-- 테이블- 제약조건탭 - C007089은 MEM_ID임
-- 제약조건 부여시, 직접 제약조건명을 부여하지 않으면 C007089처럼 시스템에서 임의의 제약조건명을 부여해줌

/*
 < CONSTRAINT >
 제약조건 부여시 제약조건명을 지정
 
 - 컬럼레벨 방식일 경우
 CREATE TABLE 테이블명(
    컬럼명 자료형 CONSTRAINT 제약조건명 제약조건, 
    컬럼명 자료형
    ...
 )   
 
 -- 테이블레벨 방식일 경우
 CREATE TABLE 테이블명(
    컬럼명, 자료형
    컬럼명, 자료형
    ...
    컬럼명, 자료조건
    CONSTRAINT 제약조건명 제약조건(컬럼명)
 )
 
 이때, 두 방식 모두 CONSTRAINT 제약조건명 부분은 생략이 가능함(생략시 임의로 이름이 붙음)
 => SYS_C007092
*/

-- 제약조건명 붙이는 연습
CREATE TABLE MEM_CON_NAME(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NOTNULL NOT NULL, -- 컬럼 레벨 제약조건명
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UNIQUE UNIQUE (MEM_ID) -- 테이블 레벨 제약조건면
);

SELECT * FROM MEM_CON_NAME;

INSERT INTO MEM_CON_NAME VALUES(1, 'user01', 'pass01', '홍길동', NULL, NULL, NULL);
-- INSERT INTO MEM_CON_NAME VALUES(2, 'user01','pass02','고길동',null,null,null);
-- [오류] unique constraint (DDL.MEM_ID_UNIQUE) violated
-- MEM_ID가 중복되어서 발생하는 오류임.
-- 제약조건명을 지어줄 경우에는 컬럼명, 제약조건의 종류를 적절히 섞어서 지어주는 것이 오류 파악에 도움됨.

SELECT * FROM MEM_CON_NAME;

----------------------------------------------------------------------------------
INSERT INTO MEM_CON_NAME VALUES(2, 'user02','pass02', '고길동', '가', NULL, NULL);
-- GENDER 컬럼에 '남' 또는 '여'만 들어가게끔 하고 싶음.
/*
 3. CHECK 제약조건
 컬럼에 기록될 수 있는 값에 대한 조건을 설정해 둘 수 있는 제약 조건
 '제약조건'탭에 SEARCH_CONDITION을 확인
 CHECK(조건식)
*/

-- CHECK 제약조건이 추가된 테이블
CREATE TABLE MEM_CHECK (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('남','여')) NOT NULL, -- 제약조건간 순서는 무관
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL
);
SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', '홍길동', '남', '010-1111-1111', null, SYSDATE);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '김갑생', null, null, null, SYSDATE);
-- CHECK제약조건에 해당 컬럼값으로 제한하고, 더해서 NULL로 INSERT도 할 수 있음.
-- 만약, 여기서 NULL을 못넣게 하고 싶으면, 제약조건에 NOT NULL을 추가해주면 됨.

INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', '김말똥', '가', null, null, SYSDATE);
-- [오류] check constraint (DDL.SYS_C007100) violated
-- CHECK 제약조건을 위반하여 생기는 오류임
-- '남'과 '여'가 아닌 다른 값으로 컬럼을 생성하는데 생기는 오류임

--------------------------------------------------------------------------------
-- 회원가입일을 항상 SYSDATE로 받고싶은 경우, 테이블 생성시 지정 가능함.(기본값 설정 옵션)

/*
 < DEFAULT > 
 특정 컬럼에 들어올 값에 대하여, 기본값으로 설정 가능함.
 단, DEFAULT는 제약조건이 아님
 '열'탭에 DATA_DEFAULT를 확인
*/

-- MEM_CHECK 테이블 삭제
DROP TABLE MEM_CHECK;

-- 기존의 MEM_CHECK 테이블에 DEFAULT설정까지 추가
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE not null
);
SELECT * FROM MEM_CHECK;

/*
 INSERT INTO 테이블명 VALUES(값1, 값2,...); 
 => 항상 값들의 개수는 테이블의 컬럼의 개수와 일치, 순서도 일치
 
 INSERT INTO 테이블명(컬럼명1, 컬럼명2, 컬럼명3) VALUES (값1, 값2, 값3);
 => 일부의 컬럼의 값만 넣고 싶을때 사용함.
*/

INSERT INTO MEM_CHECK 
VALUES(1, 'user01','pass01', '홍길동', '남', null, null);
-- [오류] not enough values
-- DEFAULT설정을 했음에도, value가 충분하지 않다고 뜸.

INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES(1, 'user01','pass01', '홍길동');
-- 지정이 안된 컬럼에는 기본적으로 null이 채워져서 한 행이 추가됨
-- 만약, default 설정이 되어있다면, null이 아니라 default가 추가되는 것을 확인할 수 있음.

INSERT INTO MEM_CHECK 
VALUES(2, 'user02', 'pass02','고길동',null, null, null, default);
-- DEFAULT 제약조건을 걸 자리에 DEFAULT를 넣어줘도 됨.

INSERT INTO MEM_CHECK 
VALUES(3, 'user03', 'pass03', '김말똥', null, null, null, '21/03/25');
-- DEFAULT설정 시 다른값을 담아도 무관
-------------------------------------------------------------------------------

/*
 4. PRIMARY KEY(기본키) 제약조건
 테이블에서 각 행들의 정보를 유일하게 식별해줄 수 있는 컬럼에 부여하는 제약조건
 각 행 한줄 한줄마다 구분할 수 있는 식별자의 역할(자바 컬랙션에서 MAP계열의 KEY와 같음.)
 '제약조건'탭에 CONSTRAINT_TYPE에서 확인 
 예) 주민등록번호, 사번, 학번, 예약번호, 아이디, 회원번호
 => 중복되지 않고, 값이 존재해야만 하는 컬럼에 PRIMARY KEY를 부여(UNIQUE, NOT NULL)
 
 단, 한 테이블당 한개의 PRIMARY KEY 제약조건만 존재해야 함.
 - PRIMARY KEY 제약조건을 컬럼 한개에만 거는 것
 
 - PRIMARY KEY 제약조건을 컬럼 여러개를 묶어서 한번에 거는 것(복합키)
   =>(굳이 이렇게 할 필요는 없음.)
*/

-- PRIMARY KEY 제약조건을 추가한 테이블 생성
CREATE TABLE MEM_PRIMARY_KEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, --컬럼레벨 방식
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN('남','여')),
    PHONE VARCHAR2(15), 
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE
);   
SELECT * FROM MEM_PRIMARY_KEY1;

INSERT INTO MEM_PRIMARY_KEY1
VALUES(1, 'user01', 'pass01','홍길동','남',NULL, NULL, DEFAULT);

INSERT INTO MEM_PRIMARY_KEY1
VALUES(1, 'user02', 'pass02','김말똥',NULL ,NULL, NULL, DEFAULT);
-- [오류] unique constraint (DDL.MEM_PK) violated
-- PRIMARY KEY가 중복 되었을 경우, 오류내용은 UNIQUE 제약조건 위배로 나옴.
-- 이 경우에는 제약조건명을 갖고 정확히 UNIQUE인지 PRIMARY KEY인지를 찾아가야 함.
-- 따라서, PRIMARY KEY 오류에 대비하여 제약조건명을 확실히 해줌(테이블명_PK)


-- NULL이 허용되나?
INSERT INTO MEM_PRIMARY_KEY1
VALUES(NULL, 'user02', 'pass02','김말똥',NULL ,NULL, NULL, DEFAULT);
-- [오류] cannot insert NULL into ("DDL"."MEM_PRIMARY_KEY1"."MEM_NO")
-- 당연히 PRIMARY KEY에는 NULL이 들어갈 수 없음.(NOT NULL 위배)
-- (계정명.테이블명.컬럼명)으로 오류가 뜸.

INSERT INTO MEM_PRIMARY_KEY1
VALUES(2, 'user02', 'pass02','김말똥',NULL ,NULL, NULL, DEFAULT);

-- PRIMARY KEY 제약조건을 추가한 테이블 생성
CREATE TABLE MEM_PRIMARY_KEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN('남','여')),
    PHONE VARCHAR2(15), 
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEM_PK2 PRIMARY KEY (MEM_NO) -- 테이블 레벨 방식
); 
-- [오류] name already used by an existing constraint
-- 아무리 다른 테이블의 제약조건이더라도, 제약조건명이 중복되면 안됨.
SELECT * FROM MEM_PRIMARY_KEY2;

-- 복합키 : 여러 컬럼을 묶어서 한번에 PRIMARY KEY제약조건을 주는 것
CREATE TABLE MEM_PRIMARY_KEY3(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE
); 
-- [오류] "table can have only one primary key"
-- 테이블에 2개 이상의 PRIMARY KEY 제약조건을 걸 시 나타나는 오류임.
-- PRIMARY KEY가 한 테이블에 2개 이상이 될 수 없음.
-- 단, 컬럼을 여러개 묶어서 한개의 PRIMARY KEY로 나타내는 것은 할 수 있음.

CREATE TABLE MEM_PRIMARY_KEY3(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(MEM_NO,MEM_ID) -- 복합키는 테이블 레벨 방식으로만 작성 가능
    -- 컬럼을 묶어서 PRIMARY KEY 하나로 설정된 것을 볼 수 있음.
); 

INSERT INTO MEM_PRIMARY_KEY3
VALUES(1, 'user01', 'pass01','홍길동',NULL ,NULL, NULL, DEFAULT);

SELECT * FROM MEM_PRIMARY_KEY3;

INSERT INTO MEM_PRIMARY_KEY3
VALUES(1, 'user02', 'pass02','김영희',NULL ,NULL, NULL, DEFAULT);
-- 복합키의 경우, 해당 컬럼에 들은 값들이 완전히 다 일치해야만 중복으로 판별
-- 만일 하나라도 값이 다를 경우, 중복으로 판별이 안됨.

INSERT INTO MEM_PRIMARY_KEY3
VALUES(2, NULL, 'pass02','김영희',NULL ,NULL, NULL, DEFAULT);
-- [오류] cannot insert NULL into ("DDL"."MEM_PRIMARY_KEY3"."MEM_ID")
-- 복합키의 경우, 복합키에 해당하는 컬럼값들 중 하나라도 NULL이 들어가면 안됨.

---------------------------------------------------------------------------------
/*
  < FOREIGN KEY(외래키) 제약조건
  해당 컬럼에 다른 테이블에 존재하는 값만 들어와야되는 컬럼에 부여하는 제약조건
  예시) EMPLOYEE테이블의 JOB_CODE컬럼에 들은 값들은 
       반드시 JOB테이블의 JOB_CODE컬럼에 들은 값들로 이루어져 있어야 함.
       그 이외의 값은 들어오면 안됨.
       => EMPLOYEE테이블 입장에서 JOB테이블의 컬럼값을 끌어다가 '참조'함.
       => EMPLOYEE테이블 입장에서 JOB테이블을 부모테이블이라고 표현 가능
       => JOB테이블 입장에서 EMPLOYEE테이블을 자식테이블이라고 표현 가능
       
  => 다른 테이블(부모테이블)을 '참조'한다고 표현함.(Reference)
  => 즉, 참조된 다른 테이블이 제공하고 있는 값만, 해당 외래키 설정이 되어있는 컬럼에 들어올 수 있음.
  => FOREIGN KEY 제약조건으로, 다른 테이블간의 관계를 형성할 수 있음 == JOIN
  
  [표현법]
  - 컬럼레벨 방식
  컬럼명 자료형 [CONSTRAINT 제약조건명] REFERENCES 참조할테이블명(컬럼명)
  ...
  
  - 테이블레벨 방식
  컬럼명 자료형,
  [CONSTRAINT제약조건명] FOREIGN KEY (제약조건을걸컬럼명) REFERENCES 참조할테이블명(참조할컬럼명)
  
  단, 두 방식 모두 참조할컬렴명은 생략 가능함.
  이 경우, 기본적으로 참조할테이블의 PRIMARY KEY 컬럼으로 참조할컬럼명이 자동으로 잡힘.
  CONSTRAINT 제약조건은 생략 가능함.(SYS_C007092)
*/

-- 테스트를 위한 부모테이블 생성
-- 회원등급, 회원구분
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES('G1', '일반회원');
INSERT INTO MEM_GRADE VALUES('G2', '우수회원');
INSERT INTO MEM_GRADE VALUES('G3', '특별회원');

-- 자식테이블(외래키 제약조건 걸어보기)
CREATE TABLE MEM(
  MEM_NO NUMBER PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),-- 컬럼레벨 방식
  GENDER CHAR(3) CHECK (GENDER IN('남','여')),
  PHONE VARCHAR2(15),
  EMAIL VARCHAR2(30),
  MEM_DATE DATE DEFAULT SYSDATE
);
SELECT * FROM MEM;
DROP TABLE MEM;
INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '홍길동', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '김말똥', 'G2', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '고영희', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(4, 'user04', 'pass04', '박개똥', NULL , NULL, NULL, NULL, DEFAULT); 
-- 외래키 제약조건이 걸려있는 컬럼에는 기본적으로 NULL이 들어갈 수 있음(CHECK제약조건처럼)
-- 따라서, NOT NULL 제약조건을 추가로 걸어주어야 함.

INSERT INTO MEM 
VALUES(5, 'user05', 'pass05', '고길동', 'G5' , NULL, NULL, NULL, DEFAULT); 
-- [오류] integrity constraint (DDL.SYS_C007170) violated - parent key not found
-- 'G5'가 부모테이블인 MEM_GRADE테이블의 GRADE_CODE컬럼에서 제공하는 값이 아니기 때문에 오류 발생

-- 문제) 부모테이블인 MEM_GRADE에서 데이터값이 삭제된다면
-- MEM_GRADE 테이블로부터 GRADE_CODE가 G1인 데이터를 지우기
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- [오류] integrity constraint (DDL.SYS_C007170) violated - child record found
-- 자식테이블인 MEM 중에 G1이라는 값을 사용하고 있는 행들이 존재하기 때문에, 부모 값을 삭제할 수 없음.
-- 현재 외래키 제약조건 부여시, 추가적으로 삭제 옵션을 부여하지않았음.
-- => 자식테이블에서 사용하고 있는 값이 있을 경우, 삭제가 되지 않는 삭제제한옵션이 기본값으로 부여되어 있음.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';

SELECT * FROM MEM_GRADE;
-- G3이라는 값은 자식테이블에서 사용하고 있지 않기에, 잘 삭제된 것을 볼 수 있음.

-- 테스트했던 사항 이전의 상태로 되돌리기
ROLLBACK;

-- MEM 테이블 삭제
DROP TABLE MEM;

/*
 자식테이블을 생성 시(외래키 제약조건을 부여할 시)
 부모테이블의 데이터가 삭제되었을 때, 자식테이블에서는 삭제된 값에 대하여 어떤 처리를 할 것인지
 옵션으로 정할 수 있음.
 
 FOREIGN KEY 삭제옵션
 - ON DELETE RESTRICTED : 삭제옵션을 별도로 제시하지 않았을 때(기본값) => 삭제제한(자식테이블에서 해당 값 참조시)
 - ON DELETE SET NULL : 부모데이터를 삭제 시, 해당 데이터를 사용하는 자식데이터를 NULL로 변경
 - ON DELETE CASCADE : 부모데이터를 삭제 시, 해당 데이터를 사용하는 자식데이터도 같이 삭제
*/

-- 1) ON DELETE SET NULL : 부모데이터 삭제시, 자식데이터를 NULL로 변경
CREATE TABLE MEM(
  MEM_NO NUMBER PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3) CHECK (GENDER IN('남','여')),
  PHONE VARCHAR2(15),
  EMAIL VARCHAR2(30),
  MEM_DATE DATE DEFAULT SYSDATE,
  GRADE_ID CHAR(2),
  FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
); 

DROP TABLE MEM;
DROP TABLE MEM_GRADE;
SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '홍길동', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '김말똥', 'G2', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '고영희', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(4, 'user04', 'pass04', '박개똥', NULL , NULL, NULL, NULL, DEFAULT); 

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- 자식테이블임에도 삭제가 잘 된 것을 볼 수 있음.

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;
-- 삭제됨과 동시에 GRADE_ID부분에서 G1에 해당하는 값이 NULL로 변한것을 볼 수 있음.

ROLLBACK;
-- 그동한 테스트했던거 되돌리기

DROP TABLE MEM;
-- MEM 테이블 삭제

-- 2) ON DELETE CASCADE : 부모데이터를 삭제했을 때, 자식데이터를 같이 삭제
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('남','여')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE,
    GRADE_ID CHAR(2),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE -- 테이블레벨 방식
);

SELECT * FROM MEM;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', '홍길동', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '김말똥', 'G2', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '고영희', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(4, 'user04', 'pass04', '박개똥', NULL , NULL, NULL, NULL, DEFAULT); 

SELECT * FROM MEM;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 'G1';
-- 부모테이블(MEM_GRADE)의 G1을 삭제

SELECT * FROM MEM_GRADE;
-- 자식테이블에서 참조하고 있는데도, 잘 삭제된 것을 볼 수 있음.

SELECT * FROM MEM;
-- 자식테이블(MEM)의 GRADE_ID가 G1인 행들은 삭제되었음.

-- [참고]
-- 외래키와 조인
-- 전체 회원의 회원번호, 아이디, 비밀번호, 이름, 등급명 조회
--> 오라클 전용 구문
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM , MEM_GRADE 
WHERE GRADE_ID = GRADE_CODE(+);

--> ANSI구문
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM 
LEFT JOIN MEM_GRADE ON(GRADE_ID = GRADE_CODE);

/*
 굳이, 외래키 제약조건이 걸려있지 않더라도 JOIN이 가능함.
 다만, 두 컬럼에 동일한 의미의 데이터만 담겨있다면, 참조해서 JOIN으로 조회 가능함.
 => EMPLOYEE테이블의 제약조건탭을 보면 FOREIGN KEY에 대한 제약조건이 적혀있지 않음
*/

ROLLBACK;
DROP TABLE MEM;

-- [참고] : 서브쿼리를 이용한 테이블 생성(테이블 복사의 개념)
/*
 -- 여기서부터는 KH계정으로 접속해서 테스트 --
 서브쿼리를 이용한 테이블 생성 (테이블을 복사 뜨는 개념)
 서브쿼리 : 메인 SQL문(SELECT, CREATE, INSERT, UPDATE)를 보조역할하는 쿼리문(SELECT)
 
 [표현법]
 CREATE TABLE 테이블명
 AS (서브쿼리);
 
 해당 서브쿼리를 실행한 결과를 이용해서,
 새로이 테이블을 생성하는 개념.
*/

-- EMPLOYEE 테이블을 복제한 새로운 테이블 생성 (EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY
AS (SELECT * 
    FROM EMPLOYEE);
    --> 컬럼들, 조회결과의 데이터값들이 잘 복사됨.
    --> 추가적으로, 제약조건의 경우, NOT NULL만 복사만 됨.
SELECT * FROM EMPLOYEE_COPY;

-- EMPLOYEE 테이블에 있는 컬럼의 구조만 복사하고 싶음(데이터값은 필요없는 경우)
/*
CREATE TABLE EMPLOYEE_COPY2(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20), 
    ...
);
*/
CREATE TABLE EMPLOYEE_COPY2
AS (SELECT *
    FROM EMPLOYEE
    WHERE 1 = 0) ; -- 조건문을 거짓으로 하여, 데이터값 없이 구조만 가져올 수 있음.
    
SELECT * FROM EMPLOYEE_COPY2;

-- 전체 사원들 중 급여가 300만원 이상인 사원들의
-- 사번, 이름, 부서코드, 급여를 복제
CREATE TABLE EMPLOYEE_COPY3
AS(SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
   FROM EMPLOYEE
   WHERE SALARY >= 3000000);

SELECT * FROM EMPLOYEE_COPY3;

-- 전체사원의 사번, 사원명, 급여, 연봉 조회겨로가 테이블을 생성
CREATE TABLE EMPLOYEE_CODY4
AS(SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12
   FROM EMPLOYEE);
-- [오류] must name this expression with a column alias
-- 서브쿼리의 SELECT절 부분에 산술연산, 함수식이 기술된 경우, 반드시 별칭을 부여해주어야 함.

CREATE TABLE EMPLOYEE_COPY4
AS (SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12"연봉"
    FROM EMPLOYEE);

SELECT * FROM EMPLOYEE_COPY4;

-- [참고] 기존 테이블에 제약조건을 추가하는 방법
/*
 테이블이 이미 다 생성된 후, 뒤늦게 제약조건을 추가
 ALTER TABLE 테이블명
 - PRIMARY KEY : ADD PRIMARY KEY(컬럼명);
 - FOREIGN KEY : ADD FOREIGN KEY(컬럼명) REFERENCES 참조할테이블명(참조할컬럼명);
 참조할 컬럼명은 생략 가능, 이 경우 참조할테이블명의 PRIMARY KEY로 잡힘.
 - UNIQUE : ADD UNIQUE(컬럼명);
 - CHECK : ADD CHECK(조건식);
 - NOT NULL : MODIFY 컬럼명 NOT NULL;
*/

-- EMPLOYEE_COPY 테이블에 없는 PRIMARY KEY 제약조건을 추가(EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

-- EMPLOYEE_COPY테이블에 DEPT_CODE 컬럼에 외래키 제약조건을 추가(DEPARTMENT)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

-- EMPLOYEE_COPY 테이블에 JOB_CODE 컬럼에 외래키 제약조건을 추가(JOB)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY (JOB_CODE) REFERENCES JOB (JOB_CODE);



-- 실습 문제 --
-- 도서관리 프로그램을 만들기 위한 테이블들 만들기 --
-- 이때, 제약조건에 이름을 부여할것
-- 각 컬럼에 주석 달기

-- 1. 출판사들에 대한 데이터를 담기 위한 출판사 테이블 (TB_PUBLISHER)
-- 컬럼 : PUB_NO (출판사번호) -- 기본키 (PUBLISHER_PK)
--        PUB_NAME (출판사명) -- NOT NULL (PUBLISHER_NN)
--        PHONE (출판사전화번호) -- 제약조건 없음
-- 주석 추가
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '출판사 번호';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '출판사명';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '출판사 전화번호';

-- 3개 정도의 샘플 데이터 추가하기
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,      -- 출판사 번호
    PUB_NAME VARCHAR2(30) CONSTRAINT PUBLISHER_NN NOT NULL, -- 출판사 명
    PHONE VARCHAR2(15)                                      -- 출판사 전화번호
);
-- INSERT문
INSERT INTO TB_PUBLISHER VALUES(1, '한빛누리', '010-1111-1111');
INSERT INTO TB_PUBLISHER VALUES(2, '두리미디어', '010-2222-2222');
INSERT INTO TB_PUBLISHER VALUES(3, '세빛섬', '010-3333-3333');
-- SELECT문
SELECT * FROM TB_PUBLISHER;

-- 2. 도서들에 대한 데이터를 담기 위한 도서 테이블 (TB_BOOK)
-- 컬럼 : BK_NO (도서번호) -- 기본키 (BOOK_PK)
--        BK_TITLE (도서명) -- NOT NULL (BOOK_NN_TITLE)
--        BK_AUTHOR (저자명) -- NOT NULL (BOOK_NN_AUTHOR)
--        BK_PRICE (가격)
--        BK_PUB_NO (출판사번호) -- 외래키(BOOK_FK) (TB_PUBLISHER 테이블을 참조하도록)
--                                 이 때, 참조하고 있는 부모데이터 삭제 시 자식 데이터도 삭제 되도록 한다.
-- 주석 추가
COMMENT ON COLUMN TB_BOOK.BK_NO IS '도서번호';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '도서명';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '저자명';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '도서 가격';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '출판사 번호';
-- 5개 정도의 샘플 데이터 추가하기
CREATE TABLE TB_BOOK(
    BK_NO NUMBER PRIMARY KEY,                                   -- 도서번호
    BK_TITLE VARCHAR2(30) CONSTRAINT BOOK_NN_TITLE NOT NULL,    -- 도서명
    BK_AUTHOR VARCHAR2(10) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,  -- 저자명
    BK_PRICE NUMBER,                                            -- 가격    
    BK_PUB_NO REFERENCES TB_PUBLISHER ON DELETE CASCADE         -- 출판사 번호(외래키)
);     
-- INSERT문
INSERT INTO TB_BOOK VALUES(1, '자바의 정석','남궁성',12000,1);
INSERT INTO TB_BOOK VALUES(2, '수학의 정석','김수학',13000,2);
INSERT INTO TB_BOOK VALUES(3, '국어의 정석','김국어',14000,3);
INSERT INTO TB_BOOK VALUES(4, '영어의 정석','김영어',15000,2);
INSERT INTO TB_BOOK VALUES(5, '국사의 정석','김국사',16000,1);
--SELECT문
SELECT BK_NO, BK_TITLE, BK_AUTHOR, BK_PRICE, BK_PUB_NO, PUB_NAME
FROM TB_PUBLISHER, TB_BOOK
WHERE BK_PUB_NO = PUB_NO; -- TB_BOOK의 출판사 번호와 TB_PUBLISHER의 출판사 번호를 JOIN


-- 3. 회원에 대한 데이터를 담기 위한 회원 테이블 (TB_MEMBER)
-- 컬럼명 : MEMBER_NO (회원번호) -- 기본키 (MEMBER_PK)
--         MEMBER_ID (아이디) -- 중복금지 (MEMBER_UQ)
--         MEMBER_PWD (비밀번호) -- NOT NULL (MEMBER_NN_PWD)
--         MEMBER_NAME (회원명) -- NOT NULL (MEMBER_NN_NAME)
--         GENDER (성별) -- 'M' 또는 'F' 로 입력되도록 제한 (MEMBER_CK_GEN)
--         ADDRESS (주소)
--         PHONE (연락처)
--         STATUS (탈퇴여부) -- 기본값으로 'N' 으로 지정, 그리고 'Y' 혹은 'N' 으로만 입력되도록 제약조건 (MEMBER_CK_ST)
--         ENROLL_DATE (가입일) -- 기본값으로 SYSDATE, NOT NULL 제약조건 (MEMBER_NN_EN)
-- 주석 추가하기
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS '회원번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '멤버아이디';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '멤버비밀번호';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS '회원명';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '성별';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '주소';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '전화번호';
COMMENT ON COLUMN TB_MEMBER.STATUS IS '탈퇴여부';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '가입일';
-- 5개 정도의 샘플 데이터 추가하기
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,                                     -- 회원번호
    MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_UQ UNIQUE,                                    -- 멤버 아이디
    MEMBER_PWD VARCHAR2(30) CONSTRAINT MEMBER_NN_PWD NOT NULL,                             -- 멤버 비밀번호
    MEMBER_NAME VARCHAR2(15) CONSTRAINT MEMBER_NN_NAME NOT NULL,                           -- 회원명
    GENDER CHAR(3) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN('M','W')),                     -- 성별
    ADDRESS VARCHAR2(30),                                                                  -- 주소
    PHONE VARCHAR2(30),                                                                    -- 전화번호
    STATUS VARCHAR2(30) DEFAULT 'N' CONSTRAINT MEMBER_CK_ST CHECK (STATUS IN('Y','N')),    -- 탈퇴여부     
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL);                    -- 가입일 
-- INSERT문
INSERT INTO TB_MEMBER VALUES(1, 'user01', 'pass01','username1',NULL, NULL, NULL, NULL, '2021/02/22'); -- CHECK제약조건에 NULL
INSERT INTO TB_MEMBER VALUES(2, 'user02', 'pass02','username2','M', NULL, NULL,DEFAULT ,DEFAULT ); -- DEFAULT 설정
INSERT INTO TB_MEMBER VALUES(3, 'user03', 'pass03','username3','W', NULL, NULL, 'Y' , SYSDATE ); -- SYSDATE설정
INSERT INTO TB_MEMBER VALUES(4, 'user04', 'pass04','username4','M', NULL, NULL,'N' ,SYSDATE );
INSERT INTO TB_MEMBER VALUES(5, NULL, 'pass05','username5','W', NULL, NULL,NULL ,SYSDATE);
-- SELECT문
SELECT * FROM TB_MEMBER;

-- 4. 어떤 회원이 어떤 도서를 대여했는지에 대한 대여목록 테이블 (TB_RENT)
-- 컬럼 : RENT_NO (대여번호) -- 기본키 (RENT_PK)
--       RENT_MEM_NO (대여회원번호) -- 외래키 (RENT_FK_MEM) TB_MEMBER 와 참조하도록
--                                    이 때, 부모 데이터 삭제 시 자식 데이터 값이 NULL 이 되도록 옵션 설정
--       RENT_BOOK_NO (대여도서번호) -- 외래키 (RENT_FK_BOOK) TB_BOOK 와 참조하도록
--                                     이 때, 부모 데이터 삭제 시 자식 데이터 값이 NULL 값이 되도록 옵션 설정
--       RENT_DATE (대여일) -- 기본값 SYSDATE
-- 주석추가
COMMENT ON COLUMN TB_RENT.RENT_NO IS '대여번호';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '대여 회원번호';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '대여 도서번호';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '대여 날짜';
-- 3개 정도의 샘플 데이터 추가하기
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,                                              -- 대여 번호                                 
    RENT_MEM_NO NUMBER REFERENCES TB_MEMBER ON DELETE SET NULL,  -- 컬럼레벨 방식                  -- 대여 회원번호(외래키)                
    RENT_BOOK_NO NUMBER,                                                                        -- 대여 도서번호(외래키)   
    RENT_DATE DATE DEFAULT SYSDATE,                                                             -- 대여 일
    CONSTRAINT RENT_FK_BOOK FOREIGN KEY(RENT_BOOK_NO) REFERENCES TB_BOOK ON DELETE SET NULL      
    -- 테이블 레벨 방식
);
-- INSERT문
INSERT INTO TB_RENT VALUES(1, 1, 1, DEFAULT);
INSERT INTO TB_RENT VALUES(2, 2, 2, DEFAULT);
INSERT INTO TB_RENT VALUES(3, 3, 3, DEFAULT);
-- SELECT문
SELECT RENT_NO, RENT_MEM_NO,MEMBER_NAME, RENT_BOOK_NO, BK_TITLE, RENT_DATE
FROM TB_RENT
JOIN TB_BOOK ON(BK_NO = RENT_BOOK_NO) -- TB_RENT테이블의 RENT_BOOK_NO와 TB_BOOK테이블의 BK_NO를 조인
JOIN TB_MEMBER ON(MEMBER_NO = RENT_MEM_NO); -- TB_RENT테이블의 RENT_MEM_NO와 TB_MEMBER테이블의 MEMBER_NO를 조인


COMMIT;
