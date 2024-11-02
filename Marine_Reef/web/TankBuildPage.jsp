<%@page contentType="text/html; charset=UTF-8" import="java.util.ArrayList" import="Model.Product" import="java.math.BigDecimal"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<style>
   body {
    background-color: white; /* Nền trắng */
    color: #003366; /* Màu chữ xanh đại dương */
    font-family: Arial, sans-serif; /* Chọn font chữ */
}

h2 {
    color: #005f7f; /* Màu tiêu đề xanh đậm hơn */
    text-align: center; /* Căn giữa tiêu đề */
    margin: 20px 0; /* Khoảng cách trên và dưới tiêu đề */
}

form {
    max-width: 600px; /* Chiều rộng tối đa của form */
    margin: 0 auto; /* Căn giữa form */
    padding: 20px; /* Đệm trong form */
    border-radius: 8px; /* Bo tròn các góc */
    background-color: rgba(255, 255, 255, 0.8); /* Màu nền trắng có độ trong suốt */
    box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng cho form */
}

label {
    display: block; /* Hiển thị label như block */
    margin: 10px 0 5px; /* Khoảng cách giữa label và input */
    font-weight: bold; /* Chữ in đậm */
    color: #003366; /* Màu chữ label xanh đại dương */
}

input[type="number"], select {
    width: 100%; /* Chiều rộng 100% cho input và select */
    padding: 10px; /* Đệm trong input và select */
    border-radius: 5px; /* Bo tròn các góc */
    border: 1px solid #0077cc; /* Đường viền màu xanh dương */
    background-color: #e6f2ff; /* Màu nền cho input và select */
    color: #003366; /* Màu chữ xanh đại dương */
    margin-bottom: 20px; /* Khoảng cách giữa các trường */
}

input[type="number"]:focus, select:focus {
    outline: none; /* Xóa viền khi input và select được chọn */
    border-color: #005f7f; /* Đổi màu viền khi focus */
    background-color: #cce5ff; /* Đổi màu nền khi focus */
}

button {
    background-color: #0077cc; /* Nền nút màu xanh dương */
    color: white; /* Chữ màu trắng */
    border: none; /* Không có viền */
    padding: 10px 15px; /* Padding cho nút */
    border-radius: 5px; /* Bo góc cho nút */
    cursor: pointer; /* Con trỏ chuột khi di chuột qua */
}

button:hover {
    background-color: #005f7f; /* Thay đổi màu nút khi hover */
}

.select2-selection__rendered img {
    width: 30px; /* Kích thước ảnh trong dropdown */
    height: 30px; /* Kích thước ảnh trong dropdown */
    object-fit: cover; /* Đảm bảo ảnh không bị méo */
    margin-right: 5px; /* Khoảng cách giữa ảnh và text */
}

.select2-results__option img {
    width: 30px; /* Kích thước ảnh trong dropdown */
    height: 30px; /* Kích thước ảnh trong dropdown */
    object-fit: cover; /* Đảm bảo ảnh không bị méo */
}

</style>

<script>
    $(document).ready(function() {
        $('.product-select').select2({
            templateResult: function(product) {
                if (!product.id) {
                    return product.text;
                }
                var img = $('<img src="images/coral-image/' + product.id + '.jpg" alt="' + product.text + '" />');
                var span = $('<span>' + product.text + ' VND</span>');
                var container = $('<div></div>').append(img).append(span);
                return container;
            },
            templateSelection: function(product) {
                if (!product.id) {
                    return product.text;
                }
                return product.text;
            }
        });
    });

    function updateHiddenFields(type) {
        var s1 = '#' + type + ' option:checked';
        var selectedOption = document.querySelector(s1);
        var s2 = type + 'Details';
        var hiddenField = document.getElementById(s2);
        if (selectedOption) {
            var productDetails = {
                productID: selectedOption.value,
                name: selectedOption.getAttribute('data-name'),
                type: selectedOption.getAttribute('data-type'),
                description: selectedOption.getAttribute('data-description'),
                price: selectedOption.getAttribute('data-price'),
                costprice: selectedOption.getAttribute('data-costprice'),
                quantityInStock: selectedOption.getAttribute('data-quantityInStock'),
                categoryID: selectedOption.getAttribute('data-categoryID')
            };
            hiddenField.value = JSON.stringify(productDetails);
        }
    }
</script>

