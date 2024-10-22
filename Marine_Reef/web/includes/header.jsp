<%-- 
    Document   : header
    Created on : 11 Oct 2024, 22:34:35
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <div class="container">
        <div class="logo">
            <img alt="Marine and Reef Logo" height="50" src="./images/logo/logo.jpg" width="100"/>
        </div>
        <nav style="font-size: 12px; padding-top: 20px">
            <ul>
                <li><a href="#">GIỚI THIỆU</a></li>
                <li><a href="#">XÂY DỰNG BỂ</a></li>
                <li><a href="#">SẢN PHẨM</a></li>
                <li><a href="#">DỊCH VỤ</a></li>
                <li><a href="#">CHIA SẺ KIẾN THỨC</a></li>
                <li><a href="#">LIÊN HỆ</a></li>
                <% String lg = (String) request.getAttribute("lg");
                    if (lg == null) {%>
                <li style="font-size: 12px; text-decoration: none; background-color: aqua; padding: 5px 10px; border-radius: 5px;"><a href="LoginServlet" class="login-button">LOGIN</a></li>
                <%}%>
            </ul>
        </nav>
        <div class="contact-info">
            <i class="fas fa-envelope"></i>
            <span>anonymous@fpt.edu.vn</span>
            <i class="fas fa-phone"></i>
            <span>0345 6789 JQK</span>
        </div>
    </div>
</header>
