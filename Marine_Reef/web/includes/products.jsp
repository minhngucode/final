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

    </style>
<div class="section">
    <h2>SẢN PHẨM</h2>
    <div class="products">
        <div class="product">
            <img alt="Máy Bơm" height="200" src="images/coral-image/PU001.jpg" width="200"/>
            <h3>Máy Bơm</h3>
        </div>
        <div class="product">
            <img alt="Đèn Cá" height="200" src="images/coral-image/L001.jpg" width="200"/>
            <h3>Đèn Cá</h3>
        </div>
        <div class="product">
            <img alt="San Hô" height="200" src="images/coral-image/CR028.jpg" width="200"/>
            <h3>San Hô</h3>
        </div>
        <div class="product">
            <img alt="Thức Ăn" height="200" src="images/coral-image/FD001.jpg" width="200"/>
            <h3>Thức Ăn</h3>
        </div>
    </div>
</div>

