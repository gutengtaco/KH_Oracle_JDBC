/*
 <JOIN>
 �ΰ� �̻��� ���̺��� �����͸� ���� ��ȸ�ϰ��� �� �� ���Ǵ� ����
 ��ȸ����� �ϳ��� �����(Result set)�� ����
 
 ������ �����ͺ��̽������� �ּ����� �����ͷ� ������ ���̺� �����͸� �����ϰ� ����.
 �� ������, �ߺ��� �ּ�ȭ�ϱ� ���ؼ� �ִ��� �ɰ��� ������.
 => ��, �ϳ��� ���̺��� ��� �����͸� �����ϴ� �� ����(�ߺ��� ���ɼ��� ������)
 => �ִ��� ���̺� �ɰ� ��, JOIN������ �̿��ؼ� �������� ���̺� "����"�� �ξ ���� ��ȸ�ϴ� ���� ȿ������.
 => ���̺� ���� "�����"�� �ش��ϴ� �÷��� ��Ī���Ѽ� ��ȸ�ؾ� ��.
 
 JOIN�� ũ�� "����Ŭ ���� ����"�� "ANSI(�̱�����ǥ����ȸ) ����"���� ����.
 => �� �ٸ� ��, ������ �Ȱ���.
 
 
        ����Ŭ ���� ����                           ANSI (����Ŭ, �ٸ�DBMS)����
 ===============================================================================
        �����(EQUAL JOIN)                     ��������(INNER JOIN) -> JOIN USING / ON  
                                               �ܺ�����(OUTER JOIN) -> JOIN USING
 -------------------------------------------------------------------------------
        ��������                                 ���� �ܺ�����(LEFT OUTER JOIN)  
        (LEFT OUTER JOIN)                      ������ �ܺ�����(RIGHT OUTER JOIN)  
        (RIGHT OUTER JOIN)                     ��ü �ܺ�����(FULL OUTER JOIN)
 -------------------------------------------------------------------------------    
        ī�׽þ� ��(CARTESIAN PRODUCT)          ���� ����(CROSS JOIN)
 -------------------------------------------------------------------------------
        ��ü����(SELF JOIN)                      JOIN ON ������ �̿�
        ������(NON EQUAL JOIN)
 ===============================================================================       
*/

-- ��ü ������� ���, �����, �μ��ڵ�, �μ������ �˾Ƴ����� �Ѵٸ�?
-- �μ����� DEPARTMENT���̺� ������.
SELECT EMP_ID, EMP_NAME, DEPT_CODE
FROM EMPLOYEE; -- EMPLOYEE���̺��� DEPT_CODE �÷�

SELECT DEPT_ID, DEPT_TITLE
FROM DEPARTMENT; -- DEPARTMENT���̺��� DEPT_ID �÷��� ����


-- ��ü ������� ���, �����, �����ڵ�, ���޸��� �˾Ƴ����� �Ѵٸ�?
-- ���޸��� JOB���̺� ������
SELECT EMP_ID, EMP_NAME, JOB_CODE
FROM EMPLOYEE; -- EMPLOYEE ���̺��� JOB_CODE�÷�

SELECT JOB_CODE, JOB_NAME
FROM JOB; -- JOB���̺��� JOB_CODE�÷��� ����

-------------------------------------------------------------------------------
/*
 1. �����(EQUAL JOIN,����Ŭ) / ��������(INNER JOIN,ANSI)
 �����Ű�� �÷��� ���� ��ġ�ϴ� ��鸸 �����ؼ� ��ȸ
 ��ġ���� �ʴ� ������ ��ȸ���� ����
*/


-->> ����Ŭ ���� ����
-- FROM���� ��ȸ�ϰ��� �ϴ� ���̺����� ������
-- WHERE���� ��Ī��ų �÷���(�����)�� ���� ������ ������.

