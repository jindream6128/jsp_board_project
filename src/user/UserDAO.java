package user;
//외부 라이브러리 추가
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO { //데이터베이스 접근 객체 
	
	private Connection  conn; //데이터베이스에 접근하게 해주는 하나의 객채
	private PreparedStatement pstmt;
	private ResultSet rs;

	public UserDAO() {  //실제로db에 접속해 db를 건드리는 객체
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
	
	public int login(String userID, String userPassword) {
		String SQL = "SELECT userPassword FROM USER WHERE userID = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setNString(1,  userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString(1).contentEquals(userPassword)) {
					return 1; //입력 패스워드와 저장된 패스워드가 일치하면 1을 돌려주면서 로그인 성공
				}
				else 
					return 0; //비밀번호 가 틀린거 알려준다.
			}
			return -1; //아이디가 없음
				
		} catch (Exception e) {
			e.printStackTrace();//예외 출력
		}
		return -2; //데이터베이스오류
	}
	
public int join(User user) { //DB의 속성과 맞춰서 회원가입 데이터를 넣음
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
	return -1; //데이터베이스 오류 인설트 문은 반드시 0이상의 결과값이 반환된다.
}
	
}

