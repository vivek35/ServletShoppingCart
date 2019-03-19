package com.shopcart.web;

import java.io.*;
import java.util.*;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; 

import com.shopcart.domain.Item;
import com.shopcart.service.ItemService;
import com.shopcart.service.LoginService;

public class ServletController extends HttpServlet{
	
	private LoginService loginService;
	private ItemService itemService;
	private HttpSession session;
	
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		loginService=new LoginService();
		itemService=new ItemService();
		
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String page=request.getParameter("page");
		String action=request.getParameter("action");
		session=request.getSession();
		HashMap<String,String> hmap=new HashMap<>();
		
		String nextPage="/login.jsp";
		if(page.equalsIgnoreCase("login")) {
			if(action.equalsIgnoreCase("login")) {
			session.setAttribute("user_selected_data", "");
			String username=request.getParameter("username");
			String password=request.getParameter("password");
			boolean isValidUser;
			try {
				try {
					isValidUser = loginService.authenticate(username, password);
					if(isValidUser) {
						nextPage="/items.jsp";
						session.setAttribute("login_name", username);
						session.setAttribute("item_list",itemService.fetchItems());
					}else {
						nextPage="/login.jsp";
						request.setAttribute("loginError", "Please enter valid username and password");
					}
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			}
			
		}else if(page.equalsIgnoreCase("Items")) {
			if(action.equalsIgnoreCase("AddtoCart")) {
				
				session.setAttribute("user_selected_data", "");
				 String[] paramValues = request.getParameterValues("item_checked");
				 
				 if(paramValues!=null && paramValues.length!=0) {
					 for(int i = 0; i < paramValues.length; i++) {
		            	System.out.println(paramValues[i]);
		            	String item_data[]=paramValues[i].split("\\|");
		            	String qty=request.getParameter(item_data[0]+"_item_qty");
		            	hmap.put( paramValues[i],qty);
		            }
					 
		          }
				 request.setAttribute("message","Element Added to Cart");
				 session.setAttribute("user_selected_data", hmap);
				 nextPage="/items.jsp";
				 
			}else if(action.equalsIgnoreCase("Checkout")) {
				nextPage="/cart.jsp";
			}
		}else if(page.equalsIgnoreCase("Cart")) {
			if(action.equalsIgnoreCase("Checkout")) {
				nextPage="/thank.jsp";
			}else if(action.equalsIgnoreCase("BacktoCart")) {
				nextPage="/items.jsp";
			}
		}else if(page.equalsIgnoreCase("menu")) {
			if(action.equalsIgnoreCase("logout")) {
				session.setAttribute("login_name", "");
				session.setAttribute("user_selected_data", "");
				nextPage="/login.jsp";
			}else if(action.equalsIgnoreCase("help")) {
				nextPage="/help.jsp";
			}
		}
		RequestDispatcher rd=request.getRequestDispatcher(nextPage);
		rd.forward(request,response);
		
	}	
}
