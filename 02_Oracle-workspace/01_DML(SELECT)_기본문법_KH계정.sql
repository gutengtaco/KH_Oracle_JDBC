/*
 SELECT
 �����͸� ��ȸ�ϰų�, �˻��� �� ����ϴ� ��ɾ�
 -ResultSet : SELECT��������, ��ȸ�� ������(��)���� �����
                            
 [ǥ����]
 SELECT ��ȸ�ϰ����ϴ��÷���1, �÷���2, �÷���3,... 
 FROM ���̺��;
 =>������ �����ϴ� �÷����� �������־�� ��.
*/
--EMPLOYEE���̺��� ��ü ������� ���, �̸�, �޿� �÷����� ��ȸ
--EMP_ID, EMP_NAME,SALARY
SELECT EMP_ID, EMP_NAME,SALARY 
FROM employee;
-- ��ɾ Ű����, ���̺��, �÷��� ���� ��ҹ��ڸ� �������� ����.

--EMPLOYEE ���̺��� ��ü ������� ��� �÷��� ��ȸ
/*
SELECT EMP_ID, EMP_NAME, EMP_NO, EMAIL, PHONE, DEPT_CODE,JOB_CODE,SAL_LEVEL,
       SALARY, BONUS, MANAGER_ID, HIRE_DATE,ENT_DATE,ENT_YN
FROM EMPLOYEE;
*/
SELECT *
FROM EMPLOYEE;

--JOB ���̺��� ��� �÷��� ��ȸ
SELECT *
FROM JOB;

--JOB ���̺��� ���޸� �÷��� ��ȸ
SELECT JOB_NAME
FROM JOB;


--1. DEPARTMENT���̺��� ��� �÷� ��ȸ
SELECT *
FROM department;
--2. EMPLOYEE���̺��� ������, �̸���, ��ȭ��ȣ, �Ի��� �÷��� ��ȸ
SELECT EMP_NAME, EMAIL, PHONE, HIRE_DATE
FROM EMPLOYEE;
--3. EMPLOYEE���̺��� �Ի���, ������, �޿� �÷��� ��ȸ
SELECT HIDE_DATE, EMP_NAME, SALARY
FROM EMPLOYEE;
--[�����޼���]
--00904. 00000 -  "%s: invalid identifier"
--�߸��� �ĺ��ڸ� �Է��ϸ� �߻���.(�÷���� ���̺���� �߸� �Է�)
--------------------------------------------------------
/*
 �÷� ���� ���� ��� ����
 ��ȸ�ϰ��� �ϴ� �÷����� �����ϴ� SELECT���� 
 ��������� ��鿩 �� ����.(+,-,/,*)
 => ��ⷯ������ ����Ŭ���� ���� ������.
*/
--EMPLOYEE ���̺�κ��� ������, ����, ����(����*12)
SELECT EMP_NAME, SALARY, SALARY*12
FROM EMPLOYEE;
--EMPLOYEE ���̺�κ��� ������, ����,���ʽ�, ���ʽ��� ���Ե� ����
SELECT EMP_NAME, SALARY,BONUS,(SALARY + (SALARY*BONUS))*12
FROM EMPLOYEE;
--������� ������ NULL�� �����Ѵٸ�, ������� ����� NULL�� ����!!

--EMPLOYEE���̺�κ��� ������, �Ի���, �ٹ��ϼ�(���ó�¥-�Ի���)�� ��ȸ
--���ó�¥ : SYSDATE
--DATE������ ������ ���� => ��,��,��,��,��,��
SELECT EMP_NAME, HIRE_DATE, (SYSDATE-HIRE_DATE)
FROM EMPLOYEE;
--������� �ϼ������� ����(�����κ�)
--������ �Ҽ��������� ���� ���� �������� ����.
--�̴�, DATEŸ�Կ� ���ԵǾ��ִ� ��/��/�ʿ� ���� ������� �����ϱ� ������.
-----------------------------------------------------------------

/*
 �÷��� ��Ī �ο��ϱ�
 [ǥ����]
 �÷��� AS ��Ī
 �÷��� AS "��Ī"
 �÷��� ��Ī
 �÷��� "��Ī"
 
 ��Ī�� Ư�����ڳ� ���Ⱑ ���Ե� ���, �ݵ�� ""�� ��� ǥ���ؾ� ��.
*/

--EMPLOYEE ���̺�κ��� �̸�, �� �޿�, ���ʽ��� ���Ե� �� �ҵ��� ��ȸ
SELECT EMP_NAME AS �̸�, SALARY AS "�� �޿�" , 
       BONUS ���ʽ�, (SALARY+(BONUS*SALARY))*12 "�� �ҵ�(���ʽ�����)"