-- ��ü ������� ���, �����, �μ��ڵ�, �μ����� ���� ��ȸ
-- 1) ������ �� �÷����� �ٸ� ��� ( EMPLOYEE���̺��� DEPT_CODE == DEPARTMENT���̺��� DEPT_ID)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; 
-- EMPLOYEE���̺��� ������� 23��������, ����� 21�� ��µ�.
-- EMPLOYEE���̺��� DEPT_CODE�� NULL�� ����� 2���� ������.
-- DEPT_CODE�� DEPT_ID�� ��ġ���� �ʴ� ��(NULL)�� ��ȸ���� ���ܵ�.
-- �̴� DEPT_ID�÷��� NULL�� �������� �ʱ� ������
-- �߰������� EMPLOYEE���̺��� DEPT_CODE�� D3,D4,D7�� �ش�Ǵ� ������� �������� �ʱ� ������
-- DEPARTMENT���̺��� DEPT_ID�� D3,D4,D7�� �ش��ϴ� DEPT_TITLE�� ������� ����.

-- ��ü ������� ���, �����, �����ڵ�, ���޸��� ���� ��ȸ
-- 2) ������ �� �÷����� ���� ���(EMPLOYEE���̺��� JOB_CODE == DEPARTMENT���̺��� JOB_CODE)
/*
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE JOB_CODE = JOB_CODE;
*/
-- [�����޼���] "column ambiguously defined" => �÷��� �ָŸ�ȣ�ϰ� ������.
-- �÷����� ��� ���̺� �Դ����� ������־�� ��.

-- ��� 1. ���̺���� ������ִ� ���
-- ���̺��.�÷���
SELECT EMP_ID, EMP_NAME, JOB.JOB_CODE, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
-- �μ��ʹ� �ٸ��� ������ ��� �����ϱ� ������, J1~J7�� ��� �÷����� ��µ�.

-- ���2. ���̺� ��Ī�� �ٿ� �� ��Ī�� ������ִ� ���
-- ���̺�Ī.�÷���
SELECT EMP_ID, EMP_NAME, E.JOB_CODE, J.JOB_CODE, JOB_NAME
FROM EMPLOYEE E, JOB J -- ���̺�� ��Ī
WHERE E.JOB_CODE = J.JOB_CODE;
--FROM���� WHERE, SELECT������ �켱�ϱ� ������, WHERE, SELECT������ ��Ī���� �ۼ���.



-->> ANSI����
-- FROM���� ���̺���� �� �ϳ��� �ۼ�(���� ���̺��� ���ؼ� �ۼ�)
-- FROM�� �ڿ� JOIN���� �ۼ��Ͽ� ���� ��ȸ�ϰ��� �ϴ� ���̺���� ���
-- ����, ��Ī��ų �÷�(�����)�� ���� ���ǵ� ���� ���
-- JOIN������ ON���� �Ǵ� USING�������� ������� ���� ������ �����.

-- ���, �����, �μ��ڵ�, �μ���
-- 1) ������ �� �÷����� �ٸ� ���(EMPLOYEE���̺��� DEPT_CODE == DEPARTMENT���̺��� DEPT_ID)
-- => �� �÷����� �ٸ� ���, ������ ON ������ ��� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE  -- �������̺�
/*INNER*/JOIN DEPARTMENT  -- JOIN�ϰ��� �ϴ� ���̺�, INNER�� ���� ����
ON (DEPT_CODE = DEPT_ID); -- ������� ���� ����

-- ���, �����, �����ڵ�, ���޸�
-- 2) ������ �� �÷����� ���� ���(EMPLOYEE���̺��� JOB_CODE == DEPARTMENT���̺��� JOB_CODE)
-- => �� �÷����� ���� ���, ON���� USING���� �Ѵ� ��� ����
-- 2-1. ON���� ���� 
SELECT EMP_ID, EMP_NAME, EMPLOYEE/*E*/.JOB_CODE, JOB_NAME -- AMBIGUOUSLY ���� �߻� ����
FROM EMPLOYEE /*E*/ 
JOIN JOB /*J*/
ON (EMPLOYEE /*E*/.JOB_CODE = JOB /*J*/.JOB_CODE); -- AMBIGUOUSLY ���� �߻� ����
-- ��Ȯ�ϰ� ���̺��(��Ī)�� �������

