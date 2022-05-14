/*
 DDL(DATA DEFINITION LANGUAGE)
 ������ ���� ���
 
 ����Ŭ���� �����ϴ� ��ü(OBJECT)�� 
 ������ �����(CREATE), ������ �����ϰ�(ALTER) ���� ��ü�� �����ϴ�(DROP) ��ɹ�
 ��, ����(���̺�)��ü�� �����ϴ� ����, �ַ� DB�����ڳ� �����ڰ� �����.
 
 ����Ŭ������ ��ü : ���̺�, ��(��ȸ�� ���̺�), ������(�ڵ����� ��ȣ �ο�, SELECT���� ROWNUM�� ���)
                  �����(USER), ��Ű��(�ڹٿ����� ��Ű���� ������), 
                  Ʈ����(���� �߻����� ��, �ڵ����� ������ ���� ����)
                  ���ν���, �Լ�(�ڹٿ����� �޼ҵ�� ����)
                  ���Ǿ�(SELECT������ ��Ī�� �����)                  
*/

/*
 < CREATE TABLE >
 ���̺��̶�, ��(ROW,RECORD,Ʃ��)�� ��(COLUMN, FIELDS, ATTRIBUTES)�� �����Ǵ� 
 ���� �⺻���� �����ͺ��̽� ��ü
 �׻� ��� �����ʹ� ���̺��� ���ؼ� �����.
 ��, �����͸� �����ϰ��� �Ѵٸ� ���̺��� ������ ��.
 
 [ǥ����]
 CREATE TABLE ���̺�� (
     �÷���1 �ڷ���,
     �÷���2 �ڷ���,
     ... 
     �÷���N �ڷ���
 );
 
 < �ڷ��� >
 - ���� (CHAR(������),VARCHAR2(������)) : ������� BYTE��
                                    (����, ����, Ư������, ���� => 1���ڴ� 1BYTE
                                                        �ѱ� => 1���ڴ� 3BYTE)
       CHAR(BYTE) : �������� ���ڿ�. �ƹ��� ���� ���� ����, �������� ä���� �Ҵ��� ũ�⸦ ������.
                  : BYTE���� �ִ� 2000���� ���� ����
                  => �ַ� ���� ���� ���ڼ��� ���������� �� ���
                  => ��) ����(��,��) : 3BYTE / (M,F) : 1BYTE
       VARCHAR2(BYTE) : �������� ���ڿ�. ���� ���� ����, �ڵ����� ������ �ش� ����ŭ ������.
                      : BYTE���� �ִ� 4000���� ���� ����
                      => �ַ� ���� ���� �������� �ʾ��� �� ���
                      => ��) �̸�(2~3��), �̸����ּ�, ���ּ�,...
 - ���� (NUMBER) : ���� / �Ǽ� ������� NUMBER��.
 
 - ��¥ (DATE) : ��,��,��,��,��,���� ������ �� �ڷ���
 
 
*/

-- ȸ������ �����͸� ���� �� �ִ� ���̺� �����
-- ���̺�� : MEMBER
-- �÷����� : ���̵�, ��й�ȣ, �̸�, ȸ��������
CREATE TABLE MEMBER (
    MEMBER_ID VARCHAR2(20), -- ����Ŭ������ ��ҹ��� ������ ���� �ʾ�, ��Ÿ��ǥ��� ��� ����ٸ� ���
    MEMBER_PWD VARCHAR2(16),
    MEMBER_NAME VARCHAR2(15),
    MEMBER_DATE DATE
    );

SELECT * FROM MEMBER; -- ���̺��� �� ���� �ۼ� ��, ���빰�� ���� ���·� ��µ�.
SELECT * FROM MEMBER2; -- [����] table or view does not exist  
                       -- �������� �ʴ� ���̺��� ��ȸ�� ������ �߻���.

/*
 �÷��� �ּ� �ޱ�(�÷��� ���� ����)
 '��'�ǿ� COMMENT�� Ȯ��
 
 [ǥ����]
 COMMENT ON COLUMN ���̺��.�÷��� IS '�ּ�����';
*/

COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�� ���̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ�� ��й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ�� �̸�';
COMMENT ON COLUMN MEMBER.MEMBER_DATE IS 'ȸ�� ������';

-- ����) �ش� ������ � ���̺�, �÷������ �����ϴ��� �� �� �ִ� ���
-- DATA DICTIONARY : �پ��� ��ü���� ������ �����ϰ� �ִ� �ý��� ���̺�(������)
SELECT TABLE_NAME FROM USER_TABLES;
-- USER_TABLES : ���� �������ִ� ������ ������ �ִ� ���̺��� �������� ������ Ȯ���� �� ����.
-- TABLE_NAME : ������ ������ �ִ� ���̺��� �̸��� Ȯ���� �� ����.

SELECT * FROM USER_TAB_COLUMNS;
-- USER_TAB_COLUMNS : ���� �� ������ ������ �ִ� ���̺���� ��� �÷��� ������ ��ȸ�� �� ����.

SELECT * FROM MEMBER;
-- �����͸� �߰��� �� �ִ� ���� 
-- INSERT : �� �� ������ �߰�. ���� ������ ���߾ �ۼ����־�� ��.
-- INSERT INTO ���̺�� VALUES(ù��°�÷��ǰ�, �ι�°�÷��ǰ�, ����°�÷��ǰ�,...)
INSERT INTO MEMBER VALUES('user01','pass01','ȫ�浿','2022-03-25');
INSERT INTO MEMBER VALUES('user02','pass02','�踻��','2022-03-26');
INSERT INTO MEMBER VALUES('user03','pass03','�ڰ���',SYSDATE);

INSERT INTO MEMBER VALUES('�����ٶ󸶹ٻ�','pass04','�̵���',SYSDATE);
-- [����] Value too large for column "DDL"."MEMBER"."MEMBER_ID" 
-- (actual: 21, maximum: 20)
-- �ִ� 20����Ʈ���� ���� �����ѵ�, 21����Ʈ¥�� ���� �־��� ��� �߻�


