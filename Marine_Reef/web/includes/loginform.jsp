<%-- 
    Document   : loginform
    Created on : 22 Oct 2024, 21:07:01
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    /* Đặt nền tổng thể */
    body {
        background-color: #f5f5f5; /* Nền màu nhạt để tạo cảm giác thanh lịch */
        font-family: Arial, sans-serif;
        color: #333; /* Màu chữ chính là màu tối */
    }

    /* Thẻ card bao quanh form */
    .card {
        border: 2px solid #0689B7;
        box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
        border-radius: 8px;
        overflow: hidden;
        background-color: white;
    }

    /* Phần tiêu đề */
    .card h3 {
        color: #0689B7;
        font-weight: bold;
        margin-bottom: 20px;
    }

    /* Căn chỉnh cho từng trường trong form */
    .form-group label {
        font-weight: 600;
        color: #0689B7;
    }

    /* Trường input */
    .form-control {
        border: 1px solid #0689B7;
        border-radius: 4px;
        padding: 10px;
        font-size: 16px;
        color: #333;
    }

    .form-control:focus {
        border-color: #0689B7;
        box-shadow: 0 0 5px rgba(6, 137, 183, 0.5); /* Ánh sáng nhẹ khi nhấn vào */
    }

    /* Nút Login */
    .btn-primary {
        background-color: #0689B7;
        border: none;
        font-size: 18px;
        font-weight: bold;
        color: #fff;
        padding: 10px 20px;
        border-radius: 4px;
        transition: background-color 0.3s ease;
    }

    .btn-primary:hover {
        background-color: #055f7d; /* Đổi màu nhẹ khi hover để tạo cảm giác tương tác */
    }

    /* Margin cho form */
    .card-body {
        padding: 30px 40px;
    }

    /* Tạo khoảng trống cho toàn bộ trang */
    html, body {
        margin: 0;
        padding: 0;
    }

</style>
<div class="container" style="margin-bottom: 9%; margin-top: 5%">
    <div class="row justify-content-center">
        <div class="col-md-4">
            <div class="card mt-5">
                <div class="card-body">
                    <h3 class="text-center mb-4">Login</h3>
                    <form action="LoginServlet" method="post">
                        <div class="form-group">
                            <label for="username">Username</label>
                            <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
                        </div>
                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter password" required>
                        </div>
                        <div class="d-flex justify-content-center" style="padding-top: 3%">
                            <button type="submit" class="btn btn-primary">Login</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
