<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh Sách Chi Tiết Hóa Đơn</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="#">Hệ Thống Bán Hàng</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNav">
        <ul class="navbar-nav">
            <li class="nav-item active">
                <a class="nav-link" href="/TrangChu">Trang Chủ</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/khachhang">Quản Lý Khánh hàng</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/hanghoa">Quản Lý Hàng Hóa</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/hienthi">Quản Lý Thanh Toán</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container mt-5">
    <h2 class="text-center">Danh Sách Chi Tiết Hóa Đơn</h2>

    <c:if test="${not empty error}">
        <div class="alert alert-danger">${error}</div>
    </c:if>

    <form action="/danhSachChiTietHoaDon" method="get" class="form-inline mb-4">
        <label for="startDate" class="mr-2">Từ ngày:</label>
        <input type="date" id="startDate" name="startDate" class="form-control mr-3" value="${startDate != null ? startDate : ''}">

        <label for="endDate" class="mr-2">Đến ngày:</label>
        <input type="date" id="endDate" name="endDate" class="form-control mr-3" value="${endDate != null ? endDate : ''}">

        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
    </form>

    <form action="/danhSachChiTietHoaDon" method="get" class="form-inline mb-4 d-flex">
        <input type="text" id="searchName" name="searchName" class="form-control mr-3" placeholder="Tìm kiếm theo tên">
        <button type="submit" class="btn btn-secondary">Tìm kiếm</button>
    </form>

    <table class="table table-bordered table-striped">
        <thead class="thead-light">
        <tr>
            <th>Số Thứ Tự</th>
            <th>Mã Hóa Đơn</th>
            <th>Khách Hàng</th>
            <th>Hàng Hóa</th>
            <th>Số Lượng</th>
            <th>Đơn Giá</th>
            <th>Ngày Tạo</th>
            <th>Tổng Tiền</th>
            <th>Trạng Thái</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="chiTiet" items="${chiTietHoaDon}" varStatus="status">
            <tr>
                <td>${status.index + 1}</td>
                <td>${chiTiet.maHoaDon}</td>
                <td>${chiTiet.khachHang.ten}</td>
                <td>${chiTiet.hangHoa.ten}</td>
                <td>${chiTiet.soLuong}</td>
                <td>${chiTiet.donGia}</td>
                <td>${chiTiet.ngayTao}</td>
                <td>${chiTiet.tongTien}</td>
                <td>${chiTiet.trangThai}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

<footer class="bg-light text-center py-3 mt-5">
    <p>&copy; 2024 Hệ Thống Bán Hàng. Tất cả quyền được bảo lưu.</p>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
