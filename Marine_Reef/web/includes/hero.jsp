<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="hero">
    <div class="carousel">
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="images/banner/banner.jpg" alt="Banner 1">
            </div>
            <div class="carousel-item">
                <img src="images/banner/banner2.jpg" alt="Banner 2">
            </div>
            <div class="carousel-item">
                <img src="images/banner/banner3.jpg" alt="Banner 3">
            </div>
        </div>
        <button class="carousel-control prev" onclick="prevSlide()">&#10094;</button>
        <button class="carousel-control next" onclick="nextSlide()">&#10095;</button>
    </div>
    <!-- Container cho nội dung chính -->
    <div class="content-overlay">
        <h2>XÂY DỰNG CẤU HÌNH BỂ SAN HÔ</h2>
        <ul>
            <li>Hàng trăm mẫu Layout lựa chọn</li>
            <li>Chọn các món đồ thiết kế</li>
            <li>Giảm giá khủng khi đăng ký online</li>
        </ul>
        <div class="nut">
            <a class="btn" href="gioithieu.jsp">THÔNG TIN</a>
            <a class="btn" href="ProductList">MUA SẮM NGAY</a>
        </div>
    </div>
</div>

<style>
.hero {
    position: relative;
    color: #fff;
    text-align: center;
}

.carousel {
    position: relative;
    width: 100%;
    margin: 0;
    overflow: hidden;
    border-radius: 10px;
}

.carousel-inner {
    display: flex;
    transition: transform 0.5s ease-in-out;
    height: 600px;
}

.carousel-item {
    min-width: 100%;
    opacity: 0;
    transition: opacity 1s;
}

.carousel-item.active {
    opacity: 1;
}

.carousel-item img {
    width: 100%;
    height: 600px; /* Điều chỉnh chiều cao */
    object-fit: cover;
}

.carousel-control {
    position: absolute;
    top: 50%;
    transform: translateY(-50%);
    background-color: rgba(0, 0, 0, 0.5);
    color: #fff;
    border: none;
    padding: 10px;
    cursor: pointer;
    font-size: 24px;
    border-radius: 50%;
}

.carousel-control.prev {
    left: 20px;
}

.carousel-control.next {
    right: 20px;
}

/* CSS cho phần nội dung chính giữa banner */
.content-overlay {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    text-align: center;
    color: #fff;
}

.content-overlay h2 {
    font-size: 2.5rem;
    margin-bottom: 15px;
}

.content-overlay ul {
    list-style: none;
    padding: 0;
    margin: 0 0 20px 0;
}

.content-overlay ul li {
    margin: 5px 0;
}

.content-overlay .nut {
    display: flex;
    gap: 20px;
    justify-content: center;
}

.content-overlay .btn {
    background-color: white;
    color: #0689B7;
    padding: 10px 30px;
    text-decoration: none;
    font-weight: 700;
    border-radius: 5px;
}
</style>

<script>
let currentIndex = 0;

function showSlide(index) {
    const slides = document.querySelectorAll('.carousel-item');
    if (index >= slides.length) {
        currentIndex = 0;
    } else if (index < 0) {
        currentIndex = slides.length - 1;
    } else {
        currentIndex = index;
    }

    slides.forEach((slide, i) => {
        slide.classList.remove('active');
        if (i === currentIndex) {
            slide.classList.add('active');
        }
    });

    const offset = -currentIndex * 100; // Dịch chuyển theo phần trăm width
    document.querySelector('.carousel-inner').style.transform = `translateX(${offset}%)`;
}

function nextSlide() {
    showSlide(currentIndex + 1);
}

function prevSlide() {
    showSlide(currentIndex - 1);
}

// Tự động chuyển slide sau mỗi 5 giây
setInterval(nextSlide, 5000);
</script>
