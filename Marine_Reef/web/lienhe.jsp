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
        color: #0689B7;
        text-align: center;
        margin-bottom: 20px;
    }

    .contact-subtitle {
        font-size: 1.8rem;
        color: #0689B7;
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
        color: #0689B7;
    }

    .contact-form input, .contact-form textarea {
        padding: 10px;
        border: 1px solid #0689B7;
        border-radius: 4px;
        font-size: 1rem;
        outline: none;
    }
    .contact-form input:focus, .contact-form textarea:focus {
        border-color: #0689B7; /* Giữ màu xanh khi input focus */
        box-shadow: 0 0 5px rgba(6, 137, 183, 0.5); /* Ánh sáng nhẹ khi nhấn vào */
    }
    .contact-form button {
        background-color: #0689B7;
        color: #fff;
        padding: 10px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 1.1rem;
    }

    .contact-form button:hover {
        background-color: #055f7d;
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
<div style="position: relative; display: inline-block; width: 100%;">
    <a href="https://earth.google.com/web/search/%c4%90%e1%ba%a1i+h%e1%bb%8dc+FPT+%c4%90%c3%a0+N%e1%ba%b5ng,+Khu+%c4%91%c3%b4+th%e1%bb%8b+FPT+City,+H%c3%b2a+H%e1%ba%a3i,+Ng%c5%a9+H%c3%a0nh+S%c6%a1n,+%c4%90%c3%a0+N%e1%ba%b5ng/@15.96888573,108.26089073,4.33707477a,810.7563465d,35y,0h,0t,0r/data=CtABGqEBEpoBCiUweDMxNDIxMTY5NDk4NDA1OTk6MHgzNjViMzU1ODBmNTJlOGQ1GW4cDNAR8C9AIeZTbHGyEFtAKl_EkOG6oWkgaOG7jWMgRlBUIMSQw6AgTuG6tW5nLCBLaHUgxJHDtCB0aOG7iyBGUFQgQ2l0eSwgSMOyYSBI4bqjaSwgTmfFqSBIw6BuaCBTxqFuLCDEkMOgIE7hurVuZxgCIAEiJgokCUyVTd3H8i9AEYY10F7t7C9AGT0KBVdpEVtAIQroFWzMD1tAQgIIAUICCABKDQj___________8BEAA" 
       target="_blank" title="địa chỉ Marine & Reef shop" style="display: block;">
        <iframe src="images/coral-image/map.jpg" style="width:100%; height:400px; border: 0;" frameborder="0" allowfullscreen></iframe>
        <div style="position: absolute; top: 0; left: 0; width: 100%; height: 100%;"></div>
    </a>
</div>


</div>

<jsp:include page="includes/footer.jsp"/>
<jsp:include page="includes/endtag.jsp"/>
