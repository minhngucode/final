/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.CartDetail;
import Model.DBConnect;
import Model.Product;
import jakarta.servlet.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;

/**
 *
 * @author
 */
public class CartServlet extends HttpServlet {
    ArrayList<CartDetail> arrCartDetail = new ArrayList<>();
    private DBConnect DAO = new DBConnect();

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void upCartDetail(HttpServletRequest request, HttpServletResponse response, int change)
            throws ServletException, IOException {
        String cartID = request.getParameter("cartID");
        String productID = request.getParameter("productID");
        int quantity = Integer.parseInt(request.getParameter("quantity"))+change;
        DAO.updateQuantityCartDetail(cartID, productID, quantity, DAO.getConnection());
    }
    protected void delCartDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cartID = request.getParameter("cartID");
        String productID = request.getParameter("productID");
        DAO.deleteCartDetail(cartID, productID, DAO.getConnection());
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
        
        Cookie[] cookies = request.getCookies();
        int count = 0;
        String username = "";
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("_noname")) {
                    username = c.getValue();
                    System.out.println("username="+username);
                    count++;
                }
                if (c.getName().equals("_nopass")) {
                    count++;
                }
            }
        }
        if (count == 2) {
            arrCartDetail = DAO.getCart(username, DAO.getConnection());
             request.setAttribute("cartDetails", arrCartDetail);
        RequestDispatcher dispatcher = request.getRequestDispatcher("giohang.jsp");
        dispatcher.forward(request, response);
        }
        else
            response.sendRedirect("LoginServlet");
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

        Cookie[] cookies = request.getCookies();
        int count = 0;
        String username = "";
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("_noname")) {
                    username = c.getValue();
                    System.out.println("username="+username);
                    count++;
                }
                if (c.getName().equals("_nopass")) {
                    count++;
                }
            }
        }

        if (count == 2) {
            String action = request.getParameter("action");
            switch (action){
                case "updateQuantity" -> {
                String cartID = request.getParameter("cartID");
                String productID = request.getParameter("productID");
                int delta = Integer.parseInt(request.getParameter("delta"));
                
                CartDetail cartDetail = DAO.getCartDetail(cartID, productID, DAO.getConnection());
                int newQuantity = cartDetail.getQuantity() + delta;
                
                if (newQuantity > 0) {
                    DAO.updateQuantityCartDetail(cartID, productID, newQuantity, DAO.getConnection());
                } else {
                    DAO.deleteCartDetail(cartID, productID, DAO.getConnection());
                }
                
                // Tính toán lại tổng giá giỏ hàng
                ArrayList<CartDetail> cartDetails = DAO.getCart(username, DAO.getConnection());
                BigDecimal totalPrice = BigDecimal.ZERO;
                BigDecimal productTotal = BigDecimal.ZERO;
                Product x = DAO.getProductbyID(productID, DAO.getConnection());
                productTotal = productTotal.add(x.getPrice().multiply(new BigDecimal(newQuantity)));
                for (CartDetail detail : cartDetails) {
                    Product product = DAO.getProductbyID(detail.getProductID(), DAO.getConnection());
                    totalPrice = totalPrice.add(product.getPrice().multiply(new BigDecimal(detail.getQuantity())));
                }

                // Trả về kết quả JSON
                response.setContentType("application/json");
                PrintWriter out = response.getWriter();
                out.print("{\"success\": true, \"newQuantity\": " + newQuantity + ", \"totalPrice\": " + totalPrice+ ", \"productTotal\": " + productTotal  + "}");
                out.flush();
            }
                case "remove"->{
                    delCartDetail(request, response);
                   doGet(request, response);

                }
                case "addtocart" ->{
              String productID = request.getParameter("productID");
            String name = request.getParameter("name");
            String type = request.getParameter("type");
            String description = request.getParameter("description");
            BigDecimal price = new BigDecimal(request.getParameter("price"));
            BigDecimal costprice = new BigDecimal(request.getParameter("costprice"));
            int quantityInStock = Integer.parseInt(request.getParameter("quantityInStock"));
            String categoryID = request.getParameter("categoryID");

            // Tạo đối tượng Product
            Product product = new Product(productID, name, type, description, price, costprice, quantityInStock, categoryID);
            DAO.addCartDetail(product, username, 1, DAO.getConnection());
            doGet(request, response);
                }
            }
            
        }
        else 
                        response.sendRedirect("LoginServlet");

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