-- ������ �߻����� ����. ��, ��ȿ�� ���� �ƴ� ������ ���� ��Ȳ��
INSERT INTO MEMBER VALUES('user04', null, null, sysdate);
INSERT INTO MEMBER VALUES(null, null, null, sysdate);
-- ȸ�����Խ� ���̵�, ��й�ȣ, ȸ���̸��� �ʼ������� null�� �ƴ� ���� ���� ��.

INSERT INTO MEMBER VALUES('user03', 'pass03', '��浿', sysdate);
-- ȸ�����Խ� ���̵�, ��й�ȣ�� �̹� ������� ���, ������ ���� �ʾ� �ߺ��� ���� �����ϸ� �ȵ�.


-- ���� null�̳�, �ߺ��� ���� ��ȿ���� ���� ������.
-- ��ȿ�� �����Ͱ��� �����ϱ� ���ؼ��� '��������'�� �ɾ��־�� ��.

----------------------------------------------------------------------------------
/*
 < �������� CONSTRAINTS >
 - ���ϴ� ������ ���� �����ϱ� ���ؼ�, Ư�� �÷����� �����ϴ� ����
 - ��ȿ�� ���鸸 �����ϱ� ���ؼ�, �ش� ���������� ������.
 - �ִ���� : �������� ���Ἲ(��Ȯ��)�� �����ϱ� ���� �������� ���
 -        : ��ü�����δ� �ߺ��� NULL�� ���� �����.
 - ���ʿ� ���������� �ο��� �÷��� ���� �������� ������ �ִ��� �������� �˻���. 
 
 - ���� : NOT NULL, UNIQUE, CHECK, PRIMARY KEY(�⺻Ű), FOREIGN KEY(�ܷ�Ű)
 - �÷��� ���������� �ο��ϴ� ��� : �÷��������, ���̺������
*/

/*
 1. NOT NULL ��������
 �ش� �÷�(��)�� �ݵ�� ���� �����ؾ� �� ��쿡�� �����.
 NULL�� ����� ���ͼ��� �ȵǴ� �÷��� �ο�
 INSERT�Ҷ� / UPDATE�Ҷ��� ���������� NULL�� ������� �ʵ��� ����
 '��'���� NALLABLE�� Ȯ��
 '��������'���� SEARCH_CONDITION�� Ȯ��

 ��, NOT NULL ���������� �÷�����������θ� �� �� ����.
*/

-- NOT NULL �������Ǹ� ������ ���̺� �����
-- �÷�������� : �÷��� �ڷ��� ��������
-- ȸ����ȣ, ���̵�, ��й�ȣ, �̸�
CREATE TABLE MEM_NOTNULL (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);

SELECT * FROM MEM_NOTNULL;

INSERT INTO MEM_NOTNULL VALUES(1, 'user01','pass01','ȫ�浿','��','010-1111-2222','aaa@naver.com');
INSERT INTO MEM_NOTNULL VALUES(2, null, null, null, null, null, null);
-- [����] cannot insert NULL into ("DDL"."MEM_NOTNULL"."MEM_ID")
-- NOT NULL ���������� ���� ������, NULL�� �� �� ����.

INSERT INTO MEM_NOTNULL VALUES(2, 'user02', 'pass02', '�踻��', null, null, null);
INSERT INTO MEM_NOTNULL VALUES(3, 'user03', 'pass03', '�ڰ���', '��',null, null); 
-- NOT NULL ���������� ���� ���� �κп���, NULL�� �� �� ����.

---------------------------------------------------------------------------------------------
/*
 2. UNIQUE ��������
 �÷��� �ߺ����� �����ϴ� ��������
 INSERT(����) / UPDATE(����)��, ���� �ش� �÷��� ��  �ߺ����� ���� ���
 �߰� �Ǵ� ������ ���� �ʰԲ� ����
 '��������'�ǿ� CONSTRAINT_TYPEȹ�� 
 
 �÷����� / ���̺��� ��� �Ѵ� ����
*/

-- UNIQUE ���������� �߰��� ���̺� ����
-- �÷� ���� ���
CREATE TABLE MEM_UNIQUE(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30)
);    

SELECT * FROM MEM_UNIQUE;

-- ���̺� ���� ���
CREATE TABLE MEM_UNIQUE( -- [����] name is already used by an existing object
                         -- ���̺�� �ߺ��� ������ ���� ������ �߻���.
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    UNIQUE(MEM_ID) -- ���̺� ���� ����� ���� ����
);

SELECT * FROM MEM_UNIQUE;

-- ���̺��� ������ų �� �ִ� ����
DROP TABLE MEM_UNIQUE;

INSERT INTO MEM_UNIQUE VALUES(1, 'user01','pass01','ȫ�浿','��','010-1234-1234','abc@gmail.com');
INSERT INTO MEM_UNIQUE VALUES(2, 'user02','pass02','�踻��',null,null,null);

INSERT INTO MEM_UNIQUE VALUES(3, 'user02','pass02','����',null,null,null);
-- [����] unique constraint (DDL.SYS_C007089) violated
-- UNIQUE ���������� �ɷ����� ���, �ߺ����� �Է� �� ���� �߻�
-- ���̺�- ���������� - C007089�� MEM_ID��
-- �������� �ο���, ���� �������Ǹ��� �ο����� ������ C007089ó�� �ý��ۿ��� ������ �������Ǹ��� �ο�����

/*
 < CONSTRAINT >
 �������� �ο��� �������Ǹ��� ����
 
 - �÷����� ����� ���
 CREATE TABLE ���̺��(
    �÷��� �ڷ��� CONSTRAINT �������Ǹ� ��������, 
    �÷��� �ڷ���
    ...
 )   
 
 -- ���̺��� ����� ���
 CREATE TABLE ���̺��(
    �÷���, �ڷ���
    �÷���, �ڷ���
    ...
    �÷���, �ڷ�����
    CONSTRAINT �������Ǹ� ��������(�÷���)
 )
 
 �̶�, �� ��� ��� CONSTRAINT �������Ǹ� �κ��� ������ ������(������ ���Ƿ� �̸��� ����)
 => SYS_C007092
*/

