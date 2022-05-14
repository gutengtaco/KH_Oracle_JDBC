/*
 �Լ�(FUNCTION)
 �ڹ��� �޼ҵ�� ���� ����
 ���޵� ������ �о ����� ����� ��ȯ
 - ������ : N���� ���� �о N���� ����� ����(�� �ึ�� �ݺ������� �Լ��� ���� �� ����� ��ȯ��.)
 - �׷��Լ� : N���� ���� �о 1���� ����� ����(�ϳ��� �׷캰�� �Լ��� ���� �� ����� ��ȯ��.) => ����, ��迡 ���� ��.
 
 ���ǻ���
 �������Լ��� �������Լ�����, �׷��Լ��� �׷��Լ����� �����.(������� ������ �ٸ��� ����)
*/

-- <������ �Լ�> --
/*
 ���ڿ��� ���õ� �Լ�
 LENGTH / LENGTHB
  - LENGTH(STR) : �ش� ���޵� ���ڿ��� ���� ���� ��ȯ
  - LENGTHB(STR): �ش� ���޵ǳ� ���ڿ��� ����Ʈ �� ��ȯ
  ������� NUMBERŸ������ ��ȯ
  STR : '���ڿ� ���ͷ�' / ���ڿ��� �ش��ϴ� �÷�
  �ѱ� : '��', '��', '��', '��', ... => �ѱ��ڴ� 3BYTE
  ����, ����, Ư������ : '!', '~', 'a', 'A', '1' => �ѱ��ڴ� 1BYTE
*/

SELECT LENGTH('����Ŭ!'), LENGTHB('����Ŭ !')
FROM DUAL; 
--�������̺�(DUMMY TABLE) : ��� �����̳� ���� �÷� ���� ���� �ѹ��� ����ϰ� ������ ����ϴ� ���̺�

SELECT EMAIL, LENGTH(EMAIL), LENGTHB(EMAIL),
       EMP_NAME, LENGTH(EMP_NAME), LENGTHB(EMP_NAME)
       --EMAIL�� LENGTH�� LENGTHB�� ��ġ��.
       --NAME�� �ѱ��̱⶧���� LENGTH�� LENGTHB�� ���̳�(3��)
FROM EMPLOYEE;

/*
    INSTR(STR,'Ư������',ã����ġ�ǽ��۰�,����) : ���ڿ��κ��� Ư�� ������ ��ġ�� ��ȯ
    ������� NUMBERŸ������ ��ȯ
    ã����ġ�ǽ��۰�, ������ ���� ����
    
    ã�� ��ġ�� ���۰� 
    1 : 'Ư������'�� �տ������� ã�ڴ�(������ �⺻��)
    -1 : 'Ư������'�� �ڿ������� ã�ڴ�.
    
    ����(������ �⺻���� 1)
*/

SELECT INSTR('AABAACAABBAA', 'B' /*, 1*/)
FROM DUAL; -- 3: �տ������� �ش� 'Ư������'�� ù��° ������ ��ġ�� ��ȯ

SELECT INSTR('AABAACAABBAA', 'B', -1)
FROM DUAL; -- 10 : �ڿ������� ù��°�� ��ġ�ϴ� 'B'�� ��ġ���� �տ������� ���� �˷���

SELECT INSTR('AABAACAABBAA', 'B', 1,2)
FROM DUAL; -- 9 : �տ������� �ι�°�� ��ġ�ϴ� 'B'�� ��ġ���� �տ������� ���� �˷���.

SELECT INSTR('AABAACAABBAA', 'B', -1, 2)
FROM DUAL; -- 9 : �ڿ������� �ι�°�� ��ġ�ϴ� 'B'�� ��ġ���� �տ������� ���� �˷���.

-- EMAIL �÷����� '@'�� ��ġ�� ã�ƺ���
SELECT EMAIL,INSTR(EMAIL, '@',1 ,2) AS "@�� ��ġ"
FROM EMPLOYEE;
-- ���� ������ �����ϸ� 0�̶�� ����� ����

------------------------------------------------------------------
/*
   SUBSTR
   SUBSTR(STR, POSITION, LENGTH) : ���ڿ��κ��� Ư�� ���ڿ��� �����Ͽ� ��ȯ
                                   �ڹٿ����� ���ڿ�.substring()�� ����
   ������� CHARACTER������ ��ȯ��.
   LENGTH�� ���� ����(������, ������ �߶�)
   
    - STR : '���ڿ�'���ͷ�' / ���ڿ� Ÿ���� �÷���
    - POSITION : ���ڿ� ������ ������ ��ġ��
    - LENGTH : ������ ���� ����
*/
SELECT SUBSTR('SHOWMETHEMONEY',7)
FROM DUAL; -- 'THEMONEY' : 7��° ���ں��� ������ ����.
SELECT SUBSTR('SHOWMETHEMONEY',5,2)
FROM DUAL; -- 'ME' : 5��° ���ں��� 2���� ���ڸ� ����
SELECT SUBSTR('SHOWMETHEMONEY',1,6)
FROM DUAL; -- 'SHOWME' : 1��° ���ں��� 6���� ���ڸ� ����(1���� ��)
SELECT SUBSTR('SHOWMETHEMONEY',-8,3)
FROM DUAL; -- 'THE' : �ڿ������� 8��° ���ں��� 3���� ���ڸ� ����

