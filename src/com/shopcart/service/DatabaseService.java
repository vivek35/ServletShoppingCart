package com.shopcart.service;

import java.sql.*;

public class DatabaseService {
	Connection con;
	PreparedStatement pstmt;
	ResultSet rs;
	
	public void connectDatabase() throws ClassNotFoundException {
		String url="jdbc:mysql://127.0.0.1:3306/shoppingcart?useSSL=false";
		String username="root";
		String password="database";
		Class.forName("com.mysql.cj.jdbc.Driver");
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con=DriverManager.getConnection(url,username,password);
		}catch(Exception e) {
			System.out.println(e);
		}
	}
}