-- 2-2. USING���� ���� : �÷��� �����ϴ� ����
-- ���ʿ� �÷����� ������ ��쿡�� ��� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
JOIN JOB
USING (JOB_CODE); -- ������ �÷��� USING������ ���ָ� AMBIGUOUSLY�� �߻����� ����.

-- [����] ���� USING���������� ���ô� NATURAL JOIN(�ڿ�����)�̶�� �������ε� ǥ�� ����
SELECT EMP_ID, EMP_NAME, JOB_CODE, JOB_NAME
FROM EMPLOYEE
NATURAL JOIN JOB; 
-- �ΰ��� ���̺�� ������ ����
-- �����Ե� �ΰ��� ���̺� ��ġ�ϴ� �÷����� �����ϰ� �Ѱ� �����ϴ� ���(JOB_CODE)
-- �˾Ƽ� ��Ī��.

-- �߰����� ������ ���� ����
-- ������ �븮�� ������� ������ ��ȸ
--> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE, JOB
WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE -- ������ �Ͼ ���, �ʼ����� ����
     AND JOB_NAME ='�븮';
-- �����ÿ� �������� ���̱� ����, ���� �ϳ��� ���� + �鿩���⸦ ����.

--> ANSI ����
-- ��ü������ JOIN���� ON, USING������ ÷���Ͽ�
-- WHERE���� ���̱� ª����
SELECT EMP_ID, EMP_NAME, SALARY, JOB_NAME
FROM EMPLOYEE E
-- /*INNER*/JOIN JOB USING (JOB_CODE)
JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
WHERE JOB_NAME='�븮';

----------�ǽ�����------------
-- 1. �μ��� '�λ������'�� ������� ���, �����, ���ʽ��� ��ȸ
SELECT *
FROM DEPARTMENT;
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
-- �μ��� '�λ������'�� ��� : ����, ���¿�, ������

--> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
  AND DEPT_TITLE = '�λ������'; 
--> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS
FROM EMPLOYEE
JOIN DEPARTMENT ON (EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID)
WHERE DEPT_TITLE = '�λ������';

-- 2. �μ��� '�ѹ���'�� �ƴ� ������� �����, �޿�, �Ի����� ��ȸ
SELECT *
FROM DEPARTMENT;
SELECT EMP_NAME, DEPT_CODE
FROM EMPLOYEE;
-- �ѹ����� ��� : ������, ���߱�, ���ö
-- �μ��� ���� ��� : �ϵ���, �̿���

--> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
    AND DEPARTMENT.DEPT_TITLE != '�ѹ���'; 
    -- ��� : 18��
--> ANSI����
SELECT EMP_NAME, SALARY, HIRE_DATE
FROM EMPLOYEE
JOIN DEPARTMENT ON EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
WHERE DEPARTMENT.DEPT_TITLE != '�ѹ���';

-- 3. ���ʽ��� �޴� ������� ���, �����, ���ʽ�, �μ��� ��ȸ
SELECT EMP_NAME, BONUS
FROM EMPLOYEE;
SELECT DEPT_CODE
FROM EMPLOYEE; 
-- �μ��� ���� ��� ��ȸ : �ϵ���, �̿���
-- ���ʽ��� �޴� ��� ��ȸ : ������, �����, ������, �ɺ���, ������,(�ϵ���), ���¿�, ������, ���¸�

--> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID
    AND EMPLOYEE.BONUS IS NOT NULL; 
    -- ��� : 8��
    
--> ANSI����
SELECT EMP_ID, EMP_NAME, BONUS, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID)
WHERE EMPLOYEE.BONUS IS NOT NULL;

-- 4. �Ʒ��� �� ���̺��� �����ؼ� �μ��ڵ�, �μ���, �����ڵ�, ������(LOCAL_NAME)�� ��ȸ
SELECT *
FROM DEPARTMENT;
SELECT *
FROM LOCATION;

--> ����Ŭ ���� ����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT, LOCATION
WHERE DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE;
--> ANSI����
SELECT DEPT_ID, DEPT_TITLE, LOCAL_CODE, LOCAL_NAME
FROM DEPARTMENT 
JOIN LOCATION ON(DEPARTMENT.LOCATION_ID = LOCATION.LOCAL_CODE);

