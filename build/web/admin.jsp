<%-- 
    Document   : admin
    Created on : Jan 22, 2026, 10:45:42 AM
    Author     : LENOVO
--%>

<%@page import="java.util.List"%>
<%@page import="fa26.t2s2.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"AD".equals(loginUser.getRoleID())) {
                session.invalidate();
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy giá trị search để giữ trên thanh input và truyền hidden
            String searchValue = request.getParameter("search");
            if (searchValue == null || searchValue.trim().isEmpty()) {
                searchValue = request.getParameter("fullName");
            }
            if (searchValue == null) {
                searchValue = "";
            }
        %>

        <h1>Welcome: <%= loginUser.getFullName()%></h1>

        <!-- phan search -->
        <form action="MainController">
            Full Name <input type="text" name="fullName" value="<%= searchValue%>" required=""/>
            <input type="submit" name="action" value="Search"/> 
        </form>
            
            <!-- phan insert them user -->
            <a href="createUser.jsp">Create User</a>

        <!-- ... phần bảng ... -->

        <%
            List<UserDTO> listUser = (List<UserDTO>) request.getAttribute("LIST_USER");
            if (listUser != null) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>No</th>
                    <th>User ID</th>
                    <th>Full Name</th>
                    <th>Role ID</th>
                    <th>Password</th>
                    <th>Update</th>
                    <th>Delete</th>
                </tr>
            </thead>
            <tbody>
                <%
                    int count = 1;
                    for (UserDTO user : listUser) {
                %>
            <form action="MainController">
                <tr>
                    <td><%= count++%></td>
                    <td>
                        <input type="text" name="userID" value="<%= user.getUserID()%>" readonly=""/>
                    </td>
                    <td>
                        <input type="text" name="fullName" value="<%= user.getFullName()%>" required=""/>
                    </td>
                    <td>
                        <input type="text" name="roleID" value="<%= user.getRoleID()%>" required=""/>
                    </td>
                    <td><%= user.getPassword()%></td>
                    <td>
                        <input type="submit" name="action" value="Update"/>
                        <!-- Dùng searchValue ở đây -->
                        <input type="hidden" name="search" value="<%= searchValue%>"/>
                    </td>
                    <td>
                        <a href="DeleteController?userID=<%= user.getUserID()%>&fullName=<%= searchValue%>"
                           onclick="return confirm('Are you sure to delete?')">
                            Delete
                        </a>


                    </td>

                </tr>

            </form>

            <%
                }
            %>
<%
    String errorMsg = (String) request.getAttribute("ERROR_MESSAGE");
    if (errorMsg != null) {
%>
    <p style="color:red"><%= errorMsg %></p>
<%
    }
%>


        </tbody>
    </table>
    <%
    } else {
        String emptyMessage = (String) request.getAttribute("EMPTY_MESSAGE");
        if (emptyMessage == null)
            emptyMessage = "";
    %>
    <%= emptyMessage%>
    <%
        }
    %>


    <form action="MainController">
    <input type="submit" name="action" value="Logout"/>
</form>
</body>
</html>
