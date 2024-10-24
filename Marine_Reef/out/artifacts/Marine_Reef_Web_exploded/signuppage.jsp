<%-- 
    Document   : signup
    Created on : 23 Oct 2024, 20:00:14
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/begintag.jsp"/>
        <jsp:include page="includes/header.jsp"/>
       <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8">
                <div class="card border-info shadow-lg">
                    <div class="card-body">
                        <h2 class="text-center mb-4 text-info">Sign Up</h2>
                        <form action="Signup" method="post" onsubmit="return validatePassword()">
                            <div class="mb-3">
                                <label for="username" class="form-label text-neon">Username</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-info text-dark"><i class="bi bi-person"></i></span>
                                    <input type="text" class="form-control bg-dark text-white border-info" id="username" name="username" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="password" class="form-label text-neon">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-info text-dark"><i class="bi bi-lock"></i></span>
                                    <input type="password" class="form-control bg-dark text-white border-info" id="password" name="password" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="confirmPassword" class="form-label text-neon">Confirm Password</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-info text-dark"><i class="bi bi-lock-fill"></i></span>
                                    <input type="password" class="form-control bg-dark text-white border-info" id="confirmPassword" name="confirmPassword" required>
                                </div>
                            </div>

                            <div class="mb-3 text-danger" id="passwordError"></div>

                            <div class="mb-3">
                                <label for="email" class="form-label text-neon">Email</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-info text-dark"><i class="bi bi-envelope"></i></span>
                                    <input type="email" class="form-control bg-dark text-white border-info" id="email" name="email" required>
                                </div>
                            </div>

                            <div class="mb-3">
                                <label for="phone" class="form-label text-neon">Phone</label>
                                <div class="input-group">
                                    <span class="input-group-text bg-info text-dark"><i class="bi bi-telephone"></i></span>
                                    <input type="tel" class="form-control bg-dark text-white border-info" id="phone" name="phone" required>
                                </div>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-info text-dark fw-bold">Sign Up</button>
                            </div>

                            <script>
                                function validatePassword() {
                                    const password = document.getElementById('password').value;
                                    const confirmPassword = document.getElementById('confirmPassword').value;
                                    const passwordError = document.getElementById('passwordError');

                                    if (password !== confirmPassword) {
                                        passwordError.textContent = 'Passwords do not match!';
                                        return false; // Ngăn chặn form được submit
                                    } else {
                                        passwordError.textContent = ''; // Xóa thông báo lỗi
                                        return true; // Cho phép form được submit
                                    }
                                }
                            </script>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

        <jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>

