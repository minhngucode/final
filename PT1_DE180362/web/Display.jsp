<%-- 
    Document   : Display.jsp
    Created on : 25 Sept 2024, 13:22:46
    Author     : 
--%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList" import="Model.Book"%>
<%@ page isELIgnored="False"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page import="java.util.Locale" %>



<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">        
        <title>Book</title>
    </head>
    <body class="container">
        <% if (request.getAttribute("username") != null) { %>
        
        <!-- Lời chào người dùng -->
        <p class="mt-3">Xin chào, <strong>${username}</strong></p>
        <h1 class="mt-4">Danh sách sách</h1>

        <!-- Bảng hiển thị danh sách sách -->
        <table class="table table-bordered table-striped table-hover">
            <thead class="thead-dark">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Date Published</th>
                    <th>Quantity</th>
                </tr>
            </thead>
            <tbody>
                <% if (request.getAttribute("listBook") != null)  { %>
                        <c:forEach var="b" items="${listBook}">
                            <tr>
                                <td>${b.id}</td>
                                <td>${b.title}</td>
                                <td>${b.author}</td>
                                <td>${b.dop}</td>
                                <td>${b.quantity}</td>
                            </tr>
                        </c:forEach>
                    <%} else {%>
            <p> Không có danh sách </p> 
            <% }%>
            </tbody>
        </table>
          <!-- Thiết lập locale mặc định -->
    <fmt:setLocale value="vi_VN" />

    <!-- Hiển thị số với locale mặc định -->
    <c:set var="amount" value="1234567.89" />
    
    <h1>Giá trị số theo locale mặc định:</h1>
    <p>
        <fmt:formatNumber value="${amount}" type="currency"  />
    </p>        <!-- Form thêm sách -->
        <h2 class="mt-4">Thêm sách</h2>
        <form action="Main?action=add" method="post" class="mt-3">
            <div class="form-group">
                <label for="title">Title:</label>
                <input type="text" class="form-control" id="title" name="title" placeholder="Nhập tiêu đề" required>
            </div>
            <div class="form-group">
                <label for="author">Author:</label>
                <input type="text" class="form-control" id="author" name="author" placeholder="Nhập tên tác giả" required>
            </div>
            <div class="form-group">
                <label for="publicationDate">Publication Date (YYYY-MM-DD):</label>
                <input type="date" class="form-control" id="publicationDate" name="publicationDate" required>
            </div>
            <div class="form-group">
                <label for="quantity">Quantity:</label>
                <input type="number" class="form-control" id="quantity" name="quantity" placeholder="Nhập số lượng" required>
            </div>
            <button type="submit" class="btn btn-success btn-block">Thêm sách</button>
        </form>

        <form action="Main?action=logout" method="post" class="mt-3">
            <button type="submit" class="btn btn-danger btn-block">Logout</button>
        </form>
        
        <% } else { %>
        <h1 class="mt-5 text-center">Vui lòng đăng nhập</h1>
        <a href="login.jsp" class="btn btn-primary mt-3 text-center">Đến trang đăng nhập</a>
        <% } %>
    </body>
</html>
