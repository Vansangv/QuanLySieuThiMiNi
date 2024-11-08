<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Hàng Hóa</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h2 class="my-4">Thêm Mới Hàng Hóa</h2>
    <form action="/hanghoa/save" method="post">
        <div class="form-group">
            <label>Mã Hàng Hóa</label>
            <input type="text" class="form-control" name="ma">
        </div>
        <div class="form-group">
            <label>Tên Hàng Hóa</label>
            <input type="text" class="form-control" name="ten">
        </div>
        <div class="form-group">
            <label>Giá</label>
            <input type="number" class="form-control" name="gia">
        </div>
        <div class="form-group">
            <label>Số Lượng</label>
            <input type="number" class="form-control" name="soLuong">
        </div>
        <div class="form-group">
            <label>Đơn Vị</label>
            <input type="text" class="form-control" name="donVi">
        </div>
        <div class="form-group">
            <label>Ngày Nhập</label>
            <input type="date" class="form-control" name="ngayNhap">
        </div>
        <div class="form-group">
            <label>Thời Gian Ngày Nhập</label>
            <input type="time" class="form-control" name="thoiGianNgayNhap">
        </div>
        <div class="form-group">
            <label>Hạn Sử Dụng</label>
            <input type="date" class="form-control" name="hanSuDung">
        </div>
        <div class="form-group">
            <label>Thời Gian Hạn Sử Dụng</label>
            <input type="time" class="form-control" name="thoiGianHSD">
        </div>
        <div class="form-group">
            <label>Tổng Thành Phần</label>
            <input type="text" class="form-control" name="tongThanhPhan">
        </div>
        <button type="submit" class="btn btn-success">Lưu</button>
    </form>
</div>
</body>
</html>