<h2>Xây dựng bể cá của bạn</h2>
<form action="TankBuild" method="post">
    <input type="hidden" name="lightDetails" id="lightDetails">
    <input type="hidden" name="tankDetails" id="tankDetails">
    <input type="hidden" name="pumpDetails" id="pumpDetails">
    <input type="hidden" name="filterMaterialDetails" id="filterMaterialDetails">
    <input type="hidden" name="saltDetails" id="saltDetails">
    <input type="hidden" name="skimmerDetails" id="skimmerDetails">

    <label for="tank">Chọn hồ kính:</label>
    <select name="tank" id="tank" class="product-select" onchange="updateHiddenFields('tank')">
        <option value="">Chọn hồ kính</option>
        <c:forEach var="product" items="${tanks}">
            <option value="${product.productID}" data-name="${product.name}" data-type="${product.type}" data-description="${product.description}" data-price="${product.price}" data-costprice="${product.costprice}" data-quantityInStock="${product.quantityInStock}" data-categoryID="${product.categoryID}">
                ${product.name} - <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND" />
            </option>
        </c:forEach>
    </select>

    <label for="tankDimensions">Kích thước hồ kính (Dài x Rộng x Cao):</label>
    <label for="tankLength">Dài (cm):</label>
    <input type="number" id="tankLength" name="tankLength" required>
    <label for="tankWidth">Rộng (cm):</label>
    <input type="number" id="tankWidth" name="tankWidth" required>
    <label for="tankHeight">Cao (cm):</label>
    <input type="number" id="tankHeight" name="tankHeight" required>

    <label for="pump">Chọn bơm:</label>
    <select name="pump" id="pump" class="product-select" onchange="updateHiddenFields('pump')">
        <option value="">Chọn bơm</option>
        <c:forEach var="product" items="${pumps}">
            <option value="${product.productID}" data-name="${product.name}" data-type="${product.type}" data-description="${product.description}" data-price="${product.price}" data-costprice="${product.costprice}" data-quantityInStock="${product.quantityInStock}" data-categoryID="${product.categoryID}">
                ${product.name} - <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND" />
            </option>
        </c:forEach>
    </select>

    <label for="filterMaterial">Chọn vật liệu lọc:</label>
    <select name="filterMaterial" id="filterMaterial" class="product-select" onchange="updateHiddenFields('filterMaterial')">
        <option value="">Chọn vật liệu lọc</option>
        <c:forEach var="product" items="${filterMaterials}">
            <option value="${product.productID}" data-name="${product.name}" data-type="${product.type}" data-description="${product.description}" data-price="${product.price}" data-costprice="${product.costprice}" data-quantityInStock="${product.quantityInStock}" data-categoryID="${product.categoryID}">
                ${product.name} - <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND" />
            </option>
        </c:forEach>
    </select>

    <label for="salt">Chọn muối:</label>
    <select name="salt" id="salt" class="product-select" onchange="updateHiddenFields('salt')">
        <option value="">Chọn muối</option>
        <c:forEach var="product" items="${salts}">
            <option value="${product.productID}" data-name="${product.name}" data-type="${product.type}" data-description="${product.description}" data-price="${product.price}" data-costprice="${product.costprice}" data-quantityInStock="${product.quantityInStock}" data-categoryID="${product.categoryID}">
                ${product.name} - <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND" />
            </option>
        </c:forEach>
    </select>

    <label for="skimmer">Chọn Skimmer:</label>
    <select name="skimmer" id="skimmer" class="product-select" onchange="updateHiddenFields('skimmer')">
        <option value="">Chọn Skimmer</option>
        <c:forEach var="product" items="${skimmers}">
            <option value="${product.productID}" data-name="${product.name}" data-type="${product.type}" data-description="${product.description}" data-price="${product.price}" data-costprice="${product.costprice}" data-quantityInStock="${product.quantityInStock}" data-categoryID="${product.categoryID}">
                ${product.name} - <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND" />
            </option>
        </c:forEach>
    </select>

    <label for="light">Chọn đèn:</label>
    <select name="light" id="light" class="product-select" onchange="updateHiddenFields('light')">
        <option value="">Chọn đèn</option>
        <c:forEach var="product" items="${lights}">
            <option value="${product.productID}" data-name="${product.name}" data-type="${product.type}" data-description="${product.description}" data-price="${product.price}" data-costprice="${product.costprice}" data-quantityInStock="${product.quantityInStock}" data-categoryID="${product.categoryID}">
                ${product.name} - <fmt:formatNumber value="${product.price}" type="currency" currencySymbol="VND" />
            </option>
        </c:forEach>
    </select>

    <button type="submit">Xây dựng bể cá</button>
</form>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