-- �ֹε�Ϲ�ȣ���� �����κ��� �����ؼ� ����, ���ڸ� üũ�ϱ�
SELECT EMP_NAME, SUBSTR(EMP_NO, 8,1)AS "����"
FROM EMPLOYEE;

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8,1)='1' OR SUBSTR(EMP_NO, 8,3)='3';
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

-- ���ڻ���鸸 ��ȸ
SELECT EMP_NAME, SALARY
FROM EMPLOYEE
-- WHERE SUBSTR(EMP_NO, 8,1)='2' OR SUBSTR(EMP_NO, 8,3)='4';
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');
-- ����Ŭ���� �ڵ�����ȯ�� �����ֱ⶧����, ����ǥ�� �Ⱥٿ��� ���� ����� ����.

-- ��ø�ؼ� �Լ��� ���
-- �̸��Ͽ��� ID�κи� �����ؼ� ��ȸ
SELECT EMP_NAME, EMAIL,SUBSTR(EMAIL,1, INSTR(EMAIL,'@')-1) AS "ID" 
FROM EMPLOYEE;
---------------------------------------------------------------------

/*
 LPAD/ RPAD()
  - LPAD/RPAD(STR, ���������� ��ȯ�� ���ڿ��� ����(����Ʈ), �����̰����ϴ� ����) 
  : ������ ���ڿ��� ������ ���ڸ� ���� �Ǵ� �����ʿ� ���ٿ��� ���� N���̸�ŭ�� ���ڿ��� ��ȯ
  : STR : '���ڿ� ���ͷ�', ���ڿ� Ÿ���� �÷���
  : ������� CHARACTERŸ������ ����.(���ڿ� ����)
  : �����̰����ϴ� ���� �κ��� ���� ������.
*/
--SELECT LPAD(EMAIL,16) -- �����̰����ϴ� ���ڸ� ������ ���, ������ �⺻������ ������.
SELECT LPAD(EMAIL,16,'#') -- ��16(BYTE)����¥�� ���ڿ��� ��ȯ��.
                      -- ��, ������ ���빰�� ���ʿ� �߰��Ͽ� ������.                    
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20, '#')
FROM EMPLOYEE;

-- 850918-2****** => ����ŷ ó���� ���·� �ֹε�Ϲ�ȣ(�� 14����) �����ֱ�
SELECT RPAD('850918-2',14,'*')
FROM DUAL;

SELECT EMP_NAME,RPAD(SUBSTR(EMP_NO,1,8),14,'*')
FROM EMPLOYEE;

-----------------------------------------------------------------

/*
 LTRIM, RTRIM
  - LTRIM/RTRIM(STR, '���Ž�Ű�����ϴ¹���')
  ������� CHARACTERŸ������ ��ȯ(���ڿ� ����)
  '���Ž�Ű�����ϴ¹���'�� ���� ����
  
  - STR : '���ڿ����ͷ�' / ���ڿ��� ��� �÷���
  
*/
SELECT LTRIM('          K        H')
FROM DUAL; -- '���Ž�Ű�����ϴ¹���'�� ���� ��, ������ ������.

SELECT RTRIM('K         H         ')
FROM DUAL;

SELECT LTRIM('000123456000','0')
FROM DUAL; -- 123456000

SELECT RTRIM('000123456000','0')
FROM DUAL; -- 000123456

SELECT LTRIM('123123KH123', '123')
FROM DUAL; -- KH123

SELECT LTRIM('ACABACCKH','ABC')
FROM DUAL; -- KH
SELECT LTRIM('ACABACCKH','D')
FROM DUAL; -- ACABACCKH
-- '���Ž�Ű�����ϴ¹��ڿ�'�� �Ѱ��� ���Ե� ���ڿ��� ������.
-- '���Ž�Ű�����ϴ¹��ڿ�'�� ���Ե��� ���� ���ڿ��� ������, ���������� ����� ��ȯ��.

------------------------------------------------------------------

/*
 TRIM
 
 -TRIM(BOTH/LEADING/TRAILING '���Ž�Ű�����ϴ¹���' FROM STR)
 : ���ڿ��� ����/ ����/ ���ʿ� �ִ� Ư�����ڸ� ������ ������ ���ڿ��� ��ȯ
 
 ������� CHARACTERŸ������ ��ȯ(���ڿ� ����)
 BOTH : ���ʿ� �ִ� �ش� ���ڸ� ������. 
 LEADING : ���ʿ� �ִ� �ش� ���ڸ� ������.(LTRIM�� ����)
 TRAILING : ���ʿ� �ִ� �ش� ���ڸ� ������.(RTRIM�� ����)
 BOTH, LEADING, TRAILING�� ���� ����(BOTH�� �⺻��)
 '���Ž�Ű�����ϴ¹���' FROM ���� ���� 
 
 - STR : '���ڿ� ���ͷ�' / ���ڿ� ������ �÷���
*/
-- �⺻������ ���ʿ� �ִ� ���� ����
SELECT TRIM('   K   H   ')
FROM DUAL; -- K    H

