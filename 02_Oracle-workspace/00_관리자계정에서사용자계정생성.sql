--한 줄 주석
/*여려 줄 주석*/

--관리자 계정은 총괄(직접적인 값을 다루지 않음)
--관리자 계정을 통해, 데이터를 직접 다룰 수 있는 일반 사용자 계정을 만들 것임.

--일반 사용자 계정을 만드는 방법
--[표현법] CREATE USER 계정명 IDENTIFIED BY 비밀번호;
CREATE USER KH IDENTIFIED BY KH;

--생성된 사용자 계정에게 최소한의 권한을 주어야 함(접속, 데이터관리)
--[표현법] GRANT 권한명1, 권한명2,... TO 계정명;
GRANT CONNECT, RESOURCE TO KH;
--다만, 코드를 실행해도 계정이 만들어지지 않음. 새 접속으로 수동으로 만들어주어야 함.

--[오류]
--Cause: There is already a user or role with that name.
--위의 코드를 한번 더 실행하면 발생함. 중복되는 이름으로 계정을 만드려면 발생.