-- �������� : ���̺��� 3�� �̻��� ������.
-- ���, �����, �μ���, ���޸�
SELECT * FROM EMPLOYEE;     -- DEPT_CODE, JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID
SELECT * FROM JOB;          --            JOB_CODE

--> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID
  AND E.JOB_CODE = J.JOB_CODE;
--> ANSI����
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE
JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
JOIN JOB USING (JOB_CODE);

-- ����� / �������� : ��ġ���� �ʴ� ���� ���ʿ� ��ȸ�� ���� ����.
-- ���� : EMPLOYEE���̺��� DEPT_CODE�� NULL�� �ϵ���, �̿�������� �����ϰ� ��ȸ�� ��.
-- => �ش� �μ��� �Ҽ� ����� ���� ���� ���� ������� Ȯ���� �Ұ���.

-----------------------------------------------------------------------------
/*
 2. �������� / �ܺ�����(OUTER JOIN)
 ���̺��� JOIN�� ��ġ���� �ʴ� ��鵵 ���Խ��Ѽ� ��ȸ ����
 ��, LEFT/RIGHT�� �����ؾ� ��(������ LEFT/ RIGHT������ �����϶�� ��)
*/

-- "��ü" ������� �����, �޿�, �μ��� ��ȸ
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE
JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- DEPT_CODE�� NULL�� ����� ���(NULL)
-- ������ �μ��� ���� ����� ���(D3,D4,D7), ������� ���ܵ�.

-- 1) LEFT OUTER JOIN : �� ���̺� �� ���� ����� ���̺��� �������� JOIN
--                      ��, ���� �Ǿ��� ����, ���� ����� ���� ���̺��� �����ʹ� ������ ��ȸ��.
--                      (��ġ���� ������ NULL�� ��ü�Ͽ� ���)
-->> ANSI����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE /*�������̺� (����)*/ LEFT OUTER JOIN DEPARTMENT 
ON (DEPT_CODE = DEPT_ID);
-- EMPLOYEE���̺��� �������� ��ȸ�� �߱� ������, 
-- EMPLOYEE���̺� �����ϴ� �����ʹ� ���� �Ǿ��� ���� �ѹ��� �� ��ȸ�ǰԲ� ��.

-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE EMPLOYEE.DEPT_CODE = DEPARTMENT.DEPT_ID(+); -- ������� ���� ����
-- (+) : ���� �������� 
-- ���� �������� ���� ���̺��� �÷����� �ƴ�, �ݴ� ���̺��� �÷��� �ڿ� (+)��ȣ�� ����.

-- 2) RIGHT OUTER JOIN : �� ���̺� �� ������ ����� ���̺��� �������� JOIN
--                       ��, ���� �Ǿ��� ���� ������ ����� ���� ���̺��� �����ʹ� ������ ��ȸ
--                       (��ġ���� ������ NULL�� ��ü�Ͽ� ���)
-->> ANSI ����
SELECT EMP_NAME, SALARY,DEPT_ID, DEPT_TITLE
FROM EMPLOYEE RIGHT OUTER JOIN DEPARTMENT/*�������̺�(������)*/
ON (DEPT_CODE = DEPT_ID); 
-- 21�������� �/�������� �����
-- 22, 23, 24���� DEPARTMENT���̺��� �������� D3,D4,D7�� ���� ������ �߰���.

-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID; -- ������� ���� ����

-- LEFT / RIGHT OUTER JOIN�� 
-- �⺻������ �/���������� ��� + �������̺��� ������ ������ �������� ������

-- 3) FULL OUTER JOIN : �� ���̺��� ���� ��� ���� ��ȸ�� �� �ְ� JOIN
--                      ��, ����Ŭ ���� ���������� �Ұ�
-->> ANSI ����
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE
FULL OUTER JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
-- �⺻������ � / ���������� ��� + �������̺��� ������ ���� + ���������̺��� ������ ����
-- �ϵ���, �̿����� ����(LEFT) + D3, D4, D7�� ����(RIGHT)

