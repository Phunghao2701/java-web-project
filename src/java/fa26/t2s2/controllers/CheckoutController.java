/*
     * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
     * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package fa26.t2s2.controllers;

import fa26.t2s2.shopping.Cart;
import fa26.t2s2.shopping.OrderDAO;
import fa26.t2s2.shopping.Product;
import fa26.t2s2.user.UserDAO;
import fa26.t2s2.user.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author LENOVO
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private static final String ERROR = "LoadProductController";
    private static final String SUCCESS = "LoadProductController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {

            HttpSession session = request.getSession(false);

            if (session != null) {

                Cart cart = (Cart) session.getAttribute("CART");
                UserDTO user = (UserDTO) session.getAttribute("LOGIN_USER");

                if (cart != null && cart.getCart() != null && user != null) {

                    OrderDAO dao = new OrderDAO();

                    float total = 0;

                    for (Product p : cart.getCart().values()) {
                        total += p.getPrice() * p.getQuantity();
                    }

                    int orderID = dao.createOrder(user.getUserID(), total);

                    if (orderID > 0) {
                        boolean updatedAll = true;
                        for (Product p : cart.getCart().values()) {

                            dao.insertOrderDetail(
                                    orderID,
                                    p.getPid(),
                                    p.getPrice(),
                                    p.getQuantity()
                            );

                            boolean updated = dao.updateProductQuantity(
                                    p.getPid(),
                                    p.getQuantity()
                            );

                            if (!updated) {
                                updatedAll = false;
                            }
                        }

                        if (updatedAll) {
                            session.removeAttribute("CART");
                            request.setAttribute("MESSAGE", "Checkout success");
                        } else {
                            request.setAttribute("MESSAGE", "Checkout failed: not enough stock");
                        }
                        url = SUCCESS;
                    }
                }
            }

        } catch (Exception e) {
            log("Error at CheckoutController: " + e.toString());
        } finally {
            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
