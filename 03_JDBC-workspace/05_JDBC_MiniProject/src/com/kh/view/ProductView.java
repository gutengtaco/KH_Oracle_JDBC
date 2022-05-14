package com.kh.view;

import java.util.ArrayList;
import java.util.Scanner;

import com.kh.controller.ProductController;
import com.kh.model.vo.Product;

public class ProductView {
	// 2. View단 꾸미기
	
	// 2-1. Scanner와 Controller단 전역변수화 
	private Scanner sc = new Scanner(System.in); 
	private ProductController pc = new ProductController();
	
	public void mainMenu() {
		// 2-2 while문으로 메뉴 꾸미기	
		while(true) {
			System.out.println("===========제품관리 프로그램==========");
			System.out.println("1. 상품 전체 조회하기");
			System.out.println("2. 상품 추가하기");
			System.out.println("3. 상품명 검색하기[이름]");
			System.out.println("4. 상품 정보 수정하기");
			System.out.println("5. 상품 삭제하기");
			System.out.println("6. 상품명 검색하기[가격]");
			System.out.println("0. 프로그램 종료");
			System.out.println("-------------------------------------");
			System.out.print("메뉴 번호 : ");
			int menu = sc.nextInt();
			sc.nextLine();
			
			// 2-3 switch문으로 메뉴 선택하기
			switch(menu) {
			case 1 : break;
			case 2 : break;
			case 3 : break;
			case 4 : break;
			case 5 : break;
			case 6 : selectByPrice(); break;
			case 0 : System.out.println("프로그램을 종료합니다");
			return;
			default : System.out.println("잘못 입력하였습니다. 다시 입력해주세요.");
			}
		}
		
	}
	// 2-4 메뉴에 맞는 메소드 만들기
	// 상품명 검색하기(가격)
	public void selectByPrice() {
		System.out.println("상품명 검색하기(가격)");
		System.out.print("희망하는 최저가 : ");
		int minPrice = sc.nextInt();
		sc.nextLine();
		System.out.print("희망하는 최고가 : ");
		int maxPrice = sc.nextInt();
		sc.nextLine();
		if(maxPrice > minPrice) {
			pc.selectByPrice(minPrice, maxPrice);
		}else {
			pc.selectByPrice(maxPrice, minPrice);
		}
	}
	// 2-5 성공/ 실패 출력하기
	public void displaySuccess(ArrayList<Product> list) {
		System.out.println("조회된 결과는 "+ list.size() + "건 입니다.");
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	
	public void displayFail(String message) {
		System.out.println(message);
	}
}