FROM EMPLOYEE;
--[�����޼���]
--"FROM keyword not found where expected"
--��Ī�� ���Ⱑ ���Եƴµ� �ֵ���ǥ("")�� ���������� �߻�.
--------------------------------------------------------------
/*
 ���ͷ�
 ���Ƿ� ������ ���ڿ�(''), ����, ��¥�� SELECT���� ����ϸ�
 ���� �� ���̺� �����ϴ� ������ó�� ResultSet���� ��ȸ�� ����
*/

--employee���̺� ���, �����, �޿�, ȭ����� ��ȸ�ϱ� 
SELECT EMP_ID AS ���, EMP_NAME AS "��� ��", SALARY �޿�, '��' AS "����!"
FROM EMPLOYEE;
--SELECT���� ������ ���ͷ��� ��ȸ����� ResultSet�� ��� �࿡ �ݺ������� ���
-------------------------------------------------------------------
/*
 DISTINCT
 ��ȸ�ϰ��� �ϴ� �÷��� �ߺ��� ���� �� �ѹ����� ��ȸ�ϰ� ���� �� ���
 EX) �μ��ڵ� - ������, ȸ����, �λ��� ...
 �ش� �÷��� �տ� DISTINCT�� ������ָ� ��.
 [ǥ����]
 DISTINCT �÷��� 
 => ��,
 SELECT���� DISTINCT������ �� �Ѱ��� �ۼ� ������.
*/
--EMPLOYEE ���̺�κ��� �μ��ڵ带 ��ȸ
/*
SELECT DEPT_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT DEPT_CODE
FROM EMPLOYEE;

--EMPLOYEE ���̺�κ��� �����ڵ带 ��ȸ
/*
SELECT JOB_CODE
FROM EMPLOYEE;
*/
SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

--DEPT_CODE JOB_CODE�÷��� ���� ��Ʈ�� ��� �ߺ��� �Ǻ�
SELECT DISTINCT DEPT_CODE, JOB_CODE
FROM EMPLOYEE;

--------------------------------------------------
/*
 WHERE
 ��ȸ�� �ϰ��� �ϴ� ���̺��� Ư���� ������ �����ؼ�, 
 ���ǿ� �����ϴ� �����͸��� ��ȸ�ϰ����� �� ����ϴ� ����
 
 [ǥ����]
 SELECT �÷��� FROM ���̺�� WHERE ���ǽ�;
 ������� : FROM > WHERE > SELECT
 
 ���ǽĿ� �پ��� �����ڵ��� ��� ������
 �񱳿����� : ��Һ�(>,<,>=,<=)
            �����( = / != �Ǵ� ^= �Ǵ� <>)
*/
-- EMPLOYEE���̺�κ��� �޿��� 400���� �̻��� ������� ��� �÷� ��ȸ
SELECT * 
FROM EMPLOYEE
WHERE SALARY >= 4000000;

--EMPLOYEE���̺�κ��� �μ��ڵ尡 D9�� ������� �����, �μ��ڵ�, �޿��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE='D9';
--3���� ����

--EMPLOYEE���̺�κ��� �μ��ڵ尡 D9�� �ƴ� ������� �����, �μ��ڵ�, �޿��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY 
FROM EMPLOYEE
WHERE DEPT_CODE !=/*<>,^=*/'D9'; 
-- 23�� �� 20���� ���;� ��
-- NULL�� 2�� �־ 18���� ����
-- ������궧�� ����, NULL�� ������ ������ ����� NULL�� ���ܰ� ��.
--------------------------------------------------------------
-- �ǽ�����
-- 1. EMPLOYEE���̺�κ��� �޿��� 300���� �̻��� ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME AS �̸�,SALARY AS �޿�, HIRE_DATE AS �Ի��� 
FROM EMPLOYEE
WHERE SALARY >= 3000000;
-- 2. EMPLOYEE���̺�κ��� �����ڵ尡 J2�� ������� �̸�, �޿�, ���ʽ� ��ȸ
SELECT EMP_NAME AS �̸�, SALARY AS �޿�, BONUS AS ���ʽ�
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';
-- 3. EMPLOYEE���̺�κ��� ���� �������� ������� ���, �̸�, �Ի��� ��ȸ
SELECT EMP_ID AS ���, EMP_NAME AS �̸�, HIRE_DATE AS �Ի���
FROM EMPLOYEE
WHERE ENT_YN = 'N';
-- 4. EMPLOYEE���̺�κ��� ����(�޿�*12)�� 5õ���� �̻��� ������� �̸�, �޿�,����, �Ի��� ��ȸ  
SELECT EMP_NAME AS �̸�, SALARY AS �޿�,(SALARY*12) AS ����, HIRE_DATE AS �Ի���
FROM EMPLOYEE
WHERE (SALARY*12)/*����*/ >= 50000000;
--WHERE�������� ��Ī�� ������ �ȵ�.
--������ FROM > WHERE > SELECT�����̱� ������ ��Ī�� ���� �ȵ�.
--------------------------------------------------------
/*
 �������� 
 ���� ���� ������ ���� �� ���
 JAVA������
 -�̸鼭, �׸��� : AND(&&)
 -�̰ų�, �Ǵ� : OR(||)
 ORACLE������
 -�̸鼭, �׸��� : AND
 -�̰ų�, �Ǵ� : OR
*/
-- EMPLOYEE���̺�κ��� �μ��ڵ尡 "D9"�̸鼭 �޿��� 500���� �̻���
-- ������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE='D9' AND SALARY >= 5000000;

