package com.kh.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.kh.common.JDBCTemplate;
import com.kh.model.vo.Product;

public class ProductDao {
	// 6. DAO단 꾸미기
	
	// 6-1. Properties객체의 전역변수화
	private Properties prop = new Properties();
	
	// 6-2. 기본생성자 선언 시, xml파일 읽어들이기
	public ProductDao() {
		try {
			prop.loadFromXML(new FileInputStream("resources/query.xml"));
		}catch(IOException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Product> selectByPrice(Connection conn, int minPrice, int maxPrice){
		// 6-3. 필요한 변수 세팅
		// ArrayList, pstmt, rset
		ArrayList <Product> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		// 6-4. SQL문 작성
		String sql = prop.getProperty("selectByPrice");
		
		
		try {
			// 6-5. pstmt 객체 생성
			pstmt=conn.prepareStatement(sql);
			
			// 6-6. 미완성된 SQL문인 경우, 값 채워주기
			pstmt.setInt(1, minPrice);
			pstmt.setInt(2, maxPrice);
			
			// 6-7. SQL문을 전달 후, 실행결과를 받기
			rset = pstmt.executeQuery();
			
			// 6-8. 현재 조회결과가 담긴 rset의 내용물을 VO객체에 담기
			// 조회결과가 다수일 수 있기 때문에, 반복문을 돌림.

			while(rset.next()) {
				// Product 객체 생성
				Product p = new Product();
				
				// Product객체의 필드값을 초기화하여 담기
				// p.setXXX() / rset.getXXX() / list.add(XXX)
				list.add(new Product(rset.getString("PRODUCT_ID"),
									 rset.getString("PRODUCT_NAME"),
									 rset.getInt("PRICE"),
									 rset.getString("DESCRIPTION"),
									 rset.getInt("STOCK")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 6-9. 자원 반납
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		// 6-10. 결과값 반환
		return list;
	}
	
	
}
