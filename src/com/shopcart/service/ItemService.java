package com.shopcart.service;

import java.util.*;

import com.shopcart.domain.Item;

public class ItemService {
	
	DatabaseService db=new DatabaseService();
	
	public List<Item> fetchItems() throws ClassNotFoundException{
		db.connectDatabase();
		List<Item> items=new ArrayList<>();
		try {
			String sql="select * from items";
			db.pstmt=db.con.prepareStatement(sql);
			db.rs=db.pstmt.executeQuery();
			while(db.rs.next()) {
				Item retrived_item=new Item(db.rs.getInt("id"),db.rs.getString("name"),db.rs.getInt("price"));
				items.add(retrived_item);
			}
		}catch(Exception e) {
			return items;
		}
		return items;
	}
}
