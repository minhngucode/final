<%-- 
    Document   : OrderManage
    Created on : 4 Nov 2024, 10:26:34
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Order Management</title>
</head>
<body>
    <h2>Order Management</h2>
    <table border="1">
        <tr>
            <th>Order ID</th>
            <th>Order Date</th>
            <th>Total Amount</th>
            <th>Status</th>
            <th>Action</th>
        </tr>
        <c:forEach var="order" items="${orders}">
            <tr>
                <td>${order.orderId}</td>
                <td>${order.orderDate}</td>
                <td>${order.totalAmount}</td>
                <td>${order.status}</td>
                <td>
                    <form action="OrderManagement" method="post" style="display:inline;">
                        <input type="hidden" name="orderId" value="${order.orderId}" />
                        <input type="submit" value="Delete" />
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>
</html>