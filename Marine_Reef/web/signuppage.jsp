<%-- 
    Document   : signup
    Created on : 23 Oct 2024, 20:00:14
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
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
        max-width: 800px; /* Chiều rộng tối đa cho card */
        margin: 40px auto; /* Căn giữa card */
    }

    /* Phần tiêu đề */
    .card h2 {
        color: #0689B7; /* Màu xanh cho tiêu đề */
        font-weight: bold;
        text-align: center;
        margin-bottom: 20px; /* Khoảng cách dưới tiêu đề */
    }

    /* Căn chỉnh cho từng trường trong form */
    .mb-3 label {
        font-weight: 600; /* Đậm chữ */
        color: #0689B7; /* Màu xanh cho label */
    }

    /* Trường input */
    .form-control {
        border: 1px solid #0689B7; /* Giữ viền màu xanh */
        border-radius: 4px;
        padding: 10px;
        font-size: 16px;
        color: #333;
    }

    .form-control:focus {
        border-color: #0689B7; /* Giữ màu xanh khi input focus */
        box-shadow: 0 0 5px rgba(6, 137, 183, 0.5); /* Ánh sáng nhẹ khi nhấn vào */
    }

    /* Nút Sign Up */
    .btn-info {
        background-color: #0689B7; /* Màu nền cho nút */
        border: none;
        font-size: 18px;
        font-weight: bold;
        color: #fff; /* Màu chữ nút */
        padding: 10px 20px;
        border-radius: 4px;
        transition: background-color 0.3s ease;
        display: block; /* Đặt chế độ hiển thị là block để có thể căn giữa */
        margin: 0 auto; /* Căn giữa nút */
    }

    .btn-info:hover {
        background-color: #055f7d; /* Đổi màu nhẹ khi hover */
    }

    /* Margin cho form */
    .card-body {
        padding: 30px 40px; /* Padding cho card body */
    }
</style>

<div class="card">
    <div class="card-body">
        <h2>Sign Up</h2>
        <form action="Signup" method="post" onsubmit="return validateForm()">

            <!-- Name Field -->
            <div class="form-group mb-3">
                <label for="name">Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <div class="form-group mb-3">
                <label for="username">Username</label>
                <input type="text" class="form-control" id="username" name="username" required>
            </div>

            <div class="form-group mb-3">
                <label for="password">Password</label>
                <input type="password" class="form-control" id="password" name="password" required>
            </div>

            <div class="form-group mb-3">
                <label for="confirmPassword">Confirm Password</label>
                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
            </div>

            <div id="passwordError" style="color: red;"></div>

            <div class="form-group mb-3">
                <label for="email">Email</label>
                <input type="email" class="form-control" id="email" name="email" required>
            </div>

            <div class="form-group mb-3">
                <label for="phone">Phone</label>
                <input type="tel" class="form-control" id="phone" name="phone" required>
            </div>

            <div id="phoneError" style="color: red;"></div>

            <div>
                <button type="submit" class="btn-info">Sign Up</button>
            </div>

            <script>
                function validateForm() {
                    const password = document.getElementById('password').value;
                    const confirmPassword = document.getElementById('confirmPassword').value;
                    const passwordError = document.getElementById('passwordError');
                    const phone = document.getElementById('phone').value;
                    const phoneError = document.getElementById('phoneError');

                    // Kiểm tra mật khẩu
                    if (password !== confirmPassword) {
                        passwordError.textContent = 'Passwords do not match!';
                        return false;
                    } else {
                        passwordError.textContent = '';
                    }

                    // Kiểm tra số điện thoại (bắt đầu bằng 0 và có đúng 10 số)
                    const phonePattern = /^0\d{9}$/;
                    if (!phonePattern.test(phone)) {
                        phoneError.textContent = 'Phone number must start with 0 and be exactly 10 digits!';
                        return false;
                    } else {
                        phoneError.textContent = '';
                    }

                    return true;
                }
            </script>
        </form>
    </div>
</div>




<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
