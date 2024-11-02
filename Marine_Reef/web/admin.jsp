<%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.ArrayList"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>

<%
    ArrayList<String> categoryList = (ArrayList<String>) request.getAttribute("categoryList");
    ArrayList<String> typeList = (ArrayList<String>) request.getAttribute("typeList");
%>

<div class="container">
        <div class="form-container">
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
                <div class="form-row">
                    <label for="image">Ảnh:</label>
                    <input type="file" id="image" name="image" class="form-control-file" accept="image/*" required>
                </div>
                <button type="submit" class="btn btn-primary">Thêm</button>
            </form>
            <a href="ProductList" class="btn btn-secondary mt-3">Quay lại</a>
        </div>
    </div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
