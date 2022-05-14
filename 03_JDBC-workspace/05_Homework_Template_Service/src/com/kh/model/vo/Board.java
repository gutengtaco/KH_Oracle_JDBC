package com.kh.model.vo;

import java.sql.Date;

public class Board {
	// 필드부
	
	private int bno;//	BNO NUMBER PRIMARY KEY, 
	private String title;//  TITLE VARCHAR2(50) NOT NULL, 
	private String content;//  CONTENT VARCHAR2(500) NOT NULL,
	private Date createDate;//  CREATE_DATE DATE DEFAULT SYSDATE, 
	private String writer;//  WRITER NUMBER, 
	private String deleteYN;//  DELETE_YN CHAR(2) DEFAULT 'N', 
    
	// 생성자부
	public Board() {
		super();
	}

	public Board(String title, String content, String writer) {
		super();
		this.title = title;
		this.content = content;
		this.writer = writer;
	}

	public Board(int bno, String title, String content, Date createDate, String writer, String deleteYN) {
		super();
		this.bno = bno;
		this.title = title;
		this.content = content;
		this.createDate = createDate;
		this.writer = writer;
		this.deleteYN = deleteYN;
	}

	// 메소드부 
	// getter, setter메소드
	public int getBno() {
		return bno;
	}

	public void setBno(int bno) {
		this.bno = bno;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getDeleteYN() {
		return deleteYN;
	}

	public void setDeleteYN(String deleteYN) {
		this.deleteYN = deleteYN;
	}

	// toString메소드 
	@Override
	public String toString() {
		return "Board [bno=" + bno + ", title=" + title + ", content=" + content + ", createDate=" + createDate
				+ ", writer=" + writer + ", deleteYN=" + deleteYN + "]";
	}

	
	
}
