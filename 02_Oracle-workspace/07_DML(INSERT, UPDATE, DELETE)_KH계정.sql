/*
 < DML : DATA MANIPULATION LANGUAGE>
 ������ ���� ���

 ���̺��� ���ο� �����͸� ����(INSERT)�ϰų�, ������ �����͸� ����(UPDATE)�ϰų�
 , ������ �����͸� ����(DELETE)�ϴ� ����
 
 �߰������� SELECT���� DML�� ���Խ�ų �� ����.
*/

/*
 1. INSERT : ���̺� ���ο� ���� �߰��ϴ� ����
 
 [ǥ����]
 1) INSERT INTO ���̺�� VALUES(��, ��, ��,...); 
 => �ش� ���̺� ��� �÷��� ���Ͽ� �߰��ϰ��� �ϴ� ���� ���� �� ���� ���� ��� �����Ͽ� �߰���.
 => �÷� ������ ���Ѽ� VALUES ��ȣ �ȿ� ���� �����ؾ� ��.
 => ������ ������ ���� ������ ��� : NOT ENOUGH VALUE ����
 => ��ġ�� ������ ���� ������ ��� : TOO MANY VALUES ����
*/

-- EMPLOYEE ���̺� INSERT
INSERT INTO EMPLOYEE 
VALUES('900','�踻��','870215-2000000', 'kim_md@kh.or.kr',
       '01011112222','D1','J7','S3',4000000, 0.2,'200',SYSDATE,NULL,'N');
       
SELECT * FROM EMPLOYEE;
SELECT * FROM EMPLOYEE WHERE EMP_ID = '900';

/*
 2) INSERT INTO ���̺��(�÷���, �÷���,..) VALUES(��, ��,...)
 => �ش� ���̺� Ư�� �÷��� �����ؼ�, �� �÷��� �߰��� ���� �κ������� �����ϰ����� �� ���
 => �׷��� �� �� ������ �߰��Ǳ� ������, ������ �ȵ� �÷��� ���ؼ��� �⺻������ NULL�� ��
 => ��, DEFAULT������ �� ��쿡��, DEFAULT�� ���� �߰���.
 => NOT NULL ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �������־�� ��.
 => PRIMARY KEY ���������� �ɷ��ִ� �÷��� �ݵ�� �����ؼ� ���� �������־�� ��.
 => ��, NOT NULL ���������� �ɷ��ִ� �÷��̶�� �ϴ���, DEFAULT������ �ɷ������� �� ���� ���ص� ��.
*/

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, DEPT_CODE,JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(901, '�ڸ���', '990101-1234567', 'D1', 'J2','S1',SYSDATE);

SELECT * FROM EMPLOYEE WHERE EMP_ID='901';
-- ENT_YN�� DEFAULT�� �����Ǿ� �־� N�̶�� ���� �� ����.

/*
 3) INSERT INTO ���̺��(��������);
 => VALUES�� ���� ������ �����ϴ� �� ��ſ�, ���������� ��ȸ�� ���������
 => ��°�� INSERT�ϴ� ����
 => �������� INSERT ��ų �� ����.
*/

