<%-- 
    Document   : user
    Created on : Jan 22, 2026, 10:42:25 AM
    Author     : LENOVO
--%>

<%@page import="fa26.t2s2.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <a href="LoadProductController">Shopping</a>
        User ID: ${sessionScope.LOGIN_USER.userID} </br>
        Full Name: ${sessionScope.LOGIN_USER.fullName} </br>
        Role ID: ${sessionScope.LOGIN_USER.roleID}</br>
        Password: ${sessionScope.LOGIN_USER.password} </br>

    </body>
</html>
