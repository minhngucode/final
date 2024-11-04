/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.DBConnect;
import Model.Order;
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
         String customerName = request.getParameter("customerName");
         String status = request.getParameter("filterStatus");
    ArrayList<Order> orderList;
    
    if ((customerName != null && !customerName.isEmpty()) || (status != null && !status.isEmpty())) {
        // Lọc đơn hàng theo tiêu chí được nhập
        orderList = DAO.getOrdersByCustomerNameAndStatus(customerName, status);
    } else {
        // Lấy tất cả đơn hàng nếu không có điều kiện lọc
        orderList = DAO.getAllOrdersSortedByDate();
    }
    // Đưa danh sách đơn hàng vào request scope
    request.setAttribute("orderList", orderList);
    
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
        String action = request.getParameter("action");
        switch (action){
            case "addProduct" ->{
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
        Part filePart = request.getPart("image");  //Lấy đối tượng ảnh upload lên
        //tạo địa chỉ để lưu
            String uploadPath = "D:\\CN4\\PRJ\\Web\\final\\Marine_Reef\\web\\images\\coral-image";
        //tạo 1 đối tượng file để kiểm tra xem đường dẫn đã có chưa nếu chưa có thì tạo ra đường dẫn để lưu
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
        //này là tạo id để gắn cho ảnh
        String productID = DAO.generateProductID(DAO.getConnection(),categoryID ); // Tạo productID
        //tạo tên mới để lưu ảnh theo id 
        String newFileName = productID + ".jpg" ; // Đổi tên file
        //lưu cái filePart(là cái ảnh) vào cái đường dẫn với cái tên mới
        filePart.write(uploadPath + File.separator + newFileName);

        // Kết nối tới cơ sở dữ liệu và thêm sản phẩm
        DAO.addProduct(name, description, price, quantity, categoryID, costPrice, type);
            }
            case "updateStatus" ->{
                String orderId = request.getParameter("orderId");
        String newStatus = request.getParameter("newstatus");

        // Kiểm tra thông tin đầu vào
        if (orderId != null && newStatus != null) {
            // Gọi phương thức để cập nhật trạng thái đơn hàng trong cơ sở dữ liệu
            boolean isUpdated = DAO.updateOrderStatusInDatabase(orderId, newStatus);

            if (isUpdated) {
                // Chuyển hướng về trang hiển thị đơn hàng nếu cập nhật thành công
                doGet(request, response);
                } else {
                // Hiển thị thông báo lỗi nếu cập nhật thất bại
                response.sendRedirect("admin.jsp?success=false");
            }
        } else {
            // Hiển thị thông báo lỗi nếu thông tin đầu vào không hợp lệ
            response.sendRedirect("admin.jsp?success=false");
        }
            }
        }
        
        
    }

  

    
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
