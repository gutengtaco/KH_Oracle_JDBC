package com.kh.model.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import com.kh.model.vo.Member;

//	Dao(Date Access Object) 
//  Controller로부터 전달받은 요청 기능을 수행하기 위해서 
//	DB에 직접적으로 접근한 후, 해당 SQL문을 전달 및 실행하고, 결과를 받아내는 역할
//  => 실질적으로 JDBC 코드를 작성할 것임.
//	추가적으로 결과값을 가공하거나, 성공/실패 여부에 따라 트랜잭션 처리
//  결과를 Controller로 리턴해줌.
public class MemberDao {
		/*
		 * JDBC용 객체
		 * Connection : DB에 연결정보(접속정보)를 담고 있는 객체
		 * (Prepared)Statement : 해당 DB에 SQL문을 전달하고, 실행한 후 결과를 받아내는 객체 
		 * - ResultSet : 만일 내가 실행한 SQL문이 SELECT문일 경우, 조회된 결과물이 담겨있는 객체
		 * 
		 * JDBC처리 순서
		 * 1) JDBC Driver 등록 : 해당 DBMS가 제공하는 클래스를 등록(DriverManager) => 연결통로 생성
		 * 2) Connection 객체 생성 : 접속하고자 하는 DB정보를 입력해서 DB에 접속하면서 생성
		 * 3) Statement 객체 생성 : Connection객체를 통해서 생성
		 * 4) SQL문을 전달하면서 실행 : Statement 객체를 이용해서 SQL문을 실행
		 * 		> SELECT : executeQuery() 메소드를 호출하여 실행
		 * 		> INSERT, UPDATE, DELETE : executeUpdate() 메소드를 호출하여 실행
		 * 5) 결과 받기
		 * 		> SELECT : ResultSet객체로 전달받음(조회된 데이터들이 담겨있음.) 
		 * 		  => 6_1단계로
		 * 		> INSERT, UPDATE, DELETE : int로 받음(처리된 행의 개수가 담겨있음)
		 * 								   1개의 행이 삽입되었습니다. 수정되었습니다. 삭제되었습니다.
		 * 		  => 6_2단계로
		 * 6) 결과에 따른 후처리
		 * 6_1) SELECT : ResultSet에 담겨있는 데이터들을 하나씩 뽑아서 VO객체에 담기(여러명이면 ArrayList활용)
		 * 6_2) INSERT, UPDATE, DELETE : 트랜젝션 처리(성공이면 COMMIT, 실패면 ROLLBACK)
		 * 
		 * 7) 자원반납(.close() 이용) : 생성된 순서의 역순으로 자원을 반납.
		 * 8) 결과반환(Controller 한테)
		 * 		> SELECT : 6_1에서 만들어진 결과
		 * 		> INSERT, UPDATE, DELETE : int(처리된 행의 개수)
		 */
	
