/*
 <GROUP BY��>
 �׷��� ������ ������ ������ �� �ִ� ����
 => �ش� ���õ� ���غ��� �׷��� ���� �� ����
 
 �������� �÷������� �ϳ��� �׷����� ��� ó���� �������� ���
*/

-- ��ü ����� �� �޿���
SELECT SUM(SALARY)
FROM EMPLOYEE;
-- ���� ��ȸ�� ��ü ������� �ϳ��� ��� �� ���� ���� ���

-- �� �μ��� �� �޿���
SELECT DEPT_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE;
-- SELECT���� ������� ���� 23��, 1���� ����� ���ͼ� ������ ��.
-- DEPT_CODE�� �������� �Ͽ� GROUP BY���� �����Ͽ�
-- ���õ� DEPT_CODE�� ���� �� �μ��� �� �޿����� ��ȯ�� �� ����.

-- ��ü�����
SELECT COUNT(*)
FROM EMPLOYEE;

-- �� �μ��� �����
SELECT DEPT_CODE, COUNT(*)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

-- �� �μ��� �� �޿����� �μ����� ���������ؼ� ������
-- ������� : FROM > GROUP BY > SELECT > ORDER BY
SELECT DEPT_CODE, SUM(SALARY) 
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE ASC NULLS FIRST;

-- �� ���޺� �����ڵ�, �� �޿��� ��, ��� ��, ���ʽ��� �޴� ����� ��, ����� �ִ� ����� �� ��ȸ
SELECT JOB_CODE, SUM(SALARY) "�޿� ��", COUNT(*)"�����", COUNT(BONUS)"���ʽ� �޴� ��� ��", COUNT(MANAGER_ID) "����� �ִ� ��� ��"
FROM EMPLOYEE
GROUP BY JOB_CODE;

-- �� �μ��� �μ��ڵ�, ��� ��,�ѱ޿���, ��ձ޿�, �ְ�޿�, �ּұ޿�
SELECT 
        DEPT_CODE"�μ��ڵ�", 
        COUNT(*)"��� ��",
        SUM(SALARY)"�ѱ޿���", 
        ROUND(AVG(SALARY))"��ձ޿�", 
        MAX(SALARY)"�ְ�޿�", 
        MIN(SALARY)"�ּұ޿�"
FROM EMPLOYEE
GROUP BY DEPT_CODE
ORDER BY DEPT_CODE;

-- ���� �� �����
SELECT SUBSTR(EMP_NO, 8, 1) "����", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);
-- GROUP BY "����";
-- ��������� GROUP BY�� SELECT������ �켱�ϱ� ������ ���Ұ�
-- �Լ����̳� ������� ��� ����
SELECT DECODE(SUBSTR(EMP_NO, 8, 1),'1','��','2','��')"����", COUNT(*)
FROM EMPLOYEE
GROUP BY SUBSTR(EMP_NO,8,1);
----------------------------------------------------------------------------------

/*
 < HAVING ��>
 "�׷��Լ�"�� ���� ������ �����ϰ��� �� �� ����ϴ� ����
 (�ַ� �׷��Լ��� ������ ������ ������)
*/
-- �� �μ��� ��� �޿��� 300���� �̻��� �μ��鸸 ��ȸ
SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
-- WHERE AVG(SALARY) >= 3000000
-- [����] �׷��Լ��� AVG()���� WHERE�� �ƴ� HAVING�� �������
GROUP BY DEPT_CODE;

SELECT DEPT_CODE, ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING ROUND(AVG(SALARY))>=3000000;
-- �׷��Լ��� AVG()�� ����߱⿡ HAVING���� �����!

-- �� ���޺� �� �޿� ���� 1000���� �̻��� �����ڵ�, �޿� ���� ��ȸ
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING SUM(SALARY) >= 10000000;

