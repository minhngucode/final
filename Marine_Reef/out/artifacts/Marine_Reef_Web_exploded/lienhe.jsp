<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="includes/begintag.jsp"/>
<jsp:include page="includes/header.jsp"/>
<style>
    /* Liên Hệ */
    .contact-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 40px 40px;
        background-color: #f9f9f9;
        border-radius: 8px;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    }

    .contact-title {
        font-size: 2.5rem;
        color: #333;
        text-align: center;
        margin-bottom: 20px;
    }

    .contact-subtitle {
        font-size: 1.8rem;
        color: #007bff;
        margin-top: 30px;
    }

    .contact-text {
        font-size: 1.1rem;
        color: #555;
        line-height: 1.6;
        margin-bottom: 20px;
    }

    .contact-form {
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    .contact-form label {
        font-size: 1.1rem;
        color: #333;
    }

    .contact-form input, .contact-form textarea {
        padding: 10px;
        border: 1px solid #ccc;
        border-radius: 4px;
        font-size: 1rem;
    }

    .contact-form button {
        background-color: #007bff;
        color: #fff;
        padding: 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1.1rem;
    }

    .contact-form button:hover {
        background-color: #0056b3;
    }

</style>
<!-- Liên Hệ -->
<div class="contact-container">
    <h1 class="contact-title">Liên Hệ Với Chúng Tôi</h1>
    <p class="contact-text">
        Chúng tôi luôn sẵn sàng hỗ trợ bạn! Nếu bạn có bất kỳ câu hỏi nào, hãy điền vào biểu mẫu bên dưới hoặc liên hệ với chúng tôi qua thông tin dưới đây.
    </p>

    <h2 class="contact-subtitle">Thông Tin Liên Lạc</h2>
    <p><strong>Địa chỉ:</strong> Đại Học FPT, Khu đô thị FPT, P.Hòa Hải
Q.Ngũ Hành Sơn, TP.Đà Nẵng</p>
    <p><strong>Số điện thoại:</strong> 0345 678 JQK</p>
    <p><strong>Email:</strong> anonymous@fpt.edu.vn</p>

    <h2 class="contact-subtitle">Gửi Tin Nhắn Cho Chúng Tôi</h2>
    <form action="send_message.jsp" method="post" class="contact-form">
        <label for="name">Tên:</label>
        <input type="text" id="name" name="name" required>

        <label for="email">Email:</label>
        <input type="email" id="email" name="email" required>

        <label for="phone">Số điện thoại:</label>
        <input type="tel" id="phone" name="phone">

        <label for="message">Tin nhắn:</label>
        <textarea id="message" name="message" required></textarea>

        <button type="submit">Gửi</button>
    </form>

    <h2 class="contact-subtitle">Bản Đồ</h2>
    <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d..." style="width:100%; height:400px;" frameborder="0" allowfullscreen></iframe>
</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
