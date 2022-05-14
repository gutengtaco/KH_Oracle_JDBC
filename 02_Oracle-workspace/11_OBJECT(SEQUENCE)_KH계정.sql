/*
 < ������ >
 �ڵ����� ��ȣ�� �߻������ִ� ������ �ϴ� ��ü
 �������� �ڵ�����, ���������� ��������.
 
 ��) ȸ����ȣ, ���, �Խñ۹�ȣ ���� ä��(��ȣ�� ���� �ο�)�� �� �ַ� ���
 
 1. ������ ��ü ���� ����
 [ǥ����]
 CREATE SEQUENCE ��������;
 START WITH ���ۼ��� : ó�� �߻���ų ���۰��� ����     
 INCREMENT BY ������ : �ѹ��� � ������ų���� ����
 MAXVALUE �ִ밪 : �ִ밪 ����
 MINVALUE �ּҰ� : �ּҰ� ����
 CYCLE / NOCYCLE : ���� ��ȯ���θ� ����
 CACHE ����Ʈ ũ�� / NOCACHE : ĳ�ø޸� ��� ���� ����
                             (CACHE ����Ʈũ��� ����Ʈũ�⸸ŭ�� ĳ�ø޸𸮸� ����ϰڴٴ� ��)

 �������� : ��� �������� ���� ����
 * ĳ�ø޸� : �̸� �߻��� ������ �����ؼ� �����صδ� �ӽø޸𸮰���
              �Ź� ȣ���Ҷ����� ������ ��ȣ�� �����ϴ� �ͺ���
              ĳ�ø޸� ������ �̸� ������ ��ȣ���� �����ص״ٰ� ���� ���� �ӵ��� �� ����.
              ��, DB������ ����� ������ ����Ǿ� �ִ� ������ ��� ����.(�ӽø޸� �����̶�)          
*/

CREATE SEQUENCE SEQ_TEST;

SELECT * FROM USER_SEQUENCES;
-- USER_SEQUENCES : ���� ������ ������ �����ϰ� �ִ� �������鿡 ���� ���� ��ȸ�� ������ ��ųʸ�
-- �⺻ ������
-- MIN VALUE : 1
-- MAX VALUE : 9999999999999999999999999999
-- INCREMENT_BY : 1
-- CYCLE_FLAG : N
-- CACHE_SIZE : 20

CREATE SEQUENCE SEQ_EMPNO
START WITH 300
INCREMENT BY 5
MAXVALUE 310
NOCYCLE
NOCACHE;

/*
 2. ������ ��� ����
 ��ȣ�� �߻���Ű�� ����
 
 ��������.CURRVAL : CURRNET VALUE. ���� �������� ���� ��Ÿ��. 
                  (���� ���������� ���������� �߻��� NEXTVAL���� �� CURRVAL�� ��)
 ��������.NEXTVAL : ������ ���� ������Ű�� �� ������ �������� ���� ��������
                  �⺻�� ������ ������ INCREMENT BY ����ŭ ������ ��
                  (��������.CURRVAL + INCREMENT BY ������ == ��������.NEXTVAL)
 ���ǻ���
 1) ������ ���� �� ù CURRVAL �Ұ���
 2) ������ ���� �� ù NEXTVAL�� START WITH�� ���۰����� ����.
 3) CURRVAL�� ���� �������� ���������� ������ NEXTVAL�� ��Ƶδ� ������ ������!
 4) MAXVALUE, MINVALUE ������ ��� ���� �߻���ų���� ����.
*/

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL;
-- [����] sequence SEQ_EMPNO.CURRVAL is not yet defined in this session
-- �ѹ��̶� NEXTVAL�� �������� �ʴ� �̻�, CURRVAL�� ������ �� ����.
-- (CURRVAL�� ���������� ���������� ����� NEXTVAL�� ��)

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 300
-- ó�� NEXTVAL�� �����ϸ�, START WITH�� ������ ���� ��µ�.

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL; -- 300
-- �� �������� CURRVAL�� 300�̶�� ������ ��µ�.

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 305

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL; -- 305

SELECT * FROM USER_SEQUENCES;
-- LAST_NUMBER : ������ȣ ��Ⱚ
-- ���� ��Ȳ���� NEXTVAR�� ������ ����� ������ �����.
-- ���� NEXTVAL�� ������ ���, 310�� �ȴٴ� ����.

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 310

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; 
-- [����] sequence SEQ_EMPNO.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- ���� ������ MAXVALUE�� �ʰ��߱� ������ �߻��ϴ� ������.

/*
 3. ������ ���� ����
 
 [ǥ����]
 ALTER SEQUENCE ��������
 INCREMENT BY ������
 MAXVALUE
 MINVALUE
 CYCLE / NOCYCLE
 CACHE ����Ʈũ�� / NOCACHE ; 
 
 * START WITH�� ���� �Ұ� => �� ���, �׳� �������� ����� �ٽ� ����.
*/

ALTER SEQUENCE SEQ_EMPNO
INCREMENT BY 10
MAXVALUE 400;

-- �� �ٲ���� Ȯ��
SELECT * FROM USER_SEQUENCES;
-- LAST NUMBER�� 320���� �ٲ�.

SELECT SEQ_EMPNO.CURRVAL
FROM DUAL; -- 310

SELECT SEQ_EMPNO.NEXTVAL
FROM DUAL; -- 320 : ���󰪴�� �� ����.

-- SEQUENCE �����ϱ�
DROP SEQUENCE SEQ_EMPNO;

SELECT * FROM USER_SEQUENCES;

--------- ������ ��� ���� ------------------

-- �Ź� ���ο� ����� �߻��Ǵ� ������ �߻�
CREATE SEQUENCE SEQ_EID
START WITH 300;
-- INCREMENT�� �⺻���� 1�̶� 1�� ������.
-- CURRVAL : ���� �ȳ���. NEXTVAL�� �����ؾ� ����.
SELECT SEQ_EID.NEXTVAL
FROM DUAL; -- 300

-- ����� �߰��� ��, EMPLOYEE���̺� INSERT
INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '1', 'J2', 'S3',SYSDATE); -- 301

SELECT * FROM EMPLOYEE;

SELECT SEQ_EID.CURRVAL
FROM DUAL; -- 301

SELECT SEQ_EID.NEXTVAL
FROM DUAL; -- 302

INSERT INTO EMPLOYEE(EMP_ID, EMP_NAME, EMP_NO, JOB_CODE, SAL_LEVEL, HIRE_DATE)
VALUES(SEQ_EID.NEXTVAL, '��浿', '1', 'J2', 'S3',SYSDATE); -- 302

SELECT * FROM EMPLOYEE; 

COMMIT;


