package user;
//�ܺ� ���̺귯�� �߰�
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO { //�����ͺ��̽� ���� ��ü 
	
	private Connection  conn; //�����ͺ��̽��� �����ϰ� ���ִ� �ϳ��� ��ä
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {  //������db�� ������ db�� �ǵ帮�� ��ü
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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).contentEquals(userPassword)) {
					return 1; //�Է� �н������ ����� �н����尡 ��ġ�ϸ� 1�� �����ָ鼭 �α��� ����
				}
				else 
					return 0; //��й�ȣ �� Ʋ���� �˷��ش�.
			}
			return -1; //���̵� ����
				
		} catch (Exception e) {
			e.printStackTrace();//���� ���
		}
		return -2; //�����ͺ��̽�����
	}
	
public int join(User user) { //DB�� �Ӽ��� ���缭 ȸ������ �����͸� ����
	String SQL = "INSERT INTO USER VALUES(?, ?, ?, ?, ?)";
	
	try {
		pstmt = conn.prepareStatement(SQL);
		pstmt.setString(1,  user.getUserID());
		pstmt.setString(2,  user.getUserPassword());
		pstmt.setString(3,  user.getUserName());
		pstmt.setString(4,  user.getUserGender());
		pstmt.setString(5,  user.getUserEmail());
		return pstmt.executeUpdate();
	}catch(Exception e) {
		e.printStackTrace();
	}
	return -1; //�����ͺ��̽� ���� �μ�Ʈ ���� �ݵ�� 0�̻��� ������� ��ȯ�ȴ�.
}
	
}