/*
-->> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, DEPT_ID, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE(+) = DEPT_ID(+);
-- [����] : "a predicate may reference only one outer-joined table"
-- �������ν�, ������ �Ǵ� ���̺��� �ϳ��� �־�� ��.
-- => FULL OUTER JOIN������ ����Ŭ ���� ������ �Ұ���
*/
--------------------------------------------------------------------------------

/*
 3. ī�׽þ� ��(CARTESIAN PRODUCT) / �������� (CROSS JOIN)
 ��� ���̺��� �� ����� ���� ���ε� ����� ��ȸ��(��� ����� ���� �� ��ڴ�. ������)
 �� ���̺��� ����� ��� ������ ����� ������ �� ���( �����, ������)
 
 ��) EMPLOYEE ���̺��� �� 23���� �� / DEPARTMENT ���̺� �� 9���� ��
 23 * 7 = 207���� ���� ����� ����
*/

-- �����, �μ���
-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE, DEPARTMENT;
-- ī�׽þ� ���� �ַ� WHERE���� ������� ������ �Ǽ��� �������� ��� �ַ� �߻�
-- (������� ���� ������ ������ ����, ��� ����� ���� �� ��ڴٴ� ��)

-->> ANSI����
SELECT EMP_NAME, DEPT_TITLE
FROM EMPLOYEE
CROSS JOIN DEPARTMENT; 
--------------------------------------------------------------------------------

/*
 4. ������ (NON EQUAL JOIN)
 '='(��ȣ, ����񱳿�����)�� ���� ���, ��ȣ�� ������� �ʴ� JOIN
 ������ �÷����� ��ġ�ϴ� ��찡 �ƴ϶�, "����"�� ���ԵǴ� ���� ��� ��ȸ��.
*/
-- �����, �޿�
SELECT *
FROM EMPLOYEE;

SELECT * 
FROM SAL_GRADE;

-- �����, �޿�, �޿����(SAL_LEVEL)
--> ����Ŭ ���� ����
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL, MIN_SAL, MAX_SAL
FROM EMPLOYEE, SAL_GRADE
-- WHERE SALARY >= MIN_SAL AND SALARY <= MAX_SAL-- ������� ���� ���� ����
WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;

--> ANSI ����
SELECT EMP_NAME, SALARY, SAL_GRADE.SAL_LEVEL, MIN_SAL, MAX_SAL
FROM EMPLOYEE
JOIN SAL_GRADE ON (SALARY BETWEEN MIN_SAL AND MAX_SAL);
-- ������ : �ַ� ������� ���� ���ǽ����� >, <, >=, <=, BETWEEN AND�� ��
-- ��ȣ�� ���� �ʱ� ������ ON�������� �����.

--------------------------------------------------------------------------------

/*
 5. ��ü����(SELF JOIN)
 ���� ���̺��� �ٽ� �ѹ� �����ϴ� ���
 ��, �ڱ��ڽ��� ���̺�� �ٽ� ������ �ϴ� ���
*/

SELECT EMP_ID "���", EMP_NAME "�����", SALARY "�޿�", MANAGER_ID "����� ���"
FROM EMPLOYEE;

-- ���ǻ��� : ���̺���� ������ => �ָŸ�ȣ��!!
--          �׻� ���̺�� ��Ī�� �ٸ��� �ο��� ������ ����
SELECT * FROM EMPLOYEE E; -- ����� ���� ������ ��ȸ�� ���� E��� ���̺�
SELECT * FROM EMPLOYEE M; -- ����� ���� ������ ��ȸ�� ���� M�̶�� ���̺�

-- ����� ���, �����, �μ��ڵ�, �޿�(E)
-- ����� ���, �����, �μ��ڵ�, �޿�(M)
-->> ����Ŭ ���� ����
SELECT E.EMP_ID "����� ���", E.EMP_NAME "����� �����", E.DEPT_CODE "����� �μ��ڵ�", E.SALARY "����� �޿�",
M.EMP_ID "����� ���", M.EMP_NAME "����� �����", M.DEPT_CODE "����� �μ��ڵ�", M.SALARY "����� �޿�"
FROM EMPLOYEE E, EMPLOYEE M
WHERE E.MANAGER_ID = M.EMP_ID(+);

