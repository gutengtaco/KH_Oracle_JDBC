-- CREATE TABLE ������ �ο��ޱ� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- [����] insufficient privileges
-- ���̺��� ������ �� �ִ� ������ ���� ������ ������ �߻���.

-- 3.1 CREATE TABLE ������ �ο��� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- [����] no privileges on tablespace 'SYSTEM'
-- TABLE SPACE(���̺���� ���ִ� ����)�� �Ҵ���� �ʾƼ� ����� ������.

-- 3.2 TABLE SPACE�� �Ҵ� ���� ��
CREATE TABLE TEST(
    TEST_ID NUMBER
);
-- ���̺� ���� �Ϸ�

-- ���� ���̺� ���� ����(CREATE TABLE)�� �ο��ް� �Ǹ�
-- �ش� ������ ������ �ִ� ���̺���� ����(DML)�ϴ� �͵� ��������.
SELECT * FROM TEST;
INSERT INTO TEST VALUES(1);

-- 4. �� ������
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
-- [����] "insufficient privileges"
-- �� ��ü�� ������ �� �ִ� CREATE VIEW ������ ���� ������ ������ �߻���.

-- CREATE VIEW ������ �ο����� ��
CREATE VIEW V_TEST
AS (SELECT * FROM TEST);
-- �� �����Ϸ�

-- SAMPLE �������� KH������ �ִ� ���̺� ����
SELECT * 
FROM KH.EMPLOYEE;
-- [����] table or view does not exist
-- 5. KH������ ���̺� �����ؼ� ��ȸ�� �� �ִ� ������ ���� ������ ���� �߻�
-- SAMPLE���� ���忡�� "KH.EMPLOYEE"��� �̸��� ���̺��� �������� ����.

-- SELECT ON ���� �ο� ��
SELECT * 
FROM KH.EMPLOYEE;
-- EMPLOYEE ���̺� ��ȸ ����

SELECT *
FROM KH.DEPARTMENT;
-- KH.EMPLOYEE���̺��� ���ٱ����� �־ DEPARTMENT���� ������ �ȵ�. 

-- SAMPLE �������� KH������ ���̺� �����ؼ� �� �����غ���
INSERT INTO KH.DEPARTMENT VALUES('D0','ȸ���','L2');
-- [����] table or view does not exist
-- 6. KH������ ���̺� �����ؼ� ������ �� �ִ� ������ ���� ������ ���� �߻�

-- INSERT ON ���� �ο� ��
INSERT INTO KH.DEPARTMENT VALUES('D0','ȸ���','L2');
COMMIT;
-- Ŀ�Ա��� ����� ���ο� ���� ���Ե�.


