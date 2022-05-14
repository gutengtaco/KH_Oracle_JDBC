/*
 < VIEW �� >
 SELECT(��ȸ�� ������)�� �����ص� �� �ִ� ǥ ������ ��ü
 (���� ���Ϲ��� �� SELECT���� �����صθ� �Ź� �� SELECT���� �ۼ��� �ʿ䰡 ������.)
 �ӽ����̺� ���� ����(���� �����Ͱ� ����ִ� ���� �ƴ�.)
*/

----- �ǽ����� ------
-- '�ѱ�'���� �ٹ��ϴ� ������� 
-- ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT;
SELECT * FROM JOB;
SELECT * FROM LOCATION;
SELECT * FROM NATIONAL;

SELECT DISTINCT DEPT_CODE FROM EMPLOYEE ORDER BY DEPT_CODE ASC; 

SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID(+) 
      -- NULL�� ��� / DEPARTMENT���̺��� D3, D4, D7�� EMPLOYEE���̺� ���� ��찡 ����
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND L.NATIONAL_CODE = N.NATIONAL_CODE(+)
  AND N.NATIONAL_NAME = '�ѱ�';

-->> ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N USING(NATIONAL_CODE)
     JOIN JOB J USING(JOB_CODE)
WHERE N.NATIONAL_NAME = '�ѱ�';

--------------------------------------------------------------------------------


/*
 1. VIEW ���� 
 
 [ǥ����]
 CREATE VIEW ���
 AS(��������);
 
 CREATE OR REPLACE VIEW ���
 AS(��������);
 => �� ������, ������ �ߺ��� �̸��� �䰡 ���ٸ�, �ش� ����� VIEW�� ����(CREATE)
    �� ������, ������ �ߺ��� �̸��� �䰡 �ִٸ�, �ش� VIEW�� �����ϴ� �ɼ�(OR REPLACE)
*/

-- ���� ������ SELECT���� �������� ��� �� ����
DROP VIEW VW_EMPLOYEE;
CREATE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N USING(NATIONAL_CODE)
     JOIN JOB J USING(JOB_CODE));
-- [����]insufficient privileges
-- ������ �������� �ʾƼ� �߻��ϴ� ����
-- RESOURCE��� ROLE���� CREATE VIEW�� ���� ������ ����.

-- [����]
-- �ζ��κ�� �����ϸ� ������ ����.
SELECT *
FROM(SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N USING(NATIONAL_CODE)
     JOIN JOB J USING(JOB_CODE)); 

-- �� �κи� �����ڰ������� �����ؼ� ����
GRANT CREATE VIEW TO KH;
----------------------------------------------------------------------------
SELECT * FROM VW_EMPLOYEE;
-- ���� ����, ������ ���������� �̿��Ͽ�, �׶��׶� �ʿ��� �����͵鸸 ��ȸ�ϴ� �ͺ���
-- �ѹ� ���������� �並 ���� ��, �ش� ������� SELECT���� �̿��Ͽ� �����ϰ� ��ȸ ����

-- '�ѱ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸� ��ȸ
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '�ѱ�';

-- '���þ�'���� �ٹ��ϴ� ���
SELECT * 
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

-- '���þ�'���� �ٹ��ϴ� ������� ���, �̸�, �μ���, �޿�, �ٹ�������, ���޸�, ���ʽ�
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';
-- [����] "BONUS": invalid identifier
-- VIEW�� BONUS��� �÷��� �������� �ʱ� ������ ��ȸ�� ���� ����.

-- ���ʽ� �÷��� ���� �信�� ���ʽ��� ��ȸ�ϰ� ���� ���
-- CREATE OR REPLACE VIEW ��� ���
-- ������ �ش� ����� ������ ����Ἥ ���� �並 ����� �ɼ���.
CREATE OR REPLACE VIEW VW_EMPLOYEE
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID(+) 
      -- NULL�� ��� / DEPARTMENT���̺��� D3, D4, D7�� EMPLOYEE���̺� ���� ��찡 ����
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND L.NATIONAL_CODE = N.NATIONAL_CODE(+));

-- ������ �信 ���ʽ��� �߰��Ͽ� �並 ������.  
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, SALARY, NATIONAL_NAME, JOB_NAME, BONUS
FROM VW_EMPLOYEE
WHERE NATIONAL_NAME = '���þ�';

