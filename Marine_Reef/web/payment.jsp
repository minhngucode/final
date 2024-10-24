<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.Locale" %>
<%@ page import="Model.DBConnect" %>
<%@ page import="Model.CartDetail" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="Model.Product" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<%
    // Định dạng giá tiền theo VNĐ
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
    // Giả sử bạn đã có một ArrayList các đối tượng CartDetail
    DBConnect DAO = new DBConnect();
    ArrayList<CartDetail> cartDetails = (ArrayList<CartDetail>) request.getAttribute("selectedCartDetails");
    BigDecimal totalPrice = BigDecimal.ZERO; // Biến lưu tổng giá trị giỏ hàng

    if (cartDetails != null && !cartDetails.isEmpty()) {
%>
<div class="container mt-5">
    <h2 class="text-center mb-4 xeon-blue p-3 rounded">Thanh toán</h2>
    <table class="table table-bordered table-hover">
        <thead class="xeon-blue">
        <tr>
            <th>Product Image</th>
            <th>Product Name</th>
            <th class="text-center">Quantity</th>
            <th class="text-center">Price</th>
            <th class="text-center">Total</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (CartDetail cartDetail : cartDetails) {
                // Lấy sản phẩm từ productID trong cartDetail
                Product product = DAO.getProductbyID(cartDetail.getProductID(), DAO.getConnection());

                // Tính tổng giá của sản phẩm
                BigDecimal productTotal = product.getPrice().multiply(new BigDecimal(cartDetail.getQuantity()));

                // Cộng vào tổng giá của giỏ hàng
                totalPrice = totalPrice.add(productTotal);

                // Đường dẫn tới hình ảnh sản phẩm
                String imagePath = "images/coral-image/" + product.getProductID() + ".jpg";
        %>

        <tr>
            <td>
                <img src="<%= imagePath %>" alt="Product Image" class="img-fluid rounded" style="max-width: 100px; max-height: 100px;">
            </td>
            <td><%= product.getName() %></td>
            <td class="text-center">
                <span class="mx-2" id="quantity_<%= cartDetail.getProductID() %>"><%= cartDetail.getQuantity() %></span>
            </td>
            <td class="text-center"><%= currencyVN.format(product.getPrice()) %></td>
            <td class="text-center"><%= currencyVN.format(productTotal) %></td>
        </tr>


        <%
            } // Kết thúc vòng lặp
        %>

        <tr class="xeon-blue">
            <td colspan="4" class="text-right"><strong>Total Price:</strong></td>
            <td colspan="2" class="text-center"><strong id="totalPrice"><%= currencyVN.format(totalPrice) %></strong></td>
        </tr>
        </tbody>
    </table>

    <div class="text-right">
        <button type="button" class="btn btn-xeon btn-lg" onclick="submitSelectedProducts()">Proceed to Payment</button>
        <a href="products.jsp" class="btn btn-outline-xeon btn-lg">Continue Shopping</a>
    </div>
</div>

<%
} else {
%>
<div class="container mt-5">
    <p class="alert alert-warning text-center">Your cart is empty.</p>
</div>
<%
    }
%>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