--BOTH, LEADING, TRAILING ������ �⺻�� BOTH
SELECT TRIM('Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- KH

SELECT TRIM(BOTH 'Z' FROM 'ZZZBOTHZZZ')
FROM DUAL; -- BOTH : ����(������ �⺻��)

SELECT TRIM(LEADING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- KHZZZ : ����(LTRIM�� ����)

SELECT TRIM(TRAILING 'Z' FROM 'ZZZKHZZZ')
FROM DUAL; -- ZZZKH : ����(RTRIM�� ����)

-- �Ű������� ������ �������� �����Ǿ ��! (~ FROM ~)

-------------------------------------------------------------------

/*
 LOWER / UPPER / INITCAP
 
  - LOWER(STR) : �� �ҹ��ڷ� ����
  - UPPER(STR) : �� �빮�ڷ� ����
  - INITCAP(STR) : �� �ܾ� �ձ��ڸ� �빮�ڷ� ����(���� ����)
  
  ������� CHARACTER Ÿ������ ��ȯ(���ڿ� ����)
  - STR : '���ڿ� ���ͷ�' / ���ڿ� Ÿ���� �÷���
*/
SELECT LOWER('WELCOME TO MY WORLD')
FROM DUAL;

SELECT UPPER('welcome to my world')
FROM DUAL;

SELECT INITCAP('welcome to my world')
FROM DUAL;

SELECT INITCAP('welcome to myworld')
FROM DUAL;

------------------------------------------------------
/*
 CONCAT
  - CONCAT(STR1, STR2) : ���޵� �ΰ��� ���ڿ��� �ϳ��� ��ģ ����� ��ȯ
  ������� CHARACTERŸ������ ��ȯ(���ڿ�����)
  - STR1, STR2 : '���ڿ� ���ͷ�' / ���ڿ� Ÿ���� �÷��� 
*/
SELECT CONCAT('������','ABC')
FROM DUAL;

SELECT '������' || 'ABC'
FROM DUAL;

SELECT '������'||'ABC'||'DEF'
FROM DUAL;

SELECT CONCAT('������','ABC','DEF')
FROM DUAL;
--[�����޼���]
--"invalid number of arguments"
--CONCAT�� 2���� �Ű������θ� ���ڸ� ��ĥ �� ����.

SELECT CONCAT('������',CONCAT('ABC','DEF'))
FROM DUAL;
-- ��ø�Ͽ� ����� �� ����.
-----------------------------------------------------
/*
 REPLACE
 - REPLACE(STR,'ã������','�ٲܹ���')
 :STR�� ���� 'ã������'�� ã�Ƽ� '�ٲܹ���'�� �ٲ� ���ڿ��� ��ȯ
 
 ������� CHARACTERŸ������ ��ȯ
 
 -STR : '���ڿ� ���ͷ�' / ���ڿ� Ÿ���� �÷���
*/

SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ', '������')
FROM DUAL;

-- �̸����� �������� KH.OR.KR���� IEI.COM���� ����
SELECT EMP_NAME, EMAIL, REPLACE(EMAIL,'kh.or.kr','iei.com')
FROM EMPLOYEE;

--------------------------------------------------------------------

/*
 ���ڿ� ���õ� �Լ�
 ABS
 - ABS(NUMBER) : ���밪�� �����ִ� �Լ�
*/
SELECT ABS(-10)
FROM DUAL; -- 10

SELECT ABS(-10.9)
FROM DUAL; -- 10.9

--------------------------------------------------------------------
/*
 MOD
 - MOD(NUMBER1, NUMBER2) : �� ���� ���� ���������� ��ȯ���ִ� �Լ�
 
*/
SELECT MOD(10,3)
FROM DUAL; -- 1

SELECT MOD(-10,3)
FROM DUAL; -- -1

SELECT MOD(10.9, 3)
FROM DUAL; -- 1.9

---------------------------------------------------------------
/*
 ROUND
  - ROUND(NUMBER, ��ġ) : �ݿø�ó��(5�̻�)�� ���ִ� �Լ�
  ��ġ : �Ҽ��� �Ʒ� N��° ������ �ݿø���.
  ��ġ�� ���� ����, ������ �⺻���� 0
*/
SELECT ROUND(123.456)
FROM DUAL; -- 123 : ��ġ������, �⺻���� 0

SELECT ROUND(123.456, 1)
FROM DUAL; -- 123.5

SELECT ROUND(123.456, 2)
FROM DUAL; -- 123.46

SELECT ROUND(123.456, 3)
FROM DUAL; -- 123.456

SELECT ROUND(123.456, -1)
FROM DUAL; -- 120

SELECT ROUND(123.456, -2)
FROM DUAL; -- 100

SELECT ROUND(123.456, -3)
FROM DUAL; -- 0

SELECT ROUND(123.456, -4)
FROM DUAL; -- 0

----------------------------------------------------------------------

/*
 CEIL 
  - CEIL(NUMBER) : �Ҽ��� �Ʒ��� ���� ������ �ø�ó������.
 */
 
 SELECT CEIL(123.156)
 FROM DUAL; -- 124
 
 ---------------------------------------------------------------------
 
 /*
 FLOOR
  - FLOOR(NUMBER) : �Ҽ��� �Ʒ��� ���� ������ ����ó������.
 */
 
 SELECT FLOOR(123.956)
 FROM DUAL; -- 123
 
SELECT FLOOR(207.68)
FROM DUAL; -- 207
 
 -- �� �������� ����Ϸκ��� ���ñ��� �ٹ��ϼ�(���ó�¥ - �Ի���)�� ��ȸ
 -- �ٹ��ϼ� �ڿ� '��'�̶�� ��¥�� ������ �ٿ���
 SELECT EMP_NAME AS "�̸�", LPAD(CONCAT(FLOOR(SYSDATE - HIRE_DATE),'��'),6) AS "�ٹ��ϼ�"
 FROM EMPLOYEE;
 
 -----------------------------------------------------------------------------
 /*
 TRUNC(NUMBER, ��ġ) : ��ġ ���������� ����ó���� ���ִ� �Լ�
 ��ġ�� ���� ����, ������ �⺻���� 0(FLOOR�� ����)
 �Ҽ��� �Ʒ��� ��ġ������ ���ܳ��� ����ó����.
 */
 SELECT TRUNC(123.756)
 FROM DUAL; -- 123
 
 SELECT TRUNC(123.756, 1)
 FROM DUAL; -- 123.7
 
 SELECT TRUNC(123.756, -1)
 FROM DUAL; -- 120
 
 -----------------------------------------------------------------------------
 /*
  ��¥ ���� �Լ�
  DATE Ÿ�� : ��, ��, ��, ��, ��, ��
 */
 
 --SYSDATE : ���ó�¥, ���� �� ��ǻ���� �ý��۳�¥
 SELECT SYSDATE
 FROM DUAL; -- 22/03/14
 -- ����� ����Ŭ���ϸ� '������'�� ����.
 
 -- MONTHS_BETWEEN(DATE1, DATE2) : �� ��¥ ������ ������ ��ȯ
 -- ������� NUMBERŸ������ ��ȯ(��,��,��,�ʰ� �Ҽ������� ����!)
 -- ��¥�� �̷�, ���� ������ ����(�ݴ�� �ϸ� ������ ����)
 -- �� �������� ����Ϸκ��� ���ñ����� �ٹ��ϼ�, �ٹ��������� ��ȸ
 SELECT EMP_NAME,
 FLOOR(SYSDATE - HIRE_DATE)||'��' AS "�ٹ��ϼ�",
 FLOOR(MONTHS_BETWEEN(SYSDATE, HIRE_DATE))||'����' AS "�ٹ�������"
 FROM EMPLOYEE;
 
 -- ADD_MONTHS(DATE, NUMBER) : Ư�� ��¥�� �ش� ���ڸ�ŭ�� �������� ���� ��¥�� ��ȯ��.
 -- ������� DATEŸ������ ��ȯ
 SELECT ADD_MONTHS(SYSDATE,5)
 FROM DUAL; -- 22/08/14
 
 -- ��ü ������� ������, �Ի���, �Ի��� 6������ �귶�� ���� ��¥ ��ȸ
 SELECT EMP_NAME, HIRE_DATE, ADD_MONTHS(HIRE_DATE,6)
 FROM EMPLOYEE;
 
 
-- ������ �����ϸ�?(�ð� ������)
SELECT ADD_MONTHS(SYSDATE,-5)
FROM DUAL; -- 21/10/14

-- NEXT_DAY(DATE,����) : Ư�� ��¥���� ���� ����� �ش� ������ ã�Ƽ� �� ��¥�� ��ȯ
SELECT NEXT_DAY(SYSDATE, '�Ͽ���')
FROM DUAL;
-- 2022/03/14���� 2022/03/20
 
 SELECT NEXT_DAY(SYSDATE,'��')
 FROM DUAL; 
 
 
 -- 1: �Ͽ���, 2:������, 3: ȭ����, ... , 6:�ݿ���, 7:�����
 SELECT NEXT_DAY(SYSDATE,1)
 FROM DUAL;
 -- ���� �� KOREAN�̱� ������ ������ ��
 SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
 FROM DUAL;
 
 -- ��� ����
 ALTER SESSION SET NLS_LANGUAGE = AMERICAN;
 
 SELECT NEXT_DAY(SYSDATE, 'SUNDAY')
 FROM DUAL;
 
 ALTER SESSION SET NLS_LANGUAGE = KOREAN;
 -- �׻� ������ ���� �������� ��Ÿ������ �� ����, ���� ��� ���Ŀ� �°� ���ø� �ؾ� ��.
 
-- LAST_DAY(DATE) : Ư�� ��¥�� ���� ���� ������ ��¥�� ���ؼ� ��ȯ
SELECT LAST_DAY(SYSDATE)
FROM DUAL; -- 22/03/31

-- �̸�, �Ի���, �Ի��� ���� ������ ��¥ ��ȸ
SELECT EMP_NAME, HIRE_DATE, LAST_DAY(HIRE_DATE)
FROM EMPLOYEE;

/*
 EXTRACT : �⵵ �Ǵ� �� �Ǵ� �� ������ �����ؼ� ��ȯ 
 ��������� NUMBERŸ���� ��ȯ��
  - EXTRACT(YEAR FROM DATE) : Ư�� ��¥�κ��� �⵵�� ����
  - EXTRACT(MONTH FROM DATE) : Ư�� ��¥�κ��� ���� ����
  - EXTRACT(DAY FROM DATE) : Ư�� ��¥�κ��� �ϸ� ����
  
*/

-- ���� ��¥ �������� EXTRACT�Լ� ����
SELECT EXTRACT(YEAR FROM SYSDATE), -- 2022
       EXTRACT(MONTH FROM SYSDATE), -- 3
       EXTRACT(DAY FROM SYSDATE) -- 21
FROM DUAL;

-- �����, �Ի�⵵, �Ի��, �Ի��� ��ȸ
SELECT EMP_NAME,
       EXTRACT(YEAR FROM HIRE_DATE)"�Ի�⵵",
       EXTRACT(MONTH FROM HIRE_DATE)"�Ի��",
       EXTRACT(DAY FROM HIRE_DATE)"�Ի���"
FROM EMPLOYEE
ORDER BY "�Ի�⵵", "�Ի��", "�Ի���";

---------------------------------------------------------------------------
/*
 ����ȯ �Լ�
 NUMBER / DATE => CHARACTER
 - TO_CHAR(NUMBER/ DATE, '����')
 : ������ �Ǵ� ��¥�� �����͸� ������ Ÿ������ ��ȯ����.
 : ��ȯ���� CHARACTERŸ����.
*/

SELECT 1234, TO_CHAR(1234)
FROM DUAL; -- '1234'
-- ���ڿ��� ��������, ���ڴ� ���������ĵ�.

-- ���������� ����ߴ� ����(����)�� ���� ����� ������
SELECT TO_CHAR(1234,'00000')
FROM DUAL; -- '01234' : ��ĭ�� 0���� ä����

SELECT TO_CHAR(1234,'99999')
FROM DUAL; -- ' 1234' : ��ĭ�� �������� ä��

SELECT TO_CHAR(1234,'L00000')
FROM DUAL; --'��01234' : L�� ���� ������ ������ ȭ�� ������ ����

SELECT TO_CHAR(1234,'L99999')
FROM DUAL; -- '��1234' : ��ȣ�� 9�� ����ϸ� �پ ����� ��ȯ��.

SELECT TO_CHAR(1234,'$99999')
FROM DUAL; -- '$1234'

SELECT TO_CHAR(1234, 'L99,999')
FROM DUAL; -- '��1,234'  : 3�ڸ����� �޸�(,)�� ����

-- �޿������� 3�ڸ����� �޸�(,)�� �����Ͽ� ��� + ȭ�����
SELECT EMP_NAME, TO_CHAR(SALARY,'L999,999,999') AS "�޿�����"
FROM EMPLOYEE;

-- DATE(����Ͻú���) => CHARACTER
SELECT SYSDATE
FROM DUAL; -- �޷��������� ����

SELECT TO_CHAR(SYSDATE)
FROM DUAL; -- '22/03/14'
-- ������ �������� ������ 'YY/MM/DD'�������� ����

-- 'YYYY-MM-DD'�������� ����
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD')
FROM DUAL; -- '22-03-14'

-- ��, ��, �ʸ� ǥ���غ���
-- 12�ð� => ����/ ����
SELECT TO_CHAR(SYSDATE, 'PM HH:MI:SS')
FROM DUAL; -- PM�� ����/���ĸ� �������

-- 24�ð� => ����/����
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS')
FROM DUAL; -- HH24�� �ð��� 24�ð� �������� �������.

SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY')
FROM DUAL; -- 3�� ��, 2022  
-- MON=>'x��' ���� / DY =>'����' Ű���带 �� ���� ���� / YYYY => 4�ڸ� �⵵

-- ����� �� �ִ� ���˵� --
-- �⵵�ν� �� �� �ִ� ���� 
SELECT 
TO_CHAR(SYSDATE, 'YYYY'), -- 2022
TO_CHAR(SYSDATE, 'RRRR'), -- 2022(�ݿø�)
TO_CHAR(SYSDATE, 'YY'), -- 22
TO_CHAR(SYSDATE, 'RR'), -- 22(�ݿø�)
TO_CHAR(SYSDATE, 'YEAR') -- 'TWENTY TWENTY-TWO'
FROM DUAL;
-- YEAR�� ����� �⵵���� ������ִ� ������.

-- ���μ� �� �� �ִ� ����
SELECT
TO_CHAR(SYSDATE, 'MM'), -- 03
TO_CHAR(SYSDATE, 'MON'), -- 3��
TO_CHAR(SYSDATE, 'MONTH'), -- 3��
TO_CHAR(SYSDATE, 'RM') -- III
FROM DUAL;
-- RM�� �θ����ڸ� �ǹ���.

-- �Ϸν� �� �� �ִ� ����
SELECT
TO_CHAR(SYSDATE,'D'), -- 2 : ������ �������� ��ĥ°���� �˷���(��~��)
TO_CHAR(SYSDATE,'DD'), -- 21 : �� �������� ��ĥ°���� �˷���(���ó�¥)
TO_CHAR(SYSDATE,'DDD') -- 080 : �⵵ �������� ��ĥ°���� �˷���(80���� ����)
FROM DUAL;

-- ���Ϸν� �� �� �ִ� ����
SELECT
TO_CHAR(SYSDATE, 'DY'), -- �� : '����'�� �� ������ �����.
TO_CHAR(SYSDATE, 'DAY') -- ������ : '����'�� ���ļ� �����.
FROM DUAL;

-- 2022�� 03�� 21�� (��)
SELECT
TO_CHAR(SYSDATE,'YYYY"��" MM"��" DD"��" (DY)')
FROM DUAL;
-- �ѱ��� ���� ���� ������, �ֵ���ǥ�� ������.

-- �����, �Ի���(���� ���� ����)
SELECT EMP_NAME "�����", TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)')AS "�Ի���"
FROM EMPLOYEE;

-- "2010�� ���Ŀ� �Ի���" �����, �Ի���(���� ���� ����)
SELECT EMP_NAME "�����", TO_CHAR(HIRE_DATE, 'YYYY"��" MM"��" DD"��" (DY)')  "�Ի���"
FROM EMPLOYEE
WHERE EXTRACT(YEAR FROM HIRE_DATE)>=2010
-- WHERE SUBSTR(HIRE_DATE, 1,2) > 10
ORDER BY "�Ի���" ASC;

/*
 NUMBER/CHARACTER => DATE
 - TO_DATE(NUMBER �Ǵ� CHARACTER, '����'): ������ �Ǵ� ������ �����͸� ��¥������ ��ȯ
*/
SELECT TO_DATE(20220321) -- ����, 22/03/21(�޷�����)
FROM DUAL;
-- �⺻ ������ YY/MM/DD�� ������

SELECT TO_DATE('20220321')-- ����, 22/03/21(�޷�����)
FROM DUAL;

SELECT TO_DATE('000101')
FROM DUAL;
-- [����] Literals in the input must be the same length
-- 000101�� 0���� �����ϴ� ���ڷ� �ν��Ͽ� ������ �߻���.
-- ����������, DATE�� ���˿� �˸°� ���ڸ� �ۼ��ؾ� ��.(YYYY MM DD)
-- ���� 00/01/01���� �ۼ��ϰ� ������, 000101�� ���ڿ��� �ۼ�����

SELECT TO_DATE('20100101','YYYYMMDD')
FROM DUAL;
-- YY/MM/DD �������� ��������, �� ���� â�� ���� �޷����·� �� ������!

SELECT TO_DATE('041030 143021', 'YYMMDD HH24MISS')
FROM DUAL;
-- ������ â�� ��¥�� �ð��� ���� ���ִ� ���� �� �� ����.

SELECT TO_DATE('140630', 'YYMMDD')
FROM DUAL;
-- 2014�� 06�� 30��

SELECT TO_DATE('980630', 'YYMMDD')
FROM DUAL;
-- 2098�� 06�� 30������ ������.
-- ���ڸ��⵵�� ���ؼ� YY������ ��������� ���,
-- ���� ����� ��Ÿ��(98�� �������� ��, ���� ������ 2098������ ����)

SELECT TO_DATE('140630', 'RRMMDD')
FROM DUAL;
-- 2014�� 06�� 30��(��ȭ����)

SELECT TO_DATE('980630', 'RRMMDD')
FROM DUAL;
-- 1998�� 06�� 30��
-- ���ڸ� �⵵�� ���ؼ� RR(ROUND)������ ��������� ���,
-- 50�̻��̸� ���� ����, 50�̸��̸� ���� ����� ��Ÿ��.

/*
 CHARACTER => NUMBER
 �ڹ��� parseXXX(�Ľ�)�� ����
 TO_NUMBER(CHARACTER, '����') : ������ �����͸� ���������� ��ȯ, ��ȯ���� NUMBERŸ��
*/

SELECT '123' + '123' 
FROM DUAL; -- 246 : ����Ŭ������ �ڵ�����ȯ�� �ѹ� �Ͼ�� ��������� ��.

SELECT '10,000,000' + '550,000'
FROM DUAL;
-- [����] "invalid number"
-- ���� �߰����� ��ǥ��� ���ڰ� ���ԵǾ� �־�, �ڵ�����ȯ�� ������ ���� ����.

SELECT TO_NUMBER('10,000,000', '999,999,999') + TO_NUMBER('550,000','999,999,999')
FROM DUAL; -- 10550000

SELECT TO_NUMBER('0123')
FROM DUAL; -- 123 : ���� 0�� �����ϰ� ���ڷ� ��µ�

----------------------------------------------------------------------------------------

/*
 <NULL ó�� �Լ�>
*/

-- NVL(�÷���, �ش��÷����� NULL�ΰ�� ��ȯ�� ��ȯ��)
-- �ش� �÷����� ������ ���(NULL�� �ƴѰ��), ������ �÷����� ��ȯ����
-- �ش� �÷����� �������� ���� ���(NULL�� ���), ��ȯ�� ���� �������־� ��ȯ����.

-- �����, ���ʽ�(���ʽ��� ���� ���� 0���� ���)
SELECT EMP_NAME, BONUS, NVL(BONUS,0)
FROM EMPLOYEE;

-- �����, ���ʽ��� ������ ���� ��ȸ
SELECT EMP_NAME, (SALARY+(SALARY*NVL(BONUS,0)))*12
FROM EMPLOYEE;

-- �����, �μ��ڵ�(�μ��ڵ尡 ���� ���, '����') ��ȸ
SELECT EMP_NAME, NVL(DEPT_CODE,'����')
FROM EMPLOYEE;

-- NVL2(�÷���, �����1, �����2)
-- �ش� �÷����� ������ ���(NULL�� �ƴ� ���), ����� 1�� ��ȯ
-- �ش� �÷����� �������� �ʴ� ���(NULL�� ���), ����� 2�� ��ȯ

-- ���ʽ��� �ִ� ��쿡�� '����' ���� ��쿡�� '����' ���
SELECT EMP_NAME, BONUS, NVL2(BONUS, '����', '����')
FROM EMPLOYEE;

-- �����, �μ��ڵ� (�μ��ڵ尡 �ִ� ��쿡�� '��ġ�Ϸ�', ���� ��쿡�� '��ġ����')
SELECT EMP_NAME, DEPT_CODE, NVL2(DEPT_CODE, '��ġ�Ϸ�', '��ġ����')
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2)
-- �񱳴��1�̶� �񱳴��2�� ������ ���, NULL�� ��ȯ��.
-- ���� �������� ���� ���, �񱳴��1�� ��ȯ
SELECT NULLIF('123','123')
FROM DUAL; -- NULL

