<%-- 
    Document   : shopping
    Created on : Mar 2, 2026, 9:55:26 AM
    Author     : LENOVO
--%>

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
        %>
        <h1>Welcome to my Store</h1>
        <form action="MainController"  method="POST">
            <!--            <select name="product">
                            <option value="P001-T Shirt-15">T Shirt-15$</option>
                            <option value="P002-Pant-15">Pant-15$</option>
                            <option value="P003-Dress-20">Dress-20$</option>
                            <option value="P004-Short-10">Short-10$</option>
                            <option value="P005-Hat-50">Hat-50$</option>
                            <option value="P006-Balo-30">Balo-30$</option>
                        </select>
            
                        <select name="quantity">
                            <option value="1">1 item</option>
                            <option value="2">2 items</option>
                            <option value="3">3 items</option>
                            <option value="4">4 items</option>
                            <option value="5">5 items</option>
                            <option value="10">10 items</option>
                        </select>-->
            <select name="cmbProduct">

                <c:forEach var="p" items="${LIST_PRODUCT}">
                    <option value="${p.pid}">
                        ${p.name} - ${p.price}$
                    </option>
                </c:forEach>

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
