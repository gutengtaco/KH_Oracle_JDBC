package com.kh.controller;

import java.util.ArrayList;

import com.kh.model.dao.MemberDao;
import com.kh.model.vo.Member;
import com.kh.view.MemberView;

// Controller : View를 통해서 요청받은 기능을 처리하는 담당
// 				해당 메소드로 전달된 데이터(매개변수)를 
//				가공처리(VO객체의 각 필드에 변수값들을 담음)한 후, 
//				DAO단에 메소드를 호출할 때 전달.  
//				DAO단으로부터 반환받은 결과(리턴값)에 따라서 사용자가 보게 될 화면을 지정해줌.
//				(View의 응답화면을 결정해주는 역할 => View 응답화면에 해당하는 메소드를 호출)
public class MemberController {
	
	// 사용자의 '회원 추가' 요청을 처리해주는 메소드
	public void insertMember(String userId, String userPwd, String userName,
							 String gender, int age, String email, 
							 String phone, String address, String hobby) {
		// 1) View에서 전달된 데이터들을 Member 객체에 담기(Member의 생성자로 필드값을 초기화)
		// 매개변수 생성자를 이용하거나, 기본생성자로 생성 후 setter메소드 이용
		// 여기서는 매개변수생성자를 model단에 생성 후, 매개변수로 필드를 초기화함.
		Member m = new Member(userId, userPwd, userName, gender, age, email,phone, address, hobby);
		
		// 2) Dao의 메소드 호출(이때, 위에서 가공된 Member객체를 매개변수로 넘김)
		int result = new MemberDao().insertMember(m);
		
		// 3) Dao로부터 반환받은 리턴값이 성공이면 성공, 실패면 실패라는 응답화면 지정
		//    => View의 메소드 호출
		if(result > 0) { // 성공
			
			// 회원 추가 성공을 띄워줄 수 있는 View단으로 메소드 호출
			new MemberView().displaySuccess("회원추가 성공");
			
		}else{ // 실패
			
			// 회원 추가 실패를 띄워줄 수 있는 View단으로  메소드 호출
			new MemberView().displayFail("회원추가 실패");
			
		}
	}
	// 사용자의 '회원 전체 조회' 요청을 처리해주는 메소드
	public void selectAll() {
		// 1) View에서 전달된 데이터가 없으므로 VO객체로 가공할 필요가 없음.
		// 2) DAO의 메소드 호출
		ArrayList<Member> list = new MemberDao().selectAll();
		// 3) DAO로부터 반환받은 리턴값이 있는지, 없는지를 응답화면으로 지정
		if(list.isEmpty()) { // 리턴값이 없음(조회결과 없음)
			
			new MemberView().displayNoData("전체 조회결과가 없습니다.");
			// System.out.println("전체 조회 결과가 없습니다.");
			
		}else { // 리턴값이 있음(조회결과 있음.)
			
			
			new MemberView().displayList(list);
			/*
			for(int i=0; i<list.size(); i++) {
				System.out.println(list.get(i));
			}
			*/
		}
	}
	// 아이디로 검색 요청을 처리해주는 메소드
	public void selectByUserId(String userId) {
		// 1) view에서 전달된 데이터가 하나라서 굳이 가공할 필요 없음.
		Member m = new Member();
		m.setUserId(userId);
		
		// 2) DAO에 메소드 호출
		m = new MemberDao().selectByUserId(userId);
		
		// 3) DAO에서 반환한 결과값이 있는지 없는지 판단 후 View에 메소드 호출
		if(m != null ){
			new MemberView().displayOne(m);
		}else{
			new MemberView().displayNoData(userId+"에 해당하는 검색결과가 없습니다.");
		}
	}
	
	// 이름으로 검색요청을 처리해주는 메소드
	public void selectByUserName(String keyword) {
		// 1) View단에서 전달된 데이터가 1개이고, 필드에 존재하지 않는 데이터라 생략
		Member m = new Member();
		m.setUserName(keyword);
		
		// 2) DAO에 메소드 호출
		ArrayList<Member> list = new MemberDao().selectByUserName(m.getUserName());
		
		// 3) DAO에서 반환된 결과값이 있는지 없는지 판단 후 View에 메소드 호출
		if(list.isEmpty()) {
			new MemberView().displayNoData("해당 성함의 조회결과가 없습니다.");
		}else {
			new MemberView().displayList(list);

		}
	}
	
	// 회원 정보 변경 요청 시 처리해주는 메소드
	public void updateMember(String userId, String newPwd, String newEmail,
							 String newPhone,String newAddress) {
		
		// 1) VO객체로 가공
		Member m = new Member();
		m.setUserId(userId);
		m.setUserPwd(newPwd);
		m.setEmail(newEmail);
		m.setPhone(newPhone);
		m.setAddress(newAddress);
		
		// 2) DAO에 메소드를 호출(가공한 vo를 매개변수로 넘길 예정)
		int result = new MemberDao().updateMember(m); 
		
		// 3) 성공 / 실패 여부에 따라 응답뷰 지정
		if(result > 0) { // 성공
			new MemberView().displaySuccess("회원 정보 변경 성공");
		}else { // 실패
			new MemberView().displayFail("회원 정보 변경 실패");
		}
		
	}
	
	// 회원 탈퇴를 요청 시 처리해주는 메소드
	public void deleteMember(String userId) {
		
		// 1) 데이터가 1개여서 굳이 데이터 가공은 생략
		Member m = new Member();
		m.setUserId(userId);
		
		// 2) DAO에 메소드를 호출
		int result = new MemberDao().deleteMember(m.getUserId());
		
		// 3) 성공 / 실패 
		if(result > 0){
			new MemberView().displaySuccess("해당 회원의 탈퇴가 성공하였습니다.");
		}else {
			new MemberView().displayFail("해당 회원이 존재하지 않습니다.");
		}
	}
	
}


