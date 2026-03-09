<%-- 
    Document   : shopping
    Created on : Mar 2, 2026, 9:55:26 AM
    Author     : LENOVO
--%>

<%@page import="java.text.DecimalFormat"%>
<%@page import="java.util.List"%>
<%@page import="fa26.t2s2.shopping.Product"%>
<%@page import="fa26.t2s2.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Mina Store</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
            List<Product> listProduct = (List<Product>) request.getAttribute("LIST_PRODUCT");
            DecimalFormat df = new DecimalFormat("0.00");
            if (listProduct == null && request.getAttribute("MESSAGE") == null) {
                response.sendRedirect("LoadProductController");
                return;
            }
        %>
        <h1>Welcome to my Store</h1>
        <form action="MainController"  method="POST">

            <select name="product">
                <%
                    if (listProduct != null) {
                        for (Product p : listProduct) {
                %>
                <option value="<%= p.getPid()%>-<%= p.getName()%>-<%= p.getPrice()%>">
                    <%= p.getName()%> - <%= p.getPrice()%>$ (stock: <%= p.getQuantity()%>)
                </option>
                <%
                        }
                    }
                %>
            </select>
            <select name="quantity">
                <option value="1">1 item</option>
                <option value="2">2 items</option>
                <option value="3">3 items</option>
                <option value="4">4 items</option>
                <option value="5">5 items</option>
                <option value="10">10 items</option>
            </select>

            <input type="submit" name="action" value="Add"/>
            <input type="submit" name="action" value="View"/>
            <input type="submit" name="action" value="Checkout"/>
        </form>
        <% String message = (String) request.getAttribute("MESSAGE") == null ? "" : (String) request.getAttribute("MESSAGE");
        %>
        <%= message%>
    </body>
</html>
