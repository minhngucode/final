/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.DBConnect;
import Model.Product;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.ArrayList;
import org.json.JSONObject;

/**
 *
 * @author
 */
public class TankBuild extends HttpServlet {
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
            out.println("<title>Servlet TankBuild</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet TankBuild at " + request.getContextPath() + "</h1>");
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
        ArrayList<Product> tanks = DAO.getFilteredProducts("Tank","",null,null);
  

        ArrayList<Product> pumps = DAO.getFilteredProducts("Pump","",null,null);
    

        ArrayList<Product> filterMaterials = DAO.getFilteredProducts("Filter Material","",null,null);
       

        ArrayList<Product> salts = DAO.getFilteredProducts("Salt","",null,null);
     

        ArrayList<Product> skimmers = DAO.getFilteredProducts("Skimmer","",null,null);
       

        ArrayList<Product> lights = DAO.getFilteredProducts("Light","",null,null);
        

        // Đặt các danh sách sản phẩm vào request
        
        request.setAttribute("tanks", tanks);
        request.setAttribute("pumps", pumps);
        request.setAttribute("filterMaterials", filterMaterials);
        request.setAttribute("salts", salts);
        request.setAttribute("skimmers", skimmers);
        request.setAttribute("lights", lights);

        // Chuyển hướng đến trang JSP
        request.getRequestDispatcher("TankBuildPage.jsp").forward(request, response);
    }


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private static final long serialVersionUID = 1L;
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy các trường từ biểu mẫu
        String tankLength = request.getParameter("tankLength");
        String tankWidth = request.getParameter("tankWidth");
        String tankHeight = request.getParameter("tankHeight");
        
        String tankDetails = request.getParameter("tankDetails");
        String pumpDetails = request.getParameter("pumpDetails");
        String filterMaterialDetails = request.getParameter("filterMaterialDetails");
        String saltDetails = request.getParameter("saltDetails");
        String skimmerDetails = request.getParameter("skimmerDetails");
        String lightDetails = request.getParameter("lightDetails");
        System.out.println("tankdetails"+tankDetails);
        // Khởi tạo đối tượng Product cho từng sản phẩm
        Product tank = createProductFromDetails(tankDetails);
        Product pump = createProductFromDetails(pumpDetails);
        Product filterMaterial = createProductFromDetails(filterMaterialDetails);
        Product salt = createProductFromDetails(saltDetails);
        Product skimmer = createProductFromDetails(skimmerDetails);
        Product light = createProductFromDetails(lightDetails);
        System.out.println("Build tnank"+tank);
        String username = "";
        Cookie[] cookies = request.getCookies();

        if (cookies != null) 
            for (Cookie c : cookies) 
                if (c.getName().equals("_noname")) {
                    username = c.getValue();
                    System.out.println("username="+username);
                }    
        // Xử lý lưu trữ sản phẩm vào cơ sở dữ liệu
        try {
            if (tank != null) {
                    DAO.addCartDetail(tank, username, 1, DAO.getConnection()); 
                    String cartid = DAO.getCartID(username, DAO.getConnection());
                    if ((tankLength!=null) && (tankWidth!=null) && (tankHeight!=null))
                    {
                        double x = Double.parseDouble(tankLength);
                                                double y = Double.parseDouble(tankWidth);

                                                                        double z = Double.parseDouble(tankHeight);

                        int roundedValue = (int) Math.ceil((z*x*2+z*y*2+x*y)/1000);
                        DAO.updateQuantityCartDetail(cartid, tank.getProductID(), roundedValue, DAO.getConnection());
                    }
                        
            }
            if (pump != null) 
                    DAO.addCartDetail(pump, username, 1, DAO.getConnection());
          
            if (filterMaterial != null) 
                    DAO.addCartDetail(filterMaterial, username, 1, DAO.getConnection());
            
            if (salt != null) 
                    DAO.addCartDetail(salt, username, 1, DAO.getConnection());
            
            if (skimmer != null) 
                    DAO.addCartDetail(skimmer, username, 1, DAO.getConnection());
            
            if (light != null) 
                    DAO.addCartDetail(light, username, 1, DAO.getConnection());
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Có lỗi xảy ra khi lưu trữ sản phẩm.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }

        // Chuyển hướng đến trang kết quả hoặc thông báo thành công
        response.sendRedirect("CartServlet");
    }
        
    private Product createProductFromDetails(String details) {
        if (details != null && !details.isEmpty()) {
            JSONObject productJson = new JSONObject(details);
            return new Product(
                productJson.getString("productID"),
                productJson.getString("name"),
                productJson.getString("type"),
                productJson.getString("description"),
                new BigDecimal(productJson.getString("price")),  // Chuyển đổi từ String sang BigDecimal
            new BigDecimal(productJson.getString("costprice")),
                productJson.getInt("quantityInStock"),
                productJson.getString("categoryID")
            );
        }
        return null;
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
