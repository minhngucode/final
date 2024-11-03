<%-- 
    Document   : success
    Created on : 3 Nov 2024, 16:46:23
    Author     : 
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<div class="orderSuccess" style="margin: 80px auto;">
    <h1>Đã đặt hàng thành công!</h1>
    <p>Xin chào, <strong><%= request.getAttribute("username") %></strong>.</p>
    <p>Đơn hàng của bạn với mã <strong>OR<%= request.getAttribute("orderID") %></strong> đang được xử lý, vui lòng theo dõi thông tin đơn hàng để biết thêm chi tiết.</p>
    <p>Cảm ơn bạn đã mua sắm với chúng tôi!</p>
    <a href="Control">Quay về trang chủ</a>
</div>
<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/> 
