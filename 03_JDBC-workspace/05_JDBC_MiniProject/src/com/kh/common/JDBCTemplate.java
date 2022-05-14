package com.kh.common;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

// 4.  JDBCTemplate 꾸미기
// Connection, close(), Commit/Rollback을 사용하기 위해 미리 정의해놓기
// 객체 생성없이 사용하기 위해 Static을 사용
public class JDBCTemplate {
	
	public static Connection getConnection() {
		// 4-1. Connection과 Properties 선언하기
		Connection conn = null;
		Properties prop = new Properties();
		
		try {
			// 4-2. .properties파일을 읽어들이기
			prop.load(new FileInputStream("resources/driver.properties"));
			
			// 4-3. JDBC Driver 생성
			Class.forName(prop.getProperty("driver"));
			
			// 4-4 Connection 객체 생성
			conn = DriverManager.getConnection(prop.getProperty("url"),
											   prop.getProperty("username"),
											   prop.getProperty("password"));
		}catch(IOException e){
			e.printStackTrace();
		}catch(ClassNotFoundException e){
			e.printStackTrace();
		}catch(SQLException e) {
			e.printStackTrace();
		}
		
		return conn;
	}
	// 4-5. 자원반납하기
	// Connection 객체 자원반납
	public static void close(Connection conn) {
		try {
			if(conn!=null && !conn.isClosed()) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// (Prepared)Statement 객체 자원반납
	public static void close(Statement stmt) {
		try {
			if(stmt!=null && !stmt.isClosed()) {
				stmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// ResultSet 객체 자원반납
	public static void close(ResultSet rset) {
		try {
			if(rset!=null && !rset.isClosed()) {
				rset.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 4-6. Connection 객체를 트랜잭션 처리
	// commit
	public static void commit(Connection conn) {
		try {
			if(conn != null && !conn.isClosed()) {
				conn.commit();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	// rollback
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
