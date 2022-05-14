package com.kh.run;

import com.kh.view.ProductView;

public class Run {

	public static void main(String[] args) {
		// 1. Properties로 파일입출력 받기
		// 		=> .properties은 DriverManager, Connection, statement에 사용.
		// 		=> .xml은 query문에 사용.
		
		// 1-1. Properties 객체 생성
		/*
		Properties prop = new Properties();
		
		// 1-2. setProperty("","")로 Key, Value 삽입
		// setProperty()로 삽입하고 수정하는게 편하기 때문에 사용함.
		prop.setProperty("List", "ArrayList");
		prop.setProperty("Set", "HashSet");
		prop.setProperty("Map", "Properties");
		
		// 1-3 파일 형식으로 내보내기
		try {
			prop.store(new FileOutputStream("resources/driver.properties"), "driver.properties");
			prop.storeToXML(new FileOutputStream("resources/query.xml"), "query.xml");		
		}catch(IOException e) {
			e.printStackTrace();
		}
		*/
		
		/*
		// 1-4 파일 형식으로 읽어들이기
		// JDBCTemplate에 해당 파일을 활용하기 전, 실행이 원활한지 확인
		try {
			prop.load(new FileInputStream("resources/driver.properties"));
			prop.loadFromXML(new FileInputStream("resources/query.xml"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
		
		new ProductView().mainMenu();
	
	}

}