-->> ANSI����      
SELECT E.EMP_ID "����� ���", E.EMP_NAME "����� �����", E.DEPT_CODE "����� �μ��ڵ�", E.SALARY "����� �޿�",
M.EMP_ID "����� ���", M.EMP_NAME "����� �����", M.DEPT_CODE "����� �μ��ڵ�", M.SALARY "����� �޿�"
FROM EMPLOYEE E
LEFT /*OUTER*/ JOIN EMPLOYEE M ON (E.MANAGER_ID = M.EMP_ID);

-- ����� ���, �����, �μ��ڵ�, �޿�, �μ���(E)
-- ����� ���, �����, �μ��ڵ�, �޿�, �μ���(M)
SELECT E.EMP_ID "����� ���", E.EMP_NAME "����� �����", E.DEPT_CODE "����� �μ��ڵ�",D1.DEPT_TITLE "����� �μ���", E.SALARY "����� �޿�",
       M.EMP_ID "����� ���", M.EMP_NAME "����� �����", M.DEPT_CODE "����� �μ��ڵ�",D2.DEPT_TITLE "����� �μ���", M.SALARY "����� �޿�"
FROM EMPLOYEE E -- ������
LEFT JOIN EMPLOYEE M ON(E.MANAGER_ID = M.EMP_ID) -- ������� ������ ����
LEFT JOIN DEPARTMENT D1 ON(E.DEPT_CODE = D1.DEPT_ID) -- ��� : EMPLOYEE E(����)�� DEPARTMENT�� �ܺ�����
LEFT JOIN DEPARTMENT D2 ON(M.DEPT_CODE = D2.DEPT_ID); -- ��� : EMPLOYEE M(����)�� DEPARTMENT�� �ܺ�����

----------------------------------------------------------------------------------------------------------------------------

/*
 < ���� ���� >
 3�� �̻��� ���̺��� ����
*/
SELECT * FROM EMPLOYEE;     -- DEPT_CODE  JOB_CODE
SELECT * FROM DEPARTMENT;   -- DEPT_ID              LOCATION_ID
SELECT * FROM JOB;          --            JOB_CODE
SELECT * FROM LOCATION;     --                      LOCAL_CODE

-- ���, �����, �μ���, ���޸�, ������(LOCAL_NAME)
--> ����Ŭ ���� ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", JOB_NAME "���޸�", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E, DEPARTMENT D, JOB J, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+);
-- ��� ���������� ���� ������ 21��
-- ��� ���������� �ϸ� 23�� 
-- ���� 2���� �ο��� �μ��� ���� NULL�����̱� ������
-- �μ��� ������ �޴� DEPARTMENT���̺��� �μ���� LOCATION���̺� �ٹ������� ������� �ϰ� �Ǹ�
-- ������ ��� AND�����ڷ� �����ֱ� ������, NULL�� �����ϰ� �Ǿ� 21���̶�� ����� ����
-- ����, ������������ �����־�߸� 23�� ����� ����� �����.

--> ANSI ����
SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", JOB_NAME "���޸�", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
/*LEFT*/JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE) -- USING(JOB_CODE) : �������ο����� USING����
                                               -- ��� ����� ������ ������ �ֱ� ������, �ܺ������� �� �ʿ�� ����.
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE);

SELECT EMP_ID "���", EMP_NAME "�����", DEPT_TITLE "�μ���", JOB_NAME "���޸�", LOCAL_NAME "�ٹ�������"
FROM EMPLOYEE E
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);
-- LOCATION�� DEPARTMENT�� ������ �ٲٸ� ������ ��
-- LOCATION�� DEPARTMENT�� ������ �� ���̱� ������, 
-- ������ �ٲٸ� �ȵ�.
-- ANSI�������� ���������� �ۼ��� ��쿡�� JOIN�� ������ �߿���.

