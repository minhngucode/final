<%@page import="Model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<%
    // Lấy thông tin người dùng từ session
    Customer cus = (Customer) request.getAttribute("Customer");
    System.out.println(cus);
    String username = (String) request.getAttribute("username");
    // Nếu không có thông tin người dùng, chuyển hướng đến trang đăng nhập
    if (username.isEmpty() || cus == null) {
        response.sendRedirect("LoginServlet");
        return;
    }
%>
<style>
    /* Đặt nền tổng thể */
    body {
        background-color: #f5f5f5; /* Nền màu nhạt để tạo cảm giác thanh lịch */
        font-family: Arial, sans-serif;
        color: #333; /* Màu chữ chính là màu tối */
    }

    /* Thẻ card bao quanh form */
    .card {
        max-width: 500px; /* Chiều rộng tối đa cho card */
        margin: auto; /* Căn giữa card */
        border: 2px solid #0689B7;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        border-radius: 8px;
        background-color: white;
        padding: 20px; /* Padding cho card */
        max-width: 600px; /* Chiều rộng tối đa cho card */
        margin: 40px auto; /* Căn giữa card */
    }

    /* Phần tiêu đề */
    h2 {
        color: #0689B7; /* Màu xanh cho tiêu đề */
        text-align: center; /* Căn giữa tiêu đề */
        margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
    }

    /* Căn chỉnh cho từng trường trong form */
    .user-info div {
        margin-bottom: 15px; /* Khoảng cách giữa các trường */
    }

    label {
        font-weight: bold; /* Đậm chữ */
        color: #0689B7; /* Màu xanh cho label */
        display: block; /* Hiển thị label như một khối */
    }

    /* Trường input */
    input[type="text"],
    input[type="email"] {
        border: 1px solid #0689B7; /* Giữ viền màu xanh */
        border-radius: 4px;
        padding: 10px;
        font-size: 16px;
        color: #333;
        width: 100%; /* Đảm bảo input chiếm hết chiều rộng */
        box-sizing: border-box; /* Đảm bảo padding không làm tăng chiều rộng */
    }

    input[readonly] {
        background-color: #e9ecef; /* Màu nền cho input readonly */
    }

    /* Nút Cập Nhật và Đăng Xuất */
    .btn {
        background-color: #0689B7; /* Màu nền cho nút */
        border: none;
        font-size: 16px;
        font-weight: bold;
        color: #fff; /* Màu chữ nút */
        padding: 10px 20px;
        border-radius: 4px;
        transition: background-color 0.3s ease;
        display: inline-block; /* Hiển thị inline-block để căn giữa */
        margin: 10px; /* Margin giữa các nút */
        cursor: pointer; /* Con trỏ khi hover */
    }

    .btn:hover {
        background-color: #055f7d; /* Đổi màu nhẹ khi hover */
    }

    .actions {
        text-align: center; /* Căn giữa các nút hành động */
        margin-top: 20px; /* Khoảng cách trên cho các nút */
    }
</style>

<div class="card">
    <h2>Thông Tin Người Dùng</h2>
    <form action="UserInfo" method="post">
        <div class="user-info">
            <div>
                <label for="customerName"> Họ và Tên: </label>
                <input type="text" id="customerName" name="customerName" value="<%= cus.getCustomerName()%>" required />
            </div>
            <div>
                <label for="username">Tên đăng nhập:</label>
                <input type="text" id="username" name="username" value="<%= username%>" readonly />
            </div>
            <div>
                <label for="email"> Email: </label>
                <input type="email" id="email" name="email" value="<%= cus.getEmail()%>" required />
            </div>
            <div>
                <label for="phone"> Số điện thoại: </label>
                <input type="text" id="phone" name="phone" value="<%= cus.getPhone()%>" required />
            </div>
            <div>
                <label for="address"> Địa chỉ: </label>
                <input type="text" id="address" name="address" value="<%= cus.getAddress()%>" required />
            </div>
        </div>

        <div class="actions">
            <button type="submit" class="btn">Cập Nhật Thông Tin</button>
            <form action="Control?action=logout" method="POST" style="display: inline;">
                <button type="submit" class="btn">Đăng Xuất</button>
            </form>
        </div>
    </form>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
