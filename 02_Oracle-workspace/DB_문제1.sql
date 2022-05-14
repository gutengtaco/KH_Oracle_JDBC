---1. EMPLOYEE ���̺��� 12�� �����ڿ��� ���� �޼��� ������
--���: OOO�� 12�� OO�� ������ �����մϴ�! 
SELECT *
FROM EMPLOYEE;

SELECT EMP_NAME||'�� 12��'||SUBSTR(EMP_NO,5,2)||'�� ������ �����մϴ�!' "���ϸ޼���"
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,3,2) = 12;

--2. EMP ���̺��� �μ��ڵ�� DEPT ���̺��� �����Ͽ� �� �μ��� �ٹ��� ��ġ�� ��ȸ
--�����, �μ��ڵ�, �μ���, �ٹ��� ��ġ ���
SELECT *
FROM DEPARTMENT;

SELECT EMP_NAME, DEPT_CODE, DEPT_TITLE, LOCATION_ID 
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID;

--3. EMPLOYEE ���̺��� ���� 200���� �̻� 300���� ������ ����� 
--���, �����, �Ի���, �μ��ڵ�, ���� ��ȸ (��, ������ BONUS ���� �� \999,999,999�� ��ȸ)
SELECT EMP_ID, EMP_NAME, HIRE_DATE, DEPT_CODE, SALARY,
TO_CHAR((SALARY+(SALARY*BONUS)*12),'999,999,999')
FROM EMPLOYEE
WHERE SALARY BETWEEN 2000000 AND 3000000;

--4. EMPLOYEE ���̺��� ���� PHONE ��ȣ�� 011���� �����ϴ� �����
--�̸�, ���, PHONE, �μ��ڵ带 ��ȸ
SELECT EMP_NAME, EMP_ID, PHONE, DEPT_CODE
FROM EMPLOYEE
WHERE SUBSTR(PHONE,1,3) = '011';

--5. 80������ ���� ������ �� ���� '��'���� ����� �ֹι�ȣ, ������ ��ȸ
--��, �ֹι�ȣ�� [888888-2******] ���·� ��ȸ �� ���������� �������� ����
SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%' AND SUBSTR(EMP_NO,1,2)>=80 AND SUBSTR(EMP_NO,1,2)<=89
ORDER BY EMP_NAME ASC;

--6. EMPLOYEE ���̺��� �����ڵ带 �ߺ� ����, "���� ����" ��� ��Ī�� �ο��ϰ�
--"���� ����" ������������ �����ؼ� ��ȸ
SELECT DISTINCT JOB_CODE "���� ����"
FROM EMPLOYEE
ORDER BY JOB_CODE ASC;

--7. �μ��� �޿� �հ谡 �μ� �޿� ������ 10%���� ���� �μ��� �μ����, �μ��޿� �հ� ��ȸ
--�Ϲ� ������ �������� ���
-- 1) �μ� �޿� ����
SELECT SUM(SALARY)
FROM EMPLOYEE; -- 70096240

-- 2) �μ��� �޿� �հ�
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > 70096240*0.1; 

-- 3) ��ġ��
SELECT DEPT_TITLE, SUM(SALARY)
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
GROUP BY DEPT_TITLE
HAVING SUM(SALARY) > (SELECT SUM(SALARY)
                     FROM EMPLOYEE)*0.1;

--8. EMPLOYEE ���̺��� �μ� �ο��� 3�� �̻��� �μ��� 
--�μ� �ڵ�, ���, �ְ� �޿�, ���� �޿�, �ο� �� ��ȸ 
--(��, �μ��ڵ�� �������� ��ȸ �� \999,999,999�� ��ȸ)
SELECT DEPT_CODE "�μ��ڵ�", 
TO_CHAR(ROUND(AVG(SALARY)),'999,999,999')"��ձ޿�", 
TO_CHAR(MAX(SALARY),'999,999,999')"�ְ�޿�", 
TO_CHAR(MIN(SALARY),'999,999,999')"�����޿�", 
COUNT(*)"�ο���"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(DEPT_CODE) >=3
ORDER BY DEPT_CODE ASC;

--9. EMPLOYEE ���̺��� 
--���� �� '��'�� ���� �����鼭, 
--�޿��� 200���� �̻� 250���� ������ 
--������ �̸��� �޿��� ��ȸ�Ͻÿ�
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
WHERE EMP_NAME LIKE '��%' AND SALARY BETWEEN 2000000 AND 2500000;

--*10. �ڽ��� �Ŵ������� �޿�(SALARY)�� ���� �޴� ��������
--�̸�(EMP_NAME),�޿�(SALARY),MANAGER_ID,�Ŵ��� �̸�(EMP_NAME)��
--�޿��� ������������ ��ȸ�Ͻÿ�.
SELECT EMP_NAME, EMP_ID, MANAGER_ID
FROM EMPLOYEE;