-- �������Ǹ� ���̴� ����
CREATE TABLE MEM_CON_NAME(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) CONSTRAINT MEM_NAME_NOTNULL NOT NULL, -- �÷� ���� �������Ǹ�
    GENDER CHAR(3),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    CONSTRAINT MEM_ID_UNIQUE UNIQUE (MEM_ID) -- ���̺� ���� �������Ǹ�
);

SELECT * FROM MEM_CON_NAME;

INSERT INTO MEM_CON_NAME VALUES(1, 'user01', 'pass01', 'ȫ�浿', NULL, NULL, NULL);
-- INSERT INTO MEM_CON_NAME VALUES(2, 'user01','pass02','��浿',null,null,null);
-- [����] unique constraint (DDL.MEM_ID_UNIQUE) violated
-- MEM_ID�� �ߺ��Ǿ �߻��ϴ� ������.
-- �������Ǹ��� ������ ��쿡�� �÷���, ���������� ������ ������ ��� �����ִ� ���� ���� �ľǿ� �����.

SELECT * FROM MEM_CON_NAME;

----------------------------------------------------------------------------------
INSERT INTO MEM_CON_NAME VALUES(2, 'user02','pass02', '��浿', '��', NULL, NULL);
-- GENDER �÷��� '��' �Ǵ� '��'�� ���Բ� �ϰ� ����.
/*
 3. CHECK ��������
 �÷��� ��ϵ� �� �ִ� ���� ���� ������ ������ �� �� �ִ� ���� ����
 '��������'�ǿ� SEARCH_CONDITION�� Ȯ��
 CHECK(���ǽ�)
*/

-- CHECK ���������� �߰��� ���̺�
CREATE TABLE MEM_CHECK (
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN ('��','��')) NOT NULL, -- �������ǰ� ������ ����
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE NOT NULL
);
SELECT * FROM MEM_CHECK;
INSERT INTO MEM_CHECK VALUES(1, 'user01', 'pass01', 'ȫ�浿', '��', '010-1111-1111', null, SYSDATE);
INSERT INTO MEM_CHECK VALUES(2, 'user02', 'pass02', '�谩��', null, null, null, SYSDATE);
-- CHECK�������ǿ� �ش� �÷������� �����ϰ�, ���ؼ� NULL�� INSERT�� �� �� ����.
-- ����, ���⼭ NULL�� ���ְ� �ϰ� ������, �������ǿ� NOT NULL�� �߰����ָ� ��.

INSERT INTO MEM_CHECK VALUES(3, 'user03', 'pass03', '�踻��', '��', null, null, SYSDATE);
-- [����] check constraint (DDL.SYS_C007100) violated
-- CHECK ���������� �����Ͽ� ����� ������
-- '��'�� '��'�� �ƴ� �ٸ� ������ �÷��� �����ϴµ� ����� ������

--------------------------------------------------------------------------------
-- ȸ���������� �׻� SYSDATE�� �ް���� ���, ���̺� ������ ���� ������.(�⺻�� ���� �ɼ�)

/*
 < DEFAULT > 
 Ư�� �÷��� ���� ���� ���Ͽ�, �⺻������ ���� ������.
 ��, DEFAULT�� ���������� �ƴ�
 '��'�ǿ� DATA_DEFAULT�� Ȯ��
*/

-- MEM_CHECK ���̺� ����
DROP TABLE MEM_CHECK;

-- ������ MEM_CHECK ���̺� DEFAULT�������� �߰�
CREATE TABLE MEM_CHECK(
    MEM_NO NUMBER NOT NULL,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE not null
);
SELECT * FROM MEM_CHECK;

/*
 INSERT INTO ���̺�� VALUES(��1, ��2,...); 
 => �׻� ������ ������ ���̺��� �÷��� ������ ��ġ, ������ ��ġ
 
 INSERT INTO ���̺��(�÷���1, �÷���2, �÷���3) VALUES (��1, ��2, ��3);
 => �Ϻ��� �÷��� ���� �ְ� ������ �����.
*/

INSERT INTO MEM_CHECK 
VALUES(1, 'user01','pass01', 'ȫ�浿', '��', null, null);
-- [����] not enough values
-- DEFAULT������ ��������, value�� ������� �ʴٰ� ��.

INSERT INTO MEM_CHECK(MEM_NO, MEM_ID, MEM_PWD, MEM_NAME)
VALUES(1, 'user01','pass01', 'ȫ�浿');
-- ������ �ȵ� �÷����� �⺻������ null�� ä������ �� ���� �߰���
-- ����, default ������ �Ǿ��ִٸ�, null�� �ƴ϶� default�� �߰��Ǵ� ���� Ȯ���� �� ����.

INSERT INTO MEM_CHECK 
VALUES(2, 'user02', 'pass02','��浿',null, null, null, default);
-- DEFAULT ���������� �� �ڸ��� DEFAULT�� �־��൵ ��.

INSERT INTO MEM_CHECK 
VALUES(3, 'user03', 'pass03', '�踻��', null, null, null, '21/03/25');
-- DEFAULT���� �� �ٸ����� ��Ƶ� ����
-------------------------------------------------------------------------------

/*
 4. PRIMARY KEY(�⺻Ű) ��������
 ���̺��� �� ����� ������ �����ϰ� �ĺ����� �� �ִ� �÷��� �ο��ϴ� ��������
 �� �� ���� ���ٸ��� ������ �� �ִ� �ĺ����� ����(�ڹ� �÷��ǿ��� MAP�迭�� KEY�� ����.)
 '��������'�ǿ� CONSTRAINT_TYPE���� Ȯ�� 
 ��) �ֹε�Ϲ�ȣ, ���, �й�, �����ȣ, ���̵�, ȸ����ȣ
 => �ߺ����� �ʰ�, ���� �����ؾ߸� �ϴ� �÷��� PRIMARY KEY�� �ο�(UNIQUE, NOT NULL)
 
 ��, �� ���̺�� �Ѱ��� PRIMARY KEY �������Ǹ� �����ؾ� ��.
 - PRIMARY KEY ���������� �÷� �Ѱ����� �Ŵ� ��
 
 - PRIMARY KEY ���������� �÷� �������� ��� �ѹ��� �Ŵ� ��(����Ű)
   =>(���� �̷��� �� �ʿ�� ����.)
*/

