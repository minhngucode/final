/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Model.CartDetail;
import Model.Customer;
import Model.DBConnect;
import Model.OrderDetail;
import Model.Product;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
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
public class PaymentServlet extends HttpServlet {

    DBConnect DAO = new DBConnect();
    ArrayList<CartDetail> selectedCartDetails = new ArrayList<>();

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
        selectedCartDetails.clear();
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

            String[] selectedProducts = request.getParameterValues("selectedProduct");
            String[] selectedCartIDs = request.getParameterValues("selectedCartID");
            String[] selectedQuantities = request.getParameterValues("selectedQuantity");

            if (selectedProducts != null) {
                for (int i = 0; i < selectedProducts.length; i++) {
                    String productID = selectedProducts[i];
                    String cartID = selectedCartIDs[i];
                    String quantityStr = selectedQuantities[i];

                    try {
                        int quantity = Integer.parseInt(quantityStr);

                        // Tạo đối tượng CartDetail với thông tin đã nhận
                        CartDetail cartDetail = new CartDetail(cartID, productID, quantity);
                        // Thêm vào danh sách sản phẩm được chọn
                        selectedCartDetails.add(cartDetail);

                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                }
            }

            request.setAttribute("selectedCartDetails", selectedCartDetails);
            request.getSession().setAttribute("selectedCartDetails", selectedCartDetails);
            Customer cus = DAO.getCustomerDetailsByUsername(username);
            request.setAttribute("address", cus.getAddress());
            request.setAttribute("name", cus.getCustomerName());
            request.setAttribute("phone", cus.getPhone());
            System.out.println(cus.getCustomerName() + " : " + cus.getPhone() + " : " + cus.getAddress());
            RequestDispatcher dispatcher = request.getRequestDispatcher("payment.jsp");
            dispatcher.forward(request, response);
        } else {
            response.sendRedirect("LoginServlet");
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
        Cookie[] cookies = request.getCookies();
        int count = 0;
        String username = "";
        if (cookies != null) {
            for (Cookie c : cookies) {
                if (c.getName().equals("_noname")) {
                    username = c.getValue();
                    System.out.println("username=" + username);

                }
            }
        }
        if (username != null) {
            String action = request.getParameter("action");
            String name = request.getParameter("name");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String discount = request.getParameter("discount");
            BigDecimal percentDiscount = new BigDecimal( DAO.getDiscountPercent(username, discount));
            String status = "";

            // Lấy danh sách CartDetail từ session
            ArrayList<CartDetail> cartDetails = (ArrayList<CartDetail>) request.getSession().getAttribute("selectedCartDetails");

            // Kiểm tra action để xác định status
            if ("shipcod".equals(action)) {
                status = "Đang xử lý";
            } else if ("banktransfer".equals(action)) {
                status = "Chờ thanh toán";
            }

            // Lấy tổng giá trị đơn hàng từ cartDetails
            BigDecimal totalAmount = BigDecimal.ZERO;
            BigDecimal discountMultiplier = BigDecimal.ONE.subtract(percentDiscount.divide(BigDecimal.valueOf(100)));
            if (cartDetails != null) {
                for (CartDetail detail : cartDetails) {
                    Product product = DAO.getProductbyID(detail.getProductID(), DAO.getConnection());
                    totalAmount = totalAmount.add(product.getPrice().multiply(new BigDecimal(detail.getQuantity())).multiply(discountMultiplier));
                }
            }

            // Tạo OrderID mới
            // Thêm thông tin vào bảng Orders
            String orderID = DAO.newOrderID();
            DAO.addOrder(orderID, totalAmount.doubleValue(), DAO.getCustomerID(username, DAO.getConnection()), status);

            // Thêm các chi tiết đơn hàng vào bảng OrderDetails
            String cartID = DAO.getCartID(username, DAO.getConnection());
            for (CartDetail detail : cartDetails) {
                Product product = DAO.getProductbyID(detail.getProductID(), DAO.getConnection());
                
                DAO.addOrderDetail(orderID, detail.getProductID(), detail.getQuantity(), product.getPrice().multiply(new BigDecimal(detail.getQuantity())).multiply(discountMultiplier).doubleValue());  // null cho discountCode nếu không có mã giảm giá
                DAO.deleteCartDetail(cartID, detail.getProductID(), DAO.getConnection());
            }

            // Xóa giỏ hàng sau khi thêm vào database thành công
            request.setAttribute("username", username);
            request.setAttribute("orderID", orderID);
                        request.setAttribute("total", totalAmount);

            if (action.equals("shipcod")){
            // Điều hướng đến trang xác nhận
            
            RequestDispatcher dispatcher = request.getRequestDispatcher("success.jsp");
        dispatcher.forward(request, response);}
            else{
                
                RequestDispatcher dispatcher = request.getRequestDispatcher("QRCode.jsp");
        dispatcher.forward(request, response);
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
