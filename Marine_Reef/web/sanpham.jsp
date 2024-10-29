<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList" import="Model.Product" import="java.math.BigDecimal" import="java.text.NumberFormat" %>
<%
    ArrayList<Product> products = (ArrayList<Product>) request.getAttribute("productList");
    ArrayList<String> productTypes = (ArrayList<String>) request.getAttribute("listtype");

    // Tạo đối tượng NumberFormat để định dạng giá
    NumberFormat numberFormat = NumberFormat.getInstance();
    numberFormat.setGroupingUsed(true); // Bật chế độ nhóm
%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<style>
    .card-img-top {
        width: 100%;
        height: 150px;
        object-fit: contain;
        transition: transform 0.3s ease; /* Hiệu ứng chuyển tiếp cho ảnh */
        display: block; /* Đảm bảo ảnh được hiển thị như một block element */
        margin-left: auto; /* Căn trái */
        margin-right: auto; /* Căn phải */
    }

    .card-img-top:hover {
        transform: scale(1.1); /* Phóng to ảnh khi hover */
    }

    .btn-primary {
        transition: transform 0.3s ease, background 0.3s ease, box-shadow 0.3s ease; /* Hiệu ứng chuyển tiếp cho nút */
        background-color: #0689B7; /* Màu nền mặc định */
        border: none; /* Bỏ viền mặc định */
        color: white; /* Màu chữ mặc định */
        border-radius: 5px; /* Đường viền mềm mại */
    }

    .btn-primary:hover {
        transform: scale(1.1); /* Phóng to nút khi hover */
        background: linear-gradient(90deg, #00FF7F, #00BFFF); /* Gradient xanh neon khi hover */
        box-shadow: 0 0 10px #00FF7F, 0 0 20px #00BFFF; /* Viền sáng khi hover */
    }

    .img-button {
        display: block; /* Hiển thị button như block */
        margin-left: auto; /* Căn trái */
        margin-right: auto; /* Căn phải */
        padding: 0; /* Bỏ padding */
        border: none; /* Bỏ viền */
        background: transparent; /* Nền trong suốt */
    }
</style>
<div class="container">
    <h1 class="my-4">Lọc danh sách sản phẩm</h1>

    <!-- Filter and Search Form -->
    <form action="ProductList" method="post" class="mb-4">
        <input type="hidden" name="action" value="filter">
        <div class="row">
            <div class="col-md-3">
                <label for="productType">Loại sản phẩm</label>
                <select name="productType" id="productType" class="form-control">
                    <option value="">Tất cả</option>
                    <%
                        if (productTypes != null) {
                            for (String type : productTypes) {
                    %>
                    <option value="<%= type %>"><%= type %></option>
                    <%
                            }
                        }
                    %>
                </select>
            </div>
            <div class="col-md-3">
                <label for="searchName">Tên sản phẩm</label>
                <input type="text" name="searchName" id="searchName" class="form-control" placeholder="Nhập tên sản phẩm">
            </div>
            <div class="col-md-3">
                <label for="minPrice">Giá từ</label>
                <input type="number" name="minPrice" id="minPrice" class="form-control" placeholder="VNĐ">
            </div>
            <div class="col-md-3">
                <label for="maxPrice">Đến</label>
                <input type="number" name="maxPrice" id="maxPrice" class="form-control" placeholder="VNĐ">
            </div>
        </div>
        <div class="row mt-3">
            <div class="col-md-12 text-right">
                <button type="submit" class="btn btn-primary">Lọc</button>
            </div>
        </div>
    </form>
</div>

<div class="container">
    <h1 class="my-4">Danh sách sản phẩm</h1>
    <div class="row">
        <%
            if (products != null) {
                for (Product product : products) {
        %>
            <div class="col-lg-3 col-md-4 col-sm-6 mb-4">
                <div class="card h-100" style="height: 300px;"> <!-- Đặt chiều cao tối đa cho card -->
                    <form action="ProductList" method="post">
                        <input type="hidden" name="action" value="detail">
                        <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                        <input type="hidden" name="name" value="<%= product.getName() %>">
                        <input type="hidden" name="type" value="<%= product.getType() %>">
                        <input type="hidden" name="description" value="<%= product.getDescription() %>">
                        <input type="hidden" name="price" value="<%= product.getPrice() %>">
                        <input type="hidden" name="costprice" value="<%= product.getCostprice() %>">
                        <input type="hidden" name="quantityInStock" value="<%= product.getQuantityInStock() %>">
                        <input type="hidden" name="categoryID" value="<%= product.getCategoryID() %>">
                        
                        <button type="submit" class="img-button"> <!-- Căn giữa button ảnh -->
                            <img src="images/coral-image/<%= product.getProductID() %>.jpg" 
                                 class="card-img-top" 
                                 alt="<%= product.getName() %>">
                        </button>
                    </form>
                    <div class="card-body d-flex flex-column" style="flex: 1 0 auto;"> <!-- Đảm bảo card body chiếm phần còn lại -->
                        <form action="ProductList" method="post">
                            <input type="hidden" name="action" value="detail">
                            <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                            <input type="hidden" name="name" value="<%= product.getName() %>">
                            <input type="hidden" name="type" value="<%= product.getType() %>">
                            <input type="hidden" name="description" value="<%= product.getDescription() %>">
                            <input type="hidden" name="price" value="<%= product.getPrice() %>">
                            <input type="hidden" name="costprice" value="<%= product.getCostprice() %>">
                            <input type="hidden" name="quantityInStock" value="<%= product.getQuantityInStock() %>">
                            <input type="hidden" name="categoryID" value="<%= product.getCategoryID() %>">
                            
                            <button type="submit" class="btn btn-link text-decoration-none" style="width: 100%; text-align: left;"><%= product.getName() %></button>
                        </form>
                        <p class="card-text">Loại: <%= product.getType() %></p>
                        <p class="card-text">Giá: <%= numberFormat.format(product.getPrice()) %> VNĐ</p> <!-- Định dạng giá -->
                        <p class="card-text">Tồn kho: <%= product.getQuantityInStock() %></p>
                        <div class="mt-auto text-center">
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="productID" value="<%= product.getProductID() %>">
                            <input type="hidden" name="name" value="<%= product.getName() %>">
                            <input type="hidden" name="type" value="<%= product.getType() %>">
                            <input type="hidden" name="description" value="<%= product.getDescription() %>">
                            <input type="hidden" name="price" value="<%= product.getPrice() %>">
                            <input type="hidden" name="costprice" value="<%= product.getCostprice() %>">
                            <input type="hidden" name="quantityInStock" value="<%= product.getQuantityInStock() %>">
                            <input type="hidden" name="categoryID" value="<%= product.getCategoryID() %>">
                            <button type="submit"  name="action" value="addtocart" class="btn btn-primary text-decoration-none" style="width: 100%; text-align: center;">Thêm vào giỏ</button>
                        </form>
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