SELECT NULLIF('123','456')
FROM DUAL; -- 123(����)

SELECT NULLIF(123,456)
FROM DUAL; -- 123(����)

---------------------------------------------------------------------------------
/*
 <���� �Լ�>
 DECODE(�񱳴��, ���ǰ�1, �����1, ���ǰ�2, �����2,...,���ǰ�N, �����N, �����)
 �񱳴��� ���ǰ��� ���Ͽ�, ���ǿ� �����ϸ� ������� ��ȯ��.
 �ڹٿ��� ����񱳸� �����ϴ� SWITCH���� ������.
 SWITCH(�񱳴��){
 CASE ���ǰ�1 : �����1;
 CASE ���ǰ�2 : �����2;
 ...
 CASE ���ǰ�N : �����N;
 (DEFAULT : �����;) => ���� ����
 }
*/

-- ���, �����, �ֹε�Ϲ�ȣ�κ��� ���� �ڸ��� ����
-- ��, �ֹε�Ϲ�ȣ�� �����ڸ��� �����Ͽ� '1','3'�� ���� / '2','4'�� ���ڷ� ���
SELECT EMP_ID, EMP_NAME, EMP_NO,
DECODE(SUBSTR(EMP_NO,8,1),'1','����','2','����','3','����','4','����') "����"
FROM EMPLOYEE;