-- �� �μ��� ���ʽ��� �޴� ����� �Ѹ� ���� �μ����� ��ȸ
--(BONUS�÷��� �������� ����� ���� ��, 0�� ���;� ��.)
SELECT DEPT_CODE, COUNT(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING COUNT(BONUS) = 0;

------------------------------------------------------------------------------
/*
 <���� ����>
 �� ���� �ۼ� ������� �ʱ�
 5. SELECT * / ��ȸ�ϰ����ϴ��÷��� / ���ͷ� / �������� / �Լ��� AS "��Ī"
 1. FROM ��ȸ�ϰ����ϴ����̺�� / DUAL(�������̺�)
 2. WHERE ���ǽ�(���ǻ��� : ���ǽĿ� �׷��Լ��� �����ϸ� �ȵ�)
 3. GROUP BY �׷���ؿ��´��÷��� / �Լ���
 4. HAVING �׷��Լ��������������ǽ�
 6. ORDER BY ���ı��ؿ��´��÷��� / ��Ī / ���� [ASC/DESC] [NULLS FIRST/ NULLS LAST]
*/
------------------------------------------------------------------------------
/*
 <���� ������ SET OPERATOR>
 ���� ���� �������� ������, �ϳ��� ���������� ����� ������ 
 ���п��� ����ϴ� ������ ����� ����.
 - UNION : ������(�� �������� ������ ������� ��� ���� ��, �ߺ��� �κ��� �ѹ� �� ����) => OR
 - INTERSECT : ������(�� �������� ������ ������� �ߺ��� ����� �κ�) => AND
 - UNION ALL : ������ ����� �������� ������ ���� (�� �������� ��ġ�� �ߺ����Ÿ� ���� ����)
 - MINUS : ������(���� ������ ����� - ���� ������ ������� ���)
 Ư�̻��� : UNION���� UNION ALL�� �ӵ��� �� ����
 ���ǻ��� : �׻� SELECT���� �����ؾ� ��.
*/

-- 1. UNION(������)
-- �� �������� ������ ������� ��������, �ߺ��� ����� �ѹ��� ��ȸ

-- �μ��ڵ尡 D5�̰ų� �޿��� 300���� �ʰ��� ������� ��ȸ
-- ���, �����, �μ��ڵ�, �޿�

-- �μ��ڵ尡 D5�� ����鸸 ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'; -- 6�� ��ȸ

-- �޿��� 300���� �ʰ��� ������� ��ȸ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8�� ��ȸ

-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ���
-- �� �������� SELECT���� ���ƾ� ��.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION 
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 12�� ��ȸ(�� �������� ���ϰ�, �ߺ��� �ѹ���)
                        -- 12 : 6+8-2(�ߺ�)

-- �μ��ڵ尡 D5�� ��� �Ǵ� �޿��� 300���� �ʰ��� ������� ��ȸ
-- ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' OR SALARY >3000000;
-- OR�����ڷ� �ΰ��� ������ ��� ��ȸ�ϸ� ����� ����.

-- 2. UNION ALL 
-- �� �������� ������ ������� ��������, �ߺ��� ����� �ι� ��ȸ��.
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5'
UNION ALL
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 14�� ��ȸ(�� �������� ���ϰ�, �ߺ��� �ι�)
-- �ߺ��Ǵ� �ɺ����� ���ȥ�� 2���� ���� 14���� �� ���� �� �� ����.

-- 3. INTERSECT(������)
-- ���� ���� ����� �ߺ��� ������� ��ȸ

-- �μ��ڵ尡 D5�̸鼭 �޿��� 300���� �ʰ��� ������� ��ȸ
-- ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'
INTERSECT
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 2��(�� ���������� �ߺ��� ���� ���)

-- �Ʒ��� ����� ������
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE ='D5' AND SALARY > 3000000;

-- 4. MINUS(������)
-- ������������ ��������� ������������ ������� �ĳ�
-- �μ��ڵ尡 D5�� ��� �߿��� �޿��� 300���� �ʰ��� ������� �����ϰ� ��ȸ
-- ���, �����, �μ��ڵ�, �޿�

-- �μ��ڵ尡 D5�� �����(��������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'  -- 6��
MINUS
-- �޿��� 300���� �ʰ��� �����(��������)
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000; -- 8��
-- ��� : 4�� (�ɺ���, ���ȥ�� ����)
-- (�������� 6�� �߿��� ���������� �����ϰ� �����ϴ� 2���� �����ϰ� �����)

-- ����, ������ �ٲ㼭 �׽�Ʈ
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE SALARY > 3000000 -- 8��
MINUS
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5'; -- 6��
-- ��� : 6��(�ɺ���, ���ȥ�� ����)
-- �������� 8�� �߿��� ���������� �����ϰ� �����ϴ� 2���� �����ϰ� �����.

-- �Ʒ�ó���� ����
-- �μ��ڵ尡 D5�� ����� �߿��� �޿��� 300���� �ʰ��� ������� �����ؼ� ��ȸ
-- =>                             300���� ������
-- ���, �����, �μ��ڵ�, �޿�
SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5' AND SALARY <=3000000;