-- PRIMARY KEY ���������� �߰��� ���̺� ����
CREATE TABLE MEM_PRIMARY_KEY1(
    MEM_NO NUMBER CONSTRAINT MEM_PK PRIMARY KEY, --�÷����� ���
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN('��','��')),
    PHONE VARCHAR2(15), 
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE
);   
SELECT * FROM MEM_PRIMARY_KEY1;

INSERT INTO MEM_PRIMARY_KEY1
VALUES(1, 'user01', 'pass01','ȫ�浿','��',NULL, NULL, DEFAULT);

INSERT INTO MEM_PRIMARY_KEY1
VALUES(1, 'user02', 'pass02','�踻��',NULL ,NULL, NULL, DEFAULT);
-- [����] unique constraint (DDL.MEM_PK) violated
-- PRIMARY KEY�� �ߺ� �Ǿ��� ���, ���������� UNIQUE �������� ����� ����.
-- �� ��쿡�� �������Ǹ��� ���� ��Ȯ�� UNIQUE���� PRIMARY KEY������ ã�ư��� ��.
-- ����, PRIMARY KEY ������ ����Ͽ� �������Ǹ��� Ȯ���� ����(���̺��_PK)


-- NULL�� ���ǳ�?
INSERT INTO MEM_PRIMARY_KEY1
VALUES(NULL, 'user02', 'pass02','�踻��',NULL ,NULL, NULL, DEFAULT);
-- [����] cannot insert NULL into ("DDL"."MEM_PRIMARY_KEY1"."MEM_NO")
-- �翬�� PRIMARY KEY���� NULL�� �� �� ����.(NOT NULL ����)
-- (������.���̺��.�÷���)���� ������ ��.

INSERT INTO MEM_PRIMARY_KEY1
VALUES(2, 'user02', 'pass02','�踻��',NULL ,NULL, NULL, DEFAULT);

-- PRIMARY KEY ���������� �߰��� ���̺� ����
CREATE TABLE MEM_PRIMARY_KEY2(
    MEM_NO NUMBER, 
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK (GENDER IN('��','��')),
    PHONE VARCHAR2(15), 
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE,
    CONSTRAINT MEM_PK2 PRIMARY KEY (MEM_NO) -- ���̺� ���� ���
); 
-- [����] name already used by an existing constraint
-- �ƹ��� �ٸ� ���̺��� ���������̴���, �������Ǹ��� �ߺ��Ǹ� �ȵ�.
SELECT * FROM MEM_PRIMARY_KEY2;

-- ����Ű : ���� �÷��� ��� �ѹ��� PRIMARY KEY���������� �ִ� ��
CREATE TABLE MEM_PRIMARY_KEY3(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) PRIMARY KEY,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE
); 
-- [����] "table can have only one primary key"
-- ���̺� 2�� �̻��� PRIMARY KEY ���������� �� �� ��Ÿ���� ������.
-- PRIMARY KEY�� �� ���̺� 2�� �̻��� �� �� ����.
-- ��, �÷��� ������ ��� �Ѱ��� PRIMARY KEY�� ��Ÿ���� ���� �� �� ����.

CREATE TABLE MEM_PRIMARY_KEY3(
    MEM_NO NUMBER,
    MEM_ID VARCHAR2(20),
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE,
    PRIMARY KEY(MEM_NO,MEM_ID) -- ����Ű�� ���̺� ���� ������θ� �ۼ� ����
    -- �÷��� ��� PRIMARY KEY �ϳ��� ������ ���� �� �� ����.
); 

INSERT INTO MEM_PRIMARY_KEY3
VALUES(1, 'user01', 'pass01','ȫ�浿',NULL ,NULL, NULL, DEFAULT);

SELECT * FROM MEM_PRIMARY_KEY3;

INSERT INTO MEM_PRIMARY_KEY3
VALUES(1, 'user02', 'pass02','�迵��',NULL ,NULL, NULL, DEFAULT);
-- ����Ű�� ���, �ش� �÷��� ���� ������ ������ �� ��ġ�ؾ߸� �ߺ����� �Ǻ�
-- ���� �ϳ��� ���� �ٸ� ���, �ߺ����� �Ǻ��� �ȵ�.

INSERT INTO MEM_PRIMARY_KEY3
VALUES(2, NULL, 'pass02','�迵��',NULL ,NULL, NULL, DEFAULT);
-- [����] cannot insert NULL into ("DDL"."MEM_PRIMARY_KEY3"."MEM_ID")
-- ����Ű�� ���, ����Ű�� �ش��ϴ� �÷����� �� �ϳ��� NULL�� ���� �ȵ�.

---------------------------------------------------------------------------------
/*
  < FOREIGN KEY(�ܷ�Ű) ��������
  �ش� �÷��� �ٸ� ���̺� �����ϴ� ���� ���;ߵǴ� �÷��� �ο��ϴ� ��������
  ����) EMPLOYEE���̺��� JOB_CODE�÷��� ���� ������ 
       �ݵ�� JOB���̺��� JOB_CODE�÷��� ���� ����� �̷���� �־�� ��.
       �� �̿��� ���� ������ �ȵ�.
       => EMPLOYEE���̺� ���忡�� JOB���̺��� �÷����� ����ٰ� '����'��.
       => EMPLOYEE���̺� ���忡�� JOB���̺��� �θ����̺��̶�� ǥ�� ����
       => JOB���̺� ���忡�� EMPLOYEE���̺��� �ڽ����̺��̶�� ǥ�� ����
       
  => �ٸ� ���̺�(�θ����̺�)�� '����'�Ѵٰ� ǥ����.(Reference)
  => ��, ������ �ٸ� ���̺��� �����ϰ� �ִ� ����, �ش� �ܷ�Ű ������ �Ǿ��ִ� �÷��� ���� �� ����.
  => FOREIGN KEY ������������, �ٸ� ���̺��� ���踦 ������ �� ���� == JOIN
  
  [ǥ����]
  - �÷����� ���
  �÷��� �ڷ��� [CONSTRAINT �������Ǹ�] REFERENCES ���������̺��(�÷���)
  ...
  
  - ���̺��� ���
  �÷��� �ڷ���,
  [CONSTRAINT�������Ǹ�] FOREIGN KEY (�������������÷���) REFERENCES ���������̺��(�������÷���)
  
  ��, �� ��� ��� �������÷Ÿ��� ���� ������.
  �� ���, �⺻������ ���������̺��� PRIMARY KEY �÷����� �������÷����� �ڵ����� ����.
  CONSTRAINT ���������� ���� ������.(SYS_C007092)
*/

