<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="f" uri="jakarta.tags.functions" %>

<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <title>Thêm Khách Hàng</title>
</head>
<body>
<div class="container mt-5">
    <h2 class="text-center">Thêm Khách Hàng</h2>

    <form action="/khachhang/create" method="post" class="mt-4">
        <div class="form-group">
            <label for="ma">Mã Khách Hàng:</label>
            <input type="text" id="ma" name="ma" class="form-control" value="${khachHang.ma}" required />
            <c:if test="${not empty errors['ma']}">
                <div class="text-danger">${errors['ma']}</div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="ten">Tên Khách Hàng:</label>
            <input type="text" id="ten" name="ten" class="form-control" value="${khachHang.ten}" required />
            <c:if test="${not empty errors['ten']}">
                <div class="text-danger">${errors['ten']}</div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="sdt">Số Điện Thoại:</label>
            <input type="text" id="sdt" name="sdt" class="form-control" value="${khachHang.sdt}" required />
            <c:if test="${not empty errors['sdt']}">
                <div class="text-danger">${errors['sdt']}</div>
            </c:if>
        </div>

        <div class="form-group">
            <label for="diemTL">Điểm Tích Lũy:</label>
            <input type="number" id="diemTL" name="diemTL" class="form-control" value="${khachHang.diemTL}" required />
            <c:if test="${not empty errors['diemTL']}">
                <div class="text-danger">${errors['diemTL']}</div>
            </c:if>
        </div>

        <button type="submit" class="btn btn-primary">Lưu</button>
        <a href="/khachhang" class="btn btn-secondary">Quay lại</a>
    </form>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
