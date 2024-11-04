<%@page contentType="text/html; charset=UTF-8" import="java.util.ArrayList" import="Model.Product" import="java.math.BigDecimal"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
<style>
    /* Thẻ card bao quanh form */
    .form_xaydung {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 40px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    /* Phần tiêu đề */
    .form_xaydung h2 {
        color: #0689B7; /* Màu xanh cho tiêu đề */
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
    }

    /* Căn chỉnh cho từng trường trong form */
    label {
        font-weight: 600; /* Đậm chữ */
        color: #0689B7; /* Màu xanh cho label */
        margin: 10px 0  ; /* Khoảng cách trên label */
    }

    /* Trường input và select */
    select,
    input[type="number"] {
        border: 1px solid #0689B7; /* Giữ viền màu xanh */
        border-radius: 4px;
        padding: 5px;
        font-size: 16px;
        color: #333;
        width: 100%; /* Chiều rộng 100% */
        margin-bottom: 20px; /* Khoảng cách giữa các trường */
    }

    select:focus,
    input[type="number"]:focus {
        border-color: #0689B7; /* Giữ màu xanh khi input focus */
        box-shadow: 0 0 5px rgba(6, 137, 183, 0.5); /* Ánh sáng nhẹ khi nhấn vào */
        outline: none;
    }

    /* Chỉnh CSS cho nút "Xây dựng bể cá" */
    .buttonConfirm {
        background-color: #0689B7; /* Màu xanh cho nút */
        color: #fff; /* Màu chữ trắng */
        border: none; /* Không có viền */
        font-size: 18px; /* Kích thước chữ */
        font-weight: bold; /* Chữ đậm */
        padding: 12px 24px; /* Khoảng đệm trong nút */
        border-radius: 6px; /* Bo tròn các góc */
        cursor: pointer; /* Con trỏ chuột khi hover vào */
        display: block; /* Đặt nút là block để căn giữa */
        margin: 20px auto; /* Căn giữa và cách các phần tử xung quanh */
        transition: background-color 0.3s ease; /* Hiệu ứng chuyển đổi màu */
    }

    /* Hiệu ứng khi hover */
    .buttonConfirm:hover {
        background-color: #055f7d; /* Màu đậm hơn khi hover */
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
    $(document).ready(function () {
        $('.product-select').select2({
            templateResult: function (product) {
                if (!product.id) {
                    return product.text;
                }
                var img = $('<img src="images/coral-image/' + product.id + '.jpg" alt="' + product.text + '" />');
                var span = $('<span>' + product.text + ' VND</span>');
                var container = $('<div></div>').append(img).append(span);
                return container;
            },
            templateSelection: function (product) {
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
<div style="margin: 0px 50px; text-align: left">

    <form class="form_xaydung" action="TankBuild" method="post">
        <h2>Xây dựng bể cá của bạn</h2>
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
        <br>
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

        <button class="buttonConfirm" type="submit" style="margin-top: 20px">Xây dựng bể cá</button>

    </form>
</div>
<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
