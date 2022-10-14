package bbs;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class BbsDAO {
	private Connection  conn; //데이터베이스에 접근하게 해주는 하나의 객채
	private ResultSet rs;

	public BbsDAO() {  //실제로db에 접속해 db를 건드리는 객체
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?useSSL=false";  //컴퓨터에 설치된 3306 포트에 접속 useSSL=false 를 추가함으로서 시큐리티 셀을 없으므로 오류 해결
			String dbID = "root";
			String dbPassword = "root";
			//저장된 ID PW
			Class.forName("com.mysql.jdbc.Driver"); //매개체 역할을 하는 하나의 라이브러리  //여기 연동시켜서 오류확인하기
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			//에 접근하는 부분들
		}catch (Exception e) {//예외처리
			e.printStackTrace(); //오류 발생시 오류가 무엇인지 출력
		}
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS(bbsTitle, userID, bbsContent, bbsAvailable) VALUES (?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //하나의 게시물을 db로 삽입하는 함수
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  userID);
			pstmt.setString(3,  bbsContent);
			pstmt.setInt(4, 1);
			return pstmt.executeUpdate(); //INSERT 경우 성공하면 0이상을 반환 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //데이터 베이스오류
		
	}
	
	public ArrayList<Bbs> getList(int pageNumber){
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1 ORDER BY bbsID DESC LIMIT ?,10";
		ArrayList<Bbs> list = new ArrayList<Bbs>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			pstmt.setInt(1, (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				list.add(bbs);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	  
	public boolean nextPage(int pageNumber) { //1부터 시작하는 페이지 함수
		String SQL = "SELECT * FROM BBS WHERE bbsAvailable = 1"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL); 
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public Bbs getBbs(int bbsID){ //글내용을 불러오는 함수
		String SQL ="SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				Bbs bbs = new Bbs();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
			}
		}catch(Exception e) {
			e.printStackTrace();
	}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) {
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?";
		try { //해당하는 bbs내용들을 업데이트 해준다. 시간과, 페이지 번호의 경우 서버내에 기능을 응요하여 자동으로 적용되어서 삭제하였다.
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int bbsID) { //글을 삭제하는 함수
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";  //어떤 건지 알수있도록 아이디 값을 받아온다 ->글은 삭제해도 글에 대한 정보는 남아 있어야하므로 bbsAvailable 값을 0으로 한다
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  bbsID);
			return pstmt.executeUpdate();
		}catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
}
