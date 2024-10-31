<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    ArrayList<String> categoryList = (ArrayList<String>) request.getAttribute("categoryList");
    ArrayList<String> typeList = (ArrayList<String>) request.getAttribute("typeList");
%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <title>Thêm Sản Phẩm</title>
    <style>
        .form-container {
            max-width: 400px; /* Kích thước tối đa của form */
            height: 80vh; /* Chiều cao 80% chiều cao màn hình */
            margin: 20px; /* Khoảng cách xung quanh */
            overflow-y: auto; /* Cuộn dọc khi nội dung vượt quá chiều cao */
            padding: 20px; /* Khoảng cách bên trong */
            border: 1px solid #ccc; /* Đường viền cho form */
            border-radius: 5px; /* Bo góc cho form */
            background-color: #f8f9fa; /* Màu nền nhẹ cho form */
            position: absolute; /* Đặt vị trí tuyệt đối */
            top: 10%; /* Cách mép trên 10% */
            left: 0; /* Đặt sát lề bên trái */
        }
        .form-container h2 {
            font-size: 1.5rem; /* Kích thước tiêu đề nhỏ hơn */
        }
        .form-group {
            margin-bottom: 0.5rem; /* Khoảng cách giữa các trường */
        }
        .form-group label {
            width: 30%; /* Độ rộng của label */
            margin-right: 10px; /* Khoảng cách giữa label và input */
            text-align: right; /* Canh phải cho label */
        }
        .form-row {
            display: flex; /* Sử dụng Flexbox để sắp xếp các label và ô input */
            align-items: center; /* Căn giữa dọc */
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="form-container">
            <h2>Thêm Sản Phẩm</h2>
            <form action="admin" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <label for="name">Tên:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="form-row">
                    <label for="description">Mô Tả:</label>
                    <textarea id="description" name="description" class="form-control" required rows="2"></textarea>
                </div>
                <div class="form-row">
                    <label for="price">Giá:</label>
                    <input type="number" id="price" name="price" class="form-control" step="0.01" required>
                </div>
                <div class="form-row">
                    <label for="quantity">SL:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" required>
                </div>
                <div class="form-row">
                    <label for="categoryname">Danh Mục:</label>
                    <select name="categoryname" id="categoryname" class="form-control">
                        <c:forEach items="${categoryList}" var="category">
                            <option value="${category}">${category}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-row">
                    <label for="type">Loại:</label>
                    <select id="type" name="type" class="form-control" required>
                        <c:forEach items="${typeList}" var="type">
                            <option value="${type}">${type}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-row">
                    <label for="costprice">Giá Thành:</label>
                    <input type="number" id="costprice" name="costprice" class="form-control" step="0.01" required>
                </div>
                <div class="form-row">
                    <label for="image">Ảnh:</label>
                    <input type="file" id="image" name="image" class="form-control-file" accept="image/*" required>
                </div>
                <button type="submit" class="btn btn-primary">Thêm</button>
            </form>
            <a href="ProductList" class="btn btn-secondary mt-3">Quay lại</a>
        </div>
    </div>
</body>
</html>
