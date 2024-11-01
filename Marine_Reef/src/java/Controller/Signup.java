/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import static Controller.LoginServlet.encryptPassword;
import Model.DBConnect;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;


/**
 *
 * @author
 */
public class Signup extends HttpServlet {
    private DBConnect DAO= new DBConnect();
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
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
    private boolean signtodb(String name, String pass, String email, String phone, String realname){
        
        if (DAO.signupUser(name, encryptPassword(pass), email, phone,realname, DAO.getConnection())) 
        {
            return true;
        }
        else
            return false;
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
        if (cookies!=null){
            for (Cookie c: cookies){
                if (c.getName().equals("_noname"))
                {
                     count++;
                    }
                if (c.getName().equals("_nopass"))
                {
                     count++;
                }
            }
        }
        if (count==2)         
            response.sendRedirect("Control");
        else
        response.sendRedirect("signuppage.jsp");
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
        String realname = (String) request.getParameter("name");
        String name = (String) request.getParameter("username");
         String pass = (String)request.getParameter("password");
         String mail = (String)request.getParameter("email");
         String phone = (String)request.getParameter("phone");
         if (signtodb(name, pass, mail, phone, realname)) 
         {
             Cookie cname=new Cookie("_noname",name);
           Cookie cpass=new Cookie("_nopass",encryptPassword(pass));    
           cname.setMaxAge(60*30);
           cpass.setMaxAge(60*30);
           response.addCookie(cname);
           response.addCookie(cpass);
             response.sendRedirect("Control");
         }
         else
         {
             System.out.println("vo duoc con cac a");
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
