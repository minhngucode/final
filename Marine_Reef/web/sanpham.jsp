<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList" import="Model.Product" import="java.math.BigDecimal"%>
<%
    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("productList"); 
%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<div class="container">
    <h1 class="my-4">Danh sách sản phẩm</h1>
    <div class="row">
        <%
            if (products != null) {
                for (Product product : products) {
        %>
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card h-100" style="height: 300px;"> <!-- Đặt chiều cao tối đa cho card -->
                    <img src="images/coral-image/<%= product.getProductID() %>.jpg" 
                         class="card-img-top" 
                         alt="<%= product.getName() %>" 
                         style="width: 100%; height: 150px; object-fit: cover;"> <!-- Ảnh rộng bằng card -->
                    <div class="card-body d-flex flex-column" style="flex: 1 0 auto;"> <!-- Đảm bảo card body chiếm phần còn lại -->
                        <h5 class="card-title"><%= product.getName() %></h5>
                        <p class="card-text">Loại: <%= product.getType() %></p>
                        <p class="card-text">Giá: <%= product.getPrice() %> VNĐ</p>
                        <p class="card-text">Tồn kho: <%= product.getQuantityInStock() %></p>
                        <div class="mt-auto text-center"> <!-- Căn giữa nút -->
                            <a href="addToCart.jsp?productId=<%= product.getProductID() %>" class="btn btn-primary">Thêm vào giỏ</a>
                        </div>
                    </div>
                </div>
            </div>
        <%
                }
            }
        %>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
