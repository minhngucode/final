/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;
import Model.CartDetail;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;


/**
 *
 * @author
 */
public class PaymentServlet extends HttpServlet {

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
        System.out.println("Do ost da toi");
        String[] selectedProducts = request.getParameterValues("selectedProduct");
        String[] selectedCartIDs = request.getParameterValues("selectedCartID");
        String[] selectedQuantities = request.getParameterValues("selectedQuantity");
        ArrayList<CartDetail> selectedCartDetails = new ArrayList<>();

        if (selectedProducts != null) {
            for (int i = 0; i < selectedProducts.length; i++) {
                String productID = selectedProducts[i];
                String cartID = selectedCartIDs[i];
                String quantityStr = selectedQuantities[i];

                try {
                    int quantity = Integer.parseInt(quantityStr);

                    // Tạo đối tượng CartDetail với thông tin đã nhận
                    CartDetail cartDetail = new CartDetail(cartID,productID, quantity);
                    // Thêm vào danh sách sản phẩm được chọn
                    selectedCartDetails.add(cartDetail);

                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }
        }
        request.setAttribute("selectedCartDetails", selectedCartDetails);
        RequestDispatcher dispatcher = request.getRequestDispatcher("payment.jsp");
        dispatcher.forward(request, response);
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
