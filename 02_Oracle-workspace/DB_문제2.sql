---------------------------------- [Basic SELECT]--------------------------------
-- 1. �� ������б��� �а��̸��� �迭�� ǥ��
-- ��, �������� "�а���", "�迭"�� ǥ��
SELECT * FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME "�а���", CATEGORY "�迭"
FROM TB_DEPARTMENT;

-- 2.  �а��� �а� ������ ������ ���� ���·� ȭ�鿡 �������.
SELECT DEPARTMENT_NAME || '�� '||'������ '|| CAPACITY||' �� �Դϴ�.' "�а��� ����"
FROM TB_DEPARTMENT;

-- 3. "������а�" �� �ٴϴ� ���л� �� ���� �������� ���л��� ã�ƴ޶�� ��û�� ���Դ�. �����ΰ�? 
-- (�����а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
SELECT * FROM TB_STUDENT;

SELECT STUDENT_NAME 
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 001
  AND SUBSTR(STUDENT_SSN, 8,1)='2'
  AND ABSENCE_YN = 'Y';
  
-- 4. ���������� ���� ���� ��� ��ü�� ���� ã�� �̸��� �Խ��ϰ��� �Ѵ�. 
-- �� ����ڵ��� �й��� ������ ���� �� ����ڵ��� ã�� ������ SQL ������ �ۼ��Ͻÿ�  
SELECT * FROM TB_STUDENT;

SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE STUDENT_NO = 'A513079'
   OR STUDENT_NO = 'A513090'
   OR STUDENT_NO = 'A513091'
   OR STUDENT_NO = 'A513110'
   OR STUDENT_NO = 'A513119'
ORDER BY STUDENT_NAME DESC;

-- 5. ���������� 20 �� �̻� 30 �� ������ �а����� �а� �̸��� �迭�� ����Ͻÿ�.
SELECT * FROM TB_DEPARTMENT;

SELECT DEPARTMENT_NAME, CATEGORY
FROM TB_DEPARTMENT
WHERE CAPACITY BETWEEN 20 AND 30;

-- 6. �� ������б��� ������ �����ϰ� ��� �������� �Ҽ� �а��� ������ �ִ�. 
-- �׷� �������б� ������ �̸��� �˾Ƴ� �� �ִ� SQL ������ �ۼ��Ͻÿ�
SELECT * FROM TB_PROFESSOR;

SELECT PROFESSOR_NAME
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO IS NULL;

-- 7. Ȥ�� ������� ������ �а��� �����Ǿ� ���� ���� �л��� �ִ��� Ȯ���ϰ��� �Ѵ�.
-- ��� SQL ������ ����ϸ� �� ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME
FROM TB_STUDENT
WHERE DEPARTMENT_NO IS NULL;

-- 8. ������û�� �Ϸ��� ����. �������� ���θ� Ȯ���ؾ� �ϴµ�, ���������� �����ϴ�
-- ������� � �������� �����ȣ�� ��ȸ�غ��ÿ�.
SELECT CLASS_NO
FROM TB_CLASS
WHERE PREATTENDING_CLASS_NO IS NOT NULL;

-- 9. �� ���п��� � �迭(CATEGORY)���� �ִ��� ��ȸ�غ��ÿ�.
SELECT DISTINCT CATEGORY
FROM TB_DEPARTMENT
ORDER BY CATEGORY ASC;

-- 10. 02�й�, ���� �����ڵ��� ������ ������� ����. ������ ������� ������ 
-- �������� �л����� �й�, �̸�, �ֹι�ȣ�� ����ϴ� ������ �ۼ��Ͻÿ�.
SELECT * FROM TB_STUDENT;
SELECT STUDENT_NO, STUDENT_NAME, STUDENT_SSN
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)=2002
  AND INSTR(STUDENT_ADDRESS,'����')>0
  AND ABSENCE_YN = 'N';
  
----------------------------------[Additional SELECT - �Լ�] --------------------------------  
-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� 
-- ���� �⵵�� ���������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ( ��, ����� "�й�", "�̸�", "���г⵵" �� ǥ�õǵ��� ����.)
SELECT * FROM TB_DEPARTMENT;
SELECT * FROM TB_STUDENT;

