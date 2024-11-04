<%-- 
    Document   : OrderManage
    Created on : 4 Nov 2024, 10:26:34
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<style>
    .orderManage {
    margin: 20px auto;
    padding: 10px;
    width: 90%;
    border-radius: 10px;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    background-color: #f9f9f9;
    height: 500px;
}

.orderManage h2 {
    text-align: center;
    color: #0689B7;
    margin-bottom: 20px;
}

.orderManage table {
    width: 100%;
    border-collapse: collapse;
    margin: 0 auto;
}

.orderManage th, .orderManage td {
    padding: 10px;
    text-align: center;
    border: 1px solid #ddd;
}

.orderManage th {
    background-color: #0689B7;
    color: white;
    font-weight: bold;
}

.orderManage tr:nth-child(even) {
    background-color: #f2f2f2;
}

.orderManage tr:hover {
    background-color: #e6f7ff;
}

.orderManage input[type="submit"] {
    background-color: #f44336; /* Red */
    color: white;
    border: none;
    padding: 5px 10px;
    border-radius: 5px;
    cursor: pointer;
    transition: background-color 0.3s;
}

.orderManage input[type="submit"]:hover {
    background-color: #d32f2f; /* Darker red */
}

</style>
<div class="orderManage">
    <h2>Quản lí đặt hàng</h2>
    <table border="1">
        <tr>
            <th>Mã đặt hàng</th>
            <th>Ngày đặt hàng</th>
            <th>Tổng giá tiền</th>
            <th>Trạng thái</th>
            <th>Hủy đơn</th>
        </tr>
        <c:forEach var="order" items="${orders}">
            <tr><td>
                        <form action="ViewOrder" method="get">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <button type="submit" class="btn btn-link">${order.orderId}</button>
                        </form>
                 </td>
                <td>${order.orderDate}</td>
                <td>${order.totalAmount}</td>
                <td>${order.status}</td>
                <td>
                    <form action="OrderManagement" method="post" style="display:inline;">
                        <input type="hidden" name="orderId" value="${order.orderId}" />
                        <input type="submit" value="Hủy" />
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</div>
<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/> 