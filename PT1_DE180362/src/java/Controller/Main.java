/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.Book;
import Model.DBConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author
 */
public class Main extends HttpServlet {

    ArrayList<Book> listBook = new ArrayList<>();
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
     *
     * /**
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
        String sessionId = request.getParameter("jsessionid");
        HttpSession session;
         if (sessionId != null) {
            session = request.getSession(false); // Lấy session hiện tại
            if (session == null || !sessionId.equals(session.getId())) {
                // Nếu không có session hoặc ID không khớp, tạo session mới
                session = request.getSession();
            }
        } else {
            session = request.getSession(); // Nếu không có session ID, tạo session mới
        }

        String username = null;
        boolean lg = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("username".equals(cookie.getName())) {
                    lg = true;
                    username = cookie.getValue();
                }
            }
        }
        if ((session != null && session.getAttribute("username") != null) || lg == true) {
            listBook = DAO.getAll();

            request.setAttribute("listBook", listBook);
            request.setAttribute("username", username);
            try {

                RequestDispatcher dispatcher = request.getRequestDispatcher("Display.jsp");
                dispatcher.forward(request, response);
            } catch (Exception e) {
            }
        } else {
            String redirectUrl = "LoginHome.jsp?jsessionid=" + session.getId();;
            response.sendRedirect(redirectUrl);
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
        String action = request.getParameter("action");
        switch (action) {
            case "logout" -> {
                HttpSession session = request.getSession(false);
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cookie : cookies) {
                        if (cookie.getName().equals("username")) {
                            cookie.setValue("");
                            cookie.setMaxAge(0); // Đặt thời gian sống là 0 để xóa cookie
                            cookie.setPath("/"); // Đảm bảo đường dẫn chính xác
                            response.addCookie(cookie);
                        }
                    }
                }
                response.sendRedirect("LoginHome.jsp");

            }
////             case "update"->{
////                 Update(request, response);
////             }
////             case "delete"->{
////                 Delete(request, response);
////             }
////             case "search"->{
////                 Search(request, response);
////             }
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
