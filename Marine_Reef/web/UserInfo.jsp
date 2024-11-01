<%@page import="Model.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<%
    // Lấy thông tin người dùng từ session
    Customer cus = (Customer) request.getAttribute("Customer");
    System.out.println(cus);
    String username = (String) request.getAttribute("username");
    // Nếu không có thông tin người dùng, chuyển hướng đến trang đăng nhập
    if (username.isEmpty() || cus==null) {
        response.sendRedirect("LoginServlet");
        return;
    }
%>
<div class="container">
    <h1>Thông Tin Người Dùng</h1>
    <form action="UserInfo" method="Post">
        <div class="user-info">
            <div>
                <label for="customerName"><strong>Họ và Tên:</strong></label>
                <input type="text" id="customerName" name="customerName" value="<%= cus.getCustomerName()%>" required />
            </div>
            <div>
                <label for="username"><strong>Tên đăng nhập:</strong></label>
                <input type="text" id="username" name="username" value="<%= username %>" readonly />
            </div>
            <div>
                <label for="email"><strong>Email:</strong></label>
                <input type="email" id="email" name="email" value="<%= cus.getEmail() %>" required />
            </div>
            <div>
                <label for="phone"><strong>Số điện thoại:</strong></label>
                <input type="text" id="phone" name="phone" value="<%= cus.getPhone() %>" required />
            </div>
            <div>
                <label for="address"><strong>Địa chỉ:</strong></label>
                <input type="text" id="address" name="address" value="<%= cus.getAddress() %>" required />
            </div>
        </div>
        
        <div class="actions">
            <button type="submit" class="btn">Cập Nhật Thông Tin</button>
            <form action="Control?action=logout" method="POST" style="display: inline;">
                <button type="submit" class="btn">Đăng Xuất</button>
            </form>
        </div>
    </form>
</div>
<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