		// 사용자가 회원 추가 요청 시, 입력했던 값들을 가지고 INSERT문을 실행할 메소드 	
		public int insertMember(Member m) { // INSERT문 => 처리된 행의 개수 => 트랜잭션 처리
		// Controller단에서 Member m으로 가공처리해주어서, 9개의 매개변수를 쓸 필요가 없어짐.	
			
			// 0) JDBC 처리를 하기 전에, 우선적으로 필요한 변수들을 먼저 세팅
			int result = 0; // 처리된 결과(처리된 행의 개수)를 담아줄 변수
			Connection conn = null; // 접속할 DB의 연결정보를 담는 변수
			Statement stmt = null; // SQL문 실행 후 결과를 받기 위한 변수
			
			// 실행할 SQL문(완성된 형태로 String으로 정의해둘 것) => 반드시 세미콜론(;)은 떼고 넣어줌.
			// INSERT INTO MEMBER
			// VALUES(SEQ_USERNO.NEXTVAL,'아아디', '비밀번호', '이름', '성별', 
			// 나이, '이메일', '휴대폰', '주소', '취미', DEFAULT 또는 SYSDATE  );
			
			// 쌍따옴표, 홑따옴표 방식은 "'" +getter메소드+ "'," 형식으로 해줌.
			// 쌍따옴표로 홑따옴표와 콜론을 감싸줌.
			String sql = "INSERT INTO MEMBER "
					+ "VALUES(SEQ_USERNO.NEXTVAL, "
							+ "'"+ m.getUserId() + "', "
							+ "'"+ m.getUserPwd()+ "', "
							+ "'"+ m.getUserName()+ "', "
							+ "'"+ m.getGender()+ "', "
							+ m.getAge()+ ", "
							+ "'"+ m.getEmail()+ "', "
							+ "'"+ m.getPhone()+ "', "
							+ "'"+ m.getAddress()+ "', "
							+ "'"+ m.getHobby()+ "', "
							+ "DEFAULT)";
						// [오류] sequence does not exist
						// 시퀀스로 지정한 SEQ_USERNO 철자에 오타가 있을 경우 발생
						
						// [오류] not enough values
						// 위의 sql에 충분한 values를 작성하지 않아 생기는 오류임.
			
						// [오류] column...
						// 해당 sql에서 오류가 발생했을 시 나타나는 오류임.
						
						// [오류] invalid user.column ...
						// INSERT INTO MEMBER하고 띄어쓰기를 해주어야 함.
						// 띄어쓰기를 하지 않으면, INSERT INTO MEMBERVALUE가 되서
						// 테이블명이 MEMBERVALUES로 잡혀버림.
				
			// System.out.println(sql);
			
			try {
				
				// 1) JDBC Driver 등록(DriverManager)
				Class.forName("oracle.jdbc.driver.OracleDriver");
				// [오류] ClassNotFoundException
				// ojdbc6.jar 파일을 누락하거나(Properties에 라이브러리 등록)
				// 오타로 작성할 시 발생.
				
				// 2) Connection 객체 생성(DB와 연결 -> url, 계정명, 비밀번호)
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe", "JDBC", "JDBC"); // 반환형 : connection
				// Oracle에서 사용하는 포트번호가 1521
				
				
				// 3) Statement 객체 생성(Connection 객체를 이용해서 생성)
				stmt = conn.createStatement(); // 반환형 : statement
				
				// 4,5) DB에 완성된 SQL문을 전달하면서, 실행 후 결과를 받기
				result = stmt.executeUpdate(sql); // INSERT의 반환형 : int(처리된 행의 개수)
				
				// 6_2) 트랜잭션 처리
				if(result > 0) { // 실행 후 결과가 성공일 경우.
					
					conn.commit(); // COMMIT 처리
					
				}else { // 실행 후 결과가 실패인 경우
					
					conn.rollback(); // ROLLBACK 처리
				}
				
				
			}catch(ClassNotFoundException e){
				e.printStackTrace();
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
				// 7) 다 쓴 JDBC용 자원반납 => 생성된 순서의 역순
				// 위에서 Connection, Statement 객체를 만들었음.
				// close()도 throws SQLEXCEPTION 처리해달라고 되어 있음.
				try {
					stmt.close();
					conn.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
				
			}
			
			// 8) 결과값 리턴
			return result; // 처리된 행의 개수
		}
		
		// 사용자가 '회원 전체 조회' 요청 시, SELECT문을 실행할 메소드
		public ArrayList<Member> selectAll() { // SELECT => ResultSet 객체(여러행, ArrayList에 담기)
			
			// 0) JDBC처리 이전, 필요한 변수를 정의
			// 조회된 결과를 뽑아서 담아줄 ArrayList 생성(텅 빈 리스트 형태로)
			ArrayList<Member> list = new ArrayList<>();
			// java.sql패키지에서 제공
			Connection conn = null; // 접속할 DB의 연결정보를 담는 변수
			Statement stmt = null; // SQL문 실행 후 결과를 받기 위한 변수
			ResultSet rset = null; // SELECT문이 실행된 조회결과값들이 처음에 실질적으로 담길 변수
			// 실행할 SQL문(완성된 형태로 String으로 정의, 세미콜론(;)은 제외)
			// SELECT * FROM MEMBER
			String sql = "SELECT * FROM MEMBER";
			
			try {
				
				// 1) JDBC Driver 등록(DriverManager)
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				// 2) Connection 객체 생성
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
				
				// 3) Statement 객체 생성
				stmt = conn.createStatement();
				
				// 4,5) SQL문(SELECT)을 전달해서 실행 후 결과 받기
				rset = stmt.executeQuery(sql);
				
				// 6_1) 현재 조회결과가 담긴 ResultSet에서 한명씩 뽑아서 VO객체에 담기
				// '커서'라는 것을 통해, 한행 한행씩 아래로 옮겨서 현재 행의 위치를 나타냄.
				// 이때, 커서는 rset.next()를 통해 다음 줄로 넘김.
				// rset.next() : 커서를 한행 밑으로 움직여주고 해당 행이 존재할 경우 true, 
				//														 존재하지 않으면 false
				while(rset.next()) { // 더이상 뽑아낼 게 없을 때까지 반복을 돌림.
					
					// 모든 컬럼에 대해서 값을 일일이 다 뽑아야 함.
					// Member 테이블에는 11개의 컬럼이 있음.
					
					// 현재 rset의 커서가 가리키고 있는 해당 행의 데이터를
					// 한 행씩 뽑아서 Member 객체에 담음.
					Member m = new Member();
					
					// rset으로부터 어떤 컬럼에 해당하는 값을 뽑을건지 제시
					// rset.getInt(컬럼명 또는 컬럼의 순번) : int형 값으로 해당 컬럼명의 값을 뽑아줌.
					// rset.getString(컬럼명 또는 컬럼의 순번) : String형 값으로 해당 컬럼명의 값을 뽑아줌.
					// rset.getDate(컬럼명 또는 컬럼의 순번) : Date형 값으로 해당 컬럼명의 값을 뽑아줌.
					// => 권장사항 : 웬만하면 컬럼명으로 꼭 쓸것! 컬럼명 작성 시 대문자로 작성(소문자도 가능)
					
					// 뽑자마자 setter메소드로 필드에 값을 담아주기 
					m.setUserNo(rset.getInt("USERNO")); // rset.getInt(1)
					m.setUserId(rset.getString("USERID")); // rset.getString(2)
					m.setUserPwd(rset.getString("USERPWD")); // rset.getString(3)
					m.setUserName(rset.getString("USERNAME"));
					m.setGender(rset.getString("GENDER"));
					m.setAge(rset.getInt("AGE"));
					m.setEmail(rset.getString("EMAIL"));
					m.setPhone(rset.getString("PHONE"));
					m.setAddress(rset.getString("ADDRESS"));
					m.setHobby(rset.getString("HOBBY"));
					m.setEnrollDate(rset.getDate("ENROLLDATE"));
					// 한 행에 대한 모든 데이터값들을
					// 하나의 MEMBER객체에 옮겨담기 끝!
					
					// 리스트에 해당 MEMBER 객체를 ADD
					list.add(m);
					
				}
				
			}catch(ClassNotFoundException e){
				e.printStackTrace();
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				// 7) 자원 반납(생성된 순서의 역순)
				// SQLException 예외처리 해줌.
				try {
					rset.close();
					stmt.close();
					conn.close();
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
			
			return list;
		}
		
		// 회원 아이디로 회원검색 요청시, SELECT문을 실행할 매소드
		public Member selectByUserId(String userId) { // SELECT문 => ResultSet 객체
			// 회원아이디는 UNIQUE제약조건이 걸려있어서 검색에 성공하더라도
			// 검색결과가 1개밖에 안나와서 자료형을 Member로 반환해줌.
			// 만약, 결과가 여러개일 경우는 ArrayList형으로 반환해줌.
			
			
			// 0) 필요한 변수 세팅
			// 조회된 한 회원에 대한 정보를 담을 변수
			Member m = null;
			
			Connection conn = null; // 접속할 DB의 연결정보를 담는 변수
			Statement stmt = null; // SQL문 실행 후 결과를 받기 위한 변수
			ResultSet rset = null; // SELECT문이 실행된 조회결과들이 처음에 실질적으로 담길 변수
			
			// 실행할 SQL문(완성된 형태, 세미콜론X) 
			String sql = "SELECT * FROM MEMBER WHERE USERID = '" + userId + "'";
			
			try {
				// 1) JDBC Driver 등록(DriverManager)
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				// 2) Connection 객체 생성
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
				
				// 3) Statement 객체 생성
				stmt = conn.createStatement();
				
				// 4,5) SQL문(SELECT)을 전달해서 실행 후 결과를 받기
				rset = stmt.executeQuery(sql);
				
				// 6-1) 현재, 조회결과가 담긴 ResultSet에서 한행씩 뽑아서 VO객체에 담기
				// 만약, next()실행 후, 뽑아낼 게 있다면 true반환 / 없으면 false 반환
				// 어차피 한 행의 결과만 뽑기 때문에, while문을 쓰지 않음.
				if(rset.next() == true) { // 뽑아낼 행이 있음.
					
					// 조회된 한 행에 대한 데이터값을 뽑아서
					// 하나의 Member객체에 담기
					m = new Member(rset.getInt("USERNO"),
								   rset.getString("USERID"),
								   rset.getString("USERPWD"),
								   rset.getString("USERNAME"),
								   rset.getString("GENDER"),
								   rset.getInt("AGE"),
								   rset.getString("EMAIL"),
								   rset.getString("PHONE"),
								   rset.getString("ADDRESS"),
								   rset.getString("HOBBY"),
								   rset.getDate("ENROLLDATE")
							);
				}else { // 뽑아낼 행이 없음.
				}
			}catch (ClassNotFoundException e) {
				e.printStackTrace();
				
			}catch (SQLException e) {
				e.printStackTrace();
				
			}finally {
				// 7) 다 쓴 JDBC용 객체 반납(생성된 순서의 역순)
				try{
					
					rset.close();
					stmt.close();
					conn.close();
					
				}catch(SQLException e){
					e.printStackTrace();
				}
			}
			// 8) 결과 반환
			return m; // 조회된 1명의 회원 정보
		}
		
		
		// 회원 이름으로 회원검색 요청시, SELECT문을 실행할 매소드
		public ArrayList<Member> selectByUserName(String keyword) { //SELECT문 => ResultSet 객체
			
			// 0) 필요한 변수 세팅
			// 본래는 UNIQUE제약조건이 없기에, 다수의 검색결과가 나올 수 있어
			// ArrayList에 담아줌
			ArrayList<Member> list = new ArrayList<>();
			
			Connection conn = null;
			Statement stmt = null; 
			ResultSet rset = null;
			
			// 실행할 SELECT문(완성된 형태, 세미콜론X)
			String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE '%" +keyword +"%'";
			
			try {
				// 1) JDBC Driver 등록(DriverMamager)
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				// 2) Connection 객체 생성
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
				
				// 3) Statement 객체 생성
				stmt = conn.createStatement();
				
				// 4,5) SQL문(SELECT)을 전달해서 실행 후 결과를 받기
				rset = stmt.executeQuery(sql);
				
			// 6-1) SELECT문(sql)을 실행한 결과
			// 조회결과가 담긴 rset에서 한행씩 뽑아서 VO객체에 담기
			// 우선적으로, 커서를 한 칸 내린 후, 뽑을 값이 있는지를 검사 => rset.next()
			// 여러 행이 조회될 가능성이 높은 경우, 반복적으로 검사가 진행되어야 함.	
			while(rset.next()) {
				
				// rset에 있는 행의 결과를 담을 Member 객체 생성
				// Member m = new Member();
					
					/*
					// rset에 있는 한 행의 컬럼값을 Member에 담기
					m.setUserNo(rset.getInt("USERNO")); 
					m.setUserId(rset.getString("USERID")); 
					m.setUserPwd(rset.getString("USERPWD")); 
					m.setUserName(rset.getString("USERNAME"));
					m.setGender(rset.getString("GENDER"));
					m.setAge(rset.getInt("AGE"));
					m.setEmail(rset.getString("EMAIL"));
					m.setPhone(rset.getString("PHONE"));
					m.setAddress(rset.getString("ADDRESS"));
					m.setHobby(rset.getString("HOBBY"));
					m.setEnrollDate(rset.getDate("ENROLLDATE"));
					
					// Member객체에 담은 필드값을 list에 추가
					list.add(m);
					*/
					list.add(new Member(rset.getInt("USERNO"),
							   			rset.getString("USERID"),
							   			rset.getString("USERPWD"),
							   			rset.getString("USERNAME"),
							   			rset.getString("GENDER"),
							   			rset.getInt("AGE"),
							   			rset.getString("EMAIL"),
							   			rset.getString("PHONE"),
							   			rset.getString("ADDRESS"),
							   			rset.getString("HOBBY"),
							   			rset.getDate("ENROLLDATE")
							   			));
			}
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 7) 다 쓴 JDBC용 자원반납 => 생성된 순서의 역순
				try {
					rset.close();
					stmt.close();
					conn.close();
				}catch(SQLException e) {
					e.printStackTrace();
				}
			}
			
			// 8) 결과값을 반환하기
			return list;
		}
		
		// 회원 변경 요청이 들어왔을 때, UPDATE구문을 실행할 메소드
		public int updateMember(Member m) { // UPDATE 구문 => int형(처리된 행의 개수) => 트랜젝션 처리
			// 0) 필요한 변수 설정
			int result = 0;
			Connection conn = null;
			Statement stmt = null;
			
			// 실행할 sql문(비밀번호, 이메일, 전화번호, 주소)
			/*
			 * UPDATE MEMBER
			 * 	  SET USERPWD = 'newPwd' 
			 * 		, EMAIL = 'newEmail'
			 * 		, PHONE = 'newPhone'
			 * 		, ADDRESS = 'newAddress'
			 *  WHERE USERID = 'USERID'
			 */
			String sql = "UPDATE MEMBER "
					      + "SET USERPWD = '" + m.getUserPwd() + "'"
					      + "  , EMAIL = '" + m.getEmail() + "'"
					      + "  , PHONE = '" + m.getPhone() + "'"
					      + "  , ADDRESS = '" + m.getAddress() + "' "
					    + "WHERE USERID = '" + m.getUserId() + "'";
			// 띄어쓰기 주의!(MEMBER 뒤, WHERE앞에 띄어쓰기 해줌)
			
			try {
				
				// 1) JDBC Driver 등록
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				// 2) Connection 객체  생성 
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
				
				// 3) Statement 객체 생성
				stmt = conn.createStatement();
				
				// 4,5) SQL문을 실행 후 결과를 반환 
				result = stmt.executeUpdate(sql);
				
				// 6-2) 트랜젝션 처리
				if(result > 0) { // 성공(COMMIT)
					conn.commit();
				}else { // 실패(ROLLBACK)
					conn.rollback();
				}
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 7) 자원반납
				try {
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				
			}
			// 8) 결과 반환
			return result; // UPDATE된 행의 개수
		}
		
		public int deleteMember(String userId) { // delete => int형(처리된 행의 개수) => 트랜젝션 처리
			// 0) 필요한 변수 설정
			int result = 0;
			Connection conn = null;
			Statement stmt = null;
			
			// SQL문 설정
			String sql = "DELETE FROM MEMBER "
					+ "WHERE USERID = '" + userId + "'";
					
			try {
				// 1) jdbc driver 생성
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				// 2) Connection 객체 생성
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
				
				// 3) Statement 
				stmt = conn.createStatement();
				
				// 4,5) SQL문 결과 담기(처리된 행의 개수)
				result = stmt.executeUpdate(sql);
				
				// 6-2) 트랜잭션 처리
				if(result > 0) { // 성공
					conn.commit();
				}else{ // 실패
					conn.rollback();
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				try {
					// 7) 자원 반납
					stmt.close();
					conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			// 8) 결과값 반환
			return result;
	
		}
}
