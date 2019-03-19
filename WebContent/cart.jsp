<%@page import="java.util.*,com.shopcart.domain.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Items Page</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
* {
  box-sizing: border-box;
}

body {
  font-family: Arial, Helvetica, sans-serif;
}

/* Style the header */
header {
  background-color: #666;
  padding: 30px;
  text-align: center;
  font-size: 35px;
  color: white;
}

/* Create two columns/boxes that floats next to each other */
nav {
  float: left;
  width: 30%;
  height: 428px; 
  background: #ccc;
  padding: 20px;
}

/* Style the list inside the menu */
nav ul {
  list-style-type: none;
  padding: 0;
}

article {
  float: left;
  padding: 20px;
  width: 70%;
  background-color: #f1f1f1;
  height: 428px; /* only for demonstration, should be removed */
}

/* Clear floats after the columns */
section:after {
  content: "";
  display: table;
  clear: both;
}

/* Style the footer */
footer {
  background-color: #777;
  padding: 10px;
  text-align: center;
  color: white;
}

/* Responsive layout - makes the two columns/boxes stack on top of each other instead of next to each other, on small screens */
@media (max-width: 600px) {
  nav, article {
    width: 100%;
    height: auto;
  }
}
table {
  border-collapse: separate;
  border-spacing: 4px;
}
table,
th,
td {
  border: 1px solid #cecfd5;
}
th,
td {
  padding: 10px 15px;
}
.btn {
  background-color: black;
  color: white;
  font-size: 16px;
  padding: 16px 30px;
  border: none;
  cursor: pointer;
  border-radius: 5px;
  text-align: center;
}
.btn:hover {
  background-color: white;
  color: black;
}
</style>
</head>
<body>
<header>
  <jsp:include page="/header.jsp"></jsp:include>
</header>

<section>
  <nav>
    <jsp:include page="/menu.jsp"></jsp:include>
    </nav>
  <article>
  <table style="margin-left: 103px;">
  
  <form name="list_items" method="post" action="/ShopCart/cs">
  <h3>Cart Summary</h3>
  <thead>
    <tr>
      <th scope="col">Item</th>
      <th scope="col">Quantity</th>
      <th scope="col">Price</th>
      
    </tr>
  </thead>
  <tbody>
   <%
   int total_price=0;
   HashMap<String,String> user_session_data=null;
   if(session.getAttribute("user_selected_data")!=""){
  	 user_session_data=(HashMap<String,String>)session.getAttribute("user_selected_data");
  	for (Map.Entry<String, String> pair: user_session_data.entrySet()) {
  	    System.out.format("key: %s, value: %s%n", pair.getKey(), pair.getValue());
  	  	String[] item_data = ((String)pair.getKey()).split("\\|");
  	  	String item_name=item_data[1];
  	  	String item_price=item_data[2];
  	  	int item_qty=Integer.parseInt((String)pair.getValue());
  	  total_price=total_price+Integer.parseInt(item_price)*item_qty;
  	    %>
  	    <tr>
  	    <td scope="col"><%=item_name %></td>
  	    <td scope="col"><%=item_qty %></td>
  	    <td scope="col"><%=item_price %></td>
  	    </tr>
  	    <%
  	}
   }
   %>
   <tr>
   <td scope="col" colspan=2>Price: </td>
   <td scope="col" colspan=2><%=total_price %></td>
 </tbody>
 <input type="submit" class="btn" style="margin-left: 103px;" name="action" value="Checkout"/>
  <input type="submit" class="btn" name="action" value="BacktoCart"/>
    <input type="hidden" name="page" value="Cart"/>
  </form>
  </table>
  
  </article>
</section>

<footer>
  <jsp:include page="/footer.jsp"></jsp:include>
</footer>

</body>
</html>
