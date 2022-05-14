package com.kh.common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCTemplate {

	// JDBC 과정 중, 반복적으로 쓰이는 구문들을 각각의 메소드로 정의해둘 곳
	// "재사용할 목적"으로 공통 템플릿 작업 진행
	
	// 이 클래스에서의 모든 메소드들은 전부 다 Static메소드로 만들 것(재사용의 개념)
	// 싱글톤 패턴 : 메모리 영역에 단 한번만 올라간 것을 재사용하는 개념.
	
	// 1. DB와 접속된 Connection 객체를 생성해서, 그 Connection 객체를 반환해주는 메소드를 생성
	public static Connection /*<= 반환형*/ getConnection() {
		
		Connection conn = null;
		
		try {
			// 1) JDBC Driver 등록(DriverManager)
			Class.forName("oracle.jdbc.driver.OracleDriver");
			
			// 2) Connection 객체 생성
			conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	
	// 2. 전달받은 JDBC용 객체를 자원반납 해주는 메소드를 생성
	// 2-1) Connection 객체를 매개변수로 전달받아서 반납해주는 메소드
	public static void close(Connection conn) { 
		
		try {
			
			// 애초에 NullPointerException을 방지하기 위해 if문 작성
			if(conn != null && !conn.isClosed()) { // conn이 null이 아니고, conn이 닫혀있지 않다면
				
				conn.close(); // 자원반납을 하고, 통로를 닫아줌.
					
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	// 2-2) (Prepared)Statement 객체를 매개변수로 전달받아서 반납해주는 메소드
	// 다형성으로 인해 PreparedStatement(자식) 객체 또한 매개변수로 전달 가능
	// 같은 메소드 이름에 매개변수의 자료형을 달리하여 오버로딩 적용
	public static void close(Statement stmt) {
		
		try {
			
			// 애초에 NullPointerException을 방지하기 위해 if문 작성
			if(stmt !=null && !stmt.isClosed()) { // stmt가 null이 아니고, stmt가 닫혀있지 않다면
				
				stmt.close(); // 자원반납을 하고, 통로를 닫아줌.
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 2-3) ResultSet 객체를 매개변수로 전달받아서 반납해주는 메소드
	public static void close(ResultSet rset) {
		
		try {
			
			if(rset != null && !rset.isClosed()) {
				
				rset.close();
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	// 3) 전달받은 Connection 객체를 가지고 트랜잭션 처리를 해주는 메소드
	// 3-1) 매개변수로 전달받은 Connection 객체를 가지고 Commit 해주는 메소드
	public static void commit(Connection conn) {
		
		try {
			if(conn != null && !conn.isClosed()) {
				
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
	}
	
	// 3-2) 매개변수로 전달받은 Connection 객체를 가지고 Rollback 해주는 메소드
	public static void rollback(Connection conn) {
		
		try {
			if(conn != null && !conn.isClosed()) {
				conn.rollback();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
}