--EMPLOYEE���̺�κ��� �μ��ڵ尡 'D6'�̰ų� �޿��� 300���� �̻���
--������� �̸�, �μ��ڵ�, �޿� ��ȸ
SELECT EMP_NAME AS �̸�, DEPT_CODE AS �μ��ڵ�, SALARY AS �޿�
FROM EMPLOYEE
WHERE DEPT_CODE ='D6' OR SALARY >= 3000000

-- EMPLOYEE���̺�κ��� �޿��� 350���� �̻��̰�, 600���� ������ 
-- ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY >= 3500000 AND SALARY<=6000000;
      /* 3500000 <= SALARY <= 6000000
      -- ����Ŭ�� ���������� �ε�ȣ�� ���޾Ƽ� ���X
-----------------------------------------------------
/*
 BETWEEN AND ������
 �� �̻�, �� ������ ������ ���� ������ ������ �� �ִ� ������
 [ǥ����]
 �񱳴�� �÷� BETWEEN ���Ѱ� AND ���Ѱ�
 (�񱳴�� ���� ���� ���Ѱ� �̻� ���Ѱ� ���ϸ� �����ϴ� ���)
*/
-- EMPLOYEE���̺�κ��� �޿��� 350���� �ʰ�, 600���� �̸��� ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY, JOB_CODE
FROM EMPLOYEE
WHERE SALARY BETWEEN 3500000 AND 6000000;

--EMPLOYEE ���̺�κ��� �޿��� 350���� �̸��̰�, 600���� �ʰ��� ������� �̸�, ���, �޿�, �����ڵ� ��ȸ
SELECT EMP_NAME, EMP_ID, SALARY,JOB_CODE
FROM EMPLOYEE
--WHERE SALARY <35000000 OR SALARY > 6000000;
WHERE NOT SALARY /*NOT*/BETWEEN 3500000 AND 6000000;
--NOT�� �����������ڿ� ���� ������ ������.
--NOT�� ��ġ�� �÷��� �� Ȥ�� BETWEEN�տ� �ٿ���

--BETWEEN AND �����ڴ� DATE���Ŀ����� ��� ������.
--�񱳿����ڵ� DATE���Ŀ��� ��� ����
--���Ѱ��� ����, ���Ѱ��� �̷���.
--�Ի����� '90/01/01' ~ '03/01/01'�� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
--WHERE HIRE_DATE >= '90/01/01' AND HIRE_DATE <= '03/01/01';
WHERE HIRE_DATE BETWEEN '90/01/01' AND '03/01/01';

--EMPLOYEE���̺�κ��� �Ի����� 90/01/01 ~ 03/01/01�� �ƴ� ������� ��� �÷� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE NOT HIRE_DATE /*NOT*/BETWEEN '90/01/01' AND '03/01/01';

/*
 LIKE 'Ư������'
 JAVA�� CONTAINS()�� �����
 => ���Ϸ��� �÷� ���� ���� ������ Ư�� ���Ͽ� ������ ��� ��ȸ
 [ǥ����] �񱳴���÷��� LIKE 'Ư������'
 - Ư�������� ������ ��, ���ϵ�ī���� '%', '_'�� ������ ������ �� ����.
 '%'(�ۼ�Ʈ) : 0���� �̻�
 �񱳴���÷��� LIKE '����%' => �÷��� �߿� �ش� '����'�� ���۵Ǵ� ���� ��ȸ
 �񱳴���÷��� LIKE '%����' => �÷��� �߿� �ش� '����'�� ������ ���� ��ȸ
 �񱳴���÷��� LIKE '%����%' => �÷��� �߿� �ش� '����'�� ���ԵǴ� ���� ��ȸ
 '_' : �� 1����
 �񱳴���÷��� LIKE '_����' => �ش� �÷��� �߿� '����'�տ� ������ 1���ڰ� �����Ұ�� ��ȸ
 �񱳴���÷��� LIKE '__����' => �ش� �÷��� �߿� '����'�տ� ������ 2���ڰ� ������ ��� ��ȸ
*/

