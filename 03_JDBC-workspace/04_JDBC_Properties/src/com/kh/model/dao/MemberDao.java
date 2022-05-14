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
import com.kh.model.vo.Member;

//	Dao(Date Access Object) 
//  Controller로부터 전달받은 요청 기능을 수행하기 위해서 
//	DB에 직접적으로 접근한 후, 해당 SQL문을 전달 및 실행하고, 결과를 받아내는 역할
//  => 실질적으로 JDBC 코드를 작성할 것임.
//	추가적으로 결과값을 가공하거나, 성공/실패 여부에 따라 트랜잭션 처리
//  결과를 Controller로 리턴해줌.
public class MemberDao {
		/*
		 * 기존의 방식 : DAO클래스에 사용자가 요청할때마다 실행해야 하는 SQL문을
		 *  			 JAVA 소스코드 내에 직접 명시적으로 작성함 
		 *  			 이를 '정적코딩'이라고 함.
		 *  
		 * 문제점 : SQL구문을 수정해야할 경우, JAVA 소스코드를 수정하는 셈
		 *  	  	즉, 수정된 구문을 반영시키고자 할 경우, 프로그램을 재구동 해주어야 함.
		 * 
		 * 해결방식 : SQL문을 별도로 관리하는 외부파일(.xml)로 만들어서
		 *  		  실시간으로 이 파일에 기록된 SQL문들을 동적으로 읽어들여서 실행
		 *  		  이를 '동적코딩'이라고 함.
		 * 
		 * .xml로 만드는 이유는 .properties는 엔터로 줄바꿈이 되지 않기 때문에
		 * 장문의 쿼리문을 쓸 수 있는 .xml파일형식을 사용함.
		 * 
		 */
		
		// new MemberDao().xxx(); 할때마다 MemberDao 객체가 생성되면서 기본생성자가 호출됨.
		
		private Properties prop = new Properties();
		
