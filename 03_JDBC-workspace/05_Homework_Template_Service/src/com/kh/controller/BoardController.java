package com.kh.controller;

import java.util.ArrayList;

import com.kh.model.dao.BoardDao;
import com.kh.model.service.BoardService;
import com.kh.model.vo.Board;
import com.kh.view.BoardView;

public class BoardController {
	
	public void insertBoard(String title, String content, String writer) {
		// 1) VO 가공 
		Board b = new Board(title, content, writer);
		
		// 2) Service의 메소드 호출
		int result = new BoardService().insertBoard(b);
		
		// 3) 반환값으로 성공 / 실패여부를 view 메소드로 호출
		if(result > 0) {
			new BoardView().displaySuccess("게시글 작성 성공");
		}else {
			new BoardView().displayFail("게시글 작성 실패");
		}
	}
	
	public void selectAll() {
		// 1) VO가공 => 매개변수가 없으니 생략
		// 2) Service의 메소드 호출
		ArrayList<Board> list = new BoardService().selectAll();
		
		// 3) Service로부터 받은 리턴값이 있는지 없는지 확인
		if(list.isEmpty()) {
			new BoardView().displayNoData("게시글이 존재하지 않습니다.");

		}else {
			new BoardView().displayList(list);

		}
	}
	
	public void selectID(String writer) {
		// 1) VO객체로 가공 => 매개변수가 1개뿐이니 생략
		// 2) Service의 메소드 호출
		Board b = new BoardService().selectID(writer);
		
		// 3) Service로부터 받은 반환값의 결과가 있는지 없는지 확인
		if(b != null) {
			new BoardView().displayOne(b);
		}else {
			new BoardView().displayNoData("해당 아이디로 작성한 게시글이 존재하지 않습니다.");
		}
		
	}
	
	public void selectTitle(String title) {
		// 1) VO가공 => 매개변수가 1개라 생략
		// 2) Service 메소드 호출
		ArrayList<Board> list = new BoardService().selectTitle(title);
		
		// Service로부터 받은 반환값이 있는지 없는지에 따라 뷰 호출
		if(list.isEmpty()) {
			new BoardView().displayFail("조건에 해당하는 게시물이 없습니다.");
		}else {
			new BoardView().displayList(list);
		}
	}
	
	
	
	
	
	
	
	
	
}