-- �׽�Ʈ�� ���� �θ����̺� ����
-- ȸ�����, ȸ������
CREATE TABLE MEM_GRADE(
    GRADE_CODE CHAR(2) PRIMARY KEY,
    GRADE_NAME VARCHAR2(20) NOT NULL
);

SELECT * FROM MEM_GRADE;
INSERT INTO MEM_GRADE VALUES('G1', '�Ϲ�ȸ��');
INSERT INTO MEM_GRADE VALUES('G2', '���ȸ��');
INSERT INTO MEM_GRADE VALUES('G3', 'Ư��ȸ��');

-- �ڽ����̺�(�ܷ�Ű �������� �ɾ��)
CREATE TABLE MEM(
  MEM_NO NUMBER PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GRADE_ID CHAR(2) REFERENCES MEM_GRADE(GRADE_CODE),-- �÷����� ���
  GENDER CHAR(3) CHECK (GENDER IN('��','��')),
  PHONE VARCHAR2(15),
  EMAIL VARCHAR2(30),
  MEM_DATE DATE DEFAULT SYSDATE
);
SELECT * FROM MEM;
DROP TABLE MEM;
INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '����', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(4, 'user04', 'pass04', '�ڰ���', NULL , NULL, NULL, NULL, DEFAULT); 
-- �ܷ�Ű ���������� �ɷ��ִ� �÷����� �⺻������ NULL�� �� �� ����(CHECK��������ó��)
-- ����, NOT NULL ���������� �߰��� �ɾ��־�� ��.

INSERT INTO MEM 
VALUES(5, 'user05', 'pass05', '��浿', 'G5' , NULL, NULL, NULL, DEFAULT); 
-- [����] integrity constraint (DDL.SYS_C007170) violated - parent key not found
-- 'G5'�� �θ����̺��� MEM_GRADE���̺��� GRADE_CODE�÷����� �����ϴ� ���� �ƴϱ� ������ ���� �߻�

-- ����) �θ����̺��� MEM_GRADE���� �����Ͱ��� �����ȴٸ�
-- MEM_GRADE ���̺�κ��� GRADE_CODE�� G1�� �����͸� �����
DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- [����] integrity constraint (DDL.SYS_C007170) violated - child record found
-- �ڽ����̺��� MEM �߿� G1�̶�� ���� ����ϰ� �ִ� ����� �����ϱ� ������, �θ� ���� ������ �� ����.
-- ���� �ܷ�Ű �������� �ο���, �߰������� ���� �ɼ��� �ο������ʾ���.
-- => �ڽ����̺��� ����ϰ� �ִ� ���� ���� ���, ������ ���� �ʴ� �������ѿɼ��� �⺻������ �ο��Ǿ� ����.

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G3';

SELECT * FROM MEM_GRADE;
-- G3�̶�� ���� �ڽ����̺��� ����ϰ� ���� �ʱ⿡, �� ������ ���� �� �� ����.

-- �׽�Ʈ�ߴ� ���� ������ ���·� �ǵ�����
ROLLBACK;

-- MEM ���̺� ����
DROP TABLE MEM;

/*
 �ڽ����̺��� ���� ��(�ܷ�Ű ���������� �ο��� ��)
 �θ����̺��� �����Ͱ� �����Ǿ��� ��, �ڽ����̺����� ������ ���� ���Ͽ� � ó���� �� ������
 �ɼ����� ���� �� ����.
 
 FOREIGN KEY �����ɼ�
 - ON DELETE RESTRICTED : �����ɼ��� ������ �������� �ʾ��� ��(�⺻��) => ��������(�ڽ����̺��� �ش� �� ������)
 - ON DELETE SET NULL : �θ����͸� ���� ��, �ش� �����͸� ����ϴ� �ڽĵ����͸� NULL�� ����
 - ON DELETE CASCADE : �θ����͸� ���� ��, �ش� �����͸� ����ϴ� �ڽĵ����͵� ���� ����
*/

-- 1) ON DELETE SET NULL : �θ����� ������, �ڽĵ����͸� NULL�� ����
CREATE TABLE MEM(
  MEM_NO NUMBER PRIMARY KEY,
  MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
  MEM_PWD VARCHAR2(20) NOT NULL,
  MEM_NAME VARCHAR2(20) NOT NULL,
  GENDER CHAR(3) CHECK (GENDER IN('��','��')),
  PHONE VARCHAR2(15),
  EMAIL VARCHAR2(30),
  MEM_DATE DATE DEFAULT SYSDATE,
  GRADE_ID CHAR(2),
  FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE SET NULL
); 

DROP TABLE MEM;
DROP TABLE MEM_GRADE;
SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '����', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(4, 'user04', 'pass04', '�ڰ���', NULL , NULL, NULL, NULL, DEFAULT); 

DELETE FROM MEM_GRADE
WHERE GRADE_CODE = 'G1';
-- �ڽ����̺��ӿ��� ������ �� �� ���� �� �� ����.

SELECT * FROM MEM;
SELECT * FROM MEM_GRADE;
-- �����ʰ� ���ÿ� GRADE_ID�κп��� G1�� �ش��ϴ� ���� NULL�� ���Ѱ��� �� �� ����.

ROLLBACK;
-- �׵��� �׽�Ʈ�ߴ��� �ǵ�����

DROP TABLE MEM;
-- MEM ���̺� ����

