<%-- 
    Document   : header
    Created on : 11 Oct 2024, 22:34:35
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <div class="container  justify-content" >
        <div class="logo" >
            <img alt="Marine and Reef Logo" height="50" src="./images/logo/logo.jpg" width="100"/>
        </div>
        <nav style=" padding-top: 20px; margin-right: 15%">
            <ul>
                <li><a href="#">GIỚI THIỆU</a></li>
                <li><a href="#">XÂY DỰNG BỂ</a></li>
                <li><a href="#">SẢN PHẨM</a></li>
                <li><a href="#">DỊCH VỤ</a></li>
                <li><a href="#">CHIA SẺ KIẾN THỨC</a></li>
                <li><a href="#">LIÊN HỆ</a></li>
                    <% String lg = (String) request.getAttribute("lg");
                    if (lg == null) {%>
                <li style="font-size: 12px; text-decoration: none; background-color: aqua; padding: 5px 10px; border-radius: 5px;"><a href="LoginServlet">LOGIN</a></li>
                    <%} else {%>
                <li>Xin chào </li>
                <li style="font-size: 12px; text-decoration: none; background-color: aqua; padding: 5px 10px; border-radius: 5px;">
                    <form action="Control?action=logout" method="POST" style="display: inline;">
                        <button type="submit" class="login-button" style="border: none; background: none; padding: 0; color: inherit; cursor: pointer;">Logout</button>
                    </form>
                </li>
                <%}%>
            </ul>
        </nav>
 </div>
</header>
