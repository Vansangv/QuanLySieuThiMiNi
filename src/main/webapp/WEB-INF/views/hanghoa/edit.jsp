<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Cập Nhật Hàng Hóa</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="my-4">Cập Nhật Hàng Hóa</h2>
    <form action="/hanghoa/update" method="post">
<%--        <input type="hidden" name="id" value="${hangHoa.id}"> <!-- Giữ lại ID hàng hóa -->--%>

        <div class="form-group">
            <label>Mã Hàng Hóa</label>
            <input type="text" class="form-control" name="ma" value="${hangHoa.ma}" required>
        </div>

        <div class="form-group">
            <label>Tên Hàng Hóa</label>
            <input type="text" class="form-control" name="ten" value="${hangHoa.ten}" required>
        </div>

        <div class="form-group">
            <label>Giá</label>
            <input type="number" class="form-control" name="gia" value="${hangHoa.gia}" required>
        </div>

        <div class="form-group">
            <label>Số Lượng</label>
            <input type="number" class="form-control" name="soLuong" value="${hangHoa.soLuong}" required>
        </div>

        <div class="form-group">
            <label>Đơn Vị</label>
            <input type="text" class="form-control" name="donVi" value="${hangHoa.donVi}" required>
        </div>

        <div class="form-group">
            <label>Ngày Nhập</label>
            <input type="date" class="form-control" name="ngayNhap" value="${hangHoa.ngayNhap}" required>
        </div>

        <div class="form-group">
            <label>Thời Gian Ngày Nhập</label>
            <input type="time" class="form-control" name="thoiGianNgayNhap" value="${hangHoa.thoiGianNgayNhap}" required>
        </div>


    <div class="form-group">
        <label>Hạn Sử Dụng</label>
        <input type="date" class="form-control" name="hanSuDung" value="${hangHoa.hanSuDung}" required>
    </div>

        <div class="form-group">
            <label>Thời Gian Hạn Sử Dụng</label>
            <input type="time" class="form-control" name="thoiGianHSD" value="${hangHoa.thoiGianHSD}" required>
        </div>

        <div class="form-group">
            <label>Tổng Thành Phần</label>
            <input type="text" class="form-control" name="tongThanhPhan" value="${hangHoa.tongThanhPhan}" required>
        </div>

        <button type="submit" class="btn btn-success">Cập Nhật</button>
        <a href="/hanghoa" class="btn btn-secondary">Quay Lại</a>
    </form>
</div>
</body>
</html>
