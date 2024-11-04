<%-- 
    Document   : services
    Created on : 11 Oct 2024, 22:35:01
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .service {
        transition: transform 0.2s ease, box-shadow 0.2s ease;
    }

    .service:hover {
        transform: translateY(-5px); /* Hiệu ứng nổi */
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Đổ bóng */
    }
</style>
<div class="section">
    <a href="dichvu.jsp"><h2>DỊCH VỤ</h2></a>
    <div class="services">
        <div class="service">
            <h3>Chăm sóc - Bảo trì</h3>
            <p>Marine&Reef cung cấp dịch vụ chăm sóc, bảo trì bể cá cảnh biển, san hô tại nhà.</p>
        </div>
        <div class="service">
            <h3>Thiết kế layout</h3>
            <p>Có đội ngũ layout bể cá cảnh biển, bể san hô với kỹ năng và công cụ chuyên nghiệp.</p>
        </div>
        <div class="service">
            <h3>Setup trọn gói</h3>
            <p>Marine&Reef cung cấp dịch vụ setup trọn gói, khách hàng chỉ việc đưa ra yêu cầu, mọi việc sẽ được chúng tôi lo liệu.</p>
        </div>
    </div>
</div>
