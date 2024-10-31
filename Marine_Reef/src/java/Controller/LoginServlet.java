/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.DBConnect;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;


/**
 *
 * @author
 */
public class LoginServlet extends HttpServlet {
    private static DBConnect DAO=new DBConnect();
    private static ArrayList<User> arr = new ArrayList<>();
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
    public static boolean checkLogin(String name, String pass){
        arr = DAO.getUser(DAO.getConnection());
        for (User u:arr)
            if (u.getUsername().equals(name) && u.getPassword().equals(pass))
                return true;
        return false;
    }
    public static String encryptPassword(String password) {
        try {
            // Tạo một đối tượng MessageDigest với thuật toán SHA-256
            MessageDigest md = MessageDigest.getInstance("SHA-256");

            // Chuyển mật khẩu sang byte và thực hiện mã hóa
            byte[] hashedBytes = md.digest(password.getBytes());

            // Chuyển byte sang chuỗi hexa
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }

            // Trả về chuỗi hexa đã mã hóa
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Cookie[] cookies = request.getCookies();
        String name=null;
        String passcode=null;
        boolean isLogedIn = false;
        if (cookies!=null){
            for (Cookie c: cookies){
                if (c.getName().equals("_noname"))
                {
                     name=c.getValue();
                    }
                if (c.getName().equals("_nopass"))
                {
                    passcode=c.getValue();
                }
            }
        }
        if (name!=null && passcode!=null)
            if (checkLogin(name,passcode))
                isLogedIn=true;
        if (isLogedIn)
        {
            response.sendRedirect("Control");
        }
        else
        {
            response.sendRedirect("loginpage.jsp");
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
        String name=request.getParameter("username");
        String pass=request.getParameter("password");
        if (checkLogin(name,encryptPassword(pass)))
        {
            String lg="ok";
            Cookie cname=new Cookie("_noname",name);
           Cookie cpass=new Cookie("_nopass",encryptPassword(pass));
           HttpSession session = request.getSession();
           
            session.setAttribute("username", name);
            session.setAttribute("role", DAO.getRole(name));
            session.setMaxInactiveInterval(86400);
           cname.setMaxAge(60*30);
           cpass.setMaxAge(60*30);
           
           response.addCookie(cname);
           response.addCookie(cpass);
           response.sendRedirect("Control?lg=true");
        }
        else
        {
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
