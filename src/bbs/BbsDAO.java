package bbs;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;


public class BbsDAO {
	private Connection  conn; //�����ͺ��̽��� �����ϰ� ���ִ� �ϳ��� ��ä
	private ResultSet rs;

	public BbsDAO() {  //������db�� ������ db�� �ǵ帮�� ��ü
		try {
			String dbURL = "jdbc:mysql://localhost:3306/bbs?useSSL=false";  //��ǻ�Ϳ� ��ġ�� 3306 ��Ʈ�� ���� useSSL=false �� �߰������μ� ��ť��Ƽ ���� �����Ƿ� ���� �ذ�
			String dbID = "root";
			String dbPassword = "root";
			//����� ID PW
			Class.forName("com.mysql.jdbc.Driver"); //�Ű�ü ������ �ϴ� �ϳ��� ���̺귯��  //���� �������Ѽ� ����Ȯ���ϱ�
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
			//�� �����ϴ� �κе�
		}catch (Exception e) {//����ó��
			e.printStackTrace(); //���� �߻��� ������ �������� ���
		}
	}
	
	public int write(String bbsTitle, String userID, String bbsContent) {
		String SQL = "INSERT INTO BBS(bbsTitle, userID, bbsContent, bbsAvailable) VALUES (?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);  //�ϳ��� �Խù��� db�� �����ϴ� �Լ�
			pstmt.setString(1,  bbsTitle);
			pstmt.setString(2,  userID);
			pstmt.setString(3,  bbsContent);
			pstmt.setInt(4, 1);
			return pstmt.executeUpdate(); //INSERT ��� �����ϸ� 0�̻��� ��ȯ 
		}catch(Exception e) {
			e.printStackTrace();
		}
		return -1; //������ ���̽�����
		
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
	  
	public boolean nextPage(int pageNumber) { //1���� �����ϴ� ������ �Լ�
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
	
	public Bbs getBbs(int bbsID){ //�۳����� �ҷ����� �Լ�
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
		try { //�ش��ϴ� bbs������� ������Ʈ ���ش�. �ð���, ������ ��ȣ�� ��� �������� ����� �����Ͽ� �ڵ����� ����Ǿ �����Ͽ���.
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
	
	public int delete(int bbsID) { //���� �����ϴ� �Լ�
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?";  //� ���� �˼��ֵ��� ���̵� ���� �޾ƿ´� ->���� �����ص� �ۿ� ���� ������ ���� �־���ϹǷ� bbsAvailable ���� 0���� �Ѵ�
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
