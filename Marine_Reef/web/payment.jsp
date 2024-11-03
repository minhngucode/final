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
    /* Styles for Proceed to Payment and Continue Shopping buttons */
    .btn-cart {
        transition: transform 0.3s ease, background 0.3s ease, box-shadow 0.3s ease;
        background-color: #0689B7;
        border: none;
        color: white;
        border-radius: 5px;
        width: auto;
        padding: 8px 16px;
        margin-right: 10px;
        text-align: center;
        font-size: 14px;
    }
    .btn-cart:hover {
        color: white;
        transform: scale(1.1);
        background: linear-gradient(90deg, #00FF7F, #00BFFF);
        box-shadow: 0 0 10px #00FF7F, 0 0 20px #00BFFF;
    }
    .text-right {
        text-align: left;
        margin-left: 20px;
    }
</style>

<%
    Locale localeVN = new Locale("vi", "VN");
    NumberFormat currencyVN = NumberFormat.getCurrencyInstance(localeVN);
    DBConnect DAO = new DBConnect();
    ArrayList<CartDetail> cartDetails = (ArrayList<CartDetail>) request.getAttribute("selectedCartDetails");
    BigDecimal totalPrice = BigDecimal.ZERO;
    
    if (cartDetails == null) {
        // Giả sử bạn đã có phương thức để lấy danh sách giỏ hàng từ cơ sở dữ liệu
        request.getSession().setAttribute("selectedCartDetails", cartDetails); // Lưu vào session
    }

    // Lấy thông tin địa chỉ và người dùng
    String address = (String) request.getAttribute("address");
    String name = (String) request.getAttribute("name");
    String phone = (String) request.getAttribute("phone");
    System.out.println(address + " ; " + name + " ; " + phone);
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
                Product product = DAO.getProductbyID(cartDetail.getProductID(), DAO.getConnection());
                BigDecimal productTotal = product.getPrice().multiply(new BigDecimal(cartDetail.getQuantity()));
                totalPrice = totalPrice.add(productTotal);
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
            }
        %>

        <tr class="xeon-blue">
            <td colspan="4" class="text-right"><strong>Total Price:</strong></td>
            <td colspan="2" class="text-center"><strong id="totalPrice"><%= currencyVN.format(totalPrice) %></strong></td>
        </tr>
        </tbody>
    </table>

    <!-- Shipping Address and Payment Options -->
    <form action="PaymentServlet" method="POST">
        <div class="container mt-5">
            <h4 class="text-center mb-4 xeon-blue">Thông tin người nhận</h4>
            <div class="mb-3">
                <label for="name" class="form-label">Tên</label>
                <input type="text" class="form-control" id="name" name="name" value="<%= name != null ? name : "" %>" required>
            </div>
            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="text" class="form-control" id="phone" name="phone" value="<%= phone != null ? phone : "" %>" required>
            </div>
            <div class="mb-3">
                <label for="address" class="form-label">Địa chỉ giao hàng</label>
                <input type="text" class="form-control" id="address" name="address" value="<%= address != null ? address : "" %>" required placeholder="Nhập địa chỉ giao hàng">
            </div>
             <div class="mb-3">
                <label for="discount" class="form-label">Discount Code</label>
                <input type="text" class="form-control" id="discount" name="discount" >
            </div>
        </div>

        <!-- Payment Buttons with Hidden Actions -->
        <div class="text-right">
            <button type="submit" class="btn btn-cart" name="action" value="shipcod">Ship COD</button>
            <button type="submit" class="btn btn-cart" name="action" value="banktransfer">Chuyển khoản ngân hàng</button>
            <a href="ProductList" class="btn btn-cart text-decoration-none">Continue Shopping</a>
        </div>
    </form>
</div>

<%
    } else {
%>
<div class="container mt-5">
    <p class="alert alert-warning text-center">Giỏ hàng của bạn đang trống.</p>
</div>
<%
    }
%>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
