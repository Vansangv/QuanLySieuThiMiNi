<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .header {
            background-color: #343a40;
            color: white;
            padding: 20px 0;
            text-align: center;
        }
        .footer {
            background-color: #343a40;
            color: white;
            padding: 10px 0;
            text-align: center;
            position: relative;
            bottom: 0;
            width: 100%;
        }
        .main-content {
            padding: 20px;
        }
        .card {
            transition: transform 0.2s;
        }
        .card:hover {
            transform: scale(1.05);
        }
        .navbar {
            margin-bottom: 20px;
        }
    </style>
</head>
<body>

<div class="header">
    <h1>Chào Mừng Đến Với Siêu Thị MINI</h1>
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark">
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" aria-current="page" href="#">Trang Chủ</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/hienthi">Sản Phẩm</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/danhSachChiTietHoaDon">Lịch sử hóa đơn</a>
                </li>
            </ul>
        </div>
    </nav>
</div>

<div class="main-content">
    <div class="container">
        <h2 class="text-center my-4">Giới Thiệu</h2>
        <p class="text-center">Chúng tôi cung cấp các sản phẩm chất lượng cao với giá cả hợp lý.</p>

        <h3 class="my-4 text-center">Sản Phẩm Nổi Bật</h3>
        <div class="row justify-content-center">
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm text-center">
                    <div class="card-body">
                        <h5 class="card-title">Khánh Hàng</h5>
                        <p class="card-text">Mô tả ngắn gọn về Khánh Hàng</p>
                        <a href="/khachhang" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card mb-4 shadow-sm text-center">
                    <div class="card-body">
                        <h5 class="card-title">Hàng Hóa</h5>
                        <p class="card-text">Mô tả ngắn gọn về Hàng Hóa</p>
                        <a href="/hanghoa" class="btn btn-primary">Xem Chi Tiết</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="footer">
    <p>&copy; 2024 Công Ty ABC. Tất cả quyền được bảo lưu.</p>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
