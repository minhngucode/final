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
<style>
    /* Phong cách cho nút "Proceed to Payment" và "Continue Shopping" */
    .btn-cart {
        transition: transform 0.3s ease, background 0.3s ease, box-shadow 0.3s ease; /* Hiệu ứng chuyển tiếp cho nút */
        background-color: #0689B7; /* Màu nền */
        border: none; /* Bỏ viền */
        color: white; /* Màu chữ */
        border-radius: 5px; /* Đường viền mềm mại */
        width: auto; /* Tự động điều chỉnh chiều rộng theo nội dung */
        padding: 8px 16px; /* Điều chỉnh khoảng cách bên trong nút */
        margin-right: 10px; /* Khoảng cách giữa các nút */
        text-align: center; /* Căn giữa nội dung nút */
        font-size: 14px; /* Kích thước chữ nhỏ hơn */
    }

    .btn-cart:hover {
        color: white;
        transform: scale(1.1); /* Hiệu ứng phóng to khi hover */
        background: linear-gradient(90deg, #00FF7F, #00BFFF); /* Gradient xanh neon khi hover */
        box-shadow: 0 0 10px #00FF7F, 0 0 20px #00BFFF; /* Viền sáng khi hover */
    }

    /* Căn hai nút sang bên trái */
    .text-right {
        text-align: left; /* Căn nội dung sang trái */
        margin-left: 20px; /* Khoảng cách từ cạnh trái của khung */
    }

</style>
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
<div class="container mt-5" style="margin-bottom: 80px">
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
        <button type="button" class="btn btn-cart text-decoration-none" onclick="submitSelectedProducts()">Proceed to Payment</button>
        <a href="ProductList"><button type="button" class="btn btn-cart text-decoration-none">Continue Shopping</button></a>
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
