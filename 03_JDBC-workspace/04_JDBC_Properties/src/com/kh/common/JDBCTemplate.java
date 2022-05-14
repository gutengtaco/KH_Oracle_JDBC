package com.kh.common;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

public class JDBCTemplate {

	// JDBC 과정 중, 반복적으로 쓰이는 구문들을 각각의 메소드로 정의해둘 곳
	// "재사용할 목적"으로 공통 템플릿 작업 진행
	
	// 이 클래스에서의 모든 메소드들은 전부 다 Static메소드로 만들 것(재사용의 개념)
	// 싱글톤 패턴 : 메모리 영역에 단 한번만 올라간 것을 재사용하는 개념.
	
	// 1. DB와 접속된 Connection 객체를 생성해서, 그 Connection 객체를 반환해주는 메소드를 생성
	public static Connection /*<= 반환형*/ getConnection() {
		/*
		 * 기존의 방식 : JDBC Driver 구문, 접속할 DB의 연결정보(url, 계정명, 비밀번호)들을
		 * 				 JAVA 소스코드 내에 직접 명시적으로 작성. 
		 * 				 이를 '정적코딩'이라고 함.
		 * 
		 * 문제점 : DBMS의 종류나, 접속할 DB의 url 또는 계정명, 비밀번호가 변경될 경우
		 *          JAVA 소스코드를 다시 수정해주어야 함.
		 *          JAVA 소스코드를 수정된 상태에서, 변경된 설정사항들이 적용되려면 프로그램을 재구동 해야함.
		 *          프로그램 사용 중, 비정상적으로 종료되었다가 다시 구동될 수 있는 여지가 발생함.
		 *          유지 보수시 불편함.
		 *
		 * 해결방식 : DB와 관련된 정보들을 별도로 관리하는 외부파일(.properties)로 만들어서 관리
		 *      	  외부파일로 만들어서 읽어들여서 반영시킬 것
		 *            이를 '동적코딩'이라고 함.
		 */
		
		Connection conn = null;
		
		Properties prop = new Properties();
		
		try {
			prop.load(new FileInputStream("resources/driver.properties"));
			
			// 1) JDBC Driver 등록
			Class.forName(prop.getProperty("driver"));
			
			// 2) Connection 객체 생성
			conn = DriverManager.getConnection(prop.getProperty("url"),
											   prop.getProperty("username"),
											   prop.getProperty("password"));
			
		} catch (IOException e) {
			e.printStackTrace();
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
