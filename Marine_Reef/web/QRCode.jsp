<%@page import="java.math.BigDecimal"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.net.URLEncoder" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
    <style>
        .container {
            display: flex;
            justify-content: space-between;
            gap: 2%; /* Khoảng cách giữa các phần */
        }
        .left, .right {
            width: 48%; /* Tỉ lệ gần đúng 50/50 */
        }
        .right img {
            width: 100%; /* Đảm bảo ảnh QR chiếm hết chiều rộng của phần tử bên phải */
        }
        h1, h2 {
            text-align: center;
        }
        ul {
            list-style-type: none;
            padding: 0;
        }
        li {
            margin-bottom: 10px;
        }
    </style>
    <h1 style="padding-top: 20px;">Chuyển khoản qua mã QR</h1>
    <%
        String bankAccountNumber = "5660324643"; // Số tài khoản nhận
        String bankName = "BIDV";
        String accountHolder = "NGUYEN VAN HUAN";
        BigDecimal amount = (BigDecimal) request.getAttribute("total");
        String orderID = (String) request.getAttribute("orderID");
        String username = (String) request.getAttribute("username");
        String transferContent = "TT_" + orderID + "_" + username; // Nội dung chuyển khoản
    %>
    <div class="container">
        <div class="left">
            <h2>Thông tin chuyển khoản</h2>
            <ul>
                <li><strong>Ngân hàng:</strong> <%= bankName %></li>
                <li><strong>Số tài khoản:</strong> <%= bankAccountNumber %></li>
                <li><strong>Tên chủ tài khoản:</strong> <%= accountHolder %></li>
                <li><strong>Số tiền:</strong> <%= amount %> VND</li>
                <li><strong>Nội dung chuyển khoản:</strong> <%= transferContent %></li>
            </ul>
        </div>
        <div class="right">
            <img src="images/qr/Banking.png" alt="QR Code để chuyển khoản" style="width: 50%">
        </div>
    </div>
<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/> 
