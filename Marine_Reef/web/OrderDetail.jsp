<%@page import="Model.OrderDetail"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<%
    ArrayList<OrderDetail> orderDetailList = (ArrayList<OrderDetail>) request.getAttribute("orderDetailList");
%>

<div class="container">
    <h2>Chi Tiết Đơn Hàng</h2>
    <% if (orderDetailList != null && !orderDetailList.isEmpty()) { %>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Product ID</th>
                    <th>Hình Ảnh</th>
                    <th>Số Lượng</th>
                    <th>Đơn Giá</th>
                    <th>Tổng Giá</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderDetail detail : orderDetailList) { %>
                    <tr>
                        <td><%= detail.getOrderID() %></td>
                        <td><%= detail.getProductID() %></td>
                        <td>
                            <img src="images/coral-image/<%= detail.getProductID() %>.jpg" alt="Product Image" style="width: 100px; height: auto;">
                        </td>
                        <td><%= detail.getQuantity() %></td>
                        <td><%= detail.getUnitPrice() %></td>
                        <td><%= detail.getQuantity() * detail.getUnitPrice() %></td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <div class="alert alert-warning" role="alert">
            Không tìm thấy chi tiết đơn hàng.
        </div>
    <% } %>
    <a href="orderList.jsp" class="btn btn-primary mt-3">Quay lại</a>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>