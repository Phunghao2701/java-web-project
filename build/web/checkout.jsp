<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.Map"%>
<%@page import="fa26.t2s2.shopping.Product"%>
<%@page import="fa26.t2s2.shopping.Cart"%>

<!DOCTYPE html>
<html>
<head>
    <title>Checkout</title>
</head>
<body>

<h1>Checkout</h1>

<%
    Cart cart = (Cart) session.getAttribute("CART");
    double total = 0;
    if(cart != null){
        Map<String, Product> items = cart.getCart();
%>

<table border="1">
    <tr>
        <th>Product ID</th>
        <th>Name</th>
        <th>Price ($)</th>
        <th>Quantity</th>
        <th>Total</th>
    </tr>

<%
    for(Product p : items.values()){
        double subtotal = p.getPrice() * p.getQuantity();
        total += subtotal;
%>

<tr>
    <td><%=p.getPid()%></td>
    <td><%=p.getName()%></td>
    <td>$<%=p.getPrice()%></td>
    <td><%=p.getQuantity()%></td>
    <td>$<%=subtotal%></td>
</tr>

<%
    }
%>

<tr>
    <td colspan="4"><b>Total</b></td>
    <td><b>$<%=total%></b></td>
</tr>

</table>

<br>

<form action="MainController">
    <input type="submit" name="action" value="Checkout"/>
</form>

<%
    }else{
%>

<h3>Your cart is empty</h3>

<%
    }
%>

<br>
<a href="shopping.jsp">Continue Shopping</a>

</body>
</html>