-- �������� �޿��� �λ���Ѽ� ��ȸ
-- �����ڵ尡 'J7'�� ����� �޿��� 10���� �λ�
-- �����ڵ尡 'J6'�� ����� �޿��� 15���� �λ�
-- �����ڵ尡 'J5'�� ����� �޿��� 20���� �λ�
-- �׿��� �����ڵ��� ����� �޿��� 5���� �λ�
SELECT EMP_NAME,
JOB_CODE,
SALARY "�λ� ��",
DECODE(JOB_CODE, 'J7', SALARY+(SALARY*0.1),
                 'J6', SALARY+(SALARY*0.15),
                 'J5', SALARY+(SALARY*0.2),
                       SALARY+(SALARY*0.05)) "�λ� ��"
FROM EMPLOYEE;
-- ���޿ø��� ����(N���� �λ�) : SALARY+(SALARY*0.N) == SALARY*1.N
-- �������� �ٲ��� ����.

----------------------------------------------------------------------------------

/*
 CASE WHEN THEN ����
 DECODE�����Լ��� ���ϸ� 
 DECODE�� �ش����� �˻�� ����񱳸��� �����Ѵٸ�(���ǰ�)
 CASE WHEN THEN������ Ư������ ���ý� ������� ���ǽ��� ��� ������.
 �ڹٿ����� IF-ELSE IF���� ���� ����
 
 [ǥ����]
 CASE WHEN ���ǽ�1 THEN �����1
      WHEN ���ǽ�2 THEN �����2
      ...
      WHEN ���ǽ�N THEN �����N
      ELSE �����
 END
*/