SELECT STUDENT_NO"�й�", STUDENT_NAME"�̸�", TO_CHAR(ENTRANCE_DATE,'YYYY-MM-DD')"���г⵵"
FROM TB_STUDENT
WHERE DEPARTMENT_NO = 002
ORDER BY ENTRANCE_DATE ASC;

-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �� �� �ִٰ� �Ѵ�. 
-- �� ������ �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. 
-- (* �̶� �ùٸ��� �ۼ��� SQL ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE PROFESSOR_NAME NOT LIKE '___';
   
-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. 
-- (��, ���� �� 2000 �� ���� ����ڴ� ������ 
-- ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ���������� ����Ѵ�.)
SELECT PROFESSOR_NAME"�����̸�"
,EXTRACT(YEAR FROM SYSDATE)-TO_NUMBER(19||SUBSTR(PROFESSOR_SSN,1,2)) "����"
FROM TB_PROFESSOR
WHERE SUBSTR(PROFESSOR_SSN,8,1)='1'
ORDER BY PROFESSOR_SSN DESC;

-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- ��� ����� '�̸�? �� �������� �Ѵ�. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT * FROM TB_PROFESSOR;

SELECT SUBSTR(PROFESSOR_NAME,2)
FROM TB_PROFESSOR;

-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? 
-- �̶�,19 �쿡 �����ϸ� ����� ���� ���� ������ ��������.
SELECT STUDENT_NO,STUDENT_NAME
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE)- TO_NUMBER('19'||SUBSTR(STUDENT_SSN,1,2))> 19;

-- 6. 2020 �� ũ���������� ���� �����ΰ�?
SELECT TO_CHAR(TO_DATE(20201224,'RRMMDD'),'DAY')
FROM DUAL;

-- 7. TO_DATE('99/10/11','YY/MM/DD'), TO_DATE('49/10/11','YY/MM/DD') �� 
-- ���� �� �� �� �� �� ���� �ǹ��ұ�? 
-- �� TO_DATE('99/10/11','RR/MM/DD'),TO_DATE('49/10/11','RR/MM/DD') �� 
-- ���� �� �� �� �� �� ���� �ǹ�����?
SELECT TO_DATE('99/10/11','YY/MM/DD')
FROM DUAL; -- 2099�� 10�� 11��
SELECT TO_DATE('49/10/11','YY/MM/DD')
FROM DUAL; -- 2049�� 10�� 11��
SELECT TO_DATE('99/10/11','RR/MM/DD')
FROM DUAL; -- 1999�� 10�� 11��
SELECT TO_DATE('49/10/11','RR/MM/DD')
FROM DUAL; -- 2049�� 10�� 11��

-- 8. �� ������б��� 2000 �⵵ ���� �����ڵ��� �й��� A �� �����ϰ� �Ǿ��ִ�. 
-- 2000 �⵵ ���� �й��� ���� �л����� �й��� �̸��� �����ִ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME 
FROM TB_STUDENT
WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) <2000;

-- 9. �й��� A517178 �� �ѾƸ� �л��� ���� �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
-- �̶� ��� ȭ���� ����� "����" �̶�� ������ �ϰ�, 
-- ������ �ݿø��Ͽ� �Ҽ��� ���� ���ڸ������� ǥ���Ѵ�

SELECT ROUND(AVG(POINT),1)"����" 
FROM TB_GRADE
WHERE STUDENT_NO = 'A517178';

-- 10. �а��� �л����� ���Ͽ� 
-- "�а���ȣ", "�л���(��)" �� ���·� ����� ����� ������� ��µǵ��� �Ͻÿ�.
SELECT DEPARTMENT_NO "�а���ȣ", COUNT(STUDENT_NAME) "�л���(��)"
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 11. ���� ������ �������� ���� �л��� ���� �� �� ���� �Ǵ� �˾Ƴ��� SQL ���� �ۼ��Ͻÿ�.
SELECT COUNT(*)
FROM TB_STUDENT
WHERE COACH_PROFESSOR_NO IS NULL;

-- 12. �й��� A112113 �� ���� �л��� �⵵ �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
-- ��, �̶� ��� ȭ���� ����� "�⵵", "�⵵ �� ����" �̶�� ������ �ϰ�, 
-- ������ �ݿø��Ͽ� �Ҽ��� ���� �� �ڸ������� ǥ������.
SELECT SUBSTR(TERM_NO,1,4) "�⵵", ROUND(AVG(POINT),1) "�⵵�� ����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4)
ORDER BY SUBSTR(TERM_NO,1,4);