SELECT E.EMP_NAME, E.SALARY, M.MANAGER_ID, M.EMP_NAME
FROM EMPLOYEE E, EMPLOYEE M

;

--11. EMPLOYEE ���̺��� �μ��� �׷��� ���Ͽ�
--�μ��� �޿� �հ�, ���� ���� �޴� �μ���, ���� ���� �޴ºμ�, �ο����� ��ȸ
--��, ��ȸ����� �ο��� ���������Ͽ� ����Ͽ���.
SELECT DEPT_CODE, SUM(SALARY), MAX(SALARY), MIN(SALARY), COUNT(*) 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY COUNT(*) ASC;

--12. EMPLOYEE ���̺��� ���޺�
--�׷��� ���Ͽ� �����ڵ�, �޿����, �޿��հ�, �ο� ���� ��ȸ
--��, ��ȸ ����� �޿���� ���������Ͽ� ���, �ο����� 3���� �ʰ��ϴ� ���޸� ��ȸ
SELECT JOB_CODE, ROUND(AVG(SALARY)), SUM(SALARY), COUNT(*)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) > 3
ORDER BY ROUND(AVG(SALARY)) ASC;

--13. 2001�⿡ �Ի��� ���� ������ �ִ�.
--�ش� ������ ���� �μ�, ���� ���޿� �ش��ϴ� ������� ��ȸ�Ͻÿ�.
--���, �����, ����, �μ�, �Ի���
-- 1) 2001�⿡ �Ի��� ���� ������ �μ�, ����
SELECT DEPT_CODE, JOB_CODE
FROM EMPLOYEE 
WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2001
  AND SUBSTR(EMP_NO,8,1) = '2' ; -- D5, J7

-- 2) D5, J7�� �ش��ϴ� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
  AND JOB_CODE = 'J7';
 
-- 3) ��ġ��
SELECT EMP_ID, EMP_NAME, JOB_CODE, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE,JOB_CODE) IN (SELECT DEPT_CODE, JOB_CODE
                               FROM EMPLOYEE 
                               WHERE EXTRACT(YEAR FROM HIRE_DATE) = 2001
                               AND SUBSTR(EMP_NO,8,1) = '2')
AND EMP_NAME != '������';

--14. EMPLOYEE ���̺��� '������'�� ���� �μ����� ���ϴ� ������� 
--�����ȣ, �����, �μ��ڵ� �����ڵ�, �޿� ��ȸ
--�����ڵ� �������� ��ȸ
-- 1) �������� �μ�
SELECT DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������'; -- D5

-- 2) D5���� ���ϴ� ��� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';

-- 3) ��ġ��
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = (SELECT DEPT_CODE
                    FROM EMPLOYEE
                    WHERE EMP_NAME = '������')
  AND EMP_NAME != '������'  
ORDER BY JOB_CODE DESC;  

-- 15.EMPLOYEE ���̺���?�Ի�����?2000��?1��?1��?������?�����?���� 
-- �����?�̸�, ?�Ի���,? �μ��ڵ�, �޿���?�Ի��ϼ�����?��ȸ�Ͻÿ�
-- (������ �ִ� �̸���� �÷����� ���� �ٿ��ּ���)
SELECT EMP_NAME "����̸�", HIRE_DATE "�Ի���", DEPT_CODE "�μ��ڵ�", SALARY "�޿�"
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE) < 2000
  AND EXTRACT(MONTH FROM HIRE_DATE) < 1
  AND EXTRACT(DAY FROM HIRE_DATE) < 1;

--16. EMPLOYEE ���̺��� �ؿܿ��� �μ�(DEPT_TITLE) �Ҽ��� �������
--�̸�(EMP_NAME), ����(JOB_TITLE), �μ���(DEPT_TITLE), �ٹ�����(NATIONAL_CODE)�� ��ȸ�Ͻÿ�
--��, ����Ŭ ���� �������� �ۼ��ϰ� ��Ī�� �ݵ�� �Է�
SELECT *
FROM DEPARTMENT;
SELECT *
FROM location;
SELECT *
FROM NATIONAL;

SELECT EMP_NAME, JOB_NAME, DEPT_TITLE, N.NATIONAL_CODE
FROM EMPLOYEE E, JOB J, DEPARTMENT D, LOCATION L, NATIONAL N
WHERE E.DEPT_CODE = D.DEPT_ID(+)
  AND E.JOB_CODE = J.JOB_CODE
  AND D.LOCATION_ID = L.LOCAL_CODE(+)
  AND L.NATIONAL_CODE = N.NATIONAL_CODE(+);

