package com.kh.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.kh.common.JDBCTemplate;
import com.kh.model.dao.ProductDao;
import com.kh.model.vo.Product;

public class ProductService {
	
	// 5. Service단 꾸미기
	// 미리 작성한 JDBCTemplate를 호출하여 Connection류 사용하기
	public ArrayList<Product> selectByPrice(int minPrice, int maxPrice){
		// 5-1. Connection 객체 생성
		Connection conn = JDBCTemplate.getConnection();
		
		// 5-2. DAO의 메소드 호출
		// Connection객체와 매개변수를 내보냄
		ArrayList<Product> list = new ProductDao().selectByPrice(conn,minPrice,maxPrice);
		
		// 5-3. 트랜잭션 처리 => SELECT문은 생략
		
		// 5-4. Connection 자원 반납
		JDBCTemplate.close(conn);
		
		// 5-5. 결과반환
		return list;
		
		
	}
}
