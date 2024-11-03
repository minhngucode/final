<%-- 
    Document   : product
    Created on : 11 Oct 2024, 22:34:48
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .section {
        text-align: center;
    }

    .products {
        display: flex;
        justify-content: space-around;
        flex-wrap: wrap;
    }

    .product {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-end;



        border: 1px solid #ccc;

    }

    .product img {
        flex-grow: 1;
    }

    .product h3 {
        text-align: center;
        margin-top: 10px;
    }

    a {
        text-decoration: none; /* Xóa gạch dưới */
    }

    a h2 {
        color: black; /* Màu đen */
        transition: transform 0.3s ease, color 0.3s ease;
    }

    a:hover h2 {
        color: #0689B7; /* Màu xanh khi hover */
        transform: translateY(-5px);
    }

    .product {
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: flex-end;
        border: 1px solid #ccc;
        cursor: pointer; /* Thêm con trỏ để cho biết có thể click */
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .product:hover {
        transform: translateY(-5px); /* Hiệu ứng nổi */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng */
    }



</style>
<div class="section">
    <a href="ProductList"><h2>SẢN PHẨM</h2></a>
    <div class="products">

        <div class="product" onclick="submitFormWithFilter('ProductList', 'filter', 'Pump')">
            <img alt="Máy Bơm" height="200" src="images/coral-image/PU001.jpg" width="200"/>
            <h3>Máy Bơm</h3>
        </div>

        <div class="product" onclick="submitFormWithFilter('ProductList', 'filter', 'Light')">
            <img alt="Đèn Cá" height="200" src="images/coral-image/L001.jpg" width="200"/>
            <h3>Đèn Cá</h3>
        </div>
        <div class="product" onclick="submitFormWithFilter('ProductList', 'filter', 'Coral')">
            <img alt="San Hô" height="200" src="images/coral-image/CR028.jpg" width="200"/>
            <h3>San Hô</h3>
        </div>
        <div class="product" onclick="submitFormWithFilter('ProductList', 'filter', 'Food')">
            <img alt="Thức Ăn" height="200" src="images/coral-image/FD001.jpg" width="200"/>
            <h3>Thức Ăn</h3>
        </div>

        <script>
    function submitFormWithFilter(actionURL, actionValue, productTypeValue) {
        // Tạo form ẩn
        const form = document.createElement("form");
        form.action = actionURL;
        form.method = "post";
        
        // Tạo input ẩn cho "action"
        const actionInput = document.createElement("input");
        actionInput.type = "hidden";
        actionInput.name = "action";
        actionInput.value = actionValue;
        
        // Tạo input ẩn cho "productType"
        const productTypeInput = document.createElement("input");
        productTypeInput.type = "hidden";
        productTypeInput.name = "productType";
        productTypeInput.value = productTypeValue;
        
        // Thêm các input vào form
        form.appendChild(actionInput);
        form.appendChild(productTypeInput);
        
        // Thêm form vào tài liệu và submit
        document.body.appendChild(form);
        form.submit();
    }
        </script>

    </div>
</div>

