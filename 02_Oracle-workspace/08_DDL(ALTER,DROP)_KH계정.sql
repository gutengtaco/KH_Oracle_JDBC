/*
 ����
 DDL(DATA DEFINITION LANGUAGE)
 ������ ���� ���
 �����Ͱ� ���ִ� ���� ��ü�� �����ϴ� �����.
 
 ��ü���� ������ ����(CREATE), ����(ALTER), ����(DROP)�ϴ� ����
 
 DML : SELECT INSERT UPDATE DELETE
 DDL : CREATE ALTER DROP
 DCL : GRANT REVOKE
 TCL : COMMIT ROLLBACK SAVEPOINT
---------------------------------------------------------------------
 1. ALTER
 ��ü ������ �����ϴ� ����
 
 <���̺� ����>
 ALTER TABLE ���̺�� �����ҳ���;
 
 - ������ ����
 1) �÷�(�ڷ���, DEFAULT)�� �߰� / ���� / ����
 2) �������� �߰� / ���� (�����ϰ� ������ ���� �� �߰�)
 3) ���̺�� / �÷��� / �������Ǹ� ����
*/

-- 1) �÷� �߰� / ���� / ����
-- 1_1) �÷��߰� : ADD �߰����÷��� ������Ÿ�� [DEFAULT �⺻��]
--               DEFAULT �⺻�� �κ��� ���� ����

/*
CREATE TABLE DEPT_COPY
AS(SELECT *
   FROM DEPARTMENT);
*/
SELECT * FROM DEPT_COPY;
DROP TABLE DEPT_COPY;

UPDATE DEPT_COPY
   SET DEPT_TITLE = '�ѹ���';
   
 

-- CNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD CNAME VARCHAR2(20);
-- LOCATION_ID �����ʿ� �⺻������ NULL�� ����ִ� CNAME�÷��� �߰�

-- LNAME �÷� �߰�
ALTER TABLE DEPT_COPY ADD LANAME VARCHAR2(20) DEFAULT '�ѱ�';
-- �⺻���� '�ѱ�'���� ä���� LNAME�÷��� �߰�

-- [������] �÷��� �ٲٱ�
ALTER TABLE DEPT_COPY RENAME COLUMN LANAME TO LNAME; 

-- 1_2) �÷� ����(MODIFY)
--      ������ Ÿ�� ���� : MODIFY �������÷��� �ٲٰ����ϴµ�����Ÿ��
--      DEFAULT �� ���� : MODIFY �������÷��� DEFAULT �ٲٰ����ϴ±⺻��

-- DEPT_ID �÷��� ������Ÿ���� CHAR(2)���� CHAR(3)���� ����
ALTER TABLE DEPT_COPY MODIFY DEPT_ID CHAR(3);
-- ���ǻ��� : ���� �����ϰ��� �ϴ� �÷��� �̹� ����ִ� ���� ������ �ٸ� �ڷ������δ� ���� �Ұ�
-- EX) ���� -> ����(X) / ���ڿ� ������ ��ҵ� X / ���ڿ� ������ Ȯ��� O

ALTER TABLE DEPT_COPY MODIFY DEPT_ID NUMBER;
-- [����] column to be modified must be empty to change datatype
-- ������ �ٸ� ������Ÿ������ �����ϰ��� �� ��쿡�� ���� ����־�� �Ѵٴ� ����

ALTER TABLE DEPT_COPY MODIFY DEPT_TITLE VARCHAR2(8);
-- [����] cannot decrease column length because some value is too big
-- ���� ����ִ� ���� ����� �� ū ��� ��� �Ұ�

-- DEPT_TITLE �÷��� ������Ÿ���� VARCHAR2(40)����
-- LOCATION_ID �÷��� ������Ÿ���� VARCHAR2(2)��
-- LNAME �÷��� �⺻���� '�̱�'����
ALTER TABLE DEPT_COPY
MODIFY DEPT_TITLE VARCHAR2(40)
MODIFY LOCATION_ID VARCHAR2(2)
MODIFY LNAME DEFAULT '�̱�';
-- �⺻���� ���� '�ѱ�'�� �� ���¿��� '�̱�'���� �ٲپ��־
-- ����ִ� ���� '�ѱ�'�� ���·� ������ ��. ������ ���� �⺻���� '�̱�'���� ������ ����.

