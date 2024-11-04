<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<%
    ArrayList<String> categoryList = (ArrayList<String>) request.getAttribute("categoryList");
    ArrayList<String> typeList = (ArrayList<String>) request.getAttribute("typeList");
%>

<div class="container">
    <div class="form-container" style="margin: 30px auto">
            <h2>Thêm Sản Phẩm</h2>
            <form action="admin" method="post" enctype="multipart/form-data">
                <div class="form-row">
                    <label for="name">Tên:</label>
                    <input type="text" id="name" name="name" class="form-control" required>
                </div>
                <div class="form-row">
                    <label for="description">Mô Tả:</label>
                    <textarea id="description" name="description" class="form-control" required rows="2"></textarea>
                </div>
                <div class="form-row">
                    <label for="price">Giá:</label>
                    <input type="number" id="price" name="price" class="form-control" step="0.01" required>
                </div>
                <div class="form-row">
                    <label for="quantity">SL:</label>
                    <input type="number" id="quantity" name="quantity" class="form-control" required>
                </div>
                <div class="form-row">
                    <label for="categoryname">Danh Mục:</label>
                    <select name="categoryname" id="categoryname" class="form-control">
                        <c:forEach items="${categoryList}" var="category">
                            <option value="${category}">${category}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-row">
                    <label for="type">Loại:</label>
                    <select id="type" name="type" class="form-control" required>
                        <c:forEach items="${typeList}" var="type">
                            <option value="${type}">${type}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="form-row">
                    <label for="costprice">Giá Thành:</label>
                    <input type="number" id="costprice" name="costprice" class="form-control" step="0.01" required>
                </div>
                <div class="form-row" style="margin: 10px auto">
                    <label for="image">Ảnh:</label>
                    <input type="file" id="image" name="image" class="form-control-file" accept="image/*" required>
                </div>
                <input type="hidden" name="action" value="addProduct">

                <button type="submit" class="btn btn-primary">Thêm</button>
            </form>
            <a href="ProductList" class="btn btn-secondary mt-3">Quay lại</a>
        </div>
    </div>
<div class="container">
    <form action="admin" method="get" class="form-inline mb-3">
        <label for="filterStatus">Lọc theo trạng thái:</label>
        <select name="filterStatus" id="filterStatus" class="form-control ml-2">
            <option value="">Tất cả</option>
            <option value="Đang xử lý">Đang xử lý</option>
            <option value="Chờ Thanh Toán">Chờ Thanh Toán</option>
            <option value="Đang vận chuyển">Đang vận chuyển</option>
            <!-- Thêm các trạng thái khác nếu cần -->
        </select>
        
        <label for="customerName" class="ml-4">Tìm theo tên khách hàng:</label>
        <input type="text" id="customerName" name="customerName" class="form-control ml-2" placeholder="Nhập tên khách hàng">
        
        <button type="submit" class="btn btn-primary ml-2">Lọc</button>
    </form>
    <div class="order-status-container" style="margin: 30px auto">
        <h2>Quản Lý Trạng Thái Đơn Hàng</h2>
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th>Đơn Hàng ID</th>
                    <th>Tên Khách Hàng </th>
                    <th>ngày Order </th>

                    <th>Trạng Thái Hiện Tại</th>
                    <th>Cập Nhật Trạng Thái</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${orderList}" var="order">
                    <tr><td>
                        <form action="Trans" method="get">
                        <input type="hidden" name="orderId" value="${order.orderId}">
                        <button type="submit" class="btn btn-link">${order.orderId}</button>
                        </form>
                        </td>
                        <td>${order.cusname}</td>
                        <td>${order.orderDate}</td>
                        <td><strong>${order.status}</strong></td>
                        <td>
                            <form action="admin" method="post">
                                <input type="hidden" name="orderId" value="${order.orderId}">
                                <input type="hidden" name="action" value="updateStatus">

                                <button type="submit" name="newstatus" value="Đang xử lý" class="btn btn-warning">Đang xử lý</button>
                                <button type="submit" name="newstatus" value="Chờ Thanh Toán" class="btn btn-info">Chờ Thanh Toán</button>
                                <button type="submit" name="newstatus" value="Đang vận chuyển" class="btn btn-success">Đang vận chuyển</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>
<div class="container">
    <c:if test="${param.success != null}">
        <c:choose>
            <c:when test="${param.success == 'true'}">
                <div class="alert alert-success" role="alert">
                    Cập nhật trạng thái đơn hàng thành công!
                </div>
            </c:when>
            <c:otherwise>
                <div class="alert alert-danger" role="alert">
                    Đã xảy ra lỗi. Vui lòng thử lại.
                </div>
            </c:otherwise>
        </c:choose>
    </c:if>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