-- VIEW�� ������ �������̺� => ���������� �����͸� �����ϰ� ���� ����.
-- VIEW�� ���� ��ü�� SELECT���� ���� == �ܼ��� �������� TEXT������ ����Ǿ�����.
-- VIEW�� Ȯ���� �� �ִ� ������ ��ųʸ�
-- USER_VIEWS ������ ��ųʸ� : �ش� ������ ������ �ִ� VIEW�鿡 ���� �������� ������ �ִ� ������ ���̺�
SELECT * FROM USER_VIEWS;

-----------------------------------------------------------------------------------------
/*
 VIEW �÷��� ��Ī �ο�
 ���������� SELECT���� �Լ��� ���������� ���� ���, �ݵ�� ��Ī�� �ο����־�� ��.
*/
-- ����� ���, �̸�, ���޸�, ����, �ٹ������ ��ȸ�� �� �ִ� SELECT���� VIEW�� ��ȸ
CREATE OR REPLACE VIEW VW_EMP_JOB
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
           DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��'),
           EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE));
-- [����] must name this expression with a column alias   
-- �ݵ�� �Լ����̳� �������Ŀ��� ��Ī(column alias)�� �ٿ��־�� ��.

CREATE OR REPLACE VIEW VW_EMP_JOB
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
           DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��')"����",
           EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)"�ٹ����"
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE));        
-- �Լ��İ� �������Ŀ� ��Ī�� �ٿ��ִ� VIEW�� �� ������ ���� �� �� ����.

SELECT * FROM VW_EMP_JOB;
    
-- �� �ٸ� ������� ��Ī�ο� ����(��, ��� �÷��� ���� ��Ī�� �� ����ؾ� ��)
CREATE OR REPLACE VIEW VW_EMP_JOB (���,�̸�,���޸�,����,�ټӳ��)
AS (SELECT EMP_ID, EMP_NAME, JOB_NAME, 
           DECODE(SUBSTR(EMP_NO,8,1),'1','��','2','��'),
           EXTRACT(YEAR FROM SYSDATE)- EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
    JOIN JOB USING(JOB_CODE));
-- [����] invalid number of column names specified
-- ��� �÷��� ��Ī�� ������� ������ ������ ���� ������ ��.

SELECT * FROM VW_EMP_JOB;   

SELECT ���, �ټӳ��
FROM VW_EMP_JOB;
-- ��Ī�� �̿��Ͽ� SELECT���� �ۼ��� ���� ����.

SELECT ���, �̸�, ���޸�
FROM VW_EMP_JOB
WHERE ���� = '��';
-- ��Ī�� �̿��Ͽ� WHERE������ �ۼ��� ���� ����.
-- (������ SELECT���� ������������� WHERE���� ��Ī�� ����� �� ����.)

SELECT *
FROM VW_EMP_JOB
WHERE �ټӳ�� >=20;

-- �並 �����ϰ� �ʹٸ�?
DROP VIEW VW_EMP_JOB;

---------------------------------------------------------------------

/*
 ������ �並 �̿��ؼ� DML(INSERT, UPDATE, DELETE)���� ����ϱ�
 ��, �並 ���ؼ� DML�� ����ϸ�, ���� �����Ͱ� ����ִ� �������̺��� �����͵� �ٲ�.(��������� �����.)
*/

CREATE OR REPLACE VIEW VW_JOB
AS(SELECT * FROM JOB);

SELECT * FROM VW_JOB;
SELECT * FROM JOB;

-- �信 INSERT
INSERT INTO VW_JOB 
VALUES('J8','����');
-- ��� �������̺� ��� ���� ���Ե�.

-- �信 UPDATE
UPDATE VW_JOB 
   SET JOB_NAME = '�˹�'
 WHERE JOB_CODE = 'J8' ;
-- ����������, ��� �������̺� ��� ���� �����.

-- �信 DELETE
DELETE FROM VW_JOB
 WHERE JOB_CODE = 'J8';
-- ����������, ��� �������̺� ��� ���� ������.

------------------------------------------------------------------------------
/*
 �並 ������ DML�� �Ұ����� ��찡 �� ����.
 1) �信 ���ǵǾ����� ���� �÷��� �����ϴ� ���
 2) �信 ���ǵǾ����� ���� �÷� �߿�, �������̺�� NOT NULL���������� ������ ���
 3) �������� �Ǵ� �Լ��� ���ؼ� ���ǵǾ� �ִ� ���
 4) �׷��Լ��� GROUP BY���� ���ԵǾ��ִ� ���
 5) DISTINCT ������ ���� ���
 6) JOIN�� �̿��ؼ� ���� ���̺��� ��Ī���ѳ��� ���
 => ��κ� �������̺�� �����Ͽ� �����غ��� ��.
*/

