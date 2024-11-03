<%-- 
    Document   : error.jsp
    Created on : 31 Oct 2024, 12:29:50
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
    <style>
        .error-container {
            text-align: center;
            border: 1px solid #dc3545;
            border-radius: 5px;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            margin: 200px 30%;
        }
        .error-container h1 {
            color: #dc3545;
        }
        .error-container p {
            margin: 20px 0;
        }
    </style>

<div class="error-container">
    <h1>403 - Truy Cập Bị Từ Chối</h1>
    <p>Xin lỗi, bạn không có quyền truy cập vào trang này.</p>
    <div class="btn-group">
        <a href="Control" class="btn btn-primary">Quay lại trang chính</a>
        <a href="LoginServlet" class="btn btn-secondary">Đăng nhập</a>
    </div>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