-- ���, �����, �ֹε�Ϲ�ȣ�κ��� �����ڸ��� �����Ͽ� �������Բ�
-- DECODE �Լ� ����
SELECT EMP_ID, EMP_NAME,EMP_NO, DECODE(SUBSTR(EMP_NO,8,1),'1','����',
                                                   '2','����',
                                                   '3','����',
                                                   '4','����') "����"
FROM EMPLOYEE;    

-- CASE WHEN THEN���� ����
SELECT EMP_ID, EMP_NAME, EMP_NO,
CASE WHEN SUBSTR(EMP_NO,8,1)='1' OR SUBSTR(EMP_NO,8,1)='3' THEN '����'
     -- WHEN SUBSTR(EMP_NO,8,1)='2' OR SUBSTR(EMP_NO,8,1)='4' THEN '����'
     ELSE '����'
     END "����"
FROM EMPLOYEE;

-- �����, �޿�, �޿����(���, �߱�, �ʱ�)
-- SALARY �÷��� �������� ������ 500���� �ʹ��� ��쿡�� '���'
-- ������ 500�������� ~ 350���� �ʰ��� ��쿡�� '�߱�'
-- ������ 350���� ������ ��쿡�� '�ʱ�'
SELECT EMP_NAME, SALARY, 
CASE WHEN SALARY > 5000000 THEN '���'
     WHEN SALARY > 3500000 AND SALARY <= 5000000 THEN '�߱�'
     WHEN SALARY <= 3500000 THEN '�ʱ�'
  -- ELSE '�ʱ�'
     END  "�޿� ���"
