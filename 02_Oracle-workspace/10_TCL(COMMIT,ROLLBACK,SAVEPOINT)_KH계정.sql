/*
 TCL(TRANSACTION CONTROL LANGUAGE>
 트랜젝션을 제어하는 언어
 
 트랜젝션(TRANSACTION)
 - 데이터베이스의 논리적 연산단위
 - 하나의 작업 단위(로그인 기능, 회원가입 기능, 게시글 작성기능, 게시글 수정기능, ...)
 - 한 트랜젝션 안에는 한개의 쿼리문만 존재할수도 있지만
                   여러개의 쿼리문이 순차적으로 존재하는 경우도 많음.
 - 데이터의 변경사항(DML)들을 하나의 트랜젝션으로 묶어서 처리
 - COMMIT(확정)하기 전까지의 변경사항들을 킵해뒀다가, 모두 다 성공했을 경우에만 확정함.
 - 트랜젝션의 대상이 되는 SQL : DML(INSERT, UPDATE, DELETE)
 - DDL은 트랜젝션의 대상이 되지 않음.
 
 
 COMMIT : 트랜젝션 종료 처리 후 "확정"
 ROLLBACK : 트랜젝션을 취소(되돌리기)
 SAVEPOINT : 임시저장점
 
 [표현법]
 - COMMIT : 하나의 트랜젝션에 담겨있는 변경사항들을 실제 DB에 반영
            실제 DB에 반영시킨 후, 트랜젝션은 비워짐
 - ROLLBACK : 하나의 트랜젝션에 담겨있는 변경사항들을 삭제한 후, 마지막 COMMIT 시점으로 되돌림.
 - SAVEPOINT 세이브포인트명; : 현재 이 시점까지의 임시저장점을 정의함.
                            임시저장점의 구분을 위해서 세이브포인트명을 붙여줌.
 - ROLLBACK TO 세이브포인트명; : 전체 변경사항들을 전체 다 되돌리는 것이 아니라
                           해당 포인트 지점까지의 트랜젝션만 롤백함.
                           (세이브포인트 지정 전 시점은 아직 유효한 트랜젝션)
*/
SELECT * FROM EMP_01; -- 25명의 사원정보

-- 사번이 901번인 사원을 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 901; -- 24명

DELETE FROM EMP_01
WHERE EMP_ID = 900; 
-- 23명이 조회되지만, 확정은 되지 않은 상태

ROLLBACK; -- 이 시점에서 위의 DELETE 구문이 2번 실행되기 이전의 시점으로 되돌아감.

------------------------------------------------------------------------------

-- 다시 25명인 상황
-- 사번이 200번인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 200;

-- 24명이 조회는 되지만, 확정은 되지 않은 상태


-- 사번이 800, 이름이 홍길동, 부서는 총무부인 사원을 추가
INSERT INTO EMP_01
VALUES(800,'홍길동','총무부');

-- 25명이 조회는 되지만
-- 200번 사원은 삭제되었고, 800번 사원이 추가된 상태(확정은 안됨)
COMMIT; -- 이 시점을 기준으로 위의 상태가 확정됨.

SELECT * FROM EMP_01;

ROLLBACK; -- 마지막 COMMIT명령어가 실행된 시점으로 되돌아감.

SELECT * FROM EMP_01; -- ROLLBACK 실행전과 실행후의 SELECT 결과가 똑같음.
-- ROLLBACK전후로 INSERT, UPDATE, DELETE가 한번도 일어나지 않았기 때문.

-------------------------------------------------------------------------------
-- 25명(200번 없고 800번있는상태) 

-- 사번이 217, 216, 214인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN(217,216,214);

-- 이 시점에서 22명이 조회될 것임(확정은 안됨)
SELECT * FROM EMP_01;

-- 3개의 행이 삭제된 시점에서 SAVEPOINT 지정
SAVEPOINT SP1; -- 나중에 ROLLBACK을 하더라도, 여기까지는 킵해두겠다.
 
-- 사번 801, 이름 김말똥, 부서 인사부인 사원 추가
INSERT INTO EMP_01
VALUES(801, '김말똥', '인사부');

SELECT * FROM EMP_01; -- 23명이 조회됨(확정은 안됨)

-- 사번이 218번인 사원을 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 218;

SELECT * FROM EMP_01; -- 22명이 조회됨(확정은 아님)

-- ROLLBACK을 하되, SP1이전까지만 ROLLBACK함
ROLLBACK TO SP1;

SELECT * FROM EMP_01; -- 75행의 시점으로 돌아가 22명이 조회됨.(81행부터의 DML을 무효화)

-------------------------------------------------------------------------------

-- [ 참고 ]
-- 22명이 조회되는 상황(확정은 아님)
-- 사번이 900, 901번인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID IN(900,901);

SELECT * FROM EMP_01; -- 20명이 남은 상황(확정은 아님)

-- 사번이 218인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 218; 

SELECT * FROM EMP_01;-- 19명이 남은 상황(확정은 아님)

-- 60번 이후의 줄은 확정이 아님. 중간에 세이브포인트가 잡혀 있더라도
-- 이 시점에서 ROLLBACK을 때려버리면, 58번의 시점으로 돌아감.(COMMIT 시점) - 25명
-- 이 시점에서 ROLLBACK TO를 때려버리면, 78번의 시점으로 돌아감.(SAVEPOINT 시점) - 22명
-- 이 시점에서 COMMIT을 때려버리면, 111번의 시점이 확정되어 19명이 조회됨.

-- 테이블 생성(DDL)
CREATE TABLE TEST(
    TID NUMBER
);

SELECT * FROM EMP_01; -- 19명이 조회됨(확정됨).

ROLLBACK;

SELECT * FROM EMP_01; -- 테이블이 커밋 역할을 하지 않으면 25명 / 커밋 역할을 하면 19명
-- 결과는 19명

-- 사번이 800번인 사원 삭제
DELETE FROM EMP_01
WHERE EMP_ID = 800;

SELECT * FROM EMP_01; -- 18명이 조회됨(확정은 아님)

ROLLBACK;

SELECT * FROM EMP_01; -- 19명이 조회됨.

/*
    DDL구문(CREATE, ALTER, DROP)을 실행하는 순간,
    기존에 트랜젝션에 있던 모든 변경사항들이 무조건 실제 DB에 반영(COMMIT)이 된 다음에
    DDL이 실행됨. 
    => 즉, DDL 수행 전, 변경사항이 있었다면 정확히 픽스(COMMIT, ROLLBACK)을 실행해야 함.
*/