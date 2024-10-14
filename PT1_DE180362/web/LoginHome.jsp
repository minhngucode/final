<%-- 
    Document   : Login
    Created on : 7 Oct 2024, 15:56:45
    Author     : 
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Đăng nhập</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">

    </head>
    <body class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <h2 class="mt-4 text-center">Đăng nhập</h2>
                <form action="Login" method="post" class="form-group mt-4">
                    <div class="form-group">
                        <label for="username">Tài khoản:</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="form-group">
                        <label for="password">Mật khẩu:</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-primary btn-block">Đăng nhập</button>
                </form>

                <%-- Hiển thị lỗi đăng nhập nếu có --%>
                <%
                    String error = (String) request.getAttribute("error");
                    if (error != null) {
                %>
                    <div class="alert alert-danger mt-3 text-center"><%= error %></div>
                <%
                    }
                %>
            </div>
        </div>
    </body>
</html>

