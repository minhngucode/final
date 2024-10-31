package Controller;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import Model.DBConnect;
import Model.Product;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
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
public class ProductList extends HttpServlet {
    ArrayList<Product> arr = new ArrayList<>();
    private DBConnect DAO = new DBConnect();
    ArrayList<String> listtype = new ArrayList<>();
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
        arr = DAO.getProduct(DAO.getConnection());
        listtype = DAO.getDistinctTypes(DAO.getConnection());
        request.setAttribute("productList", arr);
        request.setAttribute("listtype", listtype);
        RequestDispatcher dispatcher = request.getRequestDispatcher("sanpham.jsp");
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
        System.out.println(action);
        switch (action) {
            case "detail" -> {
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

                // Lưu đối tượng Product vào request để hiển thị thông tin chi tiết
                request.setAttribute("product", product);

                // Chuyển hướng đến trang hiển thị chi tiết sản phẩm
                RequestDispatcher dispatcher = request.getRequestDispatcher("detailproduct.jsp");
                dispatcher.forward(request, response);
            }

            case "filter" -> {

                String productType = request.getParameter("productType");
                String searchName = request.getParameter("searchName");
                BigDecimal minPrice = request.getParameter("minPrice") != null && !request.getParameter("minPrice").isEmpty() ? new BigDecimal(request.getParameter("minPrice")) : null;
                BigDecimal maxPrice = request.getParameter("maxPrice") != null && !request.getParameter("maxPrice").isEmpty() ? new BigDecimal(request.getParameter("maxPrice")) : null;

                arr = DAO.getFilteredProducts(productType, searchName, minPrice, maxPrice, DAO.getConnection());
                listtype = DAO.getDistinctTypes(DAO.getConnection());

                request.setAttribute("productList", arr);
                request.setAttribute("listtype", listtype);
                // Forward lại trang JSP để hiển thị
                request.getRequestDispatcher("sanpham.jsp").forward(request, response);

            }
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