--17. EMPLOYEE ���̺���
--'���¸�'����� �ټ� ����� ��ȸ�Ͻÿ� (����� ������)
SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)||'��' "�ټӳ��" 
FROM EMPLOYEE
WHERE EMP_NAME ='���¸�';

--18. �ڽ��� ���� ������ ��� �޿����� ���� �޴� �����
--�����ȣ,���޸�, �����,�μ���, �޿����� ��ȸ

SELECT EMP_NAME, JOB_CODE,SALARY
FROM EMPLOYEE;

-- 1) ������ ��� �޿�
SELECT FLOOR(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB_CODE;
-- (J2, 4850000),(J7, 2017500), (J3, 3600000), (J6, 2624373), (J5, 2820000),
-- (J1, 8000000),(J4, 2330000)
-- 2) ������ ��� �޿����� ���� �޴� ���
SELECT EMP_ID, JOB_CODE, EMP_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID
  AND SALARY  > ANY( (SELECT FLOOR(AVG(SALARY))
                   FROM EMPLOYEE
                   GROUP BY JOB_CODE))   
                ;          

--19. �μ����� �ٹ��ϴ� ����� ���� 3�� ������ ���, ����� ���� �μ����� �������� ���� ��ȸ
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(*)<=3
ORDER BY COUNT(*) ASC;

--20. EMPLOYEE ���̺���
--���� ���� �޿������ ��ȸ�ϰ� �޿���� ������������ �����Ͻÿ�
--(�޿������ TRUNC �Լ� ����Ͽ� �������� ���ϴ� ���� �Ͻÿ�)
SELECT JOB_CODE, TRUNC(AVG(SALARY),-5)
FROM EMPLOYEE
GROUP BY JOB_CODE
ORDER BY AVG(SALARY) DESC;

-- *21. 
-- �ؿܿ���2��(DEPT_CODE: D6)�� ��� �޿����� ���� �ް�, 
-- �ؿܿ���2�ο� ������ ������ 
-- �����ڰ� ���� ����� ���(EMP_ID), �̸�(EMP_NAME), ����(JOB_NAME), �μ��̸�(DEPT_TITLE), �޿�(SALARY)�� ��ȸ�Ͻÿ�.
-- ��,FROM ���� �������� ���, JOIN�� ����Ŭ ���� ���, ���� ���� 
-- 1) �ؿܿ���2���� ��� �޿�
SELECT DEPT_CODE, FLOOR(AVG(SALARY))
FROM EMPLOYEE
WHERE DEPT_CODE = 'D6'
GROUP BY DEPT_CODE; -- 3,366,666

-- 2) �ؿܿ���2�ο� ������ ������, �����ڰ� ���� ����� ���
SELECT EMP_ID, EMP_NAME, JOB_NAME, DEPT_TITLE, SALARY
FROM EMPLOYEE, JOB, DEPARTMENT
WHERE ;

-- 22. EMP���� �����̸����� �׷��� ����� ������ 5000�̻��� �׷� ã��
-- JOB�̸���, �޿� �հ踦 ��ȸ�Ͻÿ�
SELECT JOB_NAME, SUM(SALARY)
FROM EMPLOYEE E, JOB J
WHERE E.JOB_CODE = J.JOB_CODE
GROUP BY JOB_NAME;

-- *23. EMPLOYEE ���̺���
--�Ի��Ϸκ��� �ٹ������ ���� �� ���� ���� 6����
--RANK()�Լ��� �̿��Ͽ� ��ȸ�Ͻÿ�
--���, �����, �μ���, ���޸�, �Ի����� ��ȸ�Ͻÿ�.
SELECT EMP_ID, EMP_NAME, SALARY
RANK() OVER (ORDER BY SALARY DESC) AS RANK
FROM EMPLOYEE;

-- 24.EMPLOYEE ���̺��� 
-- �μ��� ���� �޿��� ���� ���� ��������
-- �μ���, �ִ�޿��� ��ȸ�Ͻÿ�
-- ��, �ִ�޿��� 400���� ������ �μ��鸸 ��ȸ�Ͻÿ�
-- (�μ����� JOIN Ȱ��)
SELECT DEPT_TITLE, MAX(SALARY)
FROM EMPLOYEE, DEPARTMENT
WHERE DEPT_CODE = DEPT_ID(+)
GROUP BY DEPT_TITLE
HAVING MAX(SALARY) <= 4000000;

-- 25. EMPLOYEE ���̺��� �μ��� �ְ� �޿��� Ȯ�� ��, 
-- ��� �� �ش� �μ��� �ְ� �޿��� ��ġ�ϴ� �����
--���(EMP_ID), �̸�(EMP_NAME), �μ��̸�(DEPT_TITLE), 
--����(JOB_NAME), �μ��ڵ�(DEPT_CODE), �޿�(SALARY)
--�޿� ������������ ����, JOIN(ANSI ���� ���), WHERE ������ ���������� �μ��� �ְ� �޿� Ȯ��.