-- 1) �信 ���ǵǾ� ���� ���� �÷��� �����ϴ� ���
CREATE OR REPLACE VIEW VW_JOB
AS(SELECT JOB_CODE FROM JOB);

SELECT * FROM VW_JOB;

-- INSERT
INSERT INTO VW_JOB(JOB_CODE, JOB_NAME)
VALUES('J8','����');
-- [����] "JOB_NAME": invalid identifier
-- VIEW�� ���� �÷��� ���� �����Ϸ��� ��� �߻��ϴ� ����

-- UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '����'
 WHERE JOB_CODE = 'J7';
-- [����] "JOB_NAME": invalid identifier
-- ���������� VIEW�� ���� �÷��� ���� �����Ϸ��� ��� �߻��ϴ� ����

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '���';
-- [����] "JOB_NAME": invalid identifier
-- ���������� VIEW�� ���� �÷��� ���� �����Ϸ��� ��� �߻��ϴ� ����
 
------------------------------------------------------------------------------
-- 2) �信 ���ǵǾ� ���� ���� �÷� �߿��� �������̺�� NOT NULL���������� ������ ���
CREATE OR REPLACE VIEW VW_JOB
AS(SELECT JOB_NAME FROM JOB);

SELECT * FROM JOB;
SELECT * FROM VW_JOB;

-- INSERT
INSERT INTO VW_JOB VALUES('����'); 
-- [����] cannot insert NULL into ("KH"."JOB"."JOB_CODE")
-- 'INSERT INTO ��� VALUES()'�������� ���� ��� ���� �����ؾ� �ؼ� 
-- ��� JOB_NAME�� �ش��ϴ� '����'�� ����������, (NULL,'����')�� ������ ������ �Ǵ���.
-- JOB_CODE�� NOT NULL���������� �ɷ��ֱ� ������, NOT NULL���������� �����ؼ� ������ �߻���.

-- UPDATE
UPDATE VW_JOB
   SET JOB_NAME = '�˹�'
 WHERE JOB_NAME = '���';  
-- VIEW�� �ִ� �÷��� �ٲ� ���̱� ������, ����� �۵���.

-- UPDATE
UPDATE VW_JOB
   SET JOB_CODE = NULL
 WHERE JOB_NAME = '�˹�';
-- [����] "JOB_CODE": invalid identifier
-- JOB_CODE�� VIEW�� ���� �÷��̶� ������ �߻���.
-- ����, JOB_CODE�� NOT NULL���������ε� NULL�� �������� �ؼ� ������ �߻���.

-- DELETE
DELETE FROM VW_JOB
WHERE JOB_NAME = '�븮';
-- [����] integrity constraint (KH.SYS_C007239) violated - child record found
-- '�븮'�� J6 ���޿� �ش��ϴ� �����ڵ带 ����ϰ� �ִ� �ڽ� �����Ͱ� �־ �߻��ϴ� ����

DELETE FROM VW_JOB
WHERE JOB_NAME = '�˹�';
-- ����������, '�˹�'�� J7���޿� �ش��ϴ� �����ڵ带 ����ϰ� �ִ� �ڽĵ����Ͱ� �־ ���� �߻�

-------------------------------------------------------------------

-- 3) �������� �Ǵ� �Լ����� ���ؼ� ���ǵǾ� �ִ� ���
-- ����� ���, �̸�, �޿�, ������ ���Ͽ� ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_EMP_SAL
AS (SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12 "����"
      FROM EMPLOYEE);

SELECT * FROM VW_EMP_SAL;      
SELECT * FROM EMPLOYEE;

-- INSERT
INSERT INTO VW_EMP_SAL
VALUES(400,'������', 3000000, 36000000);
-- [����] virtual column not allowed here
-- �������̺� SALARY*12��� �÷��� ���� �� �� ����.

-- UPDATE
UPDATE VW_EMP_SAL
   SET "����" = 80000000
 WHERE EMP_ID = 200;
-- [����] virtual column not allowed here
-- �������̺� ���� �̶�� �÷��� ���� �� �� ����.

-- UPDATE 
UPDATE VW_EMP_SAL
   SET SALARY = 7000000
 WHERE EMP_ID = 200;  
-- �������̺� SALARY �÷��� �����Ͽ� ���� �� �����.