-- 2) ON DELETE CASCADE : �θ����͸� �������� ��, �ڽĵ����͸� ���� ����
CREATE TABLE MEM(
    MEM_NO NUMBER PRIMARY KEY,
    MEM_ID VARCHAR2(20) NOT NULL UNIQUE,
    MEM_PWD VARCHAR2(20) NOT NULL,
    MEM_NAME VARCHAR2(20) NOT NULL,
    GENDER CHAR(3) CHECK(GENDER IN('��','��')),
    PHONE VARCHAR2(15),
    EMAIL VARCHAR2(30),
    MEM_DATE DATE DEFAULT SYSDATE,
    GRADE_ID CHAR(2),
    FOREIGN KEY(GRADE_ID) REFERENCES MEM_GRADE(GRADE_CODE) ON DELETE CASCADE -- ���̺��� ���
);

SELECT * FROM MEM;

INSERT INTO MEM 
VALUES(1, 'user01', 'pass01', 'ȫ�浿', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(2, 'user02', 'pass02', '�踻��', 'G2', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(3, 'user03', 'pass03', '����', 'G1', NULL, NULL, NULL, DEFAULT); 

INSERT INTO MEM 
VALUES(4, 'user04', 'pass04', '�ڰ���', NULL , NULL, NULL, NULL, DEFAULT); 

SELECT * FROM MEM;

DELETE FROM MEM_GRADE 
WHERE GRADE_CODE = 'G1';
-- �θ����̺�(MEM_GRADE)�� G1�� ����

SELECT * FROM MEM_GRADE;
-- �ڽ����̺��� �����ϰ� �ִµ���, �� ������ ���� �� �� ����.

SELECT * FROM MEM;
-- �ڽ����̺�(MEM)�� GRADE_ID�� G1�� ����� �����Ǿ���.

-- [����]
-- �ܷ�Ű�� ����
-- ��ü ȸ���� ȸ����ȣ, ���̵�, ��й�ȣ, �̸�, ��޸� ��ȸ
--> ����Ŭ ���� ����
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM , MEM_GRADE 
WHERE GRADE_ID = GRADE_CODE(+);

--> ANSI����
SELECT MEM_NO, MEM_ID, MEM_PWD, MEM_NAME, GRADE_NAME
FROM MEM 
LEFT JOIN MEM_GRADE ON(GRADE_ID = GRADE_CODE);

/*
 ����, �ܷ�Ű ���������� �ɷ����� �ʴ��� JOIN�� ������.
 �ٸ�, �� �÷��� ������ �ǹ��� �����͸� ����ִٸ�, �����ؼ� JOIN���� ��ȸ ������.
 => EMPLOYEE���̺��� ������������ ���� FOREIGN KEY�� ���� ���������� �������� ����
*/

ROLLBACK;
DROP TABLE MEM;

-- [����] : ���������� �̿��� ���̺� ����(���̺� ������ ����)
/*
 -- ���⼭���ʹ� KH�������� �����ؼ� �׽�Ʈ --
 ���������� �̿��� ���̺� ���� (���̺��� ���� �ߴ� ����)
 �������� : ���� SQL��(SELECT, CREATE, INSERT, UPDATE)�� ���������ϴ� ������(SELECT)
 
 [ǥ����]
 CREATE TABLE ���̺��
 AS (��������);
 
 �ش� ���������� ������ ����� �̿��ؼ�,
 ������ ���̺��� �����ϴ� ����.
*/

-- EMPLOYEE ���̺��� ������ ���ο� ���̺� ���� (EMPLOYEE_COPY)
CREATE TABLE EMPLOYEE_COPY
AS (SELECT * 
    FROM EMPLOYEE);
    --> �÷���, ��ȸ����� �����Ͱ����� �� �����.
    --> �߰�������, ���������� ���, NOT NULL�� ���縸 ��.
SELECT * FROM EMPLOYEE_COPY;

-- EMPLOYEE ���̺� �ִ� �÷��� ������ �����ϰ� ����(�����Ͱ��� �ʿ���� ���)
/*
CREATE TABLE EMPLOYEE_COPY2(
    EMP_ID NUMBER,
    EMP_NAME VARCHAR2(20), 
    ...
);
*/
CREATE TABLE EMPLOYEE_COPY2
AS (SELECT *
    FROM EMPLOYEE
    WHERE 1 = 0) ; -- ���ǹ��� �������� �Ͽ�, �����Ͱ� ���� ������ ������ �� ����.
    
SELECT * FROM EMPLOYEE_COPY2;

-- ��ü ����� �� �޿��� 300���� �̻��� �������
-- ���, �̸�, �μ��ڵ�, �޿��� ����
CREATE TABLE EMPLOYEE_COPY3
AS(SELECT EMP_ID, EMP_NAME, DEPT_CODE, SALARY
   FROM EMPLOYEE
   WHERE SALARY >= 3000000);

SELECT * FROM EMPLOYEE_COPY3;

-- ��ü����� ���, �����, �޿�, ���� ��ȸ�ܷΰ� ���̺��� ����
CREATE TABLE EMPLOYEE_CODY4
AS(SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12
   FROM EMPLOYEE);
-- [����] must name this expression with a column alias
-- ���������� SELECT�� �κп� �������, �Լ����� ����� ���, �ݵ�� ��Ī�� �ο����־�� ��.

CREATE TABLE EMPLOYEE_COPY4
AS (SELECT EMP_ID, EMP_NAME, SALARY, SALARY*12"����"
    FROM EMPLOYEE);

SELECT * FROM EMPLOYEE_COPY4;

-- [����] ���� ���̺� ���������� �߰��ϴ� ���
/*
 ���̺��� �̹� �� ������ ��, �ڴʰ� ���������� �߰�
 ALTER TABLE ���̺��
 - PRIMARY KEY : ADD PRIMARY KEY(�÷���);
 - FOREIGN KEY : ADD FOREIGN KEY(�÷���) REFERENCES ���������̺��(�������÷���);
 ������ �÷����� ���� ����, �� ��� ���������̺���� PRIMARY KEY�� ����.
 - UNIQUE : ADD UNIQUE(�÷���);
 - CHECK : ADD CHECK(���ǽ�);
 - NOT NULL : MODIFY �÷��� NOT NULL;
*/

-- EMPLOYEE_COPY ���̺� ���� PRIMARY KEY ���������� �߰�(EMP_ID)
ALTER TABLE EMPLOYEE_COPY ADD PRIMARY KEY (EMP_ID);

-- EMPLOYEE_COPY���̺� DEPT_CODE �÷��� �ܷ�Ű ���������� �߰�(DEPARTMENT)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY (DEPT_CODE) REFERENCES DEPARTMENT(DEPT_ID);

-- EMPLOYEE_COPY ���̺� JOB_CODE �÷��� �ܷ�Ű ���������� �߰�(JOB)
ALTER TABLE EMPLOYEE_COPY ADD FOREIGN KEY (JOB_CODE) REFERENCES JOB (JOB_CODE);



-- �ǽ� ���� --
-- �������� ���α׷��� ����� ���� ���̺�� ����� --
-- �̶�, �������ǿ� �̸��� �ο��Ұ�
-- �� �÷��� �ּ� �ޱ�

-- 1. ���ǻ�鿡 ���� �����͸� ��� ���� ���ǻ� ���̺� (TB_PUBLISHER)
-- �÷� : PUB_NO (���ǻ��ȣ) -- �⺻Ű (PUBLISHER_PK)
--        PUB_NAME (���ǻ��) -- NOT NULL (PUBLISHER_NN)
--        PHONE (���ǻ���ȭ��ȣ) -- �������� ����
-- �ּ� �߰�
COMMENT ON COLUMN TB_PUBLISHER.PUB_NO IS '���ǻ� ��ȣ';
COMMENT ON COLUMN TB_PUBLISHER.PUB_NAME IS '���ǻ��';
COMMENT ON COLUMN TB_PUBLISHER.PHONE IS '���ǻ� ��ȭ��ȣ';

-- 3�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_PUBLISHER(
    PUB_NO NUMBER CONSTRAINT PUBLISHER_PK PRIMARY KEY,      -- ���ǻ� ��ȣ
    PUB_NAME VARCHAR2(30) CONSTRAINT PUBLISHER_NN NOT NULL, -- ���ǻ� ��
    PHONE VARCHAR2(15)                                      -- ���ǻ� ��ȭ��ȣ
);
-- INSERT��
INSERT INTO TB_PUBLISHER VALUES(1, '�Ѻ�����', '010-1111-1111');
INSERT INTO TB_PUBLISHER VALUES(2, '�θ��̵��', '010-2222-2222');
INSERT INTO TB_PUBLISHER VALUES(3, '������', '010-3333-3333');
-- SELECT��
SELECT * FROM TB_PUBLISHER;

-- 2. �����鿡 ���� �����͸� ��� ���� ���� ���̺� (TB_BOOK)
-- �÷� : BK_NO (������ȣ) -- �⺻Ű (BOOK_PK)
--        BK_TITLE (������) -- NOT NULL (BOOK_NN_TITLE)
--        BK_AUTHOR (���ڸ�) -- NOT NULL (BOOK_NN_AUTHOR)
--        BK_PRICE (����)
--        BK_PUB_NO (���ǻ��ȣ) -- �ܷ�Ű(BOOK_FK) (TB_PUBLISHER ���̺��� �����ϵ���)
--                                 �� ��, �����ϰ� �ִ� �θ����� ���� �� �ڽ� �����͵� ���� �ǵ��� �Ѵ�.
-- �ּ� �߰�
COMMENT ON COLUMN TB_BOOK.BK_NO IS '������ȣ';
COMMENT ON COLUMN TB_BOOK.BK_TITLE IS '������';
COMMENT ON COLUMN TB_BOOK.BK_AUTHOR IS '���ڸ�';
COMMENT ON COLUMN TB_BOOK.BK_PRICE IS '���� ����';
COMMENT ON COLUMN TB_BOOK.BK_PUB_NO IS '���ǻ� ��ȣ';
-- 5�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_BOOK(
    BK_NO NUMBER PRIMARY KEY,                                   -- ������ȣ
    BK_TITLE VARCHAR2(30) CONSTRAINT BOOK_NN_TITLE NOT NULL,    -- ������
    BK_AUTHOR VARCHAR2(10) CONSTRAINT BOOK_NN_AUTHOR NOT NULL,  -- ���ڸ�
    BK_PRICE NUMBER,                                            -- ����    
    BK_PUB_NO REFERENCES TB_PUBLISHER ON DELETE CASCADE         -- ���ǻ� ��ȣ(�ܷ�Ű)
);     
-- INSERT��
INSERT INTO TB_BOOK VALUES(1, '�ڹ��� ����','���ü�',12000,1);
INSERT INTO TB_BOOK VALUES(2, '������ ����','�����',13000,2);
INSERT INTO TB_BOOK VALUES(3, '������ ����','�豹��',14000,3);
INSERT INTO TB_BOOK VALUES(4, '������ ����','�迵��',15000,2);
INSERT INTO TB_BOOK VALUES(5, '������ ����','�豹��',16000,1);
--SELECT��
SELECT BK_NO, BK_TITLE, BK_AUTHOR, BK_PRICE, BK_PUB_NO, PUB_NAME
FROM TB_PUBLISHER, TB_BOOK
WHERE BK_PUB_NO = PUB_NO; -- TB_BOOK�� ���ǻ� ��ȣ�� TB_PUBLISHER�� ���ǻ� ��ȣ�� JOIN


-- 3. ȸ���� ���� �����͸� ��� ���� ȸ�� ���̺� (TB_MEMBER)
-- �÷��� : MEMBER_NO (ȸ����ȣ) -- �⺻Ű (MEMBER_PK)
--         MEMBER_ID (���̵�) -- �ߺ����� (MEMBER_UQ)
--         MEMBER_PWD (��й�ȣ) -- NOT NULL (MEMBER_NN_PWD)
--         MEMBER_NAME (ȸ����) -- NOT NULL (MEMBER_NN_NAME)
--         GENDER (����) -- 'M' �Ǵ� 'F' �� �Էµǵ��� ���� (MEMBER_CK_GEN)
--         ADDRESS (�ּ�)
--         PHONE (����ó)
--         STATUS (Ż�𿩺�) -- �⺻������ 'N' ���� ����, �׸��� 'Y' Ȥ�� 'N' ���θ� �Էµǵ��� �������� (MEMBER_CK_ST)
--         ENROLL_DATE (������) -- �⺻������ SYSDATE, NOT NULL �������� (MEMBER_NN_EN)
-- �ּ� �߰��ϱ�
COMMENT ON COLUMN TB_MEMBER.MEMBER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_ID IS '������̵�';
COMMENT ON COLUMN TB_MEMBER.MEMBER_PWD IS '�����й�ȣ';
COMMENT ON COLUMN TB_MEMBER.MEMBER_NAME IS 'ȸ����';
COMMENT ON COLUMN TB_MEMBER.GENDER IS '����';
COMMENT ON COLUMN TB_MEMBER.ADDRESS IS '�ּ�';
COMMENT ON COLUMN TB_MEMBER.PHONE IS '��ȭ��ȣ';
COMMENT ON COLUMN TB_MEMBER.STATUS IS 'Ż�𿩺�';
COMMENT ON COLUMN TB_MEMBER.ENROLL_DATE IS '������';
-- 5�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_MEMBER(
    MEMBER_NO NUMBER CONSTRAINT MEMBER_PK PRIMARY KEY,                                     -- ȸ����ȣ
    MEMBER_ID VARCHAR2(30) CONSTRAINT MEMBER_UQ UNIQUE,                                    -- ��� ���̵�
    MEMBER_PWD VARCHAR2(30) CONSTRAINT MEMBER_NN_PWD NOT NULL,                             -- ��� ��й�ȣ
    MEMBER_NAME VARCHAR2(15) CONSTRAINT MEMBER_NN_NAME NOT NULL,                           -- ȸ����
    GENDER CHAR(3) CONSTRAINT MEMBER_CK_GEN CHECK(GENDER IN('M','W')),                     -- ����
    ADDRESS VARCHAR2(30),                                                                  -- �ּ�
    PHONE VARCHAR2(30),                                                                    -- ��ȭ��ȣ
    STATUS VARCHAR2(30) DEFAULT 'N' CONSTRAINT MEMBER_CK_ST CHECK (STATUS IN('Y','N')),    -- Ż�𿩺�     
    ENROLL_DATE DATE DEFAULT SYSDATE CONSTRAINT MEMBER_NN_EN NOT NULL);                    -- ������ 
-- INSERT��
INSERT INTO TB_MEMBER VALUES(1, 'user01', 'pass01','username1',NULL, NULL, NULL, NULL, '2021/02/22'); -- CHECK�������ǿ� NULL
INSERT INTO TB_MEMBER VALUES(2, 'user02', 'pass02','username2','M', NULL, NULL,DEFAULT ,DEFAULT ); -- DEFAULT ����
INSERT INTO TB_MEMBER VALUES(3, 'user03', 'pass03','username3','W', NULL, NULL, 'Y' , SYSDATE ); -- SYSDATE����
INSERT INTO TB_MEMBER VALUES(4, 'user04', 'pass04','username4','M', NULL, NULL,'N' ,SYSDATE );
INSERT INTO TB_MEMBER VALUES(5, NULL, 'pass05','username5','W', NULL, NULL,NULL ,SYSDATE);
-- SELECT��
SELECT * FROM TB_MEMBER;

-- 4. � ȸ���� � ������ �뿩�ߴ����� ���� �뿩��� ���̺� (TB_RENT)
-- �÷� : RENT_NO (�뿩��ȣ) -- �⺻Ű (RENT_PK)
--       RENT_MEM_NO (�뿩ȸ����ȣ) -- �ܷ�Ű (RENT_FK_MEM) TB_MEMBER �� �����ϵ���
--                                    �� ��, �θ� ������ ���� �� �ڽ� ������ ���� NULL �� �ǵ��� �ɼ� ����
--       RENT_BOOK_NO (�뿩������ȣ) -- �ܷ�Ű (RENT_FK_BOOK) TB_BOOK �� �����ϵ���
--                                     �� ��, �θ� ������ ���� �� �ڽ� ������ ���� NULL ���� �ǵ��� �ɼ� ����
--       RENT_DATE (�뿩��) -- �⺻�� SYSDATE
-- �ּ��߰�
COMMENT ON COLUMN TB_RENT.RENT_NO IS '�뿩��ȣ';
COMMENT ON COLUMN TB_RENT.RENT_MEM_NO IS '�뿩 ȸ����ȣ';
COMMENT ON COLUMN TB_RENT.RENT_BOOK_NO IS '�뿩 ������ȣ';
COMMENT ON COLUMN TB_RENT.RENT_DATE IS '�뿩 ��¥';
-- 3�� ������ ���� ������ �߰��ϱ�
CREATE TABLE TB_RENT(
    RENT_NO NUMBER CONSTRAINT RENT_PK PRIMARY KEY,                                              -- �뿩 ��ȣ                                 
    RENT_MEM_NO NUMBER REFERENCES TB_MEMBER ON DELETE SET NULL,  -- �÷����� ���                  -- �뿩 ȸ����ȣ(�ܷ�Ű)                
    RENT_BOOK_NO NUMBER,                                                                        -- �뿩 ������ȣ(�ܷ�Ű)   
    RENT_DATE DATE DEFAULT SYSDATE,                                                             -- �뿩 ��
    CONSTRAINT RENT_FK_BOOK FOREIGN KEY(RENT_BOOK_NO) REFERENCES TB_BOOK ON DELETE SET NULL      
    -- ���̺� ���� ���
);
-- INSERT��
INSERT INTO TB_RENT VALUES(1, 1, 1, DEFAULT);
INSERT INTO TB_RENT VALUES(2, 2, 2, DEFAULT);
INSERT INTO TB_RENT VALUES(3, 3, 3, DEFAULT);
-- SELECT��
SELECT RENT_NO, RENT_MEM_NO,MEMBER_NAME, RENT_BOOK_NO, BK_TITLE, RENT_DATE
FROM TB_RENT
JOIN TB_BOOK ON(BK_NO = RENT_BOOK_NO) -- TB_RENT���̺��� RENT_BOOK_NO�� TB_BOOK���̺��� BK_NO�� ����
JOIN TB_MEMBER ON(MEMBER_NO = RENT_MEM_NO); -- TB_RENT���̺��� RENT_MEM_NO�� TB_MEMBER���̺��� MEMBER_NO�� ����


COMMIT;
