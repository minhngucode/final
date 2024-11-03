<%-- 
    Document   : success
    Created on : 3 Nov 2024, 16:46:23
    Author     : 
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Thanh toán thành công</title>
</head>
<body>
    <h1>Đã thanh toán thành công!</h1>
    <p>Xin chào, <strong><%= request.getAttribute("username") %></strong>.</p>
    <p>Đơn hàng của bạn với mã <strong><%= request.getAttribute("orderID") %></strong> đã được thanh toán thành công.</p>
    <p>Cảm ơn bạn đã mua sắm với chúng tôi!</p>
    <a href="Control">Quay về trang chủ</a>
</body>
</html>
