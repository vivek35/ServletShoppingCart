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
  height: 428px; /* only for demonstration, should be removed */
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
<body onload="myFunction()")>
<header>
  <jsp:include page="/header.jsp"></jsp:include>
</header>

<section>
 <%
String message=(String)request.getAttribute("message");
  request.setAttribute("message",null);
if( message!=null){
 %>
 <span id="cart_message" style="color:green"><%=message %></span>
<%
}

%>
  <nav>
<jsp:include page="/menu.jsp"></jsp:include>
    </nav>
  <article>
  <table>

  <form name="list_items" method="post" action="/ShopCart/cs">
  <thead>
    <tr>
   	  <th scope="col">Select</th>
      <th scope="col" colspan="2">Item</th>
      <th scope="col">Price</th>
      <th scope="col">Quantity</th>
    </tr>
  </thead>
  <tbody>
 <%
 
 
 HashMap<String,String> user_session_data=null;
 if(session.getAttribute("user_selected_data")!=""){
	 user_session_data=(HashMap<String,String>)session.getAttribute("user_selected_data");
 }
 List<Item> items=(List<Item>)session.getAttribute("item_list");
 for(Item item_list:items){
	 String value_check=item_list.getId()+"|"+item_list.getName()+"|"+item_list.getPrice();
	  String item_checked="";
	  String item_qty="";
	  if(user_session_data!=null && user_session_data.containsKey(value_check)){
		  item_checked="checked";
	  	  item_qty=user_session_data.get(value_check);
	  }
       %>
       
  <tr id=<%=item_list.getId() %>>
  <td scope="col"><input type="checkbox" name="item_checked" value="<%=value_check %>" <%=item_checked %>></td>
   <td scope="col" name="item_id" value="<%=item_list.getId() %>"><%=item_list.getId() %></td>
    <td scope="col" name="item_name" value="<%=item_list.getName() %>"><%=item_list.getName() %></td>
    <td scope="col" name="item_price" value="<%=item_list.getPrice() %>"><%=item_list.getPrice() %></td>
    <td scope="col" ><input type="text" name="<%=item_list.getId() %>_item_qty" value="<%=item_qty %>"/></td>
  </tr>
   
  </tbody>
  <%
  	}
    %>
  <input type="submit" class="btn" style="margin-left: 103px;" name="action" value="AddtoCart"/>
  <input type="submit" class="btn" name="action" value="Checkout"/>
    <input type="hidden" name="page" value="Items"/>
    </tbody>
  </form>
  </table>
  
  </article>
</section>

<footer>
  <jsp:include page="/footer.jsp"></jsp:include>
</footer>
<script>
var myVar;

function myFunction() {
  myVar = setTimeout(invisible, 5000);
}

function invisible(){
	console.log("COming");
	var element = document.getElementById("cart_message");
	if(element!=null){
		element.remove();
	}
	
}

</script>
</body>
</html>
