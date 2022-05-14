/*
 < DCL : DATA CONTROL LANGUAGE >
 ������ ���� ���
 
 �������� �ý��� ���� �Ǵ� ��ü���ٱ����� �ο�(GRANT)�ϰų� ȸ��(REVOKE)�ϴ� ���
 
 [ǥ����]
 * ���� �ο�(GRANT)
 GRANT ����, ����, .... TO ������
 
 * ���� ȸ��(REVOKE)
 REVOKE ����, ����, ... FROM ������
*/

/*
 - �ý��� ����
 Ư�� DB�� �����ϴ� ����, ��ü���� ������ �� �ִ� ����
 
 - �ý��� ������ ����
 CREATE SESSION : ������ ������ �� �ִ� ����
 CREATE TABLE : ���̺��� ������ �� �ִ� ����
 CREATE VIEW : ��(��ȸ�� �ӽ����̺�)�� ������ �� �ִ� ����
 CREATE SEQUENCE : �������� ������ �� �ִ� ����
 CREATE USER : ������ ������ �� �ִ� ����
 ...
*/

-- 1.SAMPLE ���� ����
CREATE USER SAMPLE IDENTIFIED BY SAMPLE;
-- ���� ������ ���� ������ �־�����, ���ӿ� ���� ������ ���� �ʾ���.

-- 2. SAMPLE ������ �����ϱ� ���� CREATE SESSION ������ �ο�
GRANT CREATE SESSION TO SAMPLE;

-- 3.1 SAMPLE������ ���̺��� �����ϱ� ���� CREATE TABLE ���� �ο�
GRANT CREATE TABLE TO SAMPLE;

-- 3.2 SAMPLE������ ���̺����̽��� �Ҵ����ֱ�(SAMPLE���� ���� ����)
ALTER USER SAMPLE QUOTA 2M ON SYSTEM;
-- QUOTA : ��, �Ҵ�
-- 2M : 2 MEGA BYTE

-- 4. SAMPLE������ �並 ������ �� �ִ� CREATE VIEW ���� �ο�
GRANT CREATE VIEW TO SAMPLE;

-----------------------------------------------------------------------------------
/*
 - ��ü���ٱ���(��ü����)
 Ư�� ��ü���� ����(DML - SELECT, INSERT, UPDATE, DELETE)�� �� �ִ� ����
 
 [ǥ����]
 GRANT �������� ON Ư����ü TO ������;
 ��������       |  Ư�� ��ü
 SELECT          TABLE, VIEW, SEQUENCE
 INSERT          TABLE, VIEW
 UPDATE          TABLE, VIEW
 DELETE          TABLE, VIEW
*/

-- 5. SAMPLE ������ KH.EMPLOYEE���̺��� ��ȸ�� �� �ִ� ���� �ο�
GRANT SELECT ON KH.EMPLOYEE TO SAMPLE;

-- 6. SAMPLE ������ KH.DEPARTMENT���̺� ���� ������ �� �ִ� ���� �ο�
GRANT INSERT ON KH.DEPARTMENT TO SAMPLE;
-- KH.DEPARTMENT���̺� �� INSERT ����

--------------------------------------------------------------------------------

-- �ּ����� ������ �ο��ϰ��� �� ��, CONNECT, RESOURCE�� �ο�
-- GRANT CONNECT, RESOURCE TO ������;

/*
 < �� ROLE >
 Ư�� ���ѵ��� �ϳ��� �������� ��Ƴ��� �� 
 
 CONNECT : ������ �� �ִ� ���ѵ��� ������� ROLE (CREATE SESSION)
 RESOURCE : Ư�� ��ü���� ���� �� ������ �� �ִ� ���ѵ��� ������� ROLE
 (CREATE TABLE, CREATE SEQUENCE,...)

*/

-- ���� Ȯ���� �� �ִ� ������ ��ųʸ�
SELECT * 
FROM ROLE_SYS_PRIVS
WHERE ROLE IN ('CONNECT','RESOURCE');
-- 2���� ROLE�� 9���� ������ �ο��ϴ� ȿ��

-------------------------------------------------------------------------------

/*
 ���� ȸ��(REVOKE)
 ������ ȸ���� �� ����ϴ� ��ɾ�
 
 [ǥ����]
 REVOKE ����, ����, ����,... FROM ������
*/

-- 7. SAMPLE �������� ���̺��� ������ �� ������ ������ ȸ��
REVOKE CREATE TABLE FROM SAMPLE;

----- �ǽ����� -----