-- 1) �μ��� �ְ� �޿�
SELECT DEPT_CODE, MAX(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) �ش� �μ��� �޿��� ��ġ�ϴ� ����� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE E, DEPARTMENT, JOB J
WHERE DEPT_CODE = DEPT_ID(+)
  AND E.JOB_CODE = J.JOB_CODE(+)
  AND (DEPT_CODE, SALARY) IN (SELECT DEPT_CODE, MAX(SALARY)
                              FROM EMPLOYEE
                              GROUP BY DEPT_CODE); 
-- 3660000 8000000 3760000 3900000 2490000 2550000    

-- 26. '������'�� ���� ��������, ���� ������ ������� 
--�����ȣ, �̸�, �μ��ڵ�, �����ڵ�, ��������(SAL_LEVEL) ��ȸ (���߿� ó��)
-- 1) '������'�� ��������, ����
SELECT SAL_LEVEL, JOB_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������'; -- S5, J6

-- 2) ���������� S5�̰�, ������ J6�� ���
SELECT EMP_ID, EMP_NAME, DEPT_CODE, JOB_CODE, SAL_LEVEL
FROM EMPLOYEE
WHERE (SAL_LEVEL, JOB_CODE) = (SELECT SAL_LEVEL, JOB_CODE
                                 FROM EMPLOYEE
                                WHERE EMP_NAME = '������');

-- 27. ����� �� ������ 5000000 �̻��̸� 'HIGH', 
-- 3000000 �̻��̸� 'MEDIUM', 
-- 2000000 �̻��̸� 'LOW' �� 
-- �������� 'OTL'�� ����ϰ�  
-- �����, �μ��ڵ�, ������ ��ȸ�Ͻÿ�.
-- ��, ������ ���� ������ �����Ͻÿ�.
SELECT EMP_NAME, DEPT_CODE, 
CASE WHEN SALARY >=5000000 THEN 'HIGH'
     WHEN SALARY >= 3000000 THEN 'MEDIUM'
     WHEN SALARY >= 2000000 THEN 'LOW'
     ELSE 'OTL'
 END 
FROM EMPLOYEE
ORDER BY SALARY DESC;

--28. �������� ���� ����, ���� �μ��� �ٹ��ϴ� 
--�������� ������ ��ȸ�Ͻÿ� 
-- 1) �������� ����, �μ�
SELECT JOB_CODE, DEPT_CODE
FROM EMPLOYEE
WHERE EMP_NAME = '������'; -- J6	D8
 
-- 2) ������ J6�̰� �μ��� D8�� ����
SELECT *
FROM EMPLOYEE
WHERE (JOB_CODE, DEPT_CODE) = (SELECT JOB_CODE, DEPT_CODE
                               FROM EMPLOYEE
                               WHERE EMP_NAME = '������')
  AND EMP_NAME != '������';

--29. EMPLOYEE���̺���
--�� �μ� �� �Ի����� ���� ������ ����� �� �� ������
--�����ȣ, �����, �μ���ȣ, �Ի����� ��ȸ�ϰ� 
--������ �ִ� ��Ī��� �÷����� �����Ͻÿ�
-- 1) �μ��� �Ի����� ���� ������ ���
SELECT DEPT_CODE, MIN(HIRE_DATE)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- 2) �ش� �μ��� �Ի����� ���� ����� ����
SELECT EMP_ID, EMP_NAME, DEPT_CODE, HIRE_DATE
FROM EMPLOYEE
WHERE (DEPT_CODE, HIRE_DATE) IN (SELECT DEPT_CODE, MIN(HIRE_DATE)
                                FROM EMPLOYEE
                                GROUP BY DEPT_CODE);

--30. EMPLOYEE���̺���
--�ٹ������ 20�� �̻� 30�� �̸��� �����
--�����ȣ,�����,�Ի���,������ ���Ͻÿ�
--��,������ ���ʽ��� ������ ������ ���Ѵ�.
SELECT EMP_ID, EMP_NAME, HIRE_DATE, (SALARY+(SALARY*BONUS))*12
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) >=20
  AND EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) <30;
  
--* 31. EMPLOYEE ���̺��� �ٹ�����(NATIONAL_CODE)�� 'KO'�� �������
--�̸�(EMP_NAME), ��������, �޿�(SALARY), �ٹ�����(NATIONAL_CODE)�� ��ȸ�Ͻÿ�
--��, ���������� DENSE_RANK() ���, ANSI(JOIN) ���� ���, �������� ����(��������) 


