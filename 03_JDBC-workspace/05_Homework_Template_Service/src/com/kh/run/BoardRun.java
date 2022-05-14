package com.kh.run;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Properties;

import com.kh.view.BoardView;

public class BoardRun {

	public static void main(String[] args) {
		
		
		// Properties 객체 생성
		Properties prop= new Properties();
		
		
		
		// Properties, xml 파일 형태로 내보내기
		
		/*
		// Properties, XML 파일에 해당 내용의 Key,Value를 입력
		prop.setProperty("List", "ArrayList");
		prop.setProperty("Set", "HashSet");
		prop.setProperty("Map", "Properties");
		
		// 파일 형식으로 내보낼 수 있는 메소드
		// prop.store(출력스트림객체, 주석내용), prop.storeToXML(출력스트림객체, 주석내용)
		try {
			prop.store(new FileOutputStream("resources/drive.properties"), "drive.properties");
			prop.storeToXML(new FileOutputStream("resources/query.xml"), "query.xml");
		} catch (IOException e) {
			e.printStackTrace();
		}
		*/
		
		
		// properties,xml 파일 형식 읽어들이기
		
		// prop.load,loadFromXML(입력스트림객체)
		try {
			prop.load(new FileInputStream("resources/driver.properties"));
			prop.loadFromXML(new FileInputStream("resources/query.xml"));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		
		// 파일 내용 수정 후 출력
		// getProperty("키") : 해당 Key에 대한 Value를 return 해줌.
		// 					   없는 Key를 제시하면, null을 반환함.
		/*
		System.out.println(prop.getProperty("List"));
		System.out.println(prop.getProperty("Set"));
		System.out.println(prop.getProperty("Map"));
		System.out.println(prop.getProperty("Properties"));
		*/
		
		
		System.out.println(prop.getProperty("driver"));
		System.out.println(prop.getProperty("url"));
		System.out.println(prop.getProperty("username"));
		System.out.println(prop.getProperty("password"));
		
		
		//new BoardView().mainMenu();
	}

}
