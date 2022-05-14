package com.kh.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.dao.BoardDao;
import com.kh.model.vo.Board;

public class BoardService {
	
	public int insertBoard(Board b) {
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnetion();
		
		// 2) DAO 메소드를 호출(Connection, 전달값)
		int result = new BoardDao().insertBoard(conn,b);
		 
		// 3) 트랜잭션 처리
		if(result > 0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		// 4) 자원 반납
		JDBCTemplate.close(conn);
		
		// 5) 결과값 반환
		return result;
	}
	
	public ArrayList<Board> selectAll(){
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnetion();
		
		// 2) DAO메소드를 호출(Connection, 전달값)
		ArrayList<Board> list= new BoardDao().selectAll(conn);
		
		// 3) 트랜잭션 처리 => SELECT는 생략
		
		// 4) 자원반밥
		JDBCTemplate.close(conn);
		
		// 5) 결과값 반환
		return list;
	}
	
	public Board selectID(String writer) {
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnetion();
		
		// 2) DAO메소드를 호출
		Board b = new BoardDao().selectID(conn, writer);
		
		// 3) 트랜잭션 처리 => SELECT문이라 생략
		
		// 4) 자원반납
		JDBCTemplate.close(conn);
		
		// 5) 결과값 반환
		return b;
		
	}
	
	public ArrayList<Board> selectTitle(String title){
		// 1) Connection 객체 생성
		Connection conn = JDBCTemplate.getConnetion();
		
		// 2) DAO메소드 호출
		ArrayList<Board> list = new BoardDao().selectTitle(conn,title);
		
		// 3) 트랜잭션 처리 => SELECT문이라 생략
		
		// 4) 자원 반납
		JDBCTemplate.close(conn);
		
		// 5) 결과값 반환
		return list;
	}
}