FROM EMPLOYEE;   

------------------------------------------------------------------------------------

----------<�׷��Լ�>-----------

/*
 N���� ���� �о 1���� ����� ��ȯ(�ϳ��� �׷캰�� �Լ� ���� ����� ��ȯ��)
*/

-- 1. SUM(����Ÿ�����÷���) : �ش� �÷������� �հ踦 ���ؼ� ��ȯ
-- ��ü ������� �� �޿� �հ�
SELECT SALARY
FROM EMPLOYEE;
-- �������Լ��� �������Լ�����
SELECT SUM(SALARY)
FROM EMPLOYEE;
-- �׷��Լ��� �׷��Լ�����

-- �μ��ڵ尡 'D5'�� ������� �� �޿� ��
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE DEPT_CODE = 'D5';
    
-- ���ڻ������ �� �޿� ��
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('1','3');

-- 2. AVG(����Ÿ�����÷���) : �ش� �÷������� ��հ��� ���ؼ� ��ȯ
-- ��ü������� ��� �޿�
SELECT AVG(SALARY)
FROM EMPLOYEE;

-- ��ü������� ��� �޿�
SELECT '�뷫 ' || ROUND(AVG(SALARY),-4) || '��' "��� �޿�"
FROM EMPLOYEE;

-- 3. MIN(�ƹ�Ÿ���÷���) : �ش� �÷��� �߿��� ���� ���� ���� ��ȯ
-- ��ü ����� �� �����޿�, �������� �̸���, �������� �̸��ϰ�, ���忹���� �Ի��� ��¥
SELECT MIN(SALARY), MIN(EMP_NAME), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

