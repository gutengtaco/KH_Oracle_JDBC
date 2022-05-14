package com.kh.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.vo.Board;

public class BoardDao {
	
	public int insertBoard(Connection conn, Board b) {
		// 0. 변수 담아주기
		int result = 0;
		PreparedStatement pstmt = null;
		
		
		// 실행할 SQL문
		String sql = "INSERT INTO BOARD "
				+ "VALUES(SEQ_BOARD.NEXTVAL, ?, ?, DEFAULT, ?, DEFAULT)";
		
		try {
			
			// 3-1) PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			// 3-2) 미완성의 경우, 값 채워넣기
			pstmt.setString(1, b.getTitle());
			pstmt.setString(2, b.getContent());
			pstmt.setString(3, b.getWriter());
			
			// 4,5) 실행 후 결과 받기
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
		
	}
	
	public ArrayList<Board> selectAll(Connection conn) {
		// 0) 필요한 변수 세팅
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		// SELECT 쿼리문 작성
		String sql = "SELECT * FROM BOARD";
		
		try {
			// 3-1) PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			// 3-2) 완성된 쿼리문이므로 생략
			
			// 4,5) rset객체에 pstmt의 실행결과를 담기
			rset = pstmt.executeQuery();
			
			// 6-1) 현재 조회결과를 VO객체를 바탕으로 한행씩 담아주기
			while(rset.next()) {
				Board b = new Board();
				b.setBno(rset.getInt("BNO"));
				b.setTitle(rset.getString("TITLE"));
				b.setContent(rset.getString("CONTENT"));
				b.setCreateDate(rset.getDate("CREATE_DATE"));
				b.setWriter(rset.getString("WRITER"));
				b.setDeleteYN(rset.getString("DELETE_YN"));
				
				list.add(b);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}
	
	public Board selectID(Connection conn, String writer) {
		
		// 0) 필요한 변수 설정
		Board b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		// SELECT문 쿼리 
		String sql = "SELECT BNO, TITLE, CONTENT, CREATE_DATE, WRITER, DELETE_YN "
				+ "FROM BOARD "
				+ "WHERE WRITER = ?";
		
		try {
			// 3-1) PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			// 3-2) 미완성된 쿼리문일 경우, 값 채워넣기
			pstmt.setString(1, writer);
			
			// 4,5) rset에 pstmt의 실행 결과를 담기
			rset = pstmt.executeQuery();
			
			// 6-1) 실행결과를 VO객체에 담기
			if(rset.next()) { // 실행결과가 있을 시
				b = new Board(rset.getInt("BNO")
							, rset.getString("TITLE")
							, rset.getString("CONTENT")
							, rset.getDate("CREATE_DATE")
							, rset.getString("WRITER")
							, rset.getString("DELETE_YN"));
			}	
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			// 7. 자원 반납
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		// 8. 결과값 반환
		return b;
	}
	
	public ArrayList<Board> selectTitle(Connection conn, String title){
		
		// 0) 변수 지정
		ArrayList<Board> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		// SELECT문 작성
		String sql = "SELECT BNO, TITLE, CONTENT, CREATE_DATE, WRITER, DELETE_YN "
				+ "FROM BOARD "
				+ "WHERE TITLE LIKE ?";
		
		try {
			// 3-1) pstmt 객체 생성
			pstmt = conn.prepareStatement(sql);
			
			// 3-2) 미완성된 쿼리문일 경우, 값 채워넣기
			pstmt.setString(1, "%" + title + "%");
			
			// 4,5) rset에 pstmt의 실행결과를 대입하기
			rset = pstmt.executeQuery();
			
			// 6-1) rset의 실행결과를 VO객체에 담기
			while(rset.next()) {
				
				Board b = new Board();
				list.add(new Board(rset.getInt("BNO")
							, rset.getString("TITLE")
							, rset.getString("CONTENT")
							, rset.getDate("CREATE_DATE")
							, rset.getString("WRITER")
							, rset.getString("DELETE_YN")
							));
				
			}
			
			
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			// 7) 자원 반납
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		// 8) 결과값 반환
		return list;
	}
}