-- ���ο� ���̺� �����
CREATE TABLE EMP_01 (
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_01;

-- ��ü ������� ���, �̸�, �μ����� ��ȸ�� ����� EMP_01 ���̺� �߰�
INSERT INTO EMP_01
(
    SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE, DEPARTMENT
    WHERE DEPT_CODE = DEPT_ID(+)
);
SELECT * FROM EMP_01;
-- 25�� ����(��) ���ԵǾ����ϴ�.

/*
 2. INSERT ALL
 �� �� �̻��� ���̺� ���� INSERT �ϰ� ���� �� ���.
 ��, ���Ǵ� ���������� ������ ��� ���
 
 INSERT ALL
 INTO ���̺��1 VALUES(�÷���, �÷���,...)
 INTO ���̺��2 VALUES(�÷���, �÷���,...)
 (��������);
*/

-- ���ο� ���̺��� ���� �����
-- ù��° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, ���޸��� ������ ���̺�
CREATE TABLE EMP_JOB(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    JOB_NAME VARCHAR2(20)
);

SELECT * FROM EMP_JOB;

-- �ι�° ���̺� : �޿��� 300���� �̻��� ������� ���, �����, �μ����� ������ ���̺�
CREATE TABLE EMP_DEPT(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(30),
    DEPT_TITLE VARCHAR2(20)
);

SELECT * FROM EMP_DEPT;

-- �޿��� 300���� �̻��� ������� ���, �̸�, ���޸�, �μ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
FROM EMPLOYEE 
JOIN JOB USING(JOB_CODE)
LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
WHERE SALARY >= 3000000;

INSERT ALL
INTO EMP_JOB VALUES(EMP_ID, EMP_NAME, JOB_NAME)
INTO EMP_DEPT VALUES(EMP_ID, EMP_NAME, DEPT_TITLE)
(SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE
 FROM EMPLOYEE 
 JOIN JOB USING(JOB_CODE)
 LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
 WHERE SALARY >= 3000000);
-- ���������� ���ؼ� ��ȸ�� ���� ���� : 9��
-- �� ���� 2���� ���̺�� ����� �����ϱ� ������, �� 18���� ���� �߰���.
SELECT * FROM EMP_JOB;
SELECT * FROM EMP_DEPT;

-- INSERT ALL�ÿ� ������ ����ؼ� �� ���̺� ���� INSERT ����
-- ���, �����, �Ի���, �޿�(EMP_OLD���̺� ����) 
-- ��, 2010�� ������ �Ի��� ���
CREATE TABLE EMP_OLD
AS(SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1=0);
    
 -- ���, �����, �Ի���, �޿�(EMP_NEW���̺� ����)
 -- ��, 2010�� ���� �Ի��� ���
CREATE TABLE EMP_NEW
AS(SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
     FROM EMPLOYEE
    WHERE 1=0);

SELECT * FROM EMP_OLD;
SELECT * FROM EMP_NEW;

-- �� ������ �´� ������� ��ȸ
SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
FROM EMPLOYEE
--WHERE HIRE_DATE <'2010/01/01'; -- 2010�� ���� �Ի��ڵ�(9��)
WHERE HIRE_DATE >='2010/01/01'; -- 2010�� ���� �Ի��ڵ�(16��)

/*
 2) INSERT ALL
 WHEN ���ǽ�1 THEN
      INTO ���̺��1 VALUES(�÷���,...)
 WHEN ���ǽ�2 THEN   
      INTO ���̺��2 VALUES(�÷���,...)
 (���������� ����� ��������)
*/

INSERT ALL
WHEN HIRE_DATE <'2010/01/01' THEN
    INTO EMP_OLD VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 9�� ��
WHEN HIRE_DATE >='2010/01/01' THEN
    INTO EMP_NEW VALUES(EMP_ID, EMP_NAME, HIRE_DATE, SALARY) -- 16�� ��
(SELECT EMP_ID, EMP_NAME, HIRE_DATE, SALARY
 FROM EMPLOYEE);    

SELECT * FROM EMP_OLD; 
SELECT * FROM EMP_NEW;
-- �� 25���� �� �߰���.

-------------------------------------------------------------------------------

/*
 3. UPDATE
 ���̺� ��ϵ� ������ �����͸� �����ϴ� ����
 
 [ǥ����]
 UPDATE ���̺��
    SET �÷��� = �ٲܰ�
      , �÷��� = �ٲܰ�
      , �÷��� = �ٲܰ�
      ... => �������� �÷����� ���ÿ� ���� ����(AND�� �ƴ� �޸��� ����)
  WHERE ����; => WHERE���� ���� ����, ��, ���� �� ��ü ��� ���� �����Ͱ� �� ����Ǿ����.
*/

-- �׽�Ʈ�� ���纻 ���̺�
CREATE TABLE DEPT_COPY
AS(SELECT *
   FROM DEPARTMENT);
 
 SELECT * FROM DEPT_COPY;
 
 -- DEPT_COPY���̺��� D9�μ��� �μ����� '������ȹ��'���� ����
 UPDATE DEPT_COPY
    SET DEPT_TITLE = '������ȹ��'
  WHERE DEPT_ID = 'D9';
  
 SELECT * FROM DEPT_COPY;
 
 -- ���� : WHERE���� �����ϸ� ��� �࿡ ���Ͽ� ������ �����.
 UPDATE DEPT_COPY
    SET DEPT_TITLE = '������ȹ��';
    -- ��ü ���� DEPT_TITLE�� ��� '������ȹ��'���� �ٲ�.
 SELECT * FROM DEPT_COPY;
 
 -- ���纻 ���̺�
 CREATE TABLE EMP_SALARY
 AS(SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY, BONUS
      FROM EMPLOYEE);
      
 SELECT * FROM EMP_SALARY;
 
 -- EMP_SALARY ���̺� ���ö ����� �޿��� 1000�������� ����
 UPDATE EMP_SALARY
    SET SALARY = 10000000
  WHERE EMP_NAME = '���ö';
  
  SELECT * FROM EMP_SALARY;
 
 -- EMP_SALARY ���̺� ������ ����� �޿��� 700��������, ���ʽ��� 0.2�� ���� 
 UPDATE EMP_SALARY
    SET SALARY = 7000000
      , BONUS = 0.2
  WHERE EMP_NAME = '������';   
  
  SELECT * FROM EMP_SALARY WHERE EMP_NAME = '������';
 
 -- ��ü ����� �޿��� ���� �޿��� 20���� �λ��� �ݾ����� ����
 UPDATE EMP_SALARY
    SET SALARY = SALARY*1.2;
  
 SELECT * FROM EMP_SALARY;   
   
/*
 UPDATE �ÿ� ���������� ����ϱ�
 ���������� ������ ��������� �����ϰڴ�.
 (= ������ �� �κп� ���������� �ְڴ�)
 
 [ǥ����]
 UPDATE ���̺��
    SET �÷��� = (��������) -- ������, ���Ͽ� ��������
  WHERE ����;   
*/ 

-- EMP_SALARY ���̺� �踻�� ����� �μ��ڵ带 ������ ����� �μ��ڵ�� ����
-- 1) ������ ����� �μ��ڵ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������';

