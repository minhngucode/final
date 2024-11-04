<%-- 
    Document   : knowledge
    Created on : 11 Oct 2024, 22:35:09
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .knowledge-item {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .knowledge-item:hover {
        transform: translateY(-5px); /* Hiệu ứng nổi */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng */
    }
</style>
<div class="section">
    <a href="chiasekienthuc.jsp"><h2>CHIA SẺ KIẾN THỨC</h2></a>
    <div class="knowledge-share">
        <div class="knowledge-item">
            <img alt="Các thông số nước dành cho bể san hô" height="300" src="images/coral-image/TW004.jpg" width="300"/>
            <h3>Các thông số nước dành cho bể san hô</h3>
            <p>11/04/2023 - Chia sẻ kiến thức</p>
        </div>
        <div class="knowledge-item">
            <img alt="San hô là gì? Hải quỳ sinh sản, dinh dưỡng, di chuyển thế nào?" height="200" src="images/coral-image/CR002.jpg" width="200"/>
            <h3>San hô là gì? San hô sinh sản, dinh dưỡng, nhiệt độ thế nào?</h3>
            <p>11/04/2023 - Chia sẻ kiến thức</p>
        </div>
    </div>
</div>
