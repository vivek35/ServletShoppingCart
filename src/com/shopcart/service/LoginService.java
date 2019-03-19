package com.shopcart.service;

import java.sql.SQLException;

public class LoginService {
	DatabaseService db=new DatabaseService();
	
	public boolean authenticate(String username,String password) throws SQLException, ClassNotFoundException {
		try {
		db.connectDatabase();
		String sql="select * from login where name=? and password=?";
		db.pstmt=db.con.prepareStatement(sql);
		db.pstmt.setString(1, username);
		db.pstmt.setString(2, password);
		db.rs=db.pstmt.executeQuery();
		if(db.rs.next()) {
			return true;
		}else {
			return false;
		}
		}catch(Exception e) {
			return false;
		}
		
	}
	
}