-- 2) �踻�� ����� �μ��ڵ带 D9���� �ٲ�
UPDATE EMP_SALARY
   SET DEPT_CODE = (SELECT DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '������')  
  WHERE EMP_NAME = '�踻��';
  
SELECT * FROM EMP_SALARY;
-- �踻���� �μ��ڵ尡 D1���� D9���� �ٲ�.

DROP TABLE EMP_SALARY;
-- ���� ����� �޿��� ���ʽ��� ����� ����� �޿��� ���ʽ��� ����
-- 1) ����� ����� �޿�, ���ʽ�
SELECT SALARY, BONUS
FROM EMP_SALARY
WHERE EMP_NAME = '�����';

-- 2) ���� ����� �޿��� ���ʽ��� ����Ļ���� �޿�, ���ʽ��� ����
UPDATE EMP_SALARY
   SET (SALARY, BONUS) = (SELECT SALARY, BONUS
                            FROM EMP_SALARY
                           WHERE EMP_NAME = '�����')                       
 WHERE EMP_NAME = '����';  
 
SELECT * FROM EMP_SALARY WHERE EMP_NAME = '����'; 
-- [����] UPDATE�ÿ��� ������ ���� �־ �ش� �÷��� ���� �������ǿ� ����Ǹ� �ȵ�.
-- ���߱� ����� ����� 200������ ����
SELECT * FROM EMPLOYEE;

UPDATE EMPLOYEE
   SET EMP_ID = '200'
 WHERE EMP_NAME = '������';  
-- [����] unique constraint (KH.EMPLOYEE_PK) violated
-- PRIMARY KEY�� ���������� �����߱� ������ �߻���.


-- ����� 200���� ����� �̸��� NULL�� ����
UPDATE EMPLOYEE
   SET EMP_NAME = NULL
 WHERE EMP_ID = '200';
-- [����] cannot update ("KH"."EMPLOYEE"."EMP_NAME") to NULL
-- NOT NULL�� ������������ �ɷ��ִ� ���� NULL�� �ٲٷ��� �ؼ� ������ ��.


-- ���±��� �����ߴ� ������� Ȯ�����ڴ�.
COMMIT;

-----------------------------------------------------------------------------

/*
 DELETE
 ���̺� ��ϵ� �����͸� �����ϴ� ����
 
 [ǥ����]
 DELETE FROM ���̺��
 WHERE ����;
 
 ��, WHERE���� ���� ��� ���� �����ϰ� ��.
*/

-- EMPLOYEE ���̺��� ��� ����� ����
SELECT * FROM EMPLOYEE;

DELETE FROM EMPLOYEE;

ROLLBACK; -- ������ Ŀ�� �������� ������.

-- �踻��, �ڸ����� ���� ������.
DELETE FROM EMPLOYEE
WHERE EMP_NAME = '�踻��' OR EMP_NAME = '�ڸ���';
COMMIT;

-- DEPARTMENT���̺�κ��� DEPT_ID�� D1�� �μ� ����
DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D1';
-- [����] integrity constraint (KH.SYS_C007238) violated - child record found
-- �ڽ��� �ܷ�Ű�� �θ����̺��� �÷����� �����ϰ� ���� �� �߻�
-- ON DELETE RESTRICTED�̶� ���� ������ �� ����.
-- ���� EMPLOYEE���̺��� DEPT_CODE�� DEPARTMENT���̺��� DEPT_ID�� �����ϰ� ����.

DELETE FROM DEPARTMENT
WHERE DEPT_ID = 'D3';
-- D3�� �μ��ڵ�� ���� ����� ���� ������ �� ������.

SELECT * FROM DEPARTMENT;

ROLLBACK;
-- DEPARTMENT ���̺��� DELETE�������� ����.

-------------------------------------------------------------------------------
/*
 TRUNCATE 
 ���̺��� ��ü ���� ������ �� ����ϴ� ����(����)
 DELETE FROM ���̺��;�� ���� ����
 ��, DELETE���� ����ӵ��� ����
 ������ ������ ������ �� ����. 
 ROLLBACK�� �Ұ���.
 
 [ǥ����]
 TRUNCATE TABLE ���̺��;         |     DELETE FROM ���̺��;
 ������ �������� X                        ������ �������� O
 ����ӵ� ����                            ����ӵ� ����
 ROLLBACK�� �Ұ���                        ROLLBACK�� ����
 
*/

SELECT * FROM EMP_SALARY;

DELETE FROM EMP_SALARY;
ROLLBACK;
-- ROLLBACK���� ������ ��.

TRUNCATE TABLE EMP_SALARY;
ROLLBACK;
-- ��������. ROLLBACK���� ������ �ȵ�.