<%-- 
    Document   : login
    Created on : Jan 19, 2026, 11:07:21 AM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="MainController" method="POST">
            User ID <input type="text" name="userID" required=""/></br> 
            Password <input type="password" name="password" required=""/></br> 
            <input type="submit" name="action" value="Login"/></br> 
            <input type="reset" value="Reset"/></br> 
        </form>
        <%
        String errorMessage = (String) request.getAttribute("ERROR_MESSAGE");
        if(errorMessage == null)errorMessage = "";
                %>
                <%= errorMessage %>
    </body>
</html>
