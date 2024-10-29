<%-- 
    Document   : header
    Created on : 11 Oct 2024, 22:34:35
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header>
    <div class="container  justify-content" >
        <div class="logo" >
            <a href="index.jsp">
                <img alt="Marine and Reef Logo" height="50" src="./images/logo/logo.jpg" width="100"/>
            </a>
        </div>
        <nav style=" padding-top: 20px;">
            <ul>
                <li><a href="gioithieu.jsp">GIỚI THIỆU</a></li>
                <li><a href="#">XÂY DỰNG BỂ</a></li>
                <li><a href="ProductList">SẢN PHẨM</a></li>
                <li><a href="dichvu.jsp">DỊCH VỤ</a></li>
                <li><a href="chiasekienthuc.jsp">CHIA SẺ KIẾN THỨC</a></li>
                <li><a href="#">LIÊN HỆ</a></li>
                    <% 
                        ServletContext context = application;
            String lg = (String) context.getAttribute("lg");
                    if (lg == null) {%>
                <li style="font-size: 12px; text-decoration: none; background-color: #0689B7; padding: 5px 10px; border-radius: 5px;"><a href="LoginServlet">LOGIN</a></li>
                <li style="font-size: 12px; text-decoration: none; background-color: #0689B7; padding: 5px 10px; border-radius: 5px;"><a href="Signup">SIGNUP</a></li>

                <%} else {%>
                <li style="font-size: 12px; text-decoration: none; background-color: #0689B7; padding: 5px 10px; border-radius: 5px;">
                    <form action="Control?action=logout" method="POST" style="display: inline;">
                        <button type="submit" class="login-button" style="border: none; background: none; padding: 0; color: inherit; cursor: pointer;"><b>LOGOUT</b></button>
                    </form>
                </li>
                <li style="font-size: 12px; text-decoration: none; background-color: #0689B7; padding:5px 20px 5px 20px; border-radius: 5px;">
                    <form action="CartServlet" method="GET" style="display: inline;">
                        <button type="submit" class="login-button" style="border: none; background: none; padding: 0; color: inherit; cursor: pointer;"><b>Cart</b></button>
                    </form>
                </li>
                <%}%>

            </ul>
        </nav>
 </div>
</header>
