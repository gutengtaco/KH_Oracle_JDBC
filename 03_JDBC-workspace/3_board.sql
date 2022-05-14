-- BOARD ���̺� ����
DROP TABLE BOARD;

CREATE TABLE BOARD(
    BNO NUMBER PRIMARY KEY, -- �Խñ� ��ȣ
    TITLE VARCHAR2(50) NOT NULL, -- �Խñ� ����
    CONTENT VARCHAR2(500) NOT NULL, -- �Խñ� ����
    CREATE_DATE DATE DEFAULT SYSDATE, -- �ۼ���
    WRITER NUMBER, -- �ۼ���(ȸ����ȣ)
    DELETE_YN CHAR(2) DEFAULT 'N', -- �Խñ� ���� ����(N : ������ �ȵ� ����)
    FOREIGN KEY (WRITER) REFERENCES MEMBER(USERNO),
    CHECK(DELETE_YN IN('Y','N'))
);

-- BOARD ���̺��� PK�� ���� ������
DROP SEQUENCE SEQ_BOARD;

CREATE SEQUENCE SEQ_BOARD;

-- �׽�Ʈ ������ ����
INSERT INTO BOARD
VALUES(SEQ_BOARD.NEXTVAL, '�Խ��� ���񽺸� �����մϴ�^^', '���� �̿� �ٶ��ϴ�~!', '21/01/27', 1, DEFAULT);

INSERT INTO BOARD
VALUES(SEQ_BOARD.NEXTVAL, 'JDBC �������', '����ּ���', '21/09/05', 2, DEFAULT);

INSERT INTO BOARD
VALUES(SEQ_BOARD.NEXTVAL, '�Խñ�2', '�Խñ�2 ������ ����ü �����?', '21/09/05', 2, DEFAULT);

COMMIT;

SELECT * FROM BOARD;

-- �Խñ� ��ü ��ȸ
SELECT BNO, TITLE, CREATE_DATE,WRITER, USERID
FROM BOARD, MEMBER
WHERE WRITER = USERNO 
  AND DELETE_YN = 'N' -- ������ ���� ���� �Խñ۸� ����.
ORDER BY CREATE_DATE DESC;  -- �ֽű� ������ 

-- �Խñ� ���� 
UPDATE BOARD
   SET DELETE_YN = 'Y'
 WHERE BNO = ?;