SELECT * FROM EMPLOYEE;     -- DEPT_CODE  JOB_CODE                            SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID              LOCATION_ID
SELECT * FROM JOB;          --            JOB_CODE
SELECT * FROM LOCATION;     --                      LOCAL_CODE  NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                  NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                MIN_SAL / MAX_SAL

--> ANSI����
-- ���, ���, �μ���, ���޸�, �ٹ�������, �ٹ�������, �޿����(SAL_GRADE���̺�)
SELECT 
E.EMP_ID "���", 
E.EMP_NAME "���", 
D.DEPT_TITLE "�μ���", 
J.JOB_NAME "���޸�", 
L.LOCAL_NAME "�ٹ�������", 
N.NATIONAL_NAME "�ٹ�������", 
S.SAL_LEVEL "�޿����"
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
LEFT JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
LEFT JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
     JOIN SAL_GRADE S ON(E.SALARY BETWEEN S.MIN_SAL AND S.MAX_SAL)
;


---------------------- JOIN ���� �ǽ����� ----------------------
SELECT * FROM EMPLOYEE;     -- DEPT_CODE  JOB_CODE                            SALARY
SELECT * FROM DEPARTMENT;   -- DEPT_ID              LOCATION_ID
SELECT * FROM JOB;          --            JOB_CODE
SELECT * FROM LOCATION;     --                      LOCAL_CODE  NATIONAL_CODE
SELECT * FROM NATIONAL;     --                                  NATIONAL_CODE
SELECT * FROM SAL_GRADE;    --                                                MIN_SAL / MAX_SAL

-- 1. ������ �븮�̸鼭 ASIA ������ �ٹ��ϴ� ��������
--    ���, �����, ���޸�, �μ���, �ٹ�������, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY 
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND JOB_NAME = '�븮' 
  AND LOCAL_NAME LIKE 'ASIA%'
;

-->> ANSI ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME, SALARY 
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE JOB_NAME = '�븮'
  AND LOCAL_NAME LIKE 'ASIA%';

-- 2. 70�����̸鼭 �����̰�, ���� ������ ��������
--   �����, �ֹι�ȣ, �μ���, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E, DEPARTMENT D, JOB J
WHERE E.DEPT_CODE = D.DEPT_ID
AND E.JOB_CODE = J.JOB_CODE
AND SUBSTR(EMP_NO,1,1) ='7'
AND SUBSTR(EMP_NO,8,1) ='2'
AND EMP_NAME LIKE '��%'
;
-->> ANSI ����
SELECT EMP_NAME, EMP_NO, DEPT_TITLE, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE SUBSTR(EMP_NO,8,1) ='2'
AND SUBSTR(EMP_NO,1,1) ='7'
AND EMP_NAME LIKE '��%'
;

-- 3. �̸��� '��'�ڰ� ����ִ� �������� 
--    ���, �����, ���޸��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
AND EMP_NAME LIKE '%��%';
;
-->> ANSI ����
SELECT EMP_ID, EMP_NAME, JOB_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE EMP_NAME LIKE '%��%'
;

-- 4. �ؿܿ������� �ٹ��ϴ� ��������
--    �����, ���޸�, �μ��ڵ�, �μ����� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E, JOB J, DEPARTMENT D
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND DEPT_TITLE LIKE '�ؿܿ���%'
;
-->> ANSI ����
SELECT EMP_NAME, JOB_NAME, DEPT_CODE, DEPT_TITLE
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
WHERE DEPT_TITLE LIKE '�ؿܿ���%'
;

-- 5. ���ʽ��� �޴� ��������
--    �����, ���ʽ�, ����, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME, BONUS
FROM EMPLOYEE;

SELECT EMP_NAME, BONUS, SALARY*12, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND BONUS IS NOT NULL
;
-->> ANSI ����
SELECT EMP_NAME, BONUS, SALARY*12, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON( E.DEPT_CODE = D.DEPT_ID)
LEFT JOIN LOCATION L  ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE BONUS IS NOT NULL;

-- 6. �μ��� �ִ� ��������
--    �����, ���޸�, �μ���, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L
WHERE E.JOB_CODE = J.JOB_CODE
  AND E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND E.DEPT_CODE IS NOT NULL;