--EMPLOYEE���̺�κ��� ���� ������ ������� �̸�, �޿�, �Ի��� ��ȸ
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%';

--EMPLOYEE���̺�κ��� �̸� �߿� '��'�� ���Ե� ������� �̸�, �ֹι�ȣ, �μ��ڵ� ��ȸ
SELECT EMP_NAME, EMP_NO, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��%';

--EMPLOYEE���̺�κ��� ��ȭ��ȣ 4��°�ڸ��� 9�� �����ϴ� ������� ���, �����, ��ȭ��ȣ, �̸��� ��ȸ
SELECT EMP_ID, EMP_NAME, PHONE, EMAIL
FROM EMPLOYEE
WHERE PHONE LIKE '___9%';

--EMPLOYEE���̺�κ��� �̸� ������ڰ� '��'�� ������� ��� �÷�(�̸��� 3������ ���)
SELECT *
FROM EMPLOYEE
WHERE EMP_NAME LIKE '_��_';

--���̿��� ���
SELECT *
FROM EMPLOYEE
WHERE NOT EMP_NAME /*NOT*/ LIKE '_��_';

--------�ǽ�����-------
--1. �̸��� '��'���� ������ ������� �̸�, �Ի��� ��ȸ
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
WHERE EMP_NAME LIKE '%��'/*�Ǵ� __��*/;
--2. ��ȭ��ȣ ó�� 3���ڰ� 010�� �ƴ� ������� �̸�, ��ȭ��ȣ�� ��ȸ
SELECT EMP_NAME, PHONE
FROM EMPLOYEE
WHERE NOT PHONE LIKE '010%';
--3. DEPARTMENT���̺�κ��� �ؿܿ����� ���õ� �μ����� ��� �÷��� ��ȸ
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE LIKE '%�ؿܿ���%';

/*
 IS NULL
 NULL���� �ƴ��� �Ǻ���.
 [ǥ����]
 �񱳴���÷� IS NULL : �÷� ���� NULL�� ��츦 ��ȸ��.
 �񱳴���÷� IS NOT NULL : �÷� ���� NULL�� �ƴ� ��츦 ��ȸ��.
 
 ���ǻ��� : ����Ŭ���� NULL�� ������Ҷ��� =�� ���� �ʰ� IS NULL�� ��!!
*/
-- EMPLOYEE���̺��� ��ü �÷�
SELECT *
FROM EMPLOYEE;

--���ʽ��� ���� �ʴ� ������� ���, �̸�, �޿�, ���ʽ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NULL;

--���ʽ��� �޴� ����帣�� ���, �̸�, �޿�, ���ʽ�
SELECT EMP_ID, EMP_NAME, SALARY, BONUS
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

--����� ���� ������� �����, ������, �μ��ڵ� ��ȸ
SELECT EMP_NAME, MANAGER_ID, DEPT_CODE
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL;

--����� ����, �μ��ڵ嵵 ���� ������� ��� �÷��� ��ȸ
SELECT *
FROM EMPLOYEE
WHERE MANAGER_ID IS NULL AND DEPT_CODE IS NULL;

--�μ��ڵ�� ������, ���ʽ��� �޴� ������� �����, �μ��ڵ�, ���ʽ�
SELECT EMP_NAME, DEPT_CODE, BONUS
FROM EMPLOYEE
WHERE DEPT_CODE IS NULL AND BONUS IS NOT NULL;

/*
 IN
 �񱳴���÷� ���� ���� ������ ��ϵ� �߿��� ��ġ�ϴ� ���� �ϳ��� �ִ��� üũ��.
 [ǥ����]
 �񱳴���÷� IN (��1, ��2, ��3,....)
*/

--�μ��ڵ尡 D6�̰ų� �Ǵ� D8�̰ų� �Ǵ� D5�� ������� �̸�, �μ��ڵ�, �޿��� ��ȸ
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE IN ('D6','D8','D5');

--�� �̿��� �����
SELECT EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE NOT IN ('D6','D8','D5');

