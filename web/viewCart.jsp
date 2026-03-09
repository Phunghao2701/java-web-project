<%-- 
    Document   : viewCart
    Created on : Mar 2, 2026, 10:36:26 AM
    Author     : LENOVO
--%>

<%@page import="fa26.t2s2.user.UserDTO"%>
<%@page import="fa26.t2s2.shopping.Product"%>
<%@page import="fa26.t2s2.shopping.Cart"%>
<%@page import="javax.smartcardio.Card"%>
<%@page import="java.text.DecimalFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Cart Page</title>
    </head>
    <body>
        <%
            UserDTO loginUser = (UserDTO) session.getAttribute("LOGIN_USER");
            if (loginUser == null || !"US".equals(loginUser.getRoleID())) {
                response.sendRedirect("login.jsp");
                return;
            }
        %>
        <h1>Your selected items</h1>
        <%
            Cart cart = (Cart) session.getAttribute("CART");
            if (cart != null && cart.getCart().values().size() > 0) {
        %>
        <table border="1">
            <thead>
                <tr>
                    <th>NO</th>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Total</th>
                    <th>Edit</th>
                    <th>Remove</th>
                </tr>
            </thead>
            <tbody>
                <% int count = 1;
                    double total = 0;
                    DecimalFormat df = new DecimalFormat("0.00");
                    for (Product product : cart.getCart().values()) {
                        total += product.getPrice() * product.getQuantity();
                %>
            <form action="MainController" method="POST">
                <tr>
                    <td><%= count++%></td>
                    <td>
                        <input type="text" name="id" value="<%= product.getPid()%>" readonly=""/>
                    </td>
                    <td><%= product.getName()%></td>
                    <td><%= df.format(product.getPrice())%></td>

                    <td>
                        <input type="number" name="quantity" value="<%= product.getQuantity()%>"/>
                    </td>
                    <td><%= df.format(product.getPrice() * product.getQuantity())%></td>
                    <td>
                        <input type="submit" name="action" value="Edit"/>

                    </td>
                    <td>
                        <input type="submit" name="action" value="Remove"/>
                    </td>
                </tr>
            </form>


            <%
                }
            %>
        </tbody>
    </table>
    </br>Total: <%= df.format(total)%>$
    <br/><br/>
    <form action="MainController" method="POST">
        <input type="submit" name="action" value="Checkout"/>     
    </form>
    <%
    } else {
    %>
    <%= "Your cart is empty!!!"%>
    <%
        }
    %>
    </br><a href="LoadProductController">Mua them di !!!</a>
</body>
</html>
