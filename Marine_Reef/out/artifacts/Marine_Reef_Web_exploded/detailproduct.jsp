<%@ page contentType="text/html" pageEncoding="UTF-8" import="Model.Product" import="java.math.BigDecimal"%>
<%@ page import="java.util.*" %>
<%
    // Giả định sản phẩm được truyền vào từ request với tên là "product"
    Product product = (Product) request.getAttribute("product");

    // Kiểm tra xem sản phẩm có hợp lệ không
    if (product == null) {
        response.sendError(HttpServletResponse.SC_NOT_FOUND, "Sản phẩm không tồn tại");
        return;
    }
%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<div class="container mt-4">
    <h1 class="my-4"><%= product.getName() %></h1>
    <div class="row">
        <div class="col-md-6">
            <img src="images/coral-image/<%= product.getProductID() %>.jpg" 
                 class="img-fluid" alt="<%= product.getName() %>">
        </div>
        <div class="col-md-6">
            <h5>Thông tin sản phẩm</h5>
            <p><strong>Loại:</strong> <%= product.getType() %></p>
            <p><strong>Mô tả:</strong> <%= product.getDescription() %></p>
            <p><strong>Giá:</strong> <%= product.getPrice() %> VNĐ</p>
            <p><strong>Tồn kho:</strong> <%= product.getQuantityInStock() %></p>
            <div class="mt-4">
                <form action="CartServlet" method="post">
                            <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                            <input type="hidden" name="name" value="<%= product.getName() %>">
                            <input type="hidden" name="type" value="<%= product.getType() %>">
                            <input type="hidden" name="description" value="<%= product.getDescription() %>">
                            <input type="hidden" name="price" value="<%= product.getPrice() %>">
                            <input type="hidden" name="costprice" value="<%= product.getCostprice() %>">
                            <input type="hidden" name="quantityInStock" value="<%= product.getQuantityInStock() %>">
                            <input type="hidden" name="categoryID" value="<%= product.getCategoryID() %>">
                            
                            <button type="submit"  name="action" value="addtocart" class="btn btn-primary text-decoration-none" style="width: 26%; text-align: center;">Thêm vào giỏ</button>
                <a href="ProductList" class="btn btn-secondary">Quay lại</a>
            </div>
        </div>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
