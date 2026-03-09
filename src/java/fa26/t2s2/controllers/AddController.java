/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package fa26.t2s2.controllers;

import fa26.t2s2.shopping.Cart;
import fa26.t2s2.shopping.OrderDAO;
import fa26.t2s2.shopping.Product;
import java.io.IOException;
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
@WebServlet(name = "AddController", urlPatterns = {"/AddController"})
public class AddController extends HttpServlet {

    private static final String ERROR = "LoadProductController";
    private static final String SUCCESS = "LoadProductController";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String url = ERROR;
        try {
            String rawProduct = request.getParameter("product");
            String pid = rawProduct;
            if (rawProduct != null && rawProduct.contains("-")) {
                pid = rawProduct.split("-", 2)[0];
            }

            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (pid == null || pid.trim().isEmpty()) {
                request.setAttribute("MESSAGE", "Invalid product");
                return;
            }
            pid = pid.trim();

            OrderDAO dao = new OrderDAO();
            Product dbProduct = dao.getProductById(pid);

            if (dbProduct == null) {
                request.setAttribute("MESSAGE", "Product not found");
            } else if (quantity > dbProduct.getQuantity()) {
                request.setAttribute("MESSAGE", "Only " + dbProduct.getQuantity() + " items left for " + dbProduct.getName());
            } else {
                Product product = new Product(dbProduct.getPid(), dbProduct.getName(), dbProduct.getPrice(), quantity);
                HttpSession session = request.getSession();
                Cart cart = (Cart) session.getAttribute("CART");
                if (cart == null) {
                    cart = new Cart();
                }
                boolean check = cart.add(product);
                if (check) {
                    session.setAttribute("CART", cart);
                    request.setAttribute("MESSAGE", "Added " + quantity + " items " + dbProduct.getName());
                    url = SUCCESS;
                }
            }
        } catch (Exception e) {
            request.setAttribute("MESSAGE", "Cannot add product to cart: " + e.getMessage());
            log("Error at AddController: " + e.toString());
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
