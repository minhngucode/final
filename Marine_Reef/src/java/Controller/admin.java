/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.DBConnect;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import jakarta.servlet.http.Part;
import java.io.File;
import java.math.BigDecimal;


/**
 *
 * @author
 */
@MultipartConfig
public class admin extends HttpServlet {
        ArrayList<String> arrDistinctTypes = new ArrayList<>();
        ArrayList<String> arrDistinctCategoryName = new ArrayList<>();
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
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet admin</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet admin at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        arrDistinctTypes = DAO.getDistinctTypes(DAO.getConnection());
        arrDistinctCategoryName = DAO.getDistinctCategoryName(DAO.getConnection());
         request.setAttribute("categoryList", arrDistinctCategoryName);
        request.setAttribute("typeList", arrDistinctTypes);
        RequestDispatcher dispatcher = request.getRequestDispatcher("admin.jsp");
        dispatcher.forward(request, response);
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
        System.out.println(request.getParameter("price"));
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        BigDecimal price = new BigDecimal(request.getParameter("price"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String categoryName = request.getParameter("categoryname");
        String categoryID = DAO.getCategoryIDByName(categoryName);
        String type = request.getParameter("type");
        BigDecimal costPrice = new BigDecimal(request.getParameter("costprice"));

        // Xử lý upload hình ảnh
        Part filePart = request.getPart("image"); // Nhận file ảnh
            String uploadPath = "D:\\PRJ\\final\\Marine_Reef\\web\\images\\coral-image";
        // Tạo thư mục nếu chưa tồn tại
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        // Tạo productID
        String productID = DAO.generateProductID(DAO.getConnection(),categoryID ); // Tạo productID

        // Đổi tên file ảnh thành productID
        String fileExtension = getFileExtension(filePart.getSubmittedFileName()); // Lấy đuôi file
        String newFileName = productID + ".jpg" ; // Đổi tên file

        // Lưu file ảnh
        filePart.write(uploadPath + File.separator + newFileName);

        // Kết nối tới cơ sở dữ liệu và thêm sản phẩm
        DAO.addProduct(name, description, price, quantity, categoryID, costPrice, type);
        
    }

    // Phương thức lấy đuôi file
  

    
  private String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf('.');
        if (dotIndex >= 0 && dotIndex < fileName.length() - 1) {
            return fileName.substring(dotIndex + 1);
        }
        return ""; // Trả về chuỗi rỗng nếu không có đuôi
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
