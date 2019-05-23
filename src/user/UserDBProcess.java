package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.User;

public class UserDBProcess {
	private Connection conn; 
	private PreparedStatement pstmt; 
	private ResultSet rs; 

	public UserDBProcess() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/board?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"; // 디비명
			String dbID = "root";
			String dbPass = "0810";

			Class.forName("com.mysql.cj.jdbc.Driver"); 
			conn = DriverManager.getConnection(dbURL, dbID, dbPass);
		} catch (Exception e) {
			e.printStackTrace(); 
		}
	}

	public int login(String userId, String userPassword) { 
		String SQL = "SELECT userPassword FROM userinfo where userId = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();

			if (rs.next()) { 
				if (rs.getString(1).equals(userPassword)) {
					return 1;
				} else
					return 0; 
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; 
	}
	

	public int getNext() { 
		String SQL = "SELECT userNum FROM userinfo ORDER BY userNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}


	
	public int register(User user) {
		String SQL = "INSERT INTO userinfo VALUES(?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserId());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserName());
			pstmt.setInt(5,  getNext());
			pstmt.executeUpdate();
			return 1; 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

	public ArrayList<User> getList(int pageNumber) {
		String SQL = "SELECT * FROM userinfo WHERE userNum < ? ORDER BY userNum DESC LIMIT 10";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserId(rs.getString(1));
				user.setUserName(rs.getString(4));
				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM userinfo WHERE userNum < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext() - (pageNumber -1) * 10);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public User getUser(String userId) {
		String SQL = "SELECT * FROM userinfo WHERE userId= ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			if(rs.next()) { 
				User user = new User();
				user.setUserId(rs.getString(1));
				user.setUserPassword(rs.getString(2));
				user.setUserEmail(rs.getString(3));
				user.setUserName(rs.getString(4));
				user.setUserNum(rs.getInt(5));
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int userUpdate(String userId, String userPassword, String userEmail, String userName) {
		String SQL = "UPDATE userinfo SET userPassword = ?, userEmail = ?, userName = ? WHERE userId = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(4, userId);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userEmail);
			pstmt.setString(3, userName);
			int result = pstmt.executeUpdate();
			System.out.println(String.valueOf(result));
			System.out.println(userId);
			System.out.println(userPassword);
			System.out.println(userName);
			return result;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}
	

	public int userDelete(String userId) {
		String SQL = "DELETE FROM userinfo WHERE userId = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userId);
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; 
	}

}