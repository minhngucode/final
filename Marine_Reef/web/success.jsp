<%-- 
    Document   : success
    Created on : 3 Nov 2024, 16:46:23
    Author     : 
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<style>
    /* Đặt nền tổng thể */
    body {
        background-color: #f5f5f5; /* Nền màu nhạt */
        font-family: Arial, sans-serif;
        color: #333; /* Màu chữ chính */
        margin: 0; /* Loại bỏ margin mặc định */
    }

    /* Phần thông báo đơn hàng thành công */
    .orderSuccess {
        background-color: white; /* Nền trắng cho card */
        border: 2px solid #0689B7; /* Viền màu xanh */
        border-radius: 8px; /* Bo góc cho card */
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng cho card */
        padding: 40px; /* Padding cho card */
        text-align: center; /* Căn giữa nội dung */
        margin: 80px auto; /* Giữ nguyên margin để căn giữa trên trang */
        max-width: 600px; /* Chiều rộng tối đa cho card */
    }

    /* Tiêu đề */
    h1 {
        color: #0689B7; /* Màu xanh cho tiêu đề */
        margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
    }

    /* Đoạn văn */
    p {
        margin: 15px 0; /* Khoảng cách cho các đoạn văn */
        font-size: 16px; /* Kích thước chữ */
        line-height: 1.5; /* Khoảng cách giữa các dòng */
    }

    /* Nút quay về trang chủ */
    .back {
        display: inline-block; /* Hiển thị dưới dạng khối nội tuyến */
        background-color: #0689B7; /* Màu nền cho nút */
        color: white; /* Màu chữ */
        padding: 10px 20px; /* Padding cho nút */
        border-radius: 10px; /* Bo góc cho nút */
        text-decoration: none; /* Loại bỏ gạch chân */
        font-weight: bold; /* Chữ đậm */
        margin-top: 20px; /* Khoảng cách trên cho nút */
        transition: background-color 0.3s; /* Hiệu ứng chuyển màu khi hover */
    }

    .back:hover {
        background-color: #055f7d; /* Đổi màu khi hover */
    }
</style>

<div class="orderSuccess" style="margin: 80px auto;">
    <h1>Đã đặt hàng thành công!</h1>
    <p>Xin chào, <strong><%= request.getAttribute("username") %></strong>.</p>
    <p>Đơn hàng của bạn với mã <strong>OR<%= request.getAttribute("orderID") %></strong> đang được xử lý, vui lòng theo dõi thông tin đơn hàng để biết thêm chi tiết.</p>
    <p>Cảm ơn bạn đã mua sắm với chúng tôi!</p>
    <a class="back" href="Control">Quay về trang chủ</a>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/> 