-- 13. �а� �� ���л� ���� �ľ��ϰ��� �Ѵ�. 
-- �а� ��ȣ�� ���л� ���� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT DEPARTMENT_NO, SUM(DECODE(ABSENCE_YN, 'Y',1,'N',0))
FROM TB_STUDENT
GROUP BY DEPARTMENT_NO
ORDER BY DEPARTMENT_NO;

-- 14.�� ���б��� �ٴϴ� ��������(��٣���) �л����� �̸��� ã���� �Ѵ�. 
-- � SQL ������ ����ϸ� �����ϰڴ°�?
SELECT STUDENT_NAME, COUNT(*)
FROM TB_STUDENT
HAVING COUNT(*) > 1
GROUP BY STUDENT_NAME
ORDER BY STUDENT_NAME;

-- *15. �й��� A112113 �� ���� �л��� 
-- �⵵, �б� �� ������ �⵵ �� ���� ���� , �� ������ ���ϴ� SQL ���� �ۼ��Ͻÿ�. 
-- (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ������.)
SELECT * FROM TB_GRADE;
SELECT SUBSTR(TERM_NO,1,4) "�⵵",SUBSTR(TERM_NO,5,2) "�б�", AVG(POINT) "����"
FROM TB_GRADE
WHERE STUDENT_NO = 'A112113'
GROUP BY SUBSTR(TERM_NO,1,4), SUBSTR(TERM_NO,5,2)
ORDER BY SUBSTR(TERM_NO,1,4);

----------------------------------[Additional SELECT - Option]--------------------------------  
-- 1. �л��̸��� �ּ����� ǥ���Ͻÿ�. 
-- ��, ��� ����� "�л� �̸�", "�ּ���"�� �ϰ�, ������ �̸����� �������� ǥ���ϵ��� ����.
SELECT STUDENT_NAME "�л� �̸�", STUDENT_ADDRESS "�ּ���"
FROM TB_STUDENT
ORDER BY STUDENT_NAME ASC;

-- 2.  �������� �л����� �̸��� �ֹι�ȣ�� ���̰� ���� ������ ȭ�鿡 ����Ͻÿ�.
SELECT STUDENT_NAME, STUDENT_SSN
  FROM TB_STUDENT
 WHERE ABSENCE_YN = 'Y'
ORDER BY SUBSTR(STUDENT_SSN,1,6) DESC;

-- 3. �ּ����� �������� ��⵵�� �л��� �� 
-- 1900 ��� �й��� ���� �л����� �̸��� �й�, �ּҸ� �̸��� ������������ ȭ�鿡 ����Ͻÿ�. 
-- ��, ���������� "�л��̸�","�й�", "������ �ּ�" �� ��µǵ��� ����.
SELECT STUDENT_NAME, STUDENT_NO, STUDENT_ADDRESS
FROM TB_STUDENT
WHERE INSTR(STUDENT_ADDRESS, '������') > 0
  OR  INSTR(STUDENT_ADDRESS, '��⵵') > 0
  AND (SUBSTR(STUDENT_NO,1,2) >= '90' AND SUBSTR(STUDENT_NO,1,2) <= '99')
ORDER BY STUDENT_NAME ASC;  

-- 4. ���� ���а� ���� �� ���� ���̰� ���� ������� �̸��� Ȯ���� �� �ִ� SQL ������ �ۼ��Ͻÿ�. 
-- (���а��� '�а��ڵ�'�� �а� ���̺�(TB_DEPARTMENT)�� ��ȸ�ؼ� ã�� ������ ����)
SELECT PROFESSOR_NAME, PROFESSOR_SSN
FROM TB_PROFESSOR
WHERE DEPARTMENT_NO = 005
ORDER BY PROFESSOR_SSN ASC;

-- 5. 2004�� 2�б⿡ 'C3118100' ������ ������ �л����� ������ ��ȸ�Ϸ��� ����. 
-- ������ ���� �л����� ǥ���ϰ�, ������ ������ �й��� ���� �л����� ǥ���ϴ� ������
-- �ۼ��غ��ÿ�.
SELECT * FROM TB_GRADE;
SELECT STUDENT_NO, POINT
FROM TB_GRADE
WHERE SUBSTR(TERM_NO,1,4) = '2004'
  AND SUBSTR(TERM_NO,5,2) = '02'
  AND CLASS_NO = 'C3118100'