-- DELETE
DELETE FROM VW_EMP_SAL
WHERE ���� = 72000000;
-- ���߱� ����� �����.
-- �������̺� �����̶�� �÷��� ������, 
-- ���ǿ� ���� ������ �Ϸ��� �ô���, ������ ���� �� �ִ� ���� �־ ������ ����.

ROLLBACK;

-----------------------------------------------------------------------------

-- 4) �׷��Լ����̳� GROUP BY���� ���ԵǴ� ���
-- �μ��� �޿���, ��ձ޿��� ��ȸ�ϴ� ��
CREATE OR REPLACE VIEW VW_GROUPDEPT
AS(SELECT DEPT_CODE, SUM(SALARY) "�޿���", FLOOR(AVG(SALARY)) "��ձ޿�"
   FROM EMPLOYEE
   GROUP BY DEPT_CODE);


SELECT * FROM VW_GROUPDEPT;
-- �� �����ǰ�, �� ��ȸ��.

-- INSERT
INSERT INTO VW_GROUPDEPT
VALUES('D0', 80000000, 40000000);
-- [����] "virtual column not allowed here"
-- �ش� �Լ����̳� ���������� �������̺��� �÷��� �������� ����.

-- UPDATE
UPDATE VW_GROUPDEPT
   SET �޿��� = 8000000
 WHERE DEPT_CODE = 'D1';
-- [����] data manipulation operation not legal on this view
-- �����͸� �����ϴ� ������ �� �信�� �� �� ���ٴ� ���� ����
 
-- UPDATE
UPDATE VW_GROUPDEPT
   SET DEPT_CODE = 'D0'
 WHERE DEPT_CODE = 'D1';
-- [����] data manipulation operation not legal on this view
-- ����������, �����͸� �����ϴ� ������ �� �信�� �� �� ���ٴ� ���� ����

-- DELETE
DELETE FROM VW_GROUPDEPT
WHERE DEPT_CODE = 'D1';
-- [����] data manipulation operation not legal on this view
-- ����������, �����͸� �����ϴ� ������ �� �信�� �� �� ���ٴ� ���� ����

-- => ��ó��, �׷��Լ��� GROUP BY���� ������ �信���� DML������ �۵��� �Ұ���.

-------------------------------------------------------------------

-- 5) DISTINCT ������ ���Ե� ���
CREATE OR REPLACE VIEW VW_DT_JOB
AS(SELECT DISTINCT JOB_CODE
   FROM EMPLOYEE);

SELECT * FROM VW_DT_JOB;

-- INSERT 
INSERT INTO VW_DT_JOB VALUES('J8');
-- [����]  data manipulation operation not legal on this view

-- UPDATE
UPDATE VW_DT_JOB
   SET JOB_CODE = 'J8'
 WHERE JOB_CODE = 'J7';   
-- [����]  data manipulation operation not legal on this view

-- DELETE
DELETE FROM VW_DT_JOB
WHERE JOB_CODE = 'J7';
-- [����]  data manipulation operation not legal on this view

-----------------------------------------------------------------------

-- 6) JOIN�� �̿��Ͽ� ���� ���̺��� ��Ī���ѳ��� ���
CREATE OR REPLACE VIEW VW_JOINEMP
AS (SELECT EMP_ID, EMP_NAME, DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON(DEPT_CODE= DEPT_ID));

SELECT * FROM VW_JOINEMP;

--INSERT
INSERT INTO VW_JOINEMP VALUES(888,'������','�ѹ���');
-- [����] cannot modify more than one base table through a join view
-- �Ѱ� �̻��� �������̺��� JOIN�Ǿ� �ִ� ���� ���, ������ �� ���ٴ� ���� ������. 

-- UPDATE
UPDATE VW_JOINEMP
   SET EMP_NAME = '������'
 WHERE EMP_ID = 200;
-- ������ �ȶ�.
-- EMPLOYEE���� �ݿ� ������ UPDATE���̶� ���� ����(Ư�����̽�)
SELECT * FROM EMPLOYEE;

-- DELETE
DELETE FROM VW_JOINEMP
WHERE EMP_ID = 200;

SELECT * FROM VW_JOINEMP;
-- 200���� �ش��ϴ� ����� ������.
SELECT * FROM EMPLOYEE;
-- 200���� �ش��ϴ� ����� ������.
SELECT * FROM DEPARTMENT;
-- 200���� �ش��ϴ� D9�� �������� ����.
-- ��, ������ �Ǵ� ���̺�(EMPLOYEE)������ ���� ������.