SELECT SALARY, EMP_NAME, EMAIL, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE;
-- MIN�Լ� ��ü�� ���������� ���� ��, ���� ���� ���� ������.

-- 4. MAX(�ƹ�Ÿ���÷���) : �ش� �÷��� �߿��� ���� ū ���� ��ȯ
SELECT MAX(SALARY), MAX(EMP_NAME), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

SELECT SALARY, EMP_NAME, EMAIL, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE DESC;
-- MAX�Լ� ��ü�� ���������� ���� ��, ���� ���� ���� ������.

-- 5. COUNT(*/�÷��� / DISTINCT �÷���) : ��ȸ�� ���� ������ ���� ��ȯ��.
-- COUNT(*) : ��ȸ ����� �ش��ϴ� ��� ���� ������ ���� ��ȯ
-- COUNT(�÷���) : ���� ������ �ش� �÷����� ���� ������ ���� ��ȯ(NULL ���� X)
-- COUNT(DISTINCT �÷���) : ���� ������ �÷����� �ߺ��� ���, �ϳ��θ� ���� ���� ������ ��ȯ
--                         (NULL ���� X)

-- ��ü ������� ���� ��ȸ
SELECT COUNT(*)
FROM EMPLOYEE;

SELECT COUNT(EMP_ID)
FROM EMPLOYEE;
-- NULL���� ���� �÷��� �����Ͽ�, ��ü ������� �˾Ƴ� �� ����.

-- ���� ������� ��ȸ
SELECT COUNT(*)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN('2','4');

-- �μ���ġ�� �� ������� ��ȸ
-- ���1 : WHERE���� ������ ���
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL;

-- ���2 : ���ʿ� COUNT�� �÷��m�� �����ؼ� NULL�� �ƴ� ������ ���� ���
SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE;

-- �μ���ġ�� �� ���ڻ�� ��
SELECT COUNT(*)
FROM EMPLOYEE
WHERE DEPT_CODE IS NOT NULL AND SUBSTR(EMP_NO,8,1) IN('2','4');

SELECT COUNT(DEPT_CODE)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) IN ('2','4');

-- ����� �ִ� ����� ��(MANAGER_ID �÷�)
SELECT COUNT(*)
FROM EMPLOYEE
WHERE MANAGER_ID IS NOT NULL;

SELECT COUNT(MANAGER_ID)
FROM EMPLOYEE;

-- ���� ������� �����ִ� �μ��� ����
SELECT COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;

SELECT COUNT(*)
FROM DEPARTMENT;
-- DEPARTMENT���̺� �μ����� ������ ��������.
-- �ٸ�, �Ѹ� �������� ���� �μ��� ���� �� �ֱ� ������ �� ����� ����õ
