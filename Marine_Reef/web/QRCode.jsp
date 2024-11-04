<%@page import="java.math.BigDecimal"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<style>
    body {
        background-color: #f5f5f5; /* Nền màu nhạt */
        font-family: Arial, sans-serif;
        color: #333; /* Màu chữ chính */
        margin: 0; /* Loại bỏ margin mặc định */
    }
    .containerr {
        display: flex;
        justify-content: space-between;
        gap: 2%; /* Khoảng cách giữa các phần */
        background-color: white; /* Nền trắng cho container */
        border: 2px solid #0689B7; /* Viền màu xanh */
        border-radius: 8px; /* Bo góc cho container */
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng cho container */
        padding: 20px; /* Padding cho container */
        max-width: 1000px; /* Chiều rộng tối đa cho container */
        margin: 30px auto; /* Căn giữa container trên trang */
    }
    .left {
        width: 48%; /* Tỉ lệ gần đúng 50/50 */
        padding: 20px 40px;
    }
    .right {
        width: 48%; /* Tỉ lệ gần đúng 50/50 */
        text-align: center;
    }
    .right img {
        width: 100%; /* Đảm bảo ảnh QR chiếm hết chiều rộng của phần tử bên phải */
        border: 2px solid #0689B7; /* Viền cho hình ảnh */
        border-radius: 8px; /* Bo góc cho hình ảnh */
        box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1); /* Đổ bóng cho hình ảnh */
    }
    h1 {
        text-align: center; /* Căn giữa tiêu đề */
        padding-top: 20px; /* Khoảng cách trên cho tiêu đề */
        color: #0689B7; /* Màu tiêu đề */
        margin-bottom: 30px; /* Khoảng cách dưới tiêu đề */
    }
    ul {
        list-style-type: none;
        padding: 0;
    }
    li {
        margin: 10px 0; /* Khoảng cách cho các mục danh sách */
        font-size: 16px; /* Kích thước chữ */
    }
    strong {
        color: #0689B7; /* Màu cho chữ in đậm */
    }
</style>
<h1 style="padding-top: 30px;">Chuyển khoản qua mã QR</h1>
<%
    String bankAccountNumber = "5660324643"; // Số tài khoản nhận
    String bankName = "BIDV";
    String accountHolder = "NGUYEN VAN HUAN";
    BigDecimal amount = (BigDecimal) request.getAttribute("total");
    String orderID = (String) request.getAttribute("orderID");
    String username = (String) request.getAttribute("username");
    String transferContent = "TT_" + orderID + "_" + username; // Nội dung chuyển khoản
%>
<div class="containerr">
    <div class="left">
        <h2>Thông tin chuyển khoản</h2>
        <ul>
            <li><strong>Ngân hàng:</strong> <%= bankName%></li>
            <li><strong>Số tài khoản:</strong> <%= bankAccountNumber%></li>
            <li><strong>Tên chủ tài khoản:</strong> <%= accountHolder%></li>
            <li><strong>Số tiền:</strong> <%= amount%> VND</li>
            <li><strong>Nội dung chuyển khoản:</strong> <%= transferContent%></li>
        </ul>
    </div>
    <div class="right">
        <img src="images/qr/Banking.png" alt="QR Code để chuyển khoản" style="width: 50%">
    </div>
</div>
<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/> 
