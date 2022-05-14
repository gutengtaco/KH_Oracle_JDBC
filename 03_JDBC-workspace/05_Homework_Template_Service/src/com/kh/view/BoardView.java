package com.kh.view;

import java.util.ArrayList;
import java.util.Scanner;

import com.kh.controller.BoardController;
import com.kh.model.vo.Board;

public class BoardView {
	
	private Scanner sc = new Scanner(System.in);
	private BoardController bc = new BoardController();
	
	
	
	public void mainMenu() {
		while(true) {
			System.out.println();
			System.out.println("==========게시글 관리 프로그램==========");
			System.out.println("1. 게시글 추가");
			System.out.println("2. 게시글 전체 조회");
			System.out.println("3. 게시글 아이디로 조회");
			System.out.println("4. 게시글 제목(키워드) 조회");
			System.out.println("5. 게시글 제목 변경");
			System.out.println("6. 게시글 내용 변경");
			System.out.println("7. 게시글 삭제");
			System.out.println("0. 프로그램 종료");
			System.out.println("-------------------------------------------");
			System.out.print("이용할 메뉴 선택 : ");
			int menu = sc.nextInt();
			sc.nextLine();
			
				switch(menu) {
				case 1 : insertBoard(); break;
				case 2 : selectAll(); break;
				case 3 : selectID(); break;
				case 4 : selectTitle(); break;
				case 5 : break;
				case 6 : break;
				case 7 : break;
				case 0 : System.out.println("프로그램을 종료합니다."); return;
				default : System.out.println("번호를 잘못 입력하였습니다. 다시 입력해주세요.");
				}
		}
	}
	
	// 1. 게시글 추가
	public void insertBoard() {
		System.out.println("========== 게시글 추가 ==========");
		
		// 입력할 데이터 :title, content
		System.out.print("제목 입력 : ");
		String title = sc.nextLine();
		
		System.out.print("내용 입력 : ");
		String content = sc.nextLine();
		
		System.out.print("작성자 입력 : ");
		String writer = sc.nextLine();
		bc.insertBoard(title, content,writer);
	}
	
	// 2. 게시글 전체 조회
	public void selectAll() {
		System.out.println("========= 게시글 전체 조회 ==========");
		bc.selectAll();
	}
	
	// 3. 게시글 아이디로 조회
	public void selectID() {
		System.out.println("========= 게시글 아이디로 조회 ==========");
		System.out.print("조회할 아이디 : ");
		String writer = sc.nextLine();
		
		bc.selectID(writer);
	}
	
	// 4. 게시글 제목으로 조회
	public void selectTitle() {
		System.out.println("========== 게시글 제목으로 조회 ==========");
		System.out.print("조회할 제목 : ");
		String title = sc.nextLine();
		
		bc.selectTitle(title);
	}
	
	
	
	
	
	// 성공, 실패시 출력 화면
	public void displaySuccess(String message) {
		System.out.println(message);
	}
	public void displayFail(String message) {
		System.out.println(message);
	}
	
	
	public void displayNoData(String message) {
		System.out.println(message);
	}
	public void displayList(ArrayList<Board> list) {
		System.out.println("현재"+ list.size() + "개의 게시글이 존재합니다.");
		
		for(int i=0; i<list.size(); i++) {
			System.out.println(list.get(i));
		}
	}
	public void displayOne(Board b) {
		System.out.println("조회결과가 다음과 같습니다.");
		System.out.println(b);
	}
}