ORDER BY POINT DESC, STUDENT_NO ASC;
  
-- 6. �л� ��ȣ, �л� �̸�, �а� �̸��� 
-- �л� �̸����� �������� �����Ͽ� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT STUDENT_NO, STUDENT_NAME, DEPARTMENT_NAME
FROM TB_STUDENT TS, TB_DEPARTMENT TD
WHERE TS.DEPARTMENT_NO = TD.DEPARTMENT_NO(+);

-- 7. �� ������б��� ���� �̸��� ������ �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS
LEFT JOIN TB_DEPARTMENT USING(DEPARTMENT_NO);

-- 8. ���� ���� �̸��� ã������ ����. ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS TC, TB_CLASS_PROFESSOR TCP, TB_PROFESSOR TP
WHERE TCP.PROFESSOR_NO = TP.PROFESSOR_NO
  AND TC.CLASS_NO = TCP.CLASS_NO;

-- 9. 8 ���� ��� �� ���ι���ȸ�� �迭�� ���� ������ ���� �̸��� ã������ ����. 
-- �̿� �ش��ϴ� ���� �̸��� ���� �̸��� ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT CLASS_NAME, PROFESSOR_NAME
FROM TB_CLASS TC, TB_CLASS_PROFESSOR TCP, TB_PROFESSOR TP, TB_DEPARTMENT TD
WHERE TC.CLASS_NO = TCP.CLASS_NO
  AND TCP.PROFESSOR_NO = TP.PROFESSOR_NO
  AND TP.DEPARTMENT_NO = TD.DEPARTMENT_NO
  AND CATEGORY = '�ι���ȸ'
ORDER BY PROFESSOR_NAME;


-- 10. �������а��� �л����� ������ ���Ϸ��� ����. 
-- �����а� �л����� "�й�", "�л� �̸�", "��ü ����"�� ����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- (��, ������ �Ҽ��� 1 �ڸ������� �ݿø��Ͽ� ǥ������.)
SELECT STUDENT_NO "�й�", STUDENT_NAME "�л� �̸�", ROUND(AVG(POINT),1) "��ü ����"
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_GRADE USING(STUDENT_NO)
WHERE DEPARTMENT_NAME = '�����а�'
GROUP BY STUDENT_NO, STUDENT_NAME;

-- 11. �й��� A313047 �� �л��� �б��� ������ ���� �ʴ�. 
-- ���� �������� ������ �����ϱ� ���� �а� �̸�, �л� �̸��� ���� ���� �̸��� �ʿ��ϴ�. 
-- �̶� ����� SQL ���� �ۼ��Ͻÿ�. 
-- ��, �������� ?�а��̸�?, ?�л��̸�?, ?���������̸�?���� ��µǵ��� ����.
SELECT DEPARTMENT_NAME, STUDENT_NAME, PROFESSOR_NAME
FROM TB_STUDENT
JOIN TB_DEPARTMENT USING(DEPARTMENT_NO)
JOIN TB_PROFESSOR ON(COACH_PROFESSOR_NO = PROFESSOR_NO)
WHERE STUDENT_NO = 'A313047';

-- 12.2007 �⵵�� '�΁A�����' ������ ������ �л��� ã�� 
-- �л��̸��� �����б⸦ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT STUDENT_NAME, TERM_NO
FROM TB_STUDENT TS, TB_GRADE TG, TB_CLASS TC
WHERE TS.STUDENT_NO = TG.STUDENT_NO
  AND TG.CLASS_NO = TC.CLASS_NO
  AND TERM_NO LIKE '2007%'
  AND CLASS_NAME = '�ΰ������';
  
-- 13. ��ü�� �迭 ���� �� ���� ��米���� �� �� �������� ���� ������ ã�� 
-- �� ���� �̸��� �а� �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT CLASS_NAME, DEPARTMENT_NAME
FROM TB_CLASS TC, TB_DEPARTMENT TD
WHERE TC.DEPARTMENT_NO = TD.DEPARTMENT_NO
  AND PROFESSOR_NO IS NULL
  AND CATEGORY = '��ü��';