-- �÷� ������ ���� ���纻 ���̺� �����
CREATE TABLE DEPT_COPY2 
AS (SELECT *
    FROM DEPT_COPY);
    
SELECT * FROM DEPT_COPY2;

-- 1_3) �÷� ����(DROP COLUMN) : DROP COLUMN �����ϰ����ϴ��÷���

-- DEPT_COPY2�κ��� DEPT_ID �÷� �����
ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_ID;
-- DEPT_ID�� �����.
ROLLBACK DEPT_COPY2;
-- ���� �ȵ�. DDL���� ��ü�� ROLLBACK���� ������ �ȵ�.

-- ��� �÷� ���ֱ�
/*
ALTER TABLE DEPT_COPY2
DROP COLUMN DEPT_TITLE
DROP COLUMN LOCATION_ID
DROP COLUMN CNAME
DROP COLUMN LNAME; 
-- [����] SQL command not properly ended
-- ������ �Ѳ����� ���� �Ұ�
*/

ALTER TABLE DEPT_COPY2 DROP COLUMN DEPT_TITLE;
ALTER TABLE DEPT_COPY2 DROP COLUMN LOCATION_ID;
ALTER TABLE DEPT_COPY2 DROP COLUMN CNAME;
ALTER TABLE DEPT_COPY2 DROP COLUMN LNAME;
-- [����] cannot drop all columns in a table
-- ���̺� �ִ� ��� �÷����� ������ ���� ���ٴ� ����
-- LNAME�� ������ �ȵ��ִ� ���� �� �� ����.
-- ���̺� �ּ� 1���� �÷��� ����� �����ؾ� ��.

-- �÷� �߰� / ���� / ���� �� ���ǻ���
-- 1. �÷��� �ߺ� �Ұ�
-- 2. ���� �� ������Ÿ�� �� �Ű�Ἥ ����
-- 3. ROLLBACK�Ұ�
-- 4. ���̺�� ��� �� ���� �÷��� �־�� ��.

/*
 2_1) �������� �߰�(ADD / MODIFY)
      => ��� �÷��� ��� ���������� �߰��� �� ���
 - PRIMARY KEY : ADD PRIMARY KEY (�÷���)
 - FOREIGN KEY : ADD FOREIGN KEY (�÷���) REFERENCES ���������̺��([�������÷���])
                => ������ �÷��� ��������(���� ��, �ڵ����� PRIMARY KEY�� �������÷������� ����)
 - UNIQUE : ADD UNIQUE (�÷���) 
 - CHECK : ADD CHECK(�÷�����������) 
 - NOT NULL : MODIFY �÷��� NOT NULL
 
 ������ �������Ǹ��� �ο��ϰ��� �Ѵٸ� : CONSTRAINT �������Ǹ��� ������������ �տ� ���� ��.
 �������Ǹ� �ο��κ��� CONSTRAINT �������Ǹ��� ���� ����(SYS_C~)
 ���ǻ��� : ���� ���� ���� ������ ������ �ο��ؾ���(�ƹ��� �ٸ� ���̺��̾ �������Ǹ� �ߺ� �Ұ�)
*/

-- DEPT_COPY���̺�
-- DEPT_ID �÷��� PRIMARY KEY �������� �߰�
-- DEPT_TITLE �÷��� UNIQUE �������� �߰�
-- LNAME �÷��� NOT NULL �������� �߰�
SELECT * FROM DEPT_COPY;
DROP TABLE DEPT_COPY;
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_PK PRIMARY KEY(DEPT_ID);
ALTER TABLE DEPT_COPY ADD CONSTRAINT DCOPY_UQ UNIQUE(DEPT_TITLE);
-- [����] cannot validate (KH.DCOPY_UQ) - duplicate keys found
-- �̹� DEPT_TITLE�� '�ѹ���'��� �ߺ��� ���� �� ����.
ALTER TABLE DEPT_COPY MODIFY LNAME CONSTRAINT DCOPY_NN NOT NULL;

SELECT * 
FROM USER_CONSTRAINTS; 
-- ���� ������ �������ǵ��� �� �� �ִ� ������ ��ųʸ�

