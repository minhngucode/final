<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList" import="Model.Product" import="java.math.BigDecimal"%>
<%@ page import="Model.CartDetail" %>
<%@ page import="Model.DBConnect" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<%
    // Giả sử bạn đã có một ArrayList các đối tượng CartDetail
    DBConnect DAO = new DBConnect();
    ArrayList<CartDetail> cartDetails = (ArrayList<CartDetail>) request.getAttribute("cartDetails");
    BigDecimal totalPrice = BigDecimal.ZERO; // Biến lưu tổng giá trị giỏ hàng
    
    if (cartDetails != null && !cartDetails.isEmpty()) {
%>

<div class="container mt-5">
    <h2 class="text-center mb-4">Your Shopping Cart</h2>
    <table class="table table-bordered table-hover">
        <thead class="thead-dark">
            <tr>
                <th>Product Image</th>
                <th>Product Name</th>
                <th>Quantity</th>
                <th>Price</th>
                <th>Total</th>
                <th>Action</th>
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
                <img src="<%= imagePath %>" alt="Product Image" class="img-fluid" style="max-width: 100px; max-height: 100px;">
            </td>
            <td><%= product.getName() %></td>
            <td><%= cartDetail.getQuantity() %></td>
            <td><%= product.getPrice() %></td>
            <td><%= productTotal %></td>
            
        </tr>
        
        <%
            } // Kết thúc vòng lặp
        %>
        
        <tr>
            <td colspan="4" class="text-right"><strong>Total Price:</strong></td>
            <td colspan="2"><strong><%= totalPrice %></strong></td>
        </tr>
        </tbody>
    </table>

    <div class="text-right">
        <a href="checkout.jsp" class="btn btn-success">Proceed to Checkout</a>
        <a href="products.jsp" class="btn btn-primary">Continue Shopping</a>
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