DELETE FROM VW_JOINEMP
WHERE DEPT_TITLE = '�ѹ���';

SELECT * FROM VW_JOINEMP;
-- '�ѹ���'�� �ش��ϴ� ����� �����Ǿ���.
SELECT * FROM VW_JOINEMP;
-- '�ѹ���'�� �ش��ϴ� ����� �����Ǿ���.
ROLLBACK;
-- ��� ��ó��, DML���� ����ƴٰ� �ȵƴٰ� �ϱ⶧����
-- ��κ� �ǹ������� ��ȸ�����θ� ����.
-------------------------------------------------------------
/*
 VIEW �ɼ�
 
 [��ǥ����]
 CREATE OR REPLACE [FORCE / NOFORCE] ���
 AS (��������)
 WITH CHECK OPTION
 WITH READ ONLY 
 
 1) FORCE / NOFORCE
  - FORCE : ���������� ����� ���̺��� �������� �ʴ��� �並 ����
  - NOFORCE : ���������� ����� ���̺��� �ݵ�� �����ؾ߸� �並 ����
              ������ �⺻����.   
 2) WITH CHECK OPTION : ���������� �������� ����� ���뿡 �����ϴ� �����θ� DML�� ����
                        ���ǿ� �������� �ʴ� ������ �����ϴ� ��� ���� �߻�
 3) WITH READ ONLY : �信 ���� ��ȸ�� ����.                       
*/

-- 1) FORCE/ NOFORCE
CREATE OR REPLACE /*NOFORCE*/ VIEW VW_TEST
AS(SELECT TCODE, TNAME, TCONTENT
   FROM TT);
-- [����] table or view does not exist
-- TT��� ���̺�� �ش� �÷��� �������� �ʾ� �߻��ϴ� ������.

CREATE OR REPLACE FORCE VIEW VW_TEST
AS(SELECT TCODE, TNAME, TCONTENT
   FROM TT);
-- "������ ������ �Բ� �䰡 �����Ǿ����ϴ�."
-- ���ӿ��� ���� VW_TEST�� ���� ��� UNDEFINED��� �����Ǿ� ����.

SELECT * FROM VW_TEST;
-- ���� ��ȸ�� ���ϴ� ��Ȳ
-- ��, �ش� TT��� �̸��� ���̺��� ������ ���ĺ��ʹ� �ش� �並 ����� �� ����.

CREATE TABLE TT(
    TCODE NUMBER,
    TNAME VARCHAR2(30),
    TCONTENT VARCHAR2(50)
    );

SELECT * FROM VW_TEST;
-- TT��� ���̺��� �����ϰ� ��ȸ�� �� �ְԵ�.

-- 2) WITH CHECK OPTION
CREATE OR REPLACE VIEW VW_EMP
AS 
(SELECT *
 FROM EMPLOYEE
 WHERE SALARY >= 3000000)
 WITH CHECK OPTION;
 
SELECT * FROM VW_EMP;
-- ���� ���� ��Ȳ : ������ 300���� �̻��� ������� ������ ����

UPDATE VW_EMP
   SET SALARY = 2000000
 WHERE EMP_ID = 200;  
-- [����] view WITH CHECK OPTION where-clause violation
-- ���������� ����� ���ǿ� �������� �ʰԲ� ������ �õ��߱� ������ ���� �Ұ�

UPDATE VW_EMP
   SET SALARY = 4000000
 WHERE EMP_ID = 200;  
-- 300���� �̻��� 400������ �����߱� ������ ���������� ������Ʈ��.

SELECT * FROM VW_EMP;
ROLLBACK;

-- 3) WITH READ ONLY
CREATE OR REPLACE VIEW VW_EMPBONUS
AS(SELECT EMP_ID, EMP_NAME, BONUS
   FROM EMPLOYEE
   WHERE BONUS IS NOT NULL)
WITH READ ONLY;

SELECT * FROM VW_EMPBONUS;

DELETE FROM VW_EMPBONUS
WHERE EMP_ID = 204;
-- [����] cannot perform a DML operation on a read-only view
-- �並 ���� ��ȸ�� �����ϰ� �ٲ���� DML���� ����� �� ����.

/*
 ���λ�
 ������ �̸��� ���� �� �ǹ̺ο��� �ϴµ�
 ��� ������ ��ü �̸����� ���λ縦 ����
 
 - ���̺�� : TB_XXXX
 - �������� : SEQ_XXXX
 - ��� : VW_XXXX
*/