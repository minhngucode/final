<%-- 
    Document   : TransDetail
    Created on : 4 Nov 2024, 14:23:01
    Author     : 
--%>

<%@page import="Model.TransInfo"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
 <%   TransInfo transInfo = (TransInfo) request.getAttribute("transInfo"); %>

<div class="container">
    <h2>Chi Tiết Shipping</h2>
    <c:if test="${not empty transInfo}">
        <div class="card" style="margin: 20px auto; padding: 20px; border: 1px solid #ddd; border-radius: 5px; box-shadow: 2px 2px 5px rgba(0,0,0,0.1);">
            <div class="card-body">
                <p><strong>Order ID:</strong> ${transInfo.orderId}</p>
                <p><strong>Customer ID:</strong> ${transInfo.customerId}</p>
                <p><strong>Tên:</strong> ${transInfo.name}</p>
                <p><strong>Địa chỉ:</strong> ${transInfo.address}</p>
                <p><strong>Số điện thoại:</strong> ${transInfo.phone}</p>
            </div>
        </div>
    </c:if>
    <c:if test="${empty transInfo}">
        <div class="alert alert-warning" role="alert">
            Không tìm thấy thông tin shipping.
        </div>
    </c:if>
    <a href="admin" class="btn btn-primary mt-3">Quay lại</a>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>