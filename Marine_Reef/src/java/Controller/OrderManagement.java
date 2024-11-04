/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.DBConnect;
import Model.Order;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.Cookie;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;

/**
 *
 * @author
 */
public class OrderManagement extends HttpServlet {
    DBConnect DAO = new DBConnect();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    

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
                    System.out.println("username=" + username);
                    count++;
                }
                if (c.getName().equals("_nopass")) {
                    count++;
                }
            }
        }
        if (count == 2) {
            ArrayList<Order> orders = DAO.getOrdersByUsername(username);
        request.setAttribute("orders", orders);
        RequestDispatcher dispatcher = request.getRequestDispatcher("OrderManage.jsp");
        dispatcher.forward(request, response);
        }
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
        String orderId = request.getParameter("orderId");
        if (orderId != null) {
            DAO.deleteOrderFromDatabase(orderId);
        }
        response.sendRedirect("OrderManagement");
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
