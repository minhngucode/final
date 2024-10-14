/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.DBConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


/**
 *
 * @author
 */
public class Login extends HttpServlet {
    DBConnect DAO = new DBConnect();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     *

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
        boolean lg=false;
        if (cookies != null) {
            for (Cookie cookie : cookies) 
                if ("username".equals(cookie.getName())) {
                   lg=true;
                    System.out.println("Da gap cookies");
                    response.sendRedirect("Main");
                }
            }
        else
            System.out.println("Checkcoookies");
        if (!lg)
        response.sendRedirect("LoginHome.jsp");
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
        String tk = request.getParameter("username");
        String mk = request.getParameter("password");
        if (DAO.checkLogininfo(tk, mk)){
            Cookie userCookie = new Cookie("username", tk);
            userCookie.setMaxAge(60 * 60 * 24);
            userCookie.setPath("/");
            response.addCookie(userCookie);
             HttpSession session = request.getSession();
            session.setAttribute("username", tk);
             String sessionId = request.getParameter("jsessionid");

             if (sessionId != null) {
            session = request.getSession(false); // Lấy session hiện tại
            if (session == null || !sessionId.equals(session.getId())) {
                // Nếu không có session hoặc ID không khớp, tạo session mới
                session = request.getSession();
                    }
              } else {
            session = request.getSession(); // Nếu không có session ID, tạo session mới
        }
            String redirectUrl = "Main?jsessionid=" + session.getId();;
            response.sendRedirect(redirectUrl);
        }
        else {
            doGet(request, response);
        }
            
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