		public MemberDao() {
			try {
				
				prop.loadFromXML(new FileInputStream("resources/query.xml"));
				
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}
	
	
	
		// 사용자가 회원 추가 요청 시, 입력했던 값들을 가지고 INSERT문을 실행할 메소드 	
		public int insertMember(Connection conn, Member m) { // INSERT문 => 처리된 행의 개수 => 트랜잭션 처리
		// Controller단에서 Member m으로 가공처리해주어서, 9개의 매개변수를 쓸 필요가 없어짐.	
			
			// 0) JDBC 처리를 하기 전에, 우선적으로 필요한 변수들을 먼저 세팅
			int result = 0;
			// Connection conn = null;
			PreparedStatement pstmt = null; 
			
			String sql = prop.getProperty("insertMember");
			/*
			String sql = "INSERT INTO MEMBER "
					+ "VALUES(SEQ_USERNO.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?, ?, DEFAULT)";
			 */
			
			try {
				/*
				1) JDBC Driver 등록(DriverManager)
				Class.forName("oracle.jdbc.driver.OracleDriver");
				
				2) Connection 객체 생성
				conn = DriverManager.getConnection("jdbc:oracle:thin:@localhost:1521:xe","JDBC","JDBC");
				*/
				
				// 3-1) PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql); // 미리 미완성된 sql문을 넘김.
				
				// 3-2) 담은 SQL문이 미완성된 경우, 값 채워넣기
				// pstmt.setString(위치홀더의순번, 메꿀값); : 자동으로 홑따옴표가 들어감
				// pstmt.setInt(위치홀더의순번,메꿀값);
				pstmt.setString(1, m.getUserId());
				pstmt.setString(2, m.getUserPwd());
				pstmt.setString(3, m.getUserName());
				pstmt.setString(4, m.getGender());
				pstmt.setInt(5, m.getAge());
				pstmt.setString(6, m.getEmail());
				pstmt.setString(7, m.getPhone());
				pstmt.setString(8, m.getAddress());
				pstmt.setString(9, m.getHobby());
				
				// PreparedStatement의 장점 : 쿼리 작성하기 편함, 가독성이 좋아짐
				// PreparedStatement의 단점 : 구멍 메우기가 귀찮음, 완성된 SQL문의 형태를 확인 불가
				
				
				// 4,5) DB에 완성된 SQL문을 전달하면서, 실행 후 결과를 받기
				result = pstmt.executeUpdate(); // INSERT의 반환형 : int(처리된 행의 개수)
				// result = stmt.executeUpdate(sql);
				
				// 6) 성공 / 실패 여부에 따라 commit, rollback처리
				/*
				if(result > 0) { // 성공 => COMMIT
					JDBCTemplate.commit(conn);
				}else { // 실패(ROLLBACK)
					JDBCTemplate.rollback(conn);
				}
				*/
				
			}catch (SQLException e) {
				e.printStackTrace();
			}finally {
			
				// 7) pstmt 객체 반납
				JDBCTemplate.close(pstmt);
				// conn.close();
			}
			
			// 8) 결과값 리턴
			return result; // 처리된 행의 개수
		}
		
		// 사용자가 '회원 전체 조회' 요청 시, SELECT문을 실행할 메소드
		public ArrayList<Member> selectAll(Connection conn) { // SELECT => ResultSet 객체(여러행, ArrayList에 담기)
			
			// 0) JDBC처리 이전, 필요한 변수를 정의
			// 조회된 결과를 뽑아서 담아줄 ArrayList 생성(텅 빈 리스트 형태로)
			ArrayList<Member> list = new ArrayList<>();
			PreparedStatement pstmt = null; 
			ResultSet rset = null; 
			
			String sql = prop.getProperty("selectAll");
			/*
			// 실행할 SQL문(완성된 형태로, 세미콜론(;)은 제외)
			String sql = "SELECT * FROM MEMBER";
			*/
			
			try {
				// 3-1)PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				// stmt = conn.createStatement();
				
				// 3-2)미완성된 SQL문 완성 단계
				// => 쿼리문이 완성된 형태로 넘어갔기 때문에, 이 단계는 생략
				
				// 4,5) SQL문(SELECT)을 전달해서 실행 후 결과 받기
				rset = pstmt.executeQuery();
				//rset = stmt.executeQuery(sql);

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
				
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				// 7) 자원 반납(생성된 순서의 역순)
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
				
			}
			
			return list;
		}
		
		// 회원 아이디로 회원검색 요청시, SELECT문을 실행할 매소드
		public Member selectByUserId(Connection conn, String userId) { // SELECT문 => ResultSet 객체
			// 회원아이디는 UNIQUE제약조건이 걸려있어서 검색에 성공하더라도
			// 검색결과가 1개밖에 안나와서 자료형을 Member로 반환해줌.
			// 만약, 결과가 여러개일 경우는 ArrayList형으로 반환해줌.
			
			
			// 0) 필요한 변수 세팅
			// 조회된 한 회원에 대한 정보를 담을 변수
			Member m = null;
			PreparedStatement pstmt = null; 
			ResultSet rset = null; 
			
			// 실행할 SQL문(완성된 형태, 세미콜론X) 
			String sql = prop.getProperty("selectByUserId");
			
			/*
			String sql = "SELECT * FROM MEMBER WHERE USERID = ?"; // 미완성
			// String sql = "SELECT * FROM MEMBER WHERE USERID = '" + userId + "'"; // 완성
			*/
			
			try {
				// 3-1) PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				
				// 3-2) 담은 SQL문이 미완성인 경우, 값 채워넣기
				// 완성형인 경우, 해당 과정 생략
				pstmt.setString(1, userId);
				
				// 4,5) SQL문(SELECT)을 전달해서 실행 후 결과를 받기
				rset = pstmt.executeQuery();
				
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
				}
				
			}catch (SQLException e) {
				e.printStackTrace();
				
			}finally {
				// 7) 다 쓴 JDBC용 객체 반납(생성된 순서의 역순)
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
			// 8) 결과 반환
			return m; // 조회된 1명의 회원 정보
		}
		
		
		// 회원 이름으로 회원검색 요청시, SELECT문을 실행할 매소드
		public ArrayList<Member> selectByUserName(Connection conn, String keyword) { //SELECT문 => ResultSet 객체
			
			// 0) 필요한 변수 세팅
			// 본래는 UNIQUE제약조건이 없기에, 다수의 검색결과가 나올 수 있어
			// ArrayList에 담아줌
			ArrayList<Member> list = new ArrayList<>();
			PreparedStatement pstmt = null; 
			ResultSet rset = null;
			
			// 실행할 SELECT문(미완성된 형태, 세미콜론X)
			//String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE '% ? %'";
			// 위는 정상적으로 수행되지 않음(문자열이 메꿔질 때, 홑따옴표가 자동으로 들어가기 때문에)
			// => '%' ? '%' 의 형태가 되어버림
			
			// 방법1
			// String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE '%'|| ? || '%'";
			// 문자열의 경우, 메꿔질 때 홑따옴표가 자동으로 들어가기 때문에
			// '%' || '?' || '%'의 모양이 될 것임.
			
			/*
			// 방법2
			String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE ?";
			// 이 방법은 구멍을 메꾸는 과정에서 양쪽에 %를 붙여주어야 함.
			*/
			
			String sql = prop.getProperty("selectByUserName");
			
			try {
				// 3-1) Statement 객체 생성
				pstmt = conn.prepareStatement(sql);
				
				// 3-2) 담을 SQL문이 미완성인 경우, 값채워넣기
				//String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE '% ? %'";
				// pstmt.setString(1, keyword); => '%' keyword '%' (문법오류)
				
				// 방법1)
				// String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE '%'|| ? || '%'";
				// pstmt.setString(1, keyword); // LIKE '%' || 'keyword' || '%'
				
				// 방법2)
				// String sql = "SELECT * FROM MEMBER WHERE USERNAME LIKE ?";
				pstmt.setString(1,  "%" + keyword + "%"); // '%keyword%' 
				
				// 4,5) SQL문(SELECT)을 전달해서 실행 후 결과를 받기
				rset = pstmt.executeQuery();
				
			// 6-1) SELECT문(sql)을 실행한 결과
			// 조회결과가 담긴 rset에서 한행씩 뽑아서 VO객체에 담기
			// 우선적으로, 커서를 한 칸 내린 후, 뽑을 값이 있는지를 검사 => rset.next()
			// 여러 행이 조회될 가능성이 높은 경우, 반복적으로 검사가 진행되어야 함.	
			while(rset.next()) {
				
				// rset에 있는 행의 결과를 담을 Member 객체 생성
				Member m = new Member();
					
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
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				// 7) 다 쓴 JDBC용 자원반납 => 생성된 순서의 역순
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
			}
			
			// 8) 결과값을 반환하기
			return list;
		}
		
		// 회원 변경 요청이 들어왔을 때, UPDATE구문을 실행할 메소드
		public int updateMember(Connection conn, Member m) { // UPDATE 구문 => int형(처리된 행의 개수) => 트랜젝션 처리
			// 0) 필요한 변수 설정
			int result = 0;
			PreparedStatement pstmt = null;
			
			// 실행할 sql문(비밀번호, 이메일, 전화번호, 주소)
			/*
			 * UPDATE MEMBER
			 * 	  SET USERPWD = 'newPwd' 
			 * 		, EMAIL = 'newEmail'
			 * 		, PHONE = 'newPhone'
			 * 		, ADDRESS = 'newAddress'
			 *  WHERE USERID = 'USERID'
			 */
			/*
			String sql = "UPDATE MEMBER "
					+ "SET USERPWD = ?"
					+ ", EMAIL = ?"
					+ ", PHONE = ?"
					+ ", ADDRESS =? "
					+ "WHERE USERID = ?";
			*/
			String sql = prop.getProperty("updateMember");
			
			try {
				// 3-1) PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				
				// 3-2) 담을 SQL문이 미완성인 경우, 값 채워넣기
				pstmt.setString(1, m.getUserPwd());
				pstmt.setString(2, m.getEmail());
				pstmt.setString(3, m.getPhone());
				pstmt.setString(4, m.getAddress());
				pstmt.setString(5, m.getUserId());
				
				// 4,5) SQL문을 실행 후 결과를 반환 
				result = pstmt.executeUpdate();
				
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(pstmt);
			}
			// 8) 결과 반환
			return result; // UPDATE된 행의 개수
		}
		
		public int deleteMember(Connection conn, String userId) { // delete => int형(처리된 행의 개수) => 트랜젝션 처리
			// 0) 필요한 변수 설정
			int result = 0;
			PreparedStatement pstmt = null;
			
			// SQL문 설정
			/*
			 * DELETE FROM MEMBER 
			 * WHERE USERID = ?
			 */
			/*
			String sql = "DELETE FROM MEMBER "
					+ "WHERE USERID = ?";
			*/
			String sql = prop.getProperty("deleteMember");
			
			try {
				// 3-1) PreparedStatement 객체 생성
				pstmt = conn.prepareStatement(sql);
				
				// 3-2) 미완성된 쿼리문인 경우, 값채워넣기
				pstmt.setString(1, userId);
				
				// 4,5) SQL문 결과 담기(처리된 행의 개수)
				result = pstmt.executeUpdate();
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				JDBCTemplate.close(pstmt);
			}
			
			// 8) 결과값 반환
			return result;
		}
		
}
