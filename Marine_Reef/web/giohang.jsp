<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList" import="Model.Product" import="java.math.BigDecimal"%>
<%@ page import="Model.CartDetail" %>
<%@ page import="Model.DBConnect" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.text.NumberFormat" %>
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
    // Sử dụng currencyVN.format(...) để định dạng giá
%>
<%
    // Giả sử bạn đã có một ArrayList các đối tượng CartDetail
    DBConnect DAO = new DBConnect();
    ArrayList<CartDetail> cartDetails = (ArrayList<CartDetail>) request.getAttribute("cartDetails");
    BigDecimal totalPrice = BigDecimal.ZERO; // Biến lưu tổng giá trị giỏ hàng
    if (cartDetails != null && !cartDetails.isEmpty()) {
%>

<div class="container mt-5" style="margin-bottom: 80px">
    <h2 class="text-center mb-4 xeon-blue p-3 rounded" style="color: #0689B7">Giỏ hàng</h2>
    <table class="table table-bordered table-hover">
        <thead class="xeon-blue">
        <tr>
            <th> Chọn tất cả
                <input type="checkbox" id="selectAll" onclick="toggleSelectAll(this)" />

            </th>
            <th>Ảnh sản phẩm</th>
            <th>Tên sản phẩm</th>
            <th class="text-center">Số lượng</th>
            <th class="text-center">Giá</th>
            <th class="text-center">Tổng</th>
            <th class="text-center">Xóa sản phẩm</th>
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
                <input type="checkbox" class="selectProduct" value="<%= cartDetail.getProductID() %>" data-cartid="<%= cartDetail.getCartID() %>" />
            </td>
            <td>
                <img src="<%= imagePath %>" alt="Product Image" class="img-fluid rounded" style="max-width: 100px; max-height: 100px;">
            </td>
            <td><%= product.getName() %></td>
            <td class="text-center">
                <button class="btn btn-sm btn-xeon mr-1" onclick="updateQuantity('<%= cartDetail.getCartID() %>', '<%= cartDetail.getProductID() %>', -1)">-</button>
                <span class="mx-2" id="quantity_<%= cartDetail.getProductID() %>"><%= cartDetail.getQuantity() %></span>
                <button class="btn btn-sm btn-xeon ml-1" onclick="updateQuantity('<%= cartDetail.getCartID() %>', '<%= cartDetail.getProductID() %>', 1)">+</button>
                <input type="hidden" id="hidden_quantity_<%= cartDetail.getProductID() %>" value="<%= cartDetail.getQuantity() %>" />
            </td>
            <td class="text-center"><%= currencyVN.format(product.getPrice()) %></td>
            <td class="text-center" id="productTotal_<%= cartDetail.getProductID() %>"><%= currencyVN.format(productTotal)%></td>
            <td class="text-center">
                <form action="CartServlet" method="post">
                    <input type="hidden" name="action" value="remove" />
                    <input type="hidden" name="cartID" value="<%= cartDetail.getCartID() %>" />
                    <input type="hidden" name="productID" value="<%= cartDetail.getProductID() %>" />
                    <button type="submit" class="btn btn-danger btn-sm">Xóa</button>
                </form>
            </td>
        </tr>
        <%
            } // Kết thúc vòng lặp
        %>
        <tr class="xeon-blue">
            <td colspan="4" class="text-right"><strong>Tổng giá:</strong></td>
            <td colspan="2" class="text-center"><strong id="totalPrice"><%= currencyVN.format(totalPrice) %></strong></td>
        </tr>
        </tbody>
    </table>

    <div class="text-right">
        <button type="button" class="btn btn-cart text-decoration-none" onclick="submitSelectedProducts()">Thanh Toán</button>
        <a href="ProductList"><button type="button" class="btn btn-cart text-decoration-none">Tiếp tục mua sắm</button></a>
    </div>
</div>

<%
} else {
%>
<div class="container mt-5" style="height: 400px">
    <p class="alert alert-warning text-center">Your cart is empty.</p>
</div>
<%}%>

<jsp:include page="includes/footer.jsp"/>
<script>
    function submitSelectedProducts() {
        // Lấy danh sách checkbox đã chọn
        const selectedProducts = document.querySelectorAll('.selectProduct:checked');
        if (selectedProducts.length === 0) {
            alert('Please select at least one product.');
            return;
        }
        // Tạo form ẩn
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = 'PaymentServlet';
        // Thêm các productID, cartID và số lượng đã chọn vào form
        selectedProducts.forEach(function(product) {
            const productID = product.value;
            const cartID = product.getAttribute('data-cartid');
            const quantity = document.getElementById('hidden_quantity_' + productID).value;
            // Thêm productID
            const inputProductID = document.createElement('input');
            inputProductID.type = 'hidden';
            inputProductID.name = 'selectedProduct';
            inputProductID.value = productID;
            form.appendChild(inputProductID);
            // Thêm cartID
            const inputCartID = document.createElement('input');
            inputCartID.type = 'hidden';
            inputCartID.name = 'selectedCartID';
            inputCartID.value = cartID;
            form.appendChild(inputCartID);
            // Thêm số lượng
            const inputQuantity = document.createElement('input');
            inputQuantity.type = 'hidden';
            inputQuantity.name = 'selectedQuantity';
            inputQuantity.value = quantity;
            form.appendChild(inputQuantity);
        });
        // Thêm form vào body và submit
        document.body.appendChild(form);
        form.submit();
    }
    function formatVND(amount) {
        return new Intl.NumberFormat('vi-VN', { style: 'currency', currency: 'VND' }).format(amount);
    }
    function updateQuantity(cartID, productID, delta) {
        var xhr = new XMLHttpRequest();
        xhr.open("POST", "CartServlet", true);
        xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
        // Xử lý khi server trả về kết quả
        xhr.onreadystatechange = function() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                var response = JSON.parse(xhr.responseText);
                if (response.success) {
                    // Cập nhật lại số lượng và giá
                    document.getElementById('quantity_' + productID).innerText = response.newQuantity;
                    document.getElementById('hidden_quantity_' + productID).value = response.newQuantity;
                    document.getElementById('productTotal_' + productID).innerText = formatVND(response.productTotal);
                      console.log('productTotal_' + productID)
                    console.log(response.productTotal)
                    document.getElementById('totalPrice').innerText = formatVND(response.totalPrice);
                }
            }
        };
        // Gửi yêu cầu đến servlet với cartID, productID và delta (tăng/giảm)
        xhr.send("action=updateQuantity&cartID=" + cartID + "&productID=" + productID + "&delta=" + delta);
    }
    function toggleSelectAll(source) {
        const checkboxes = document.querySelectorAll('.selectProduct');
        checkboxes.forEach((checkbox) => {
            checkbox.checked = source.checked;
        });
    }
</script>
<jsp:include page="includes/endtag.jsp"/>