/*
 ���Ῥ���� : ||
 ���� �÷����� ��ġ �ϳ��� �÷��� �� ��������ִ� ������
 �÷��� ���ͷ�, ������ ���ڿ��� �����ų�� ����.
 
 �ڹٿ���
 ���ڿ� + ���ڿ� = ������ ���ڿ�
 ���ڿ� + ���� = ������ ���ڿ�
*/
SELECT EMP_ID || EMP_NAME || SALARY "�����"
FROM EMPLOYEE;

-- XX�� XXX�� ������ XXXX���Դϴ�. �������� ���
SELECT EMP_ID || '�� ' ||EMP_NAME || '�� ������ ' ||SALARY || '�� �Դϴ�' AS "�޿�����"
FROM EMPLOYEE;

/*
 ������ �켱���� 
 0. �Ұ�ȣ() : �켱������ �����ִ� ����
 1. ���������(*+-/) : ���� ��������� ����
 2. ���Ῥ����(||): �÷��� ���ͷ� �Ǵ� �÷��� �÷��� ����
 3. �񱳿�����(>,<,>=,<=) : ��Һ� �Ǵ� ����񱳸� ����
 {
 4. IS NULL, NOT NULL : NULL���� �ƴ����� �Ǻ�
 5. LIKE(%,_) : ������ �����ؼ� ���Ͽ� �����ϴ��� �Ǻ�
 6. IN : ������ ��� �� �ϳ��� ��ġ�ϴ����� �Ǻ�(����� + OR) 
 } => 4,5,6���� �켱������ ����.
 7. BETWEEN AND : Ư�� ������ �ش�Ǵ��� üũ(���Ѱ�<= �񱳴�� <= ���Ѱ�)
 8. NOT : ������ ������Ű�� ����.
 9. AND : ������ "�׸���" ��� Ű����� ����
 10. OR : ������ "�Ǵ�"�̶�� Ű����� ����
*/
------------------------------------------------------------------
/*
 ORDER BY ��
 SELECT�� ���� �������� �����ϴ� ���� 
 �Ӹ� �ƴ϶�, ���� ���� ���� ���� ��������.
 ��ȸ�� �����͸� �������� ������ ���ִ� ����(���ı��� + ��������/ �������� )
 
 [ǥ����]
 SELECT ��ȸ���÷��� 
 FROM ���̺��
 WHERE ����
 ORDER BY ���ı������μ�������ϴ��÷���/��Ī/�÷����� [ASC/DESC] [NULLS FIRST/NULLS LAST];
  - ASC : ��������(������ �⺻��)
  - DESC : ��������
  - NULL FIRST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ���, �ش� NULL������ ������ ��ġ�ϰ� ����
    (�������� ���� ��, �⺻����)
  - NULL LAST : �����ϰ��� �ϴ� �÷����� NULL�� ���� ���, �ش� NULL������ �ڷ� ��ġ�ϰ� ����
    (�������� ���� ��, �⺻����)
=> WHERE���� ORDER BY���� ���� ������.
*/

-- ��� ������� �÷��� ��ȸ(��, ������ ���� ���� ������� ����)
SELECT * 
FROM EMPLOYEE
ORDER BY SALARY DESC;
-- ORDER BY���� �����ϸ�, �⺻Ű�� �������� ������������ ���ĵ�.

-- ��� ������� �÷��� ��ȸ(��, �̸� �����ټ�)
SELECT * 
FROM EMPLOYEE
ORDER BY EMP_NAME ASC;

SELECT *
FROM EMPLOYEE
/*ORDER BY BONUS */ -- ASC �Ǵ� DESC�� ���� ��, �⺻���� ASC��(��������)
/*ORDER BY BONUS ASC*/ -- ����� ���� ��, ASC�� �⺻������ NULL������ �ؿ� �������(NULLS LAST)
/*ORDER BY BONUS ASC NULLS FIRST;*/ -- ���������̾ NULLS FIRST ���� ����

/*ORDER BY BONUS DESC*/-- ����� ���� ��, DESC�� �⺻������ NULL������ ���� ����(NULLS FIRST)
/*ORDER BY BONUS DESC NULLS LAST;*/ -- ���������̾ NULLS LAST ���� ����

ORDER BY BONUS DESC, SALARY ASC;
-- ù��°�� ������ ���ı����� �÷����� ��ġ�� ���, �ι�° ���ı����� ������ �ٽ� ����

-- ���� ������� �ټ����(�̸�, ����, ���� �÷� ���)
SELECT EMP_NAME, SALARY, SALARY*12 "����"
FROM EMPLOYEE
--ORDER BY SALARY*12 DESC;
--ORDER BY "����" DESC;
ORDER BY 3 DESC; -- SELECT���� ������ �÷� ����(1���� ����)




