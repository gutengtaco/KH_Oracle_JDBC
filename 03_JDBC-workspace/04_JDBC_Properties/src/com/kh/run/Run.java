package com.kh.run;

import com.kh.view.MemberView;

public class Run {
	public static void main(String[] args) {

		// Properties 복습
		// Properties(Map계열의 컬렉션)
		// Properties는 주로 외부설정파일을 읽어오거나 파일형태로 값을 출력하고자 하는 목적으로 사용
		// => 파일 입출력 기능을 제공하기 때문에, Key랑 Value 모두 문자열 형태로 작성해야 함.
		
		// Properties, xml 파일 형태로 내보내기
		/*
		Properties prop = new Properties();
		
		// Map계열에 값을 추가하고자 한다면, put() 사용
		// Properties의 경우, 문자열의 형태로 Key, Value를 넣을 수 있게끔 제공하는 setProperty("키", "벨류") 사용
		prop.setProperty("List", "ArrayList");
		prop.setProperty("Set", "HashSet");
		prop.setProperty("Map", "Properties");
		
		// 파일 형식으로 내보낼 수 있는 메소드
		// prop.store(출력스트림객체, 주석내용), prop.storeToXML(출력스트림객체, 주석내용)
		try {
			prop.store(new FileOutputStream("resources/driver.properties"), "driver.properties");
			prop.storeToXML(new FileOutputStream("resources/query.xml"), "query.xml");
			// 출력스트림 특징 : 프로그램 입장에서 데이터를 내보낼 수 있는 통로
			// 					 객체 생성 시, 파일명을 없는 파일로 작성했을 경우, 문제 없이 생성됨.
			//					 Root 디렉토리를 지정하지 않은 경우, 현재 내가 작업중인 프로젝트 폴더 내에 생성 		
			// 					 => resources폴더를 생성해주어야 함.
			
			// resources 폴더
			// "자원"이라는 뜻, 주로 프로젝트 내의 외부파일을 저장하는 역할
			// 이미지파일, 스타일시트, 코드파일, 설정파일, ...
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
		
		/*
		// properties 형식의 파일을 읽어들이기
		Properties prop = new Properties();
		
		// prop.load(입력스트림객체)
		try {
			prop.load(new FileInputStream("resources/driver.properties"));
			// 입력스트림 특징 : 외부매체로부터 데이터를 읽어들이는 통로
			// 					 없는 파일을 작성하면 무조건 오류
			//  				 Root디렉토리를 제시하지 않으면, 현재 내가 작업중인 자바 프로젝트 폴더로 시작점이 잡힙.
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		/*
		// 출력
		// getProperty("키") : 해당 Key에 대한 Value를 return 해줌.
		// 					   없는 Key를 제시하면, null을 반환함.
		System.out.println(prop.getProperty("List"));
		System.out.println(prop.getProperty("Set"));
		System.out.println(prop.getProperty("Map"));
		System.out.println(prop.getProperty("Properties"));
		
		
		System.out.println(prop.getProperty("driver"));
		System.out.println(prop.getProperty("url"));
		System.out.println(prop.getProperty("username"));
		System.out.println(prop.getProperty("password"));
		*/
		
		/*
		// xml 형식의 파일 읽어들이기
		Properties prop = new Properties();
		
		// prop.loadFromXML(입력스트림객체)
		try {
			prop.loadFromXML(new FileInputStream("resources/query.xml"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		// 출력
		System.out.println(prop.getProperty("List"));
		System.out.println(prop.getProperty("Set"));
		System.out.println(prop.getProperty("Map"));
		
		
		System.out.println(prop.getProperty("select"));
		System.out.println(prop.getProperty("insert"));
		System.out.println(prop.getProperty("update"));
		*/
		
		// 메인메뉴 화면 띄우기
		new MemberView().mainMenu();
		
	}
}