-- EMP_DEPT ���̺�� ����
-- EMP_ID �÷��� PRIMARY KEY �ο�
-- EMP_NAME �÷��� NOT NULL �������� �ο�
-- EMP_NAME �÷��� UNIQUE �������� �ο�
ALTER TABLE EMP_DEPT
ADD CONSTRAINT EDEPT_PK PRIMARY KEY (EMP_ID)
ADD CONSTRAINT EDEPT_UQ UNIQUE (EMP_NAME)
MODIFY EMP_NAME CONSTRAINT EDEPT_NN NOT NULL;

-- �÷� �߰��� ���ǻ���
-- 1. �������Ǹ� �ߺ� �Ұ�
-- 2. �̹� ��� ������ �ش� ������ ���������� �����ؾ� ��.
-- 3. ALTER�� �ϳ��� ��� �ѹ��� ���� ����

/*
 2_2) �������� ����(DROP CONSTRAINT / MODIFY)
 - PRIMARY KEY, FOREIGN KEY, UNIQUE, CHECK : DROP CONSTRAINT �������Ǹ�
 - NOT NULL : MODIFY �÷��� NULL 
*/

-- EDEPT_PK �������� �����
ALTER TABLE EMP_DEPT DROP CONSTRAINT EDEPT_PK;

-- EDEPT_UQ, EDEPT_NN �������� �����
ALTER TABLE EMP_DEPT 
DROP CONSTRAINT EDEPT_UQ
MODIFY EMP_NAME NULL;

-----------------------------------------------------------------------------
-- 3)�÷��� / �������Ǹ� / ���̺�� ����

-- 3-1) �÷��� ���� : RENAME COLUMN �����÷��� TO �ٲ��÷���
ALTER TABLE DEPT_COPY RENAME COLUMN DEPT_TITLE TO DEPT_NAME;

SELECT * FROM DEPT_COPY;


-- 3-2) �������Ǹ� ���� : RENAME CONSTRAINT �����������Ǹ� TO �ٲ��������Ǹ�
-- DEPT_ID_NN : SYS_C007311
-- LOCATION_ID_NN : SYS_C007312
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007311 TO DEPT_ID_NN;
ALTER TABLE DEPT_COPY RENAME CONSTRAINT SYS_C007312 TO LOCATION_ID_NN;

-- 3-3) ���̺�� ���� : RENAME [�������̺��] TO �ٲ����̺��
-- �������̺���� ALTER TABLE ���̺���� ����ϱ� ������ ���� ����
-- �������̺���� ������ ALTER TABLE ���̺���� ���� 
-- RENAME �������̺�� TO �ٲ����̺�� ���� ����.
ALTER TABLE DEPT_COPY RENAME TO DEPT_TEST;
RENAME EMP_SALARY TO SALARY_EMP;


SELECT * FROM DEPT_TEST;
SELECT * FROM SALARY_EMP;

----------------------------------------------------------------------------
/*
 DROP
 ��ü�� �����ϴ� ����
 
 [ǥ����]
 < ���̺� >
 DROP TABLE ���̺��;
 
 <����� ����>
 DROP USER ������; -- �ش� ������ ���� �������̸� ���� �ȵ�.
*/

DROP TABLE DEPT_TEST;
-- DELETE �Ǵ� TRUNCATE �������� ��� ���� �����ϴ� ���̶��� �ٸ�
-- DROP�� ���̺� ��ü�� ����� ����.

DROP TABLE DEPARTMENT;
-- [����] unique/primary keys in table referenced by foreign keys
-- ���� EMPLOYEE���̺�(�ڽ�)�� DEPARTMENT���̺�(�θ�)�� �ܷ�Ű�� �����ϰ� �־� ������ �Ұ���.

-- ���࿡ �θ����̺��� �����ϰ� �ʹٸ�?
-- 1. �ڽ����̺��� ���� �����, �� ������ �θ����̺��� ����.
DROP TABLE �ڽ����̺��;
DROP TABLE �θ����̺��;

-- 2. �θ����̺� ����, �¹����ִ� ���������� �Բ� ����.
DROP TABLE �θ����̺�� CASCADE CONSTRAINT;





