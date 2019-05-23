package content;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class ContentDBProcess {
	private Connection conn;
	private ResultSet rs;
	
	public ContentDBProcess() {
		try{
			String dbURL = "jdbc:mysql://localhost:3306/board?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC"; // 디비명
			String dbID = "root";
			String dbPass = "0810";
			
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPass);
		}catch(Exception e) {
			e.printStackTrace(); // 오류 출력 
		}
	}
	
	public String getDate() { // 시간 저장
		String SQL = "SELECT NOW()"; // 현재 시간
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류
	}
	
	public int getNext() { // 글번호
		String SQL = "SELECT contentNum FROM content ORDER BY contentNum DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
        // 글작성 데이터를 DB 올림
	public int write(String contentTitle, String userName, String contentDetail) {
		String SQL = "INSERT INTO content VALUES(?, ?, ?, ?, ?)";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1,  getNext());
			pstmt.setString(2, contentTitle);
			pstmt.setString(3, userName);
			pstmt.setString(4, getDate());
			pstmt.setString(5, contentDetail);
			pstmt.executeUpdate();
			if(rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	// 특정한 페이지에서 10개만큼의 게시물 출력하기 위한

		public ArrayList<Content> getList(int pageNumber){
			String SQL = "SELECT * FROM content WHERE contentNum < ? ORDER BY contentNum DESC LIMIT 10";
			ArrayList<Content> list = new ArrayList<Content>();
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1,  getNext() - (pageNumber - 1) * 10);
				rs = pstmt.executeQuery();
				while(rs.next()) {
					Content content = new Content();
					content.setContentNum(rs.getInt(1));
					content.setContentTitle(rs.getString(2));
					content.setContentUser(rs.getString(3));
					content.setContentDate(rs.getString(4));
					content.setContentDetail(rs.getString(5));
					list.add(content);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
			return list; // 특정 페이지에 맞는 게시물들을 리스트에 담겨서 반환한다
		}
		
		// 특정 페이지가 존재하는지 확인(다음 페이지)
		public boolean nextPage(int pageNumber) {
			String SQL = "SELECT * FROM content WHERE contentNum < ?";
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
		
		// 글제목을 클릭 시 글 내용을 불 수 있게 불러오기
		public Content getContent(int contentNum) {
			String SQL = "SELECT * FROM content WHERE contentNum = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, contentNum);
				rs = pstmt.executeQuery();
				if(rs.next()) { // 결과가 나왔다면
					Content content = new Content();
					content.setContentNum(rs.getInt(1));
					content.setContentTitle(rs.getString(2));
					content.setContentUser(rs.getString(3));
					content.setContentDate(rs.getString(4));
					content.setContentDetail(rs.getString(5));
					return content;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null; // 글이 존재하지 않는다면 null 반환
		}
		
		// 게시글 수정하기
		public int contentUpdate(int contentNum, String contentTitle, String contentDetail) {
			// 제목과 내용을 바꾸겠다!
			String SQL = "UPDATE content SET contentTitle = ?, contentDetail = ? WHERE contentNum = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setString(1, contentTitle);
				pstmt.setString(2, contentDetail);
				pstmt.setInt(3, contentNum);
				return pstmt.executeUpdate();
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
		
		// 게시글 삭제하기( 컨텐츠 번호를 통해서 )

		public int contentDelete(int contentNum) {
			String SQL = "DELETE FROM content WHERE contentNum = ?";
			try {
				PreparedStatement pstmt = conn.prepareStatement(SQL);
				pstmt.setInt(1, contentNum);
				return pstmt.executeUpdate(); // 성공 시 0 이상 반환
			} catch(Exception e) {
				e.printStackTrace();
			}
			return -1; // 데이터베이스 오류
		}
}