-->> ANSI ����
SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, LOCAL_NAME
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
WHERE E.DEPT_CODE IS NOT NULL;

-- 7. '�ѱ�' �� '�Ϻ�' �� �ٹ��ϴ� ��������
--    �����, �μ���, �ٹ�������, �ٹ��������� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID
  AND D.LOCATION_ID = L.LOCAL_CODE
  AND L.NATIONAL_CODE = N.NATIONAL_CODE
  AND (NATIONAL_NAME = '�ѱ�' OR NATIONAL_NAME ='�Ϻ�')
  ;
-->> ANSI ����
SELECT EMP_NAME, DEPT_TITLE, LOCAL_NAME, NATIONAL_NAME
FROM EMPLOYEE E
JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
JOIN LOCATION L ON(D.LOCATION_ID = L.LOCAL_CODE)
JOIN NATIONAL N ON(L.NATIONAL_CODE = N.NATIONAL_CODE)
WHERE NATIONAL_NAME = '�ѱ�' OR NATIONAL_NAME ='�Ϻ�';

-- 8. ���ʽ��� ���� �ʴ� ������ �� �����ڵ尡 J4 �Ǵ� J7 �� ��������
--    �����, ���޸�, �޿��� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
  AND BONUS IS NULL
  AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');
-->> ANSI ����
SELECT EMP_NAME, JOB_NAME, SALARY
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE)
WHERE BONUS IS NULL
AND (E.JOB_CODE = 'J4' OR E.JOB_CODE = 'J7');

-- 9. ���, �����, ���޸�, �޿����, ������ ��ȸ�ϴµ�
--    �� ��, ���п� �ش��ϴ� ����
--    �޿������ S1, S2 �� ��� '���'
--    �޿������ S3, S24 �� ��� '�߱�'
--    �޿������ S5, S6 �� ��� '�ʱ�' ���� ��ȸ�ǰ� �Ͻÿ�
-->> ����Ŭ ���� ����
SELECT *
FROM EMPLOYEE;
SELECT EMP_ID, EMP_NAME, JOB_NAME, SAL_LEVEL "�޿����", 
CASE WHEN SAL_LEVEL='S1' OR SAL_LEVEL= 'S2' THEN '���'
     WHEN SAL_LEVEL='S3' OR SAL_LEVEL= 'S4' THEN '�߱�'
     ELSE '�ʱ�'
     END "����"
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE;
-->> ANSI ����
SELECT EMP_ID, EMP_NAME, JOB_NAME, SAL_LEVEL "�޿����", 
CASE WHEN SAL_LEVEL='S1' OR SAL_LEVEL= 'S2' THEN '���'
     WHEN SAL_LEVEL='S3' OR SAL_LEVEL= 'S4' THEN '�߱�'
     ELSE '�ʱ�'
     END "����"
FROM EMPLOYEE E
JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- 10. �� �μ��� �� �޿����� ��ȸ�ϵ�
--     �� ��, �� �޿����� 1000���� �̻��� �μ���, �޿����� ��ȸ�Ͻÿ�
-->> ����Ŭ ���� ����
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;
-->> ANSI ����
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) >= 10000000;

-- 11. �� �μ��� ��ձ޿��� ��ȸ�Ͽ� �μ���, ��ձ޿� (����ó��) �� ��ȸ�Ͻÿ�
--     ��, �μ���ġ�� �ȵ� ������� ��յ� ���� �����Բ� �Ͻÿ�
--> ����Ŭ ���� ����
SELECT DEPT_TITLE, ROUND(AVG(SALARY))
FROM EMPLOYEE E, DEPARTMENT D
WHERE E.DEPT_CODE = D.DEPT_ID(+)
GROUP BY DEPT_TITLE;

-->> ANSI ����
SELECT DEPT_TITLE, ROUND(AVG(SALARY))
FROM EMPLOYEE E
LEFT JOIN DEPARTMENT D ON(E.DEPT_CODE = D.DEPT_ID)
GROUP BY DEPT_TITLE;