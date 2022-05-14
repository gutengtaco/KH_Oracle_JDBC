package com.kh.controller;

import java.util.ArrayList;

import com.kh.model.service.ProductService;
import com.kh.model.vo.Product;
import com.kh.view.ProductView;

public class ProductController {
	// 3. Controller단 꾸미기
	
	// 사용자의 "상품명 검색하기(가격)" 요청을 처리해주는 메소드
	public void selectByPrice(int minPrice, int maxPrice){
		// 3-1. VO객체로 가공 => 매개변수가 2개뿐이니 생략
		// 3-2. Service의 메소드 호출
		// 여러 개의 결과가 나올 수 있으므로 ArrayList사용
		ArrayList<Product> list = new ProductService().selectByPrice(minPrice,maxPrice);
		
		// 3-3. 성공 / 실패 확인
		if(list.isEmpty()) {
			new ProductView().displayFail("결과가 존재하지 않습니다.");
		}else {
			new ProductView().displaySuccess(list);
		}
	}	
}
