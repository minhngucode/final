<%-- 
    Document   : header
    Created on : 11 Oct 2024, 22:34:35
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .dropdown {
        position: relative;
    }

    .dropdown-menu {
        display: none; /* Ẩn menu chính */
        position: absolute;
        top: 100%;
        left: 50%; /* Đặt menu ở giữa phần tử cha */
        transform: translateX(-50%); /* Dịch chuyển menu vào giữa */
        background-color: white;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        z-index: 1;
        padding: 10px 0;
        min-width: 200px;
        list-style: none;
        border-radius: 5px;
    }

    .dropdown-menu li {
        padding: 0px 0px;
        line-height: 2.5;
    }

    .dropdown-menu li a {
        color: black;
        text-decoration: none;
        display: block;
        padding: 5px 10px;
    }

    .dropdown-menu li a:hover {
        background-color: #f0f0f0;
    }

    /* Hiển thị menu chính khi hover vào dropdown */
    .dropdown:hover .dropdown-menu {
        display: block;
    }

    /* Cấu hình cho menu con */
    .dropdown-submenu {
        position: relative;
    }

    .submenu {
        display: none; /* Ẩn menu con */
        position: absolute;
        left: 100%; /* Đẩy menu con sang bên phải */
        top: 0; /* Căn lề trên với menu cha */
        background-color: white;
        box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        z-index: 1;
        padding: 10px 0;
        min-width: 200px;
    }

    .dropdown-submenu:hover .submenu {
        display: block; /* Hiển thị menu con khi hover vào menu cha */
    }

</style>
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
                <li class="dropdown">
                    <a href="ProductList">SẢN PHẨM</a>
                    <ul class="dropdown-menu">
                        <!-- San Hô -->
                        <li>
                            <form action="ProductList" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="filter">
                                <input type="hidden" name="productType" value="Coral">
                                <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                    San Hô
                                </button>
                            </form>
                        </li>

                        <!-- Thiết Bị -->
                        <li class="dropdown-submenu">
                            <a href="#">Thiết Bị</a>
                            <ul class="submenu">
                                <li>
                                    <form action="ProductList" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="productType" value="Light">
                                        <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                            Đèn
                                        </button>
                                    </form>
                                </li>
                                <li>
                                    <form action="ProductList" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="productType" value="Pump">
                                        <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                            Máy Bơm
                                        </button>
                                    </form>
                                </li>
                                <li>
                                    <form action="ProductList" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="productType" value="Skimmer">
                                        <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                            Skimmer
                                        </button>
                                    </form>
                                </li>
                                <li>
                                    <form action="ProductList" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="productType" value="Wave">
                                        <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                            Máy Tạo Sóng
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </li>

                        <!-- Hóa Chất Bổ Sung -->
                        <li class="dropdown-submenu">
                            <a href="#">Hóa Chất Bổ Sung</a>
                            <ul class="submenu">
                                <li>
                                    <form action="ProductList" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="productType" value="Food">
                                        <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                            Thức Ăn
                                        </button>
                                    </form>
                                </li>
                                <li>
                                    <form action="ProductList" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="productType" value="Bacteria">
                                        <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                            Vi Sinh
                                        </button>
                                    </form>
                                </li>
                                <li>
                                    <form action="ProductList" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="filter">
                                        <input type="hidden" name="productType" value="Salt">
                                        <button type="submit" class="dropdown-item" style="background: none; border: none; padding: 0; margin: 0;">
                                            Muối
                                        </button>
                                    </form>
                                </li>
                            </ul>
                        </li>
                    </ul>
                </li>



                <li><a href="dichvu.jsp">DỊCH VỤ</a></li>
                <li><a href="chiasekienthuc.jsp">CHIA SẺ KIẾN THỨC</a></li>
                <li><a href="lienhe.jsp">LIÊN HỆ</a></li>
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
