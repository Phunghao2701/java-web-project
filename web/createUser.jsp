<%-- 
    Document   : createUser
    Created on : Feb 2, 2026, 10:19:44 PM
    Author     : LENOVO
--%>

<%@page import="fa26.t2s2.user.UserError"%>
<%@page import="java.util.List"%>
<%@page import="fa26.t2s2.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Create User</title>
    </head>
    <body>
        <h1>Create new User</h1>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                session.invalidate();
                response.sendRedirect("login.jsp");
                return;
            }
            UserError userError = (UserError) request.getAttribute("USER_ERROR");
            if (userError == null)
                userError = new UserError();
        %>

        Create new User:
        <form action="MainController" method="POST">
            User ID: <input type="text" name="userID" required=""/> ${requestScope.USER_ERROR.userIDError}
            </br>Full Name: <input type="text" name="fullName" required=""/>${requestScope.USER_ERROR.fullNameError}
            </br>Role ID: <select name="roleID">
                <option value="US">US</option>
                <option value="AD">AD</option>
            </select>
            </br>Password: <input type="password" name="password" required=""/>
            </br>Confirm: <input type="password" name="confirm" required=""/>${requestScope.USER_ERROR.confirmError}
            </br><input type="submit" name="action" value="Create"/>
            </br><input type="reset"value="Reset"/> ${requestScope.USER_ERROR.error}
        </form>

        <%
            String error = (String) request.getAttribute("ERROR");
            if (error != null) {
        %>
        <p style="color: red"><%= error%></p>
        <%
            }
        %>

    </body>
</html>
