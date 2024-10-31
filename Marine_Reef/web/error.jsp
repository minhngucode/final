<%-- 
    Document   : error.jsp
    Created on : 31 Oct 2024, 12:29:50
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Lỗi Truy Cập</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .error-container {
            text-align: center;
            border: 1px solid #dc3545;
            border-radius: 5px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        }
        .error-container h1 {
            color: #dc3545;
        }
        .error-container p {
            margin: 20px 0;
        }
    </style>
</head>
<body>
<div class="error-container">
    <h1>403 - Truy Cập Bị Từ Chối</h1>
    <p>Xin lỗi, bạn không có quyền truy cập vào trang này.</p>
    <a href="Control" class="btn btn-primary">Quay lại trang chính</a>
    <a href="LoginServlet" class="btn btn-secondary">Đăng nhập</a>
</div>
</body>
</html>
