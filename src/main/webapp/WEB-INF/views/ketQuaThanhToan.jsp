<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Thanh Toán</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container mt-5">
    <div>
        <h3>Hóa Đơn Thanh Toán</h3>
        <p>Mã Hóa Đơn: ${chiTietHoaDon.maHoaDon}</p>
        <p>Khách Hàng: ${chiTietHoaDon.khachHang.ten}</p>
        <p>Hàng Hóa: ${chiTietHoaDon.hangHoa.ten}</p>
        <p>Số Lượng: ${chiTietHoaDon.soLuong}</p>
        <p>Đơn Giá: ${chiTietHoaDon.donGia}</p>
        <p><strong>Tổng Tiền: ${chiTietHoaDon.tongTien}</strong></p> <!-- Hiển thị tổng tiền -->
        <p>Tiền Khách Đưa: ${tienKhachDua}</p>
        <p>Tiền Thừa: ${tienThua >= 0 ? tienThua : 0}</p>
        <p>Tiền Thiếu: ${tienThua < 0 ? Math.abs(tienThua) : 0}</p> <!-- Hiển thị tiền thiếu nếu có -->
    </div>
    <a href="/hienthi" class="btn btn-primary mt-3">Quay Lại</a>
    <a href="/exportWord?maHoaDon=${chiTietHoaDon.maHoaDon}&tenKhachHang=${chiTietHoaDon.khachHang.ten}&tenHangHoa=${chiTietHoaDon.hangHoa.ten}&soLuong=${chiTietHoaDon.soLuong}&donGia=${chiTietHoaDon.donGia}&tongTien=${chiTietHoaDon.tongTien}&tienKhachDua=${tienKhachDua}&tienThua=${tienThua}" class="btn btn-success mt-3">Xuất File Word</a>
</div>
</body>
